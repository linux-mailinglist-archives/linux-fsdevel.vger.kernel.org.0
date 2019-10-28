Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42603E6F78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfJ1KDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:03:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34508 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731876AbfJ1KDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:03:10 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 49ECD2E14B4;
        Mon, 28 Oct 2019 13:03:07 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id x5ouwLMN6C-36Bu083s;
        Mon, 28 Oct 2019 13:03:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572256987; bh=4OZ/cmyE0nwmb5VhPhQYX1h9cuI6Q3M2Dc2YOIwAr+s=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=hDzAQS0kyLoTyPqaa2LyHXzZ5VuU8o6Akdba0LfJSK4HM9D75q+Ydsbhj3HAmu6WC
         kCB+dh8Pt2GgBPIvuu4Q9Z8kcRpkoWT3h42OwmwAQDp/UcpL8oQJ7kLMxBiENvPSmO
         fMLVYBaY3S+b+nK9QwPYiZI8p12vsQpFBqChAqLQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id TPsiflps2c-36VmtF2T;
        Mon, 28 Oct 2019 13:03:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs: warn if stale pagecache is left after direct write
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Date:   Mon, 28 Oct 2019 13:03:06 +0300
Message-ID: <157225698620.5453.17655271871684298255.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function generic_file_direct_write() tries to invalidate pagecache after
O_DIRECT write. Unlike to similar code in dio_complete() this silently
ignores error returned from invalidate_inode_pages2_range().

According to comment this code here because not all filesystems call
dio_complete() or do proper invalidation after O_DIRECT write.
Noticeable case is a blkdev_direct_IO().

This patch calls dio_warn_stale_pagecache() if invalidation fails.

Also this skips invalidation for async writes (written == -EIOCBQUEUED).
Async write should call dio_complete() later, when write completes.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 92abf5f348a9..1fa8d587ef78 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3222,11 +3222,15 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Most of the time we do not need this since dio_complete() will do
 	 * the invalidation for us. However there are some file systems that
 	 * do not end up with dio_complete() being called, so let's not break
-	 * them by removing it completely
+	 * them by removing it completely.
+	 *
+	 * Noticeable case is a blkdev_direct_IO().
+	 *
+	 * Skip invalidation for async writes or if mapping has no pages.
 	 */
-	if (mapping->nrpages)
-		invalidate_inode_pages2_range(mapping,
-					pos >> PAGE_SHIFT, end);
+	if (written > 0 && mapping->nrpages &&
+	    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
+		dio_warn_stale_pagecache(file);
 
 	if (written > 0) {
 		pos += written;


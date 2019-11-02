Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90BECECB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKBNNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 09:13:08 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56690 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfKBNNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 09:13:07 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 642102E099D;
        Sat,  2 Nov 2019 16:13:05 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id o44VC5sfra-D4juUgbU;
        Sat, 02 Nov 2019 16:13:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572700385; bh=H7FmyTVkpiw9VXplqlyRxQrERQupmOL/uyKSLjwdIdg=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=OxUUATt2MW6cMx8NEijyWMs0vDxqyGl9Hu5nQSsfhVkprtv1/Uv5n1WLtyT/WW5hL
         oPYbwCOT+g28r8eaffciKLzmSqkXrHs4WcMOKNUQLBFbTteXGYUs5zkdobEY6yi0GZ
         4oF+DIH/CFEoJDGPesZ7+RmfP7TAE9OO2iza5z3g=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id lWH2NgOfEQ-D4VWcMj0;
        Sat, 02 Nov 2019 16:13:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 3/3] fs: warn if stale pagecache is left after direct
 write
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Sat, 02 Nov 2019 16:13:03 +0300
Message-ID: <157270038294.4812.2238891109785106069.stgit@buzz>
In-Reply-To: <157270037850.4812.15036239021726025572.stgit@buzz>
References: <157270037850.4812.15036239021726025572.stgit@buzz>
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
dio_complete() to do proper invalidation after O_DIRECT write.
Noticeable example is a blkdev_direct_IO().

This patch calls dio_warn_stale_pagecache() if invalidation fails.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 189b8f318da2..dc3b78db079b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3241,11 +3241,13 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * do not end up with dio_complete() being called, so let's not break
 	 * them by removing it completely.
 	 *
+	 * Noticeable example is a blkdev_direct_IO().
+	 *
 	 * Skip invalidation for async writes or if mapping has no pages.
 	 */
-	if (written > 0 && mapping->nrpages)
-		invalidate_inode_pages2_range(mapping,
-					pos >> PAGE_SHIFT, end);
+	if (written > 0 && mapping->nrpages &&
+	    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
+		dio_warn_stale_pagecache(file);
 
 	if (written > 0) {
 		pos += written;


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB25ECEC6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 14:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKBNNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 09:13:04 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33616 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfKBNNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 09:13:04 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 86E512E1448;
        Sat,  2 Nov 2019 16:13:00 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WfxxPXTLLl-CxDGRls1;
        Sat, 02 Nov 2019 16:13:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572700380; bh=GjZu/WoaF6tLkOYo8V/8/nxWXOX7M22Xey9THKkbDAg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=nVYU5bX0BbcH6zHWDjqI/XmQO+CTu5XFgYSDvYlaAwo5vYPo0aOqkVigo7zamEC8Y
         EDDPzBGPap5oVpPYgXsfWXspAcqIfcl68YrX3o5oop+q/ZiGweb7Q5rmvOb6LLzlOY
         g1AJ1NPneLX5yh9imdgFt3qWuUzGxQeCMDsce4+M=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2QDPdOoyS9-CxWep5NX;
        Sat, 02 Nov 2019 16:12:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/3] fs: remove redundant cache invalidation after async
 direct-io write
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Sat, 02 Nov 2019 16:12:58 +0300
Message-ID: <157270037850.4812.15036239021726025572.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function generic_file_direct_write() invalidates cache at entry. Second
time this should be done when request completes. But this function calls
second invalidation at exit unconditionally even for async requests.

This patch skips second invalidation for async requests (-EIOCBQUEUED).

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 85b7d087eb45..288e38199068 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3218,9 +3218,11 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Most of the time we do not need this since dio_complete() will do
 	 * the invalidation for us. However there are some file systems that
 	 * do not end up with dio_complete() being called, so let's not break
-	 * them by removing it completely
+	 * them by removing it completely.
+	 *
+	 * Skip invalidation for async writes or if mapping has no pages.
 	 */
-	if (mapping->nrpages)
+	if (written > 0 && mapping->nrpages)
 		invalidate_inode_pages2_range(mapping,
 					pos >> PAGE_SHIFT, end);
 


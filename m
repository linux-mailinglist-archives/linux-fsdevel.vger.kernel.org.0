Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB02AFC88B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 15:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKNONR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 09:13:17 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42410 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfKNONR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:13:17 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2B84A2E0AFA;
        Thu, 14 Nov 2019 17:13:13 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id R7MDNftX9t-DCL0jej8;
        Thu, 14 Nov 2019 17:13:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573740793; bh=T+yAvGPHhC54Ai0zkddCJxsjSTzQ1zamGJyadlfR0iE=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=JiHvYyiZRsN1XQ17pFnDbh5fw49M4czRrPmrqpKm8zJ6xW9osVRA/XHZTKxdP4GXJ
         c2PWqcj4fLds6rdVGf+mlUQHDw4Vc0X64R7ZM6VotpOQytDo1bBp7gu4TgnXmOMfJa
         feYqTPy8Q63agSfd5z3ehFbQkiDuLap+0dtry+Xc=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla5-2bf13a090f43.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id OZhp7enQie-DCWOiTNr;
        Thu, 14 Nov 2019 17:13:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2] fs/splice: ignore flag SPLICE_F_GIFT in syscall vmsplice
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 17:13:11 +0300
Message-ID: <157374079193.8131.5211902043079599773.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Generic support of flag SPLICE_F_MOVE in syscall splice was removed in
kernel 2.6.21 commit 485ddb4b9741 ("1/2 splice: dont steal").
Infrastructure stay intact and this feature may came back.
At least driver or filesystem could provide own implementation.

But stealing mapped pages from userspace never worked and is very
unlikely that will ever make sense due to unmapping overhead.
Also lru handling is broken if gifted anon page spliced into file.

Let's seal entry point for marking page as a gift in vmsplice.

v2: remove PIPE_BUF_FLAG_GIFT and related dead code.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com/
---
 fs/fuse/dev.c             |    1 -
 fs/splice.c               |   41 +++--------------------------------------
 include/linux/pipe_fs_i.h |    1 -
 3 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ed1abc9e33cf..aacc4fa639ba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1987,7 +1987,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				goto out_free;
 
 			*obuf = *ibuf;
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
 			ibuf->offset += obuf->len;
 			ibuf->len -= obuf->len;
diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..6cc5098b164b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -145,23 +145,6 @@ const struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.get = generic_pipe_buf_get,
 };
 
-static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
-				    struct pipe_buffer *buf)
-{
-	if (!(buf->flags & PIPE_BUF_FLAG_GIFT))
-		return 1;
-
-	buf->flags |= PIPE_BUF_FLAG_LRU;
-	return generic_pipe_buf_steal(pipe, buf);
-}
-
-static const struct pipe_buf_operations user_page_pipe_buf_ops = {
-	.confirm = generic_pipe_buf_confirm,
-	.release = page_cache_pipe_buf_release,
-	.steal = user_page_pipe_buf_steal,
-	.get = generic_pipe_buf_get,
-};
-
 static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
@@ -1197,12 +1180,10 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 }
 
 static int iter_to_pipe(struct iov_iter *from,
-			struct pipe_inode_info *pipe,
-			unsigned flags)
+			struct pipe_inode_info *pipe)
 {
 	struct pipe_buffer buf = {
-		.ops = &user_page_pipe_buf_ops,
-		.flags = flags
+		.ops = &nosteal_pipe_buf_ops,
 	};
 	size_t total = 0;
 	int ret = 0;
@@ -1286,10 +1267,6 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 {
 	struct pipe_inode_info *pipe;
 	long ret = 0;
-	unsigned buf_flag = 0;
-
-	if (flags & SPLICE_F_GIFT)
-		buf_flag = PIPE_BUF_FLAG_GIFT;
 
 	pipe = get_pipe_info(file);
 	if (!pipe)
@@ -1298,7 +1275,7 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	pipe_lock(pipe);
 	ret = wait_for_space(pipe, flags);
 	if (!ret)
-		ret = iter_to_pipe(iter, pipe, buf_flag);
+		ret = iter_to_pipe(iter, pipe);
 	pipe_unlock(pipe);
 	if (ret > 0)
 		wakeup_pipe_readers(pipe);
@@ -1601,12 +1578,6 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			}
 			*obuf = *ibuf;
 
-			/*
-			 * Don't inherit the gift flag, we need to
-			 * prevent multiple steals of this page.
-			 */
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
-
 			pipe_buf_mark_unmergeable(obuf);
 
 			obuf->len = len;
@@ -1681,12 +1652,6 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		obuf = opipe->bufs + nbuf;
 		*obuf = *ibuf;
 
-		/*
-		 * Don't inherit the gift flag, we need to
-		 * prevent multiple steals of this page.
-		 */
-		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
-
 		pipe_buf_mark_unmergeable(obuf);
 
 		if (obuf->len > len)
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5c626fdc10db..1a3a5efb9c6f 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -6,7 +6,6 @@
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
-#define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 
 /**


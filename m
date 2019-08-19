Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41191D56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHSGxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 02:53:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:45104 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfHSGxz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:53:55 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hzbY7-0008J5-PI; Mon, 19 Aug 2019 09:53:52 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: BUG_ON correction in fuse_dev_splice_write()
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
Message-ID: <1b09a159-bcec-63c9-df42-47d99f44d445@virtuozzo.com>
Date:   Mon, 19 Aug 2019 09:53:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 963545357202 ("fuse: reduce allocation size for splice_write")
changed size of bufs array, so BUG_ON which checks the index of the array
shold also be fixed.

Fixes: 963545357202 ("fuse: reduce allocation size for splice_write")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..f4ef6e01642c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2029,7 +2029,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				     struct file *out, loff_t *ppos,
 				     size_t len, unsigned int flags)
 {
-	unsigned nbuf;
+	unsigned nbuf, bsize;
 	unsigned idx;
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
@@ -2043,7 +2043,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 
-	bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
+	bsize = pipe->nrbufs;
+	bufs = kvmalloc_array(bsize, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
 	if (!bufs) {
 		pipe_unlock(pipe);
@@ -2064,7 +2065,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		struct pipe_buffer *ibuf;
 		struct pipe_buffer *obuf;
 
-		BUG_ON(nbuf >= pipe->buffers);
+		BUG_ON(nbuf >= bsize);
 		BUG_ON(!pipe->nrbufs);
 		ibuf = &pipe->bufs[pipe->curbuf];
 		obuf = &bufs[nbuf];
-- 
2.17.1


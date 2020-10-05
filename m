Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562E283610
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgJENCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49721 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgJENCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:02:00 -0400
X-Greylist: delayed 2844 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 09:01:59 EDT
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 095CE9Nh043502;
        Mon, 5 Oct 2020 21:14:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Mon, 05 Oct 2020 21:14:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 095CE5ef043484
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Oct 2020 21:14:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] splice: fix premature end of input detection
Date:   Mon,  5 Oct 2020 21:13:39 +0900
Message-Id: <20201005121339.4063-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

splice() from pipe should return 0 when there is no pipe writer. However,
since commit a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write()
to preallocate slot") started inserting empty pages, splice() from pipe
also returns 0 when all ready buffers are empty pages.

----------
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        const int fd = open("/tmp/testfile", O_WRONLY | O_CREAT, 0600);
        int pipe_fd[2] = { -1, -1 };
        pipe(pipe_fd);
        write(pipe_fd[1], NULL, 4096);
	/* This splice() should wait unless interrupted. */
        return !splice(pipe_fd[0], NULL, fd, NULL, 65536, 0);
}
----------

Since such behavior might confuse splice() users, let's fix it by waiting
for non-empty pages inside splice_from_pipe_next().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write() to preallocate slot")
Cc: stable@vger.kernel.org # 5.5+
---
 fs/splice.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index c3d00dfc7344..b58c7ebf6805 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -538,6 +538,8 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
  */
 static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_desc *sd)
 {
+	unsigned int head, tail, mask;
+
 	/*
 	 * Check for signal early to make process killable when there are
 	 * always buffers available
@@ -545,6 +547,7 @@ static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_des
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 
+ refill:
 	while (pipe_empty(pipe->head, pipe->tail)) {
 		if (!pipe->writers)
 			return 0;
@@ -566,7 +569,21 @@ static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_des
 		pipe_wait_readable(pipe);
 	}
 
-	return 1;
+	head = pipe->head;
+	tail = pipe->tail;
+	mask = pipe->ring_size - 1;
+
+	/* dismiss the empty buffers */
+	while (!pipe_empty(head, tail)) {
+		struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+
+		if (likely(buf->len))
+			return 1;
+		pipe_buf_release(pipe, buf);
+		pipe->tail = ++tail;
+	}
+	/* wait again if all buffers were empty */
+	goto refill;
 }
 
 /**
-- 
2.18.4


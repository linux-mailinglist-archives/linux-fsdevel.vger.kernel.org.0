Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF19114949
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfLEWam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 17:30:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22755 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727595AbfLEWam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575585041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38xi2TGNPFhGvwzO4gnWgKizEkSGuV4mkJf443b5kzE=;
        b=btEXa2mBquU2OW4DYQhTJol4vMeCyWyQm3zw0xi29ealAitFs/G2QusdGtHHvbQXbId85l
        NI4N3Y1w2/TOCBup2S8TxSHw9iGiukaQFZs2OjC8TtQF4uzLKSzHC7KjU4vMJ9leU+3w3H
        lZ2NvnAW3gcojjk1hthutJy3X3GZiNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-10AAV6W9MlCauT2HZuk5hQ-1; Thu, 05 Dec 2019 17:30:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BB94593A2;
        Thu,  5 Dec 2019 22:30:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D388160C80;
        Thu,  5 Dec 2019 22:30:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait() [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 22:30:37 +0000
Message-ID: <157558503716.10278.17734879104574600890.stgit@warthog.procyon.org.uk>
In-Reply-To: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 10AAV6W9MlCauT2HZuk5hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix pipe_write() to not cache the ring index mask and max_usage as their
values are invalidated by calling pipe_wait() because the latter function
drops the pipe lock, thereby allowing F_SETPIPE_SZ change them.  Without
this, pipe_write() may subsequently miscalculate the array indices and pipe
fullness, leading to an oops like the following:

 BUG: KASAN: slab-out-of-bounds in pipe_write+0xc25/0xe10 fs/pipe.c:481
 Write of size 8 at addr ffff8880771167a8 by task syz-executor.3/7987
 ...
 CPU: 1 PID: 7987 Comm: syz-executor.3 Not tainted 5.4.0-rc2-syzkaller #0
 ...
 Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x113/0x167 lib/dump_stack.c:113
  print_address_description.constprop.8.cold.10+0x9/0x31d mm/kasan/report.c:374
  __kasan_report.cold.11+0x1b/0x3a mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:137
  pipe_write+0xc25/0xe10 fs/pipe.c:481
  call_write_iter include/linux/fs.h:1895 [inline]
  new_sync_write+0x3fd/0x7e0 fs/read_write.c:483
  __vfs_write+0x94/0x110 fs/read_write.c:496
  vfs_write+0x18a/0x520 fs/read_write.c:558
  ksys_write+0x105/0x220 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x6e/0xb0 fs/read_write.c:620
  do_syscall_64+0xca/0x5d0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is not a problem for pipe_read() as the mask is recalculated on each
pass of the loop, after pipe_wait() has been called.

Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Biggers <ebiggers@kernel.org>
---

 fs/pipe.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index da782ee251d2..8061b093140d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -389,7 +389,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	unsigned int head, max_usage, mask;
+	unsigned int head;
 	ssize_t ret = 0;
 	int do_wakeup = 0;
 	size_t total_len = iov_iter_count(from);
@@ -408,13 +408,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	head = pipe->head;
-	max_usage = pipe->max_usage;
-	mask = pipe->ring_size - 1;
 
 	/* We try to merge small writes */
 	chars = total_len & (PAGE_SIZE-1); /* size of the last buffer */
 	if (!pipe_empty(head, pipe->tail) && chars != 0) {
-		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
+		struct pipe_buffer *buf =
+			&pipe->bufs[(head - 1) & (pipe->ring_size - 1)];
 		int offset = buf->offset + buf->len;
 
 		if (pipe_buf_can_merge(buf) && offset + chars <= PAGE_SIZE) {
@@ -443,8 +442,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 
 		head = pipe->head;
-		if (!pipe_full(head, pipe->tail, max_usage)) {
-			struct pipe_buffer *buf = &pipe->bufs[head & mask];
+		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
+			struct pipe_buffer *buf =
+				&pipe->bufs[head & (pipe->ring_size - 1)];
 			struct page *page = pipe->tmp_page;
 			int copied;
 
@@ -465,7 +465,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			spin_lock_irq(&pipe->wait.lock);
 
 			head = pipe->head;
-			if (pipe_full(head, pipe->tail, max_usage)) {
+			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
 				spin_unlock_irq(&pipe->wait.lock);
 				continue;
 			}
@@ -484,7 +484,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 
 			/* Insert it into the buffer array */
-			buf = &pipe->bufs[head & mask];
+			buf = &pipe->bufs[head & (pipe->ring_size - 1)];
 			buf->page = page;
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
@@ -510,7 +510,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 		}
 
-		if (!pipe_full(head, pipe->tail, max_usage))
+		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
 
 		/* Wait for buffer space to become available. */


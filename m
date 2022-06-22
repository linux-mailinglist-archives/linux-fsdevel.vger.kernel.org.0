Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B2554165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356876AbiFVEQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356707AbiFVEP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155FA6565
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2hUtpY7tF+1AULyN9gkMQD7g6cYjYFLHq4WPTwrgyC4=; b=YpT7wBNKlz7lWgcSGpBkV109xp
        /pJHlZB8tE5elQ0BNhXItGDTtmgrMqxbqYJmA8+0Uyj3vKtlKkwEavCdJWLKdZBoEmwCKNvcDhsGz
        JIVeWFNhd4GZZehK1czaDrag9Oerv9lbz1/HW7xk4LnB3gfFdPtUZ/0iLn2szNgrjK3o9b7vfcphV
        Ge3+ifHKfceUuc1UyT+IGyq2QuBcYDy5lXjS+ZXWChHw3l0G0YtDjMlH+dGH+GQFGj+iptGpnQySk
        gimplZnRrDcl13YOpgNzs5dcQOrl753CAct3Xnkj+WHCl8KAhsD256iYXQfhwnLf7W1yMuT4f1MBC
        wYhye1iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmU-0035wK-Hi;
        Wed, 22 Jun 2022 04:15:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 12/44] fix short copy handling in copy_mc_pipe_to_iter()
Date:   Wed, 22 Jun 2022 05:15:20 +0100
Message-Id: <20220622041552.737754-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
result in a short copy.  In that case we need to trim the unused
buffers, as well as the length of partially filled one - it's not
enough to set ->head, ->iov_offset and ->count to reflect how
much had we copied.  Not hard to fix, fortunately...

I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
rather than iov_iter.c - it has nothing to do with iov_iter and
having it will allow us to avoid an ugly kludge in fs/splice.c.
We could put it into lib/iov_iter.c for now and move it later,
but I don't see the point going that way...

Fixes: ca146f6f091e "lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/pipe_fs_i.h |  9 +++++++++
 lib/iov_iter.c            | 15 +++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index cb0fd633a610..4ea496924106 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -229,6 +229,15 @@ static inline bool pipe_buf_try_steal(struct pipe_inode_info *pipe,
 	return buf->ops->try_steal(pipe, buf);
 }
 
+static inline void pipe_discard_from(struct pipe_inode_info *pipe,
+		unsigned int old_head)
+{
+	unsigned int mask = pipe->ring_size - 1;
+
+	while (pipe->head > old_head)
+		pipe_buf_release(pipe, &pipe->bufs[--pipe->head & mask]);
+}
+
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
    memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
 #define PIPE_SIZE		PAGE_SIZE
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0b64695ab632..2bf20b48a04a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -689,6 +689,7 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 	struct pipe_inode_info *pipe = i->pipe;
 	unsigned int p_mask = pipe->ring_size - 1;
 	unsigned int i_head;
+	unsigned int valid = pipe->head;
 	size_t n, off, xfer = 0;
 
 	if (!sanity(i))
@@ -702,11 +703,17 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 		rem = copy_mc_to_kernel(p + off, addr + xfer, chunk);
 		chunk -= rem;
 		kunmap_local(p);
-		i->head = i_head;
-		i->iov_offset = off + chunk;
-		xfer += chunk;
-		if (rem)
+		if (chunk) {
+			i->head = i_head;
+			i->iov_offset = off + chunk;
+			xfer += chunk;
+			valid = i_head + 1;
+		}
+		if (rem) {
+			pipe->bufs[i_head & p_mask].len -= rem;
+			pipe_discard_from(pipe, valid);
 			break;
+		}
 		n -= chunk;
 		off = 0;
 		i_head++;
-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FED39D0BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhFFTNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFFTMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23125C06124A;
        Sun,  6 Jun 2021 12:10:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056ZI-OT; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 08/37] iov_iter_advance(): use consistent semantics for move past the end
Date:   Sun,  6 Jun 2021 19:10:22 +0000
Message-Id: <20210606191051.1216821-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

asking to advance by more than we have left in the iov_iter should
move to the very end; it should *not* leave negative i->count and
it should not spew into syslog, etc. - it's a legitimate operation.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a3aabeda945b..bdbe6691457d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1117,8 +1117,6 @@ static inline void pipe_truncate(struct iov_iter *i)
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	if (unlikely(i->count < size))
-		size = i->count;
 	if (size) {
 		struct pipe_buffer *buf;
 		unsigned int p_mask = pipe->ring_size - 1;
@@ -1159,6 +1157,8 @@ static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
 
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
+	if (unlikely(i->count < size))
+		size = i->count;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		pipe_advance(i, size);
 		return;
@@ -1168,7 +1168,6 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		return;
 	}
 	if (unlikely(iov_iter_is_xarray(i))) {
-		size = min(size, i->count);
 		i->iov_offset += size;
 		i->count -= size;
 		return;
-- 
2.11.0


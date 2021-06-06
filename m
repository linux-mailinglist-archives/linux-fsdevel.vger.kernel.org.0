Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE039D0BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFFTNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhFFTMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3628BC06124C;
        Sun,  6 Jun 2021 12:10:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAi-0056cr-0Q; Sun, 06 Jun 2021 19:10:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 35/37] pipe_zero(): we don't need no stinkin' kmap_atomic()...
Date:   Sun,  6 Jun 2021 19:10:49 +0000
Message-Id: <20210606191051.1216821-35-viro@zeniv.linux.org.uk>
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

	FWIW, memcpy_to_page() itself almost certainly ought to
use kmap_local_page()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 56d2606a47e4..7471fb181643 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -908,7 +908,9 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 
 	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memzero_page(pipe->bufs[i_head & p_mask].page, off, chunk);
+		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
+		memset(p + off, 0, chunk);
+		kunmap_local(p);
 		i->head = i_head;
 		i->iov_offset = off + chunk;
 		n -= chunk;
-- 
2.11.0


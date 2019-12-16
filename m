Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC7120308
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLPKyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 05:54:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfLPKyr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:54:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74189AC7D;
        Mon, 16 Dec 2019 10:54:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C0C51E0B2E; Mon, 16 Dec 2019 11:54:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] pipe: Fix bogus dereference in iov_iter_alignment()
Date:   Mon, 16 Dec 2019 11:54:32 +0100
Message-Id: <20191216105432.5969-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot look at 'i->pipe' unless we know the iter is a pipe. Move the
ring_size load to a branch in iov_iter_alignment() where we've already
checked the iter is a pipe to avoid bogus dereference.

Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/iov_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 Al, David, not sure who's going to merge this so sending to both :).

								Honza

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb29c02c6a3c..51595bf3af85 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1222,11 +1222,12 @@ EXPORT_SYMBOL(iov_iter_discard);
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	unsigned int p_mask = i->pipe->ring_size - 1;
 	unsigned long res = 0;
 	size_t size = i->count;
 
 	if (unlikely(iov_iter_is_pipe(i))) {
+		unsigned int p_mask = i->pipe->ring_size - 1;
+
 		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
 			return size | i->iov_offset;
 		return size;
-- 
2.16.4


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9E489511
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 10:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiAJJUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 04:20:13 -0500
Received: from smtp01.aussiebb.com.au ([121.200.0.92]:36148 "EHLO
        smtp01.aussiebb.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiAJJUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:20:08 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2022 04:20:05 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 4B67A102287;
        Mon, 10 Jan 2022 20:11:39 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7j31_hoD2O1z; Mon, 10 Jan 2022 20:11:39 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 424F810228F; Mon, 10 Jan 2022 20:11:39 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=10.0 tests=KHOP_HELO_FCRDNS,RDNS_DYNAMIC,
        SPF_HELO_NONE autolearn=disabled version=3.4.4
Received: from mickey.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 2ED02100059;
        Mon, 10 Jan 2022 20:11:37 +1100 (AEDT)
Subject: [PATCH] vfs: check dentry is still valid in get_link()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Date:   Mon, 10 Jan 2022 17:11:31 +0800
Message-ID: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When following a trailing symlink in rcu-walk mode it's possible for
the dentry to become invalid between the last dentry seq lock check
and getting the link (eg. an unlink) leading to a backtrace similar
to this:

crash> bt
PID: 10964  TASK: ffff951c8aa92f80  CPU: 3   COMMAND: "TaniumCX"
…
 #7 [ffffae44d0a6fbe0] page_fault at ffffffff8d6010fe
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffffae44d0a6fc90  RFLAGS: 00010246
    RAX: ffffffff8da3cc80  RBX: ffffae44d0a6fd30  RCX: 0000000000000000
    RDX: ffffae44d0a6fd98  RSI: ffff951aa9af3008  RDI: 0000000000000000
    RBP: 0000000000000000   R8: ffffae44d0a6fb94   R9: 0000000000000000
    R10: ffff951c95d8c318  R11: 0000000000080000  R12: ffffae44d0a6fd98
    R13: ffff951aa9af3008  R14: ffff951c8c9eb840  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffae44d0a6fc90] trailing_symlink at ffffffff8cf24e61
 #9 [ffffae44d0a6fcc8] path_lookupat at ffffffff8cf261d1
#10 [ffffae44d0a6fd28] filename_lookup at ffffffff8cf2a700
#11 [ffffae44d0a6fe40] vfs_statx at ffffffff8cf1dbc4
#12 [ffffae44d0a6fe98] __do_sys_newstat at ffffffff8cf1e1f9
#13 [ffffae44d0a6ff38] do_syscall_64 at ffffffff8cc0420b

Most of the time this is not a problem because the inode is unchanged
while the rcu read lock is held.

But xfs can re-use inodes which can result in the inode ->get_link()
method becoming invalid (or NULL).

This case needs to be checked for in fs/namei.c:get_link() and if
detected the walk re-started.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/namei.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..37a7dba3083b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1760,8 +1760,11 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	if (!res) {
 		const char * (*get)(struct dentry *, struct inode *,
 				struct delayed_call *);
-		get = inode->i_op->get_link;
+		get = READ_ONCE(inode->i_op->get_link);
 		if (nd->flags & LOOKUP_RCU) {
+			/* Does the inode still match the associated dentry? */
+			if (unlikely(read_seqcount_retry(&link->dentry->d_seq, last->seq)))
+				return ERR_PTR(-ECHILD);
 			res = get(NULL, inode, &last->done);
 			if (res == ERR_PTR(-ECHILD) && try_to_unlazy(nd))
 				res = get(link->dentry, inode, &last->done);



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BFA44FD1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 03:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhKOC1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 21:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhKOC1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:27:35 -0500
Received: from smtp02.aussiebb.com.au (smtp02.aussiebb.com.au [IPv6:2403:5800:3:25::1002])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFFEC061766;
        Sun, 14 Nov 2021 18:24:31 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id 605BF102D6F;
        Mon, 15 Nov 2021 13:24:26 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp02.aussiebb.com.au
Received: from smtp02.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp02.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tkVJymr6ixVb; Mon, 15 Nov 2021 13:24:26 +1100 (AEDT)
Received: by smtp02.aussiebb.com.au (Postfix, from userid 116)
        id 4D31F102D81; Mon, 15 Nov 2021 13:24:25 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp02.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id 69FE7102D6F;
        Mon, 15 Nov 2021 13:24:22 +1100 (AEDT)
Subject: [PATCH 2 1/2] vfs: check dentry is still valid in get_link()
From:   Ian Kent <raven@themaw.net>
To:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Nov 2021 10:24:22 +0800
Message-ID: <163694306216.229789.2523433978081516384.stgit@mickey.themaw.net>
In-Reply-To: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
References: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
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
 0 files changed

diff --git a/fs/namei.c b/fs/namei.c
index 1946d9667790..9a48a6106516 100644
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



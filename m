Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302D7B4AD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjJBCeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:34:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8F4C9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ei3uI6cTnZl/1dVU+F9NiIsmbxC2qsdW7ypmVtPBOB0=; b=bj5e4xKMx0OGtympFCMd0zBsKH
        09xGajJhIoLMgja0HmmP/BGX+QDowTqBe6TSeLXYb3/S4HBIu5MyXHP/Iobi11nPnagizE9PyCinc
        1ufsduIYV13JnhQRp5Qt6e/Sm9cT+M1W2I4uJ0nv0axFvhqBbCji/qSQF3FeL+RV2gnvVSjCBDwKl
        bMecnGL0Fycm+qzu+QMKWR/Q7kg1XFKIZGwtMQB6uavYJNcxUx2EXCoaZ+HJ12i5JV064xlAC/w9B
        dzJNisikbWM5vo7Tvxz1HgAY05pjpF8thc7zX2RSKfCKOtR/9lYiaeoq1k10Zveb/BhJAKjZKInPN
        NoyAk/IQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8lE-00EDw2-31;
        Mon, 02 Oct 2023 02:34:17 +0000
Date:   Mon, 2 Oct 2023 03:34:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/15] nfs: make nfs_set_verifier() safe for use in RCU
 pathwalk
Message-ID: <20231002023416.GJ3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nfs_set_verifier() relies upon dentry being pinned; if that's
the case, grabbing ->d_lock stabilizes ->d_parent and guarantees
that ->d_parent points to a positive dentry.  For something
we'd run into in RCU mode that is *not* true - dentry might've
been through dentry_kill() just as we grabbed ->d_lock, with
its parent going through the same just as we get to into
nfs_set_verifier_locked().  It might get to detaching inode
(and zeroing ->d_inode) before nfs_set_verifier_locked() gets
to fetching that; we get an oops as the result.

That can happen in nfs{,4} ->d_revalidate(); we check that
parent is positive, but that's done before we get to
nfs_set_verifier() and it's possible for memory pressure
to pick our dentry as eviction candidate by that time.
If that happens, back-to-back attempts to kill dentry and
its parent are quite normal.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e6a51fd94fea..8ffc1f78ba51 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1431,9 +1431,9 @@ static bool nfs_verifier_is_delegated(struct dentry *dentry)
 static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long verf)
 {
 	struct inode *inode = d_inode(dentry);
-	struct inode *dir = d_inode(dentry->d_parent);
+	struct inode *dir = d_inode_rcu(dentry->d_parent);
 
-	if (!nfs_verify_change_attribute(dir, verf))
+	if (!dir || !nfs_verify_change_attribute(dir, verf))
 		return;
 	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		nfs_set_verifier_delegated(&verf);
-- 
2.39.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403AD56D361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 05:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGKDhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 23:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:37:44 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656762D3;
        Sun, 10 Jul 2022 20:37:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id DD50D10052F;
        Mon, 11 Jul 2022 13:37:41 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mhwLkaRdPbHE; Mon, 11 Jul 2022 13:37:41 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id CAB3910052E; Mon, 11 Jul 2022 13:37:41 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 2647710051D;
        Mon, 11 Jul 2022 13:37:41 +1000 (AEST)
Subject: [PATCH 1/3] vfs: track count of child mounts
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 11:37:40 +0800
Message-ID: <165751066075.210556.17270883735094115327.stgit@donald.themaw.net>
In-Reply-To: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the total reference count of a mount is mostly all that's needed
the reference count corresponding to the mounts only is occassionally
also needed (for example, autofs checking if a tree of mounts can be
expired).

To make this reference count avaialble with minimal changes add a
counter to track the number of child mounts under a given mount. This
count can then be used to calculate the mounts only reference count.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/mount.h     |    1 +
 fs/namespace.c |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 0b6e08cf8afb..3f0f62912463 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -52,6 +52,7 @@ struct mount {
 	int mnt_writers;
 #endif
 	struct list_head mnt_mounts;	/* list of children, anchored here */
+	unsigned int mnt_mounts_cnt;	/* count of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
diff --git a/fs/namespace.c b/fs/namespace.c
index e6a7e769d25d..3c1ee5b5bb69 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -882,6 +882,8 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
 	struct mountpoint *mp;
 	mnt->mnt_parent = mnt;
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
+	if (!list_empty(&mnt->mnt_child))
+		mnt->mnt_parent->mnt_mounts_cnt--;
 	list_del_init(&mnt->mnt_child);
 	hlist_del_init_rcu(&mnt->mnt_hash);
 	hlist_del_init(&mnt->mnt_mp_list);
@@ -918,6 +920,7 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
 	hlist_add_head_rcu(&mnt->mnt_hash,
 			   m_hash(&parent->mnt, mnt->mnt_mountpoint));
 	list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
+	parent->mnt_mounts_cnt++;
 }
 
 /*
@@ -936,6 +939,8 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	struct mountpoint *old_mp = mnt->mnt_mp;
 	struct mount *old_parent = mnt->mnt_parent;
 
+	if (!list_empty(&mnt->mnt_child))
+		mnt->mnt_parent->mnt_mounts_cnt--;
 	list_del_init(&mnt->mnt_child);
 	hlist_del_init(&mnt->mnt_mp_list);
 	hlist_del_init_rcu(&mnt->mnt_hash);
@@ -1562,6 +1567,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 	/* Hide the mounts from mnt_mounts */
 	list_for_each_entry(p, &tmp_list, mnt_list) {
+		if (!list_empty(&p->mnt_child))
+			p->mnt_parent->mnt_mounts_cnt--;
 		list_del_init(&p->mnt_child);
 	}
 
@@ -1590,6 +1597,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			if (!disconnect) {
 				/* Don't forget about p */
 				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
+				p->mnt_parent->mnt_mounts_cnt++;
 			} else {
 				umount_mnt(p);
 			}



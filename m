Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE533A7BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhFOK2Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:28:25 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43447 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231625AbhFOK2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:28:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-wu-Lyb9TPteVua-OfWEG7g-1; Tue, 15 Jun 2021 06:26:17 -0400
X-MC-Unique: wu-Lyb9TPteVua-OfWEG7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFBA81841E;
        Tue, 15 Jun 2021 10:26:15 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-40.sin2.redhat.com [10.67.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19EDA5D9DD;
        Tue, 15 Jun 2021 10:26:08 +0000 (UTC)
Subject: [PATCH v7 2/6] kernfs: add a revision to identify directory node
 changes
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Jun 2021 18:26:07 +0800
Message-ID: <162375276735.232295.14056277248741694521.stgit@web.messagingengine.com>
In-Reply-To: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed during negative dentry
revalidation.

There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
on all architectures and as far as I know that assumption holds.

So adding a revision counter to the struct kernfs_elem_dir variant of
the kernfs_node type union won't increase the size of the kernfs_node
struct. This is because struct kernfs_elem_dir is at least
sizeof(pointer) smaller than the largest union variant. It's tempting
to make the revision counter a u64 but that would increase the size of
kernfs_node on archs where sizeof(pointer) is smaller than the revision
counter.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |    3 +++
 fs/kernfs/kernfs-internal.h |   19 +++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 27 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 33166ec90a112..48704c5b6a072 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	/* successfully added, account subdir number */
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
+	kernfs_inc_rev(kn->parent);
 
 	return 0;
 }
@@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
+	kernfs_inc_rev(kn->parent);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
@@ -1573,6 +1575,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	 */
 	kernfs_unlink_sibling(kn);
 	kernfs_get(new_parent);
+	kernfs_inc_rev(new_parent);
 
 	/* rename_lock protects ->parent and ->name accessors */
 	spin_lock_irq(&kernfs_rename_lock);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306f..6a38897b4d02c 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,25 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct kernfs_node *parent,
+				  struct dentry *dentry)
+{
+	dentry->d_time = parent->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *parent)
+{
+	parent->dir.rev++;
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *parent,
+				      struct dentry *dentry)
+{
+	if (parent->dir.rev != dentry->d_time)
+			return true;
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c268..d68b4ad095737 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during negative dentry revalidation.
+	 */
+	unsigned long		rev;
 };
 
 struct kernfs_elem_symlink {



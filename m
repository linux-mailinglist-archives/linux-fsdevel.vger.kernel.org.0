Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81A39D959
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFGKNz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 7 Jun 2021 06:13:55 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:47544 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhFGKNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:13:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-NXXZWSTrMd2nfJ8Azb3ccA-1; Mon, 07 Jun 2021 06:12:01 -0400
X-MC-Unique: NXXZWSTrMd2nfJ8Azb3ccA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B61F6A2A1;
        Mon,  7 Jun 2021 10:11:59 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 728265C1C2;
        Mon,  7 Jun 2021 10:11:52 +0000 (UTC)
Subject: [PATCH v5 2/6] kernfs: add a revision to identify directory node
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
Date:   Mon, 07 Jun 2021 18:11:50 +0800
Message-ID: <162306071065.69474.8064509709844383785.stgit@web.messagingengine.com>
In-Reply-To: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed.

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
 fs/kernfs/dir.c             |    8 ++++++++
 fs/kernfs/kernfs-internal.h |   24 ++++++++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 37 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 33166ec90a112..b88432c48851f 100644
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
@@ -1105,6 +1107,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
+	if (!IS_ERR(ret)) {
+		if (unlikely(ret))
+			kernfs_set_rev(parent, ret);
+		else
+			kernfs_set_rev(parent, dentry);
+	}
  out_unlock:
 	mutex_unlock(&kernfs_mutex);
 	return ret;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306f..1536002584fc4 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,30 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct kernfs_node *kn,
+				  struct dentry *dentry)
+{
+	if (kernfs_type(kn) == KERNFS_DIR)
+		dentry->d_time = kn->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *kn)
+{
+	if (kernfs_type(kn) == KERNFS_DIR)
+		kn->dir.rev++;
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *kn,
+				      struct dentry *dentry)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		/* Not really a time bit it does what's needed */
+		if (time_after(kn->dir.rev, dentry->d_time))
+			return true;
+	}
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c268..7947acb1163d7 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during revalidation.
+	 */
+	unsigned long rev;
 };
 
 struct kernfs_elem_symlink {



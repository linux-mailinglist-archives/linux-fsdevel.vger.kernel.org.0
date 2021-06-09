Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D513A0EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 10:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhFIIwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Jun 2021 04:52:19 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:39450 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237740AbhFIIwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:52:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-qhieEAuNNmGzp1Y2k73bTw-1; Wed, 09 Jun 2021 04:50:23 -0400
X-MC-Unique: qhieEAuNNmGzp1Y2k73bTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1757801B15;
        Wed,  9 Jun 2021 08:50:21 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-20.sin2.redhat.com [10.67.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAD1D60918;
        Wed,  9 Jun 2021 08:50:02 +0000 (UTC)
Subject: [PATCH v6 2/7] kernfs: add a revision to identify directory node
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
Date:   Wed, 09 Jun 2021 16:49:59 +0800
Message-ID: <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
In-Reply-To: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 fs/kernfs/dir.c             |    2 ++
 fs/kernfs/kernfs-internal.h |   23 +++++++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 30 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 33166ec90a112..b3d1bc0f317d0 100644
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
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306f..b4e7579e04799 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,29 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
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
+		if (kn->dir.rev != dentry->d_time)
+			return true;
+	}
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c268..d7e0160fce6df 100644
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
+	unsigned long rev;
 };
 
 struct kernfs_elem_symlink {



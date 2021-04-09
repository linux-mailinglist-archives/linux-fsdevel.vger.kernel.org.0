Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC13359138
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhDIBPU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Apr 2021 21:15:20 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29579 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233099AbhDIBPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:15:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-k-zj24ryMDerVoJgEso_Sg-1; Thu, 08 Apr 2021 21:15:02 -0400
X-MC-Unique: k-zj24ryMDerVoJgEso_Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9704910054F6;
        Fri,  9 Apr 2021 01:15:00 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B26E10016FC;
        Fri,  9 Apr 2021 01:14:56 +0000 (UTC)
Subject: [PATCH v3 1/4] kernfs: move revalidate to be near lookup
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 09:14:54 +0800
Message-ID: <161793089488.10062.4398328199044761298.stgit@mickey.themaw.net>
In-Reply-To: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the dentry operation kernfs_dop_revalidate() is grouped with
dentry type functions it also has a strong affinity to the inode
operation ->lookup().

In order to take advantage of the VFS negative dentry caching that
can be used to reduce path lookup overhead on non-existent paths it
will need to call kernfs_find_ns(). So, to avoid a forward declaration,
move it to be near kernfs_iop_lookup().

There's no functional change from this patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7e0e62deab53c..4c69e2af82dac 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -548,49 +548,6 @@ void kernfs_put(struct kernfs_node *kn)
 }
 EXPORT_SYMBOL_GPL(kernfs_put);
 
-static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	struct kernfs_node *kn;
-
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
-
-	kn = kernfs_dentry_node(dentry);
-	mutex_lock(&kernfs_mutex);
-
-	/* The kernfs node has been deactivated */
-	if (!kernfs_active(kn))
-		goto out_bad;
-
-	/* The kernfs node has been moved? */
-	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
-		goto out_bad;
-
-	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) != 0)
-		goto out_bad;
-
-	/* The kernfs node has been moved to a different namespace */
-	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
-	    kernfs_info(dentry->d_sb)->ns != kn->ns)
-		goto out_bad;
-
-	mutex_unlock(&kernfs_mutex);
-	return 1;
-out_bad:
-	mutex_unlock(&kernfs_mutex);
-out_bad_unlocked:
-	return 0;
-}
-
-const struct dentry_operations kernfs_dops = {
-	.d_revalidate	= kernfs_dop_revalidate,
-};
-
 /**
  * kernfs_node_from_dentry - determine kernfs_node associated with a dentry
  * @dentry: the dentry in question
@@ -1073,6 +1030,49 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	return ERR_PTR(rc);
 }
 
+static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct kernfs_node *kn;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	/* Always perform fresh lookup for negatives */
+	if (d_really_is_negative(dentry))
+		goto out_bad_unlocked;
+
+	kn = kernfs_dentry_node(dentry);
+	mutex_lock(&kernfs_mutex);
+
+	/* The kernfs node has been deactivated */
+	if (!kernfs_active_read(kn))
+		goto out_bad;
+
+	/* The kernfs node has been moved? */
+	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
+		goto out_bad;
+
+	/* The kernfs node has been renamed */
+	if (strcmp(dentry->d_name.name, kn->name) != 0)
+		goto out_bad;
+
+	/* The kernfs node has been moved to a different namespace */
+	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
+	    kernfs_info(dentry->d_sb)->ns != kn->ns)
+		goto out_bad;
+
+	mutex_unlock(&kernfs_mutex);
+	return 1;
+out_bad:
+	mutex_unlock(&kernfs_mutex);
+out_bad_unlocked:
+	return 0;
+}
+
+const struct dentry_operations kernfs_dops = {
+	.d_revalidate	= kernfs_dop_revalidate,
+};
+
 static struct dentry *kernfs_iop_lookup(struct inode *dir,
 					struct dentry *dentry,
 					unsigned int flags)



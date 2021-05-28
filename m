Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF049393D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 08:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhE1Gfq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 02:35:46 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:36008 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhE1Gfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 02:35:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-50KRAVwINrCR7Kux4--3Tg-1; Fri, 28 May 2021 02:34:03 -0400
X-MC-Unique: 50KRAVwINrCR7Kux4--3Tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3510E100747B;
        Fri, 28 May 2021 06:34:00 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-22.sin2.redhat.com [10.67.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51155B686;
        Fri, 28 May 2021 06:33:56 +0000 (UTC)
Subject: [REPOST PATCH v4 1/5] kernfs: move revalidate to be near lookup
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 28 May 2021 14:33:55 +0800
Message-ID: <162218363530.34379.16741129191900256265.stgit@web.messagingengine.com>
In-Reply-To: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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



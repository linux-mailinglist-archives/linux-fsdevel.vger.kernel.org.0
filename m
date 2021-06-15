Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F473A7BC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFOK2S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:28:18 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:25183 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231626AbhFOK2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:28:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-OdnGkFFxNaOnHM96DJar5g-1; Tue, 15 Jun 2021 06:26:04 -0400
X-MC-Unique: OdnGkFFxNaOnHM96DJar5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 031F0100C626;
        Tue, 15 Jun 2021 10:26:02 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-40.sin2.redhat.com [10.67.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 118DA5D6AD;
        Tue, 15 Jun 2021 10:25:54 +0000 (UTC)
Subject: [PATCH v7 1/6] kernfs: move revalidate to be near lookup
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
Date:   Tue, 15 Jun 2021 18:25:53 +0800
Message-ID: <162375275365.232295.8995526416263659926.stgit@web.messagingengine.com>
In-Reply-To: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
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

It makes sense to locate this function near to kernfs_iop_lookup()
because we will be adding VFS negative dentry caching to reduce path
lookup overhead for non-existent paths.

There's no functional change from this patch.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7e0e62deab53c..33166ec90a112 100644
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
+	if (!kernfs_active(kn))
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



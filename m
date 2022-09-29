Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892815EF125
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiI2JBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiI2JBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:01:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A8139BED;
        Thu, 29 Sep 2022 02:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74083B823C7;
        Thu, 29 Sep 2022 09:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF2C433D6;
        Thu, 29 Sep 2022 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664442098;
        bh=kq6rXW2klw0ESB/4qUFAE9u6eDjBGnz78vnIkkPqWMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAOu5aEq0+XL1zslTVIihn5E4n30rr43tdU8lEzy+cx9CCRqY+RFVkHwOOkjKWGBI
         Bs3VJzwzMQKkPeDFCFxOeBxvYnk8meW+QVaba9U/JMsJzJilK/OJ7jtewBZtrqJbfw
         OFjff3nSMN6rR0/RVnSj3BJImw3XTvcmoC5aiD5/YFs2XPGEt80nzaXy4bsHo5QOK8
         zRr7TFTNVZ8Nqg8oGAgt0DYFBTeKFRFmHa9dEfErQmjZMnfj9e2ZdMohmee9UKtVqr
         5YHTRelleBn1xrLrIBic4VBkBjLDiWRB9iNnYgReQx9aHpdleNvcHuOnn/iNu4HDqA
         8ld2LyqS5dqhA==
Date:   Thu, 29 Sep 2022 11:01:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 14/29] acl: add vfs_set_acl()
Message-ID: <20220929090133.2pfff6ewdjsnbvot@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-15-brauner@kernel.org>
 <20220929081727.GB3699@lst.de>
 <20220929082554.5rclj4ioo37qg254@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929082554.5rclj4ioo37qg254@wittgenstein>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:25:59AM +0200, Christian Brauner wrote:
> On Thu, Sep 29, 2022 at 10:17:27AM +0200, Christoph Hellwig wrote:
> > > +EXPORT_SYMBOL(vfs_set_acl);
> > 
> > I think all this stackable file system infrastucture should be
> > EXPORT_SYMBOL_GPL, like a lot of the other internal stuff.
> 
> Ok, sounds good.
> 
> > 
> > > +int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> > > +		     const char *name, int mask)
> > 
> > Hmm.  The only think ACLs actually need from xattr_permission are
> > the immutable / append check and the HAS_UNMAPPED_ID one.  I'd rather
> > open code that, or if you cane come up with a sane name do a smaller
> > helper rather than doing all the strcmp on the prefixes for now
> > good reason.
> 
> I'll see if a little helper makes more sense than open-coding.

So I've added - which is then used in vfs_{set,remove}_acl():

commit 6ae39d028cb6990d69a7ec27386fc1bb7b1f3e3b
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Thu Sep 29 10:47:36 2022 +0200
Commit:     Christian Brauner (Microsoft) <brauner@kernel.org>
CommitDate: Thu Sep 29 10:59:27 2022 +0200

    internal: add may_write_xattr()
    
    Split out the generic checks whether an inode allows writing xattrs. Since
    security.* and system.* xattrs don't have any restrictions and we're going
    to split out posix acls into a dedicated api we will use this helper to
    check whether we can write posix acls.
    
    Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Notes:
    To: linux-fsdevel@vger.kernel.org
    Cc: Seth Forshee <sforshee@kernel.org>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Cc: linux-security-module@vger.kernel.org
    
    /* v2 */
    patch not present
    
    /* v3 */
    patch not present
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - Split out checks whether an inode can have xattrs written to into a helper.

diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..a95b1500ed65 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -221,3 +221,4 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
+int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..57148c207545 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -80,6 +80,28 @@ xattr_resolve_name(struct inode *inode, const char **name)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+/**
+ * may_write_xattr - check whether inode allows writing xattr
+ * @mnt_userns:	User namespace of the mount the inode was found from
+ * @inode: the inode on which to set an xattr
+ *
+ * Check whether the inode allows writing xattrs. Specifically, we can never
+ * set or remove an extended attribute on a read-only filesystem  or on an
+ * immutable / append-only inode.
+ *
+ * We also need to ensure that the inode has a mapping in the mount to
+ * not risk writing back invalid i_{g,u}id values.
+ *
+ * Return: On success zero is returned. On error a negative errno is returned.
+ */
+int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode)
+{
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) ||
+	    HAS_UNMAPPED_ID(mnt_userns, inode))
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
@@ -88,20 +110,12 @@ static int
 xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		 const char *name, int mask)
 {
-	/*
-	 * We can never set or remove an extended attribute on a read-only
-	 * filesystem  or on an immutable / append-only inode.
-	 */
 	if (mask & MAY_WRITE) {
-		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-			return -EPERM;
-		/*
-		 * Updating an xattr will likely cause i_uid and i_gid
-		 * to be writen back improperly if their true value is
-		 * unknown to the vfs.
-		 */
-		if (HAS_UNMAPPED_ID(mnt_userns, inode))
-			return -EPERM;
+		int ret;
+
+		ret = may_write_xattr(mnt_userns, inode);
+		if (ret)
+			return ret;
 	}
 
 	/*

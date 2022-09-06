Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F725AE186
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiIFHpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiIFHpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:45:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237AF1CB23
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 00:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A7B2B815A0
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 07:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C75C433D6;
        Tue,  6 Sep 2022 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662450336;
        bh=hH8zYDFVf5JPVlcE5MMqiJAthjtCZc5ZdVMuH44apdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBNhEvaPUc2z0vuH4omog79ZftHNle1TUeN5AsnQY/CK2WXyTOhRwd1xqxoFLC+lT
         E4JTnPe3I2U0T2HmXn5rHRZ4JJ1gC9NmwGlG4eUkxeHfERfHnQmA+GEfTgS7khPbcw
         6HEH/ShF8QgrNCmdwshI94XDFh88RPC0PbHdB9kyZkumX2PBcunX0awvng6oTtqRoL
         +k3VZjmKtv6terNgWJfdcl/imqGk702gUHPBcKBWHXjZn1X8Y2298R89/UMj9/Hs0L
         OheWdV7kWjCLCF8Dd8v07Domu4BU10Ky4WF2IXIHXM+/AnwuajZKV4PxIMtkcS1i4E
         mtmfwP8dO5d+A==
Date:   Tue, 6 Sep 2022 09:45:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-4-brauner@kernel.org>
 <20220906045746.GB32578@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906045746.GB32578@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:57:46AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 29, 2022 at 02:38:42PM +0200, Christian Brauner wrote:
> > Various filesystems store POSIX ACLs on the backing store in their uapi
> > format. Such filesystems need to translate from the uapi POSIX ACL
> > format into the VFS format during i_op->get_acl(). The VFS provides the
> > posix_acl_from_xattr() helper for this task.
> 
> This has always been rather confusing.  Maybe we should add a separate

Absolutely and it's pretty unsafe given that we're storing k{g,u}id_t in
the uapi struct in the form of {g,u}id_t which we then recover later on.
But I've documented this as best as I could in the helpers.

> structure type for the on-disk vs uapi ACL formats?  They will be the

We do already have separate format for uapi and VFS ACLs. I'm not sure
if you're suggesting another intermediate format.

I'm currently working on a larger series to get rid of the uapi struct
abuse for POSIX ACLs. Building on that work Seth will get rid of similar
abuses for VFS caps. I'm fairly close but the rough idea is:

struct xattr_args {
	const char *name;
	union {
		struct posix_acl *kacl;
		const void *kvalue;
		void *buffer;
	};
	size_t size;
};

struct xattr_handler {
	const char *name;
	const char *prefix;
	int flags;
	bool (*list)(struct dentry *dentry);
	int (*get)(const struct xattr_handler *,
		   struct dentry *dentry,
		   struct inode *inode,
		   struct xattr_args *args);
	int (*set)(const struct xattr_handler *,
		   struct user_namespace *mnt_userns,
		   struct dentry *dentry,
		   struct inode *inode,
		   const struct xattr_args *args,
		   int flags);
};

All __vfs_{g,s}etxattr() helpers stay the same and can't be used to
{g,s}et POSIX ACLs anymore instead we add:

int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
		const char *acl_name, struct posix_acl *acl, int flags)
{
	struct xattr_args xattr_args = {
		.name = acl_name,
	};

	if (!is_posix_acl_xattr(acl_name))
		return -EINVAL;

	return set_xattr_args(mnt_userns, dentry, &xattr_args, flags);
}

int vfs_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
		const char *acl_name, struct posix_acl **acl)
{
	int error;
	struct xattr_args xattr_args = {
		.name = acl_name,
	};

	if (!is_posix_acl_xattr(acl_name))
		return -EINVAL;

	error = get_xattr_args(mnt_userns, dentry, &xattr_args);
	if (error < 0)
		return error;

	*acl = xattr_args.kacl;
	return 0;
}

These two vfs helpers can then used by filesystems like overlayfs to set
POSIX ACLs. This gets rid of passing crucial data that the VFS needs to
interpret around in a void * blob as that's causing a lot of issues
currently bc often filesystems or security hooks don't have any idea how
to interpret them correctly.

So the internal vfs api for getxattr() itself would then be:

ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *d,
		   struct xattr_ctx *ctx)
{
	struct posix_acl *kacl = NULL;

	error = vfs_get_acl(mnt_userns, d, ctx->kname->name, &kacl);
	if (error)
		return error;

	/* convert to uapi format */
	if (ctx->size)
		error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(d),
					       ctx->kacl, ctx->kvalue,
					       ctx->size);
	posix_acl_release(kacl);
	return error;
}

ssize_t
do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
	struct xattr_ctx *ctx)
{
	ssize_t error;
	char *kname = ctx->kname->name;

	if (ctx->size) {
		if (ctx->size > XATTR_SIZE_MAX)
			ctx->size = XATTR_SIZE_MAX;
		ctx->kvalue = kvzalloc(ctx->size, GFP_KERNEL);
		if (!ctx->kvalue)
			return -ENOMEM;
	}

	if (is_posix_acl_xattr(ctx->kname->name))
		error = do_get_acl(mnt_userns, d, ctx);
	else
		error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
	if (error > 0) {
		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
			error = -EFAULT;
	} else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
		/* The file system tried to returned a value bigger
		   than XATTR_SIZE_MAX bytes. Not possible. */
		error = -E2BIG;
	}

	return error;
}

and all the helpers that hack stuff into uapi POSIX ACLs are then gone.
I'm fairly along but I'm happy to hear alternative ideas.

Christian

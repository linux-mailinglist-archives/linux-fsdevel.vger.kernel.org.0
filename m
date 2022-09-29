Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04435EF057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiI2IZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiI2IZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04672BE2D;
        Thu, 29 Sep 2022 01:25:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 924F468BFE; Thu, 29 Sep 2022 10:25:35 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:25:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 23/29] xattr: use posix acl api
Message-ID: <20220929082535.GC3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-24-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-24-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:08:37PM +0200, Christian Brauner wrote:
> +static int setxattr_convert(struct user_namespace *mnt_userns, struct dentry *d,
> +			    struct xattr_ctx *ctx)
>  {
> -	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
> -		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
> +	struct posix_acl *acl;
> +
> +	if (!ctx->size || !is_posix_acl_xattr(ctx->kname->name))
> +		return 0;
> +
> +	/*
> +	 * Note that posix_acl_from_xattr() uses GFP_NOFS when it probably
> +	 * doesn't need to here.
> +	 */
> +	acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue, ctx->size);
> +	if (IS_ERR(acl))
> +		return PTR_ERR(acl);
> +
> +	ctx->acl = acl;
> +	return 0;

why is this called setxattr_convert when it is clearly about ACLs only?

> +
> +	error = setxattr_convert(mnt_userns, dentry, ctx);
> +	if (error)
> +		return error;
> +
> +	if (is_posix_acl_xattr(ctx->kname->name))
> +		return vfs_set_acl(mnt_userns, dentry,
> +				   ctx->kname->name, ctx->acl);

Also instead of doing two checks for ACLs why not do just one?  And then
have a comment helper to convert and set which can live in posix_acl.c.

No need to store anything in a context with that either.

> @@ -610,6 +642,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
>  	error = do_setxattr(mnt_userns, d, &ctx);
>  
>  	kvfree(ctx.kvalue);
> +	posix_acl_release(ctx.acl);
>  	return error;

And I don't think there is any good reason to not release the ACL
right after the call to vfs_set_acl.  Which means there is no need to
store anything in the ctx.

> +	if (is_posix_acl_xattr(ctx->kname->name)) {
> +		ctx->acl = vfs_get_acl(mnt_userns, d, ctx->kname->name);
> +		if (IS_ERR(ctx->acl))
> +			return PTR_ERR(ctx->acl);
> +
> +		error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(d), ctx->acl,
> +					       ctx->kvalue, ctx->size);
> +		posix_acl_release(ctx->acl);

An while this is just a small function body I still think splitting it
into a helper and moving it to posix_acl.c would be a bit cleaner.

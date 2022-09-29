Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097B5EF18A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiI2JM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiI2JMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:12:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98713BCE5;
        Thu, 29 Sep 2022 02:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F96B823C1;
        Thu, 29 Sep 2022 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE52C433D6;
        Thu, 29 Sep 2022 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664442632;
        bh=AkjKSrE7Dw3OL7bFNtOEzixArCbqf68zT+R/DFakqN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5jH1MGW3Rr7c2psLbN9QCuR0FCaFRbhisqf5DTWSI63Il3Oi8BHuaUvbUCEs/SKs
         KV0diFx4cQB0nfPyHeR5dZbGgJAaftVTTiacxLwEkbxCmA2aG1+5HRqdKgqCuZ6P/w
         zhB0lfia4N6uyIyF9q8WpHqY6V83fZgB+GSgBTHyjd9C5AEPlHg8QiiNwcIxzzwakr
         Kx2+vuyfxLNpt0tKbcU393ZtOPWkOj1n88LRH+wjNBg1ew+P24mIWWXyFkyiqEsekL
         HSZX5FnN31o8/t69Xsr8kPUftmVlwlV2oAKXMr4KJ8grWotxUYMo+yJvG9evuEG0cv
         YfdPtGGpSlFDw==
Date:   Thu, 29 Sep 2022 11:10:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 23/29] xattr: use posix acl api
Message-ID: <20220929091027.ddw6kbdy2s7ywvh4@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-24-brauner@kernel.org>
 <20220929082535.GC3699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929082535.GC3699@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:25:35AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 28, 2022 at 06:08:37PM +0200, Christian Brauner wrote:
> > +static int setxattr_convert(struct user_namespace *mnt_userns, struct dentry *d,
> > +			    struct xattr_ctx *ctx)
> >  {
> > -	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
> > -		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
> > +	struct posix_acl *acl;
> > +
> > +	if (!ctx->size || !is_posix_acl_xattr(ctx->kname->name))
> > +		return 0;
> > +
> > +	/*
> > +	 * Note that posix_acl_from_xattr() uses GFP_NOFS when it probably
> > +	 * doesn't need to here.
> > +	 */
> > +	acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue, ctx->size);
> > +	if (IS_ERR(acl))
> > +		return PTR_ERR(acl);
> > +
> > +	ctx->acl = acl;
> > +	return 0;
> 
> why is this called setxattr_convert when it is clearly about ACLs only?

I think that's from Stefan's (Roesch) series to add xattr support to io_uring.

> 
> > +
> > +	error = setxattr_convert(mnt_userns, dentry, ctx);
> > +	if (error)
> > +		return error;
> > +
> > +	if (is_posix_acl_xattr(ctx->kname->name))
> > +		return vfs_set_acl(mnt_userns, dentry,
> > +				   ctx->kname->name, ctx->acl);
> 
> Also instead of doing two checks for ACLs why not do just one?  And then
> have a comment helper to convert and set which can live in posix_acl.c.
> 
> No need to store anything in a context with that either.
> 
> > @@ -610,6 +642,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
> >  	error = do_setxattr(mnt_userns, d, &ctx);
> >  
> >  	kvfree(ctx.kvalue);
> > +	posix_acl_release(ctx.acl);
> >  	return error;
> 
> And I don't think there is any good reason to not release the ACL
> right after the call to vfs_set_acl.  Which means there is no need to
> store anything in the ctx.
> 
> > +	if (is_posix_acl_xattr(ctx->kname->name)) {
> > +		ctx->acl = vfs_get_acl(mnt_userns, d, ctx->kname->name);
> > +		if (IS_ERR(ctx->acl))
> > +			return PTR_ERR(ctx->acl);
> > +
> > +		error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(d), ctx->acl,
> > +					       ctx->kvalue, ctx->size);
> > +		posix_acl_release(ctx->acl);
> 
> An while this is just a small function body I still think splitting it
> into a helper and moving it to posix_acl.c would be a bit cleaner.

All good points. I'll see how workable this is.

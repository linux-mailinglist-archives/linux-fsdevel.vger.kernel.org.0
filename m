Return-Path: <linux-fsdevel+bounces-42071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31501A3BFDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 14:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153AB1884F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE121E378C;
	Wed, 19 Feb 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBwr46wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23A1C84A9;
	Wed, 19 Feb 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971642; cv=none; b=JVdGXJUrbXEtetX353Blf43LT9P6UfWG8zUx2v9xpJGS7+NRwPuvL+AbZ6vQTuk/ngRTMQYM7s8a7PtQb86ICkqFMaBA6jbtVIDTFUSEusM1DTsJLp5P1jKXWv9D0p2YZQLgJveJke7pB0CjYj9KQAws7Okw1+IXYqbtyVxkX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971642; c=relaxed/simple;
	bh=jXnvKR0ON65nm/T34nLckUZTT9cXSk1XS813CF6QjtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMgZnu5uad0B5SjvgUEkq3ZifBqPbdM/sY/osujp8xsIHlVihFCcQeTMN8pZHRzedmNNZVGD4WnZTQo6cdBgVomqMFDTAkVlnOBURS1+IOHgPY7TJldTIYYBsP0r/oPcjnZOMUjaTBM4kHYa41hIsWIA7DzLEgP+mJ44wCT8sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBwr46wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7BEC4CED1;
	Wed, 19 Feb 2025 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739971641;
	bh=jXnvKR0ON65nm/T34nLckUZTT9cXSk1XS813CF6QjtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBwr46wm4DgHZoGv/ndGFYDWEftEkQ2EjUDBYYIV6ls2V26/+0+IimX5hjsNHvLPn
	 xrYsJA2nh1HQIqJ92WQ+xQuXVAM/glNBiXm/NruBoI2wc+wumUrPmywn8A1ddfJJIL
	 7jLy77N5+vLDRznpA0+EYT8jY10tuv/BTLfqjBltxZ/wxmj5/L1Qal3sWeFIetMxyo
	 VI3GBaxesqn8E6ShTMEZzW//03k2s935HeqHETLUk8UE34gHYWHuhJn6hngJCD6yVi
	 mU2MKyauXINEVzInpD56sgkljVs1fnTMHNygShLQ7Z91+K4x6z88Ciw3IIFW+UKLFN
	 iXKu7d5eddovw==
Date: Wed, 19 Feb 2025 14:27:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ovl: allow to specify override credentials
Message-ID: <20250219-seminar-pension-db6c7765953a@brauner>
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
 <20250219-work-overlayfs-v3-1-46af55e4ceda@kernel.org>
 <CAOQ4uxgU7fH=uwEaWo=ZaHSTzMfn4tBR5Oa+hc6LOqBCiS9cVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgU7fH=uwEaWo=ZaHSTzMfn4tBR5Oa+hc6LOqBCiS9cVA@mail.gmail.com>

On Wed, Feb 19, 2025 at 12:44:45PM +0100, Amir Goldstein wrote:
> On Wed, Feb 19, 2025 at 11:02 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Currently overlayfs uses the mounter's credentials for it's
> > override_creds() calls. That provides a consistent permission model.
> >
> > This patches allows a caller to instruct overlayfs to use its
> > credentials instead. The caller must be located in the same user
> > namespace hierarchy as the user namespace the overlayfs instance will be
> > mounted in. This provides a consistent and simple security model.
> >
> > With this it is possible to e.g., mount an overlayfs instance where the
> > mounter must have CAP_SYS_ADMIN but the credentials used for
> > override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
> > custom fs{g,u}id different from the callers and other tweaks.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  Documentation/filesystems/overlayfs.rst | 24 +++++++++++++++++++-----
> >  fs/overlayfs/params.c                   | 25 +++++++++++++++++++++++++
> >  fs/overlayfs/super.c                    | 16 +++++++++++++++-
> >  3 files changed, 59 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> > index 6245b67ae9e0..2db379b4b31e 100644
> > --- a/Documentation/filesystems/overlayfs.rst
> > +++ b/Documentation/filesystems/overlayfs.rst
> > @@ -292,13 +292,27 @@ rename or unlink will of course be noticed and handled).
> >  Permission model
> >  ----------------
> >
> > +An overlay filesystem stashes credentials that will be used when
> > +accessing lower or upper filesystems.
> > +
> > +In the old mount api the credentials of the task calling mount(2) are
> > +stashed. In the new mount api the credentials of the task creating the
> > +superblock through FSCONFIG_CMD_CREATE command of fsconfig(2) are
> > +stashed.
> > +
> > +Starting with kernel v6.15 it is possible to use the "override_creds"
> > +mount option which will cause the credentials of the calling task to be
> > +recorded. Note that "override_creds" is only meaningful when used with
> > +the new mount api as the old mount api combines setting options and
> > +superblock creation in a single mount(2) syscall.
> > +
> >  Permission checking in the overlay filesystem follows these principles:
> >
> >   1) permission check SHOULD return the same result before and after copy up
> >
> >   2) task creating the overlay mount MUST NOT gain additional privileges
> >
> > - 3) non-mounting task MAY gain additional privileges through the overlay,
> > + 3) task[*] MAY gain additional privileges through the overlay,
> >      compared to direct access on underlying lower or upper filesystems
> >
> >  This is achieved by performing two permission checks on each access:
> > @@ -306,7 +320,7 @@ This is achieved by performing two permission checks on each access:
> >   a) check if current task is allowed access based on local DAC (owner,
> >      group, mode and posix acl), as well as MAC checks
> >
> > - b) check if mounting task would be allowed real operation on lower or
> > + b) check if stashed credentials would be allowed real operation on lower or
> >      upper layer based on underlying filesystem permissions, again including
> >      MAC checks
> >
> > @@ -315,10 +329,10 @@ are copied up.  On the other hand it can result in server enforced
> >  permissions (used by NFS, for example) being ignored (3).
> >
> >  Check (b) ensures that no task gains permissions to underlying layers that
> > -the mounting task does not have (2).  This also means that it is possible
> > +the stashed credentials do not have (2).  This also means that it is possible
> >  to create setups where the consistency rule (1) does not hold; normally,
> > -however, the mounting task will have sufficient privileges to perform all
> > -operations.
> > +however, the stashed credentials will have sufficient privileges to
> > +perform all operations.
> >
> >  Another way to demonstrate this model is drawing parallels between::
> >
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index 1115c22deca0..6a94a56f14fb 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -59,6 +59,7 @@ enum ovl_opt {
> >         Opt_metacopy,
> >         Opt_verity,
> >         Opt_volatile,
> > +       Opt_override_creds,
> >  };
> >
> >  static const struct constant_table ovl_parameter_bool[] = {
> > @@ -155,6 +156,7 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
> >         fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
> >         fsparam_enum("verity",              Opt_verity, ovl_parameter_verity),
> >         fsparam_flag("volatile",            Opt_volatile),
> > +       fsparam_flag_no("override_creds",   Opt_override_creds),
> >         {}
> >  };
> >
> > @@ -662,6 +664,29 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >         case Opt_userxattr:
> >                 config->userxattr = true;
> >                 break;
> > +       case Opt_override_creds: {
> > +               const struct cred *cred = NULL;
> > +
> > +               if (result.negated) {
> > +                       swap(cred, ofs->creator_cred);
> > +                       put_cred(cred);
> > +                       break;
> > +               }
> > +
> > +               if (!current_in_userns(fc->user_ns)) {
> > +                       err = -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               cred = prepare_creds();
> > +               if (cred)
> > +                       swap(cred, ofs->creator_cred);
> > +               else
> > +                       err = -EINVAL;
> 
> Did you mean ENOMEM?

Yes, thanks for spotting that. Fixed in-tree.

> 
> > +
> > +               put_cred(cred);
> > +               break;
> > +       }
> >         default:
> >                 pr_err("unrecognized mount option \"%s\" or missing value\n",
> >                        param->key);
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 86ae6f6da36b..cf0d8f1b6710 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1305,6 +1305,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >         struct ovl_fs *ofs = sb->s_fs_info;
> >         struct ovl_fs_context *ctx = fc->fs_private;
> > +       const struct cred *old_cred = NULL;
> >         struct dentry *root_dentry;
> >         struct ovl_entry *oe;
> >         struct ovl_layer *layers;
> > @@ -1318,10 +1319,15 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >         sb->s_d_op = &ovl_dentry_operations;
> >
> >         err = -ENOMEM;
> > -       ofs->creator_cred = cred = prepare_creds();
> > +       if (!ofs->creator_cred)
> > +               ofs->creator_cred = cred = prepare_creds();
> > +       else
> > +               cred = (struct cred *)ofs->creator_cred;
> >         if (!cred)
> >                 goto out_err;
> >
> > +       old_cred = ovl_override_creds(sb);
> > +
> >         err = ovl_fs_params_verify(ctx, &ofs->config);
> >         if (err)
> >                 goto out_err;
> > @@ -1481,11 +1487,19 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >
> >         sb->s_root = root_dentry;
> >
> > +       ovl_revert_creds(old_cred);
> >         return 0;
> >
> >  out_free_oe:
> >         ovl_free_entry(oe);
> >  out_err:
> > +       /*
> > +        * Revert creds before calling ovl_free_fs() which will call
> > +        * put_cred() and put_cred() requires that the cred's that are
> > +        * put are current->cred.
> > +        */
> > +       if (old_cred)
> > +               ovl_revert_creds(old_cred);
> 
> Did you mean that cred's that are NOT current->cred?

Fixed.

> 
> With those fixes you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.


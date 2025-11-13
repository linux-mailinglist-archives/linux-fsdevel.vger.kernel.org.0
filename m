Return-Path: <linux-fsdevel+bounces-68285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B253EC58632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635FA4EB172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B933556C;
	Thu, 13 Nov 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSita2Jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75C2E9749;
	Thu, 13 Nov 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046674; cv=none; b=f3i7QYAt/H7fSonFJ/bfx1yuHr9sIIfKBDefmBWhlrM/ktMHi+5m67IH9C+od3PWFzdneDcOX4ioyl+k01vfrC/3x3GP6oUn2Z/eMAcLxhm4FyAeXl6Dtv33rAOXRKMggpfJ/6jGMLxd3A4JM7mkkyVGoMh9J2ZDe0mMVetxKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046674; c=relaxed/simple;
	bh=oQ+UbjZNjGXss26QaGkdKv/TWlWa+qKQlh8JjT8b3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX8D1Hfto4jBkrxPP+870dnLVQaTKsumy+dG83SZF29xDF54vgaeNl6Qeaz7FXdcJoRvwNi4+fBkew0Se/JFqqPoCW48WfSGjTpDTDob+0guHBaNe76Mz8QymmMPXyw0TvrjkcDF+KCdh1e2kPYYJZFnNZeVvdr9M6FGzDvkHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSita2Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD0C4CEF5;
	Thu, 13 Nov 2025 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763046673;
	bh=oQ+UbjZNjGXss26QaGkdKv/TWlWa+qKQlh8JjT8b3ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSita2JyPvBKYns+qaLPaMigtzPfR1LZ+n9Vn3Oa4FIkqvh7nI1oggOnrGMwYVnWg
	 FsIGWz+H0bZth5FzZN+CKy/einnZhN+YNipNQKUVnY3e2EFcLW2/3IZ0Eql6Dv88wW
	 ruH+Ckken8n7uNYnq41TW4tJGd9TB4uDTbPmZN7Ez6arIrNeNZ4EBwiRWBuPlBkDpO
	 0oYODPp+Zwe1ce7mRRaY/a4CCuiROP/yhPfAW1YN1IKyZAAf0jCrSueergwUCtTp84
	 9562IUWfrvfFoYFc5zMXM/zJ7NSQrJEyiH9A9xhganSDAo1zJqVR0qKisYaxgVHfmb
	 i2wFuL5Jr8iww==
Date: Thu, 13 Nov 2025 16:11:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 40/42] ovl: refactor ovl_fill_super()
Message-ID: <20251113-misskredit-ziesel-29c08c35e738@brauner>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-40-fa9887f17061@kernel.org>
 <CAOQ4uxjwg2Nx=J8UtKCkGddq4TE0ix4BdTNVPLZ8-EDmB9vW9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjwg2Nx=J8UtKCkGddq4TE0ix4BdTNVPLZ8-EDmB9vW9w@mail.gmail.com>

On Thu, Nov 13, 2025 at 03:32:16PM +0100, Amir Goldstein wrote:
> On Thu, Nov 13, 2025 at 2:03 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Split the core into a separate helper in preparation of converting the
> > caller to the scoped ovl cred guard.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/super.c | 119 +++++++++++++++++++++++++++------------------------
> >  1 file changed, 62 insertions(+), 57 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 43ee4c7296a7..6876406c120a 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1369,53 +1369,35 @@ static void ovl_set_d_op(struct super_block *sb)
> >         set_default_d_op(sb, &ovl_dentry_operations);
> >  }
> >
> > -int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> > +static int do_ovl_fill_super(struct super_block *sb, struct ovl_fs *ofs,
> > +                             struct fs_context *fc)
> >  {
> > -       struct ovl_fs *ofs = sb->s_fs_info;
> > -       struct ovl_fs_context *ctx = fc->fs_private;
> > -       const struct cred *old_cred = NULL;
> > -       struct dentry *root_dentry;
> > -       struct ovl_entry *oe;
> > +       struct ovl_fs_context *fsctx = fc->fs_private;
> >         struct ovl_layer *layers;
> > -       struct cred *cred;
> > +       struct ovl_entry *oe = NULL;
> > +       struct cred *cred = (struct cred *)ofs->creator_cred;
> >         int err;
> >
> > -       err = -EIO;
> > -       if (WARN_ON(fc->user_ns != current_user_ns()))
> > -               goto out_err;
> > -
> > -       ovl_set_d_op(sb);
> > -
> > -       err = -ENOMEM;
> > -       if (!ofs->creator_cred)
> > -               ofs->creator_cred = cred = prepare_creds();
> > -       else
> > -               cred = (struct cred *)ofs->creator_cred;
> > -       if (!cred)
> > -               goto out_err;
> > -
> > -       old_cred = ovl_override_creds(sb);
> > -
> > -       err = ovl_fs_params_verify(ctx, &ofs->config);
> > +       err = ovl_fs_params_verify(fsctx, &ofs->config);
> 
> The rename of ctx var seems like unneeded churn.
> Am I missing something?

Fixed, was an oversight from a prior version of this patch. Thanks!


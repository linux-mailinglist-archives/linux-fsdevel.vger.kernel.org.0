Return-Path: <linux-fsdevel+bounces-68477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE59C5CFB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75FE935B92A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE08316901;
	Fri, 14 Nov 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2ZIE8Q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AE31618C;
	Fri, 14 Nov 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121605; cv=none; b=scCmC6CsJKsEzd1VSpZpuz+BzXDDtW2pVaZAxJq/mUQE0Qn9kg9HGSXaEWYUG9ZkvSwN6dl5WIWR5tsPHBKVZv4qxtNkpWjmwxaUN3WJUT0CJUW4B/vVLClrpy1WMLVwKnaQ6xqTG9WQbucJ/mrsCRaPVHn/J8yRpuyyXiwJljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121605; c=relaxed/simple;
	bh=5YHkhwH+C7MWTJ4jZMvZUc5jY7Dp4c03K8zT2fLqbkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRdp3rTtEk8s64M7RtraHvy2UQOzSNOizQ1zj4mkF2hruc1hnh7pyJ18ZS/9DH6J2BM1G1TIVyL+Xkp8ItzA3gl003dwK89JWpgYcCNaZKDfGAH7zjvTT3g7vgBYOENZEa8+zTeZQjiEoVKMsYaPsLgkR2qHxIs/VbrXrzFX4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2ZIE8Q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FA8C4CEF1;
	Fri, 14 Nov 2025 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763121605;
	bh=5YHkhwH+C7MWTJ4jZMvZUc5jY7Dp4c03K8zT2fLqbkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2ZIE8Q0tUJDu2VWGxwPdam5o4I32qVwFgRGXDtNmCr6pPk+JwdK/cTTOThzGX36F
	 ems+HjeMVQdEkg5YAJxiQt+jsWolsltcqIRH1OgraNg8M7uOiktF9XSdxmjhv9r6+N
	 r+lIYPuj80KxDo4zSbn7MDkWj9kV1zZoA/fAVVn0DwkA4VTBO1M/OSR/y/ncDwaptN
	 gO1mCWyHs8zsyrlfjaTzvTyWC703CxjUFcHS2J8Bohse1FAgR/wN8R6v6OAuNQxzhS
	 iwNJh9CLAmVbo6wcIFQFlqXusrKf1ZZU6RKpRSIrjmFL7RZSCifM7HYfTnY/XT9e1Y
	 PkUUWqGeCvq0Q==
Date: Fri, 14 Nov 2025 13:00:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] ovl: reflow ovl_create_or_link()
Message-ID: <20251114-gasleitung-muffel-2a5478a34a6b@brauner>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
 <CAOQ4uxhB2am_xAGugZvAiuEx7ud+8QGPJBwcA+M+LmRvWC-nsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhB2am_xAGugZvAiuEx7ud+8QGPJBwcA+M+LmRvWC-nsA@mail.gmail.com>

On Fri, Nov 14, 2025 at 12:52:58PM +0100, Amir Goldstein wrote:
> On Fri, Nov 14, 2025 at 11:15 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Reflow the creation routine in preparation of porting it to a guard.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index a276eafb5e78..ff30a91e07f8 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -644,14 +644,23 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
> >         return override_cred;
> >  }
> >
> > +static int do_ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > +                                struct ovl_cattr *attr)
> 
> Trying to avert the bikesheding over do_ovl_ helper name...
> 
> > +{
> > +       if (!ovl_dentry_is_whiteout(dentry))
> > +               return ovl_create_upper(dentry, inode, attr);
> > +
> > +       return ovl_create_over_whiteout(dentry, inode, attr);
> > +}
> > +
> >  static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >                               struct ovl_cattr *attr, bool origin)
> >  {
> >         int err;
> > -       const struct cred *new_cred __free(put_cred) = NULL;
> >         struct dentry *parent = dentry->d_parent;
> >
> >         scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
> > +               const struct cred *new_cred __free(put_cred) = NULL;
> >                 /*
> >                  * When linking a file with copy up origin into a new parent, mark the
> >                  * new parent dir "impure".
> > @@ -662,7 +671,6 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >                                 return err;
> >                 }
> >
> > -               if (!attr->hardlink) {
> >                 /*
> >                  * In the creation cases(create, mkdir, mknod, symlink),
> >                  * ovl should transfer current's fs{u,g}id to underlying
> > @@ -676,16 +684,15 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >                  * create a new inode, so just use the ovl mounter's
> >                  * fs{u,g}id.
> >                  */
> > +
> > +               if (attr->hardlink)
> > +                       return do_ovl_create_or_link(dentry, inode, attr);
> > +
> 
> ^^^ This looks like an optimization (don't setup cred for hardlink).
> Is it really an important optimization that is worth complicating the code flow?

It elides a bunch of allocations and an rcu cycle from put_cred().
So yes, I think it's worth it. You can always remove the special-case
later yourself.


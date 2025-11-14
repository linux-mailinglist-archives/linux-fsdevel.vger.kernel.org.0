Return-Path: <linux-fsdevel+bounces-68496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD648C5D626
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BC8235B589
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8231A54B;
	Fri, 14 Nov 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3KHHaJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF219AD5C;
	Fri, 14 Nov 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127261; cv=none; b=HV/BwWVnol4tETAiEpCF9cEGYrOBmnJuYUIkdb/ABGBQv1uLsQ/V01KX2dCaHJyqgXftg94t9c0ztz87s43XN2R49tVy/08RZW/lv9iEpLEC+dkV+R6DfKWzJkxAhHr2Kdx4SJhreXwGPQ8g+FIFzqY/qugtSj8nhhWRdH96zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127261; c=relaxed/simple;
	bh=Pw9CZgXixEV8n9eSXq8KsMdfVNRpSuJx7Ns+sPFC8ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTqefXKqtE2vfmCLuIrOdEsLZrOyM5eEOefG7HVUt7u78yXjE2ZM+3UrWblsmu6HHnG72vurpXNY6r7APeRY4y9RhEpdEXFomBY9i/9eARPYn4O7zTuGGA7I/sSzfeMkJa5YazXMKrGNo0t1NibT4Zb7lOwMwkOvZxDSdkE9Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3KHHaJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64499C4CEF8;
	Fri, 14 Nov 2025 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763127260;
	bh=Pw9CZgXixEV8n9eSXq8KsMdfVNRpSuJx7Ns+sPFC8ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3KHHaJ0NEIIDp9gK7O9BgfEqhzs0Tzp3q83tNm4eoO5nYA0pucDk826tppSCuBnr
	 q48sC//tbamEKFW95AG3X0GmJLQhir1GpnPE+0iLNycwZcAJAOLrxLXyaiG9JrjdhN
	 +OOXFUPVWQD05RIcJFpE1HwNfJIWGb0g3HqHJcmAVNCVfC3Y7aU2bwhXlXkWnodiiZ
	 D0qzlzW5eciY7IZPyO+eNWrk/Mw+0T8i8L4ywGB20ePDUJcvLL7obXz8PG6Wmg813W
	 wynP0ydSObkW1E23v+wLetDOpEXf9GJhYT7g+wq0RbegL+ogg6HFO4ZMBQYpdtKB47
	 oGZ03oaivSYrw==
Date: Fri, 14 Nov 2025 14:34:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] ovl: add prepare_creds_ovl cleanup guard
Message-ID: <20251114-irrational-vordach-e9dffb0968cd@brauner>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-1-4fc1208afa3d@kernel.org>
 <CAOQ4uxhpwpNKeTzR4D_LzOkwxMdpTrik0GmR1Z0UtMf16O29PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhpwpNKeTzR4D_LzOkwxMdpTrik0GmR1Z0UtMf16O29PQ@mail.gmail.com>

On Fri, Nov 14, 2025 at 01:04:22PM +0100, Amir Goldstein wrote:
> On Fri, Nov 14, 2025 at 11:15 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The current code to override credentials for creation operations is
> > pretty difficult to understand. We effectively override the credentials
> > twice:
> >
> > (1) override with the mounter's credentials
> > (2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id
> >
> > And then we elide the revert because it would be an idempotent revert.
> > That elision doesn't buy us anything anymore though because I've made it
> > all work without any reference counting anyway. All it does is mix the
> > two credential overrides together.
> >
> > We can use a cleanup guard to clarify the creation codepaths and make
> > them easier to understand.
> >
> > This just introduces the cleanup guard keeping the patch reviewable.
> > We'll convert the caller in follow-up patches and then drop the
> > duplicated code.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 0030f5a69d22..87f6c5ea6ce0 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -575,6 +575,42 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
> >         goto out_dput;
> >  }
> >
> > +static const struct cred *ovl_prepare_creds(struct dentry *dentry, struct inode *inode, umode_t mode)
> > +{
> > +       int err;
> > +
> > +       if (WARN_ON_ONCE(current->cred != ovl_creds(dentry->d_sb)))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       CLASS(prepare_creds, override_cred)();
> > +       if (!override_cred)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       override_cred->fsuid = inode->i_uid;
> > +       override_cred->fsgid = inode->i_gid;
> > +
> > +       err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
> > +                                             current->cred, override_cred);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       return override_creds(no_free_ptr(override_cred));
> > +}
> > +
> > +static void ovl_revert_creds(const struct cred *old_cred)
> > +{
> > +       const struct cred *override_cred;
> > +
> > +       override_cred = revert_creds(old_cred);
> > +       put_cred(override_cred);
> > +}
> > +
> 
> Earlier patch removed a helper by the same name that does not put_cred()
> That's a backporting trap.
> 
> Maybe something like ovl_revert_create_creds()?
> 
> And ovl_prepare_create_creds()?

Ok.

> 
> > +DEFINE_CLASS(prepare_creds_ovl,
> > +            const struct cred *,
> > +            if (!IS_ERR(_T)) ovl_revert_creds(_T),
> > +            ovl_prepare_creds(dentry, inode, mode),
> > +            struct dentry *dentry, struct inode *inode, umode_t mode)
> > +
> 
> Maybe also matching CLASS name.

Ok.


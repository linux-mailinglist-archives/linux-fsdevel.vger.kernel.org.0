Return-Path: <linux-fsdevel+bounces-27876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F91964A08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7491C2267A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452D1B2EF9;
	Thu, 29 Aug 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9LjHo5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC771B252F;
	Thu, 29 Aug 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945304; cv=none; b=jF6UvQIsRQeualJQWnsgOglR8Co1mJcrEx4TAX5GlMRY3qBTtjm3R8SNkHzCg1Orck0sBu6MFOXpATLKJDmafKTjt3ta4FNk3ENsLoblZTqdqxE1cPOJj9g48UJ/MCQ4XYnQs1BnA7imRLbwVtC6W7n1FY2KpHmocB4RiUdJhps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945304; c=relaxed/simple;
	bh=1FsuV2nbx1n+GYEIkuXpGSiCg9ZfE/2zPNNQl0ksd84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLBWniWRVWJ78hK2IXipt3nIhPfYxIlb5FaFuDFAqFsFWF/R/VyYg5/GdLyCvaxxhuFqn97ZA0pEzNjX1GlAwZg07da5PPzj69HggIE5aII5mtWerIhviJxj01csjrZJ4LKEsFjsZygfXmtNnagyODPk84kj6H3i+fSMoCqntiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9LjHo5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCD0C4CEC1;
	Thu, 29 Aug 2024 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724945303;
	bh=1FsuV2nbx1n+GYEIkuXpGSiCg9ZfE/2zPNNQl0ksd84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9LjHo5VLVex8cr7FHPl0vfbbdQMoSYDURPeFS/J806re8FHs5nd1k66+aa+3Feop
	 DusDA/6GO+dopcH4shH58tiHFvP+qNP0KGZ1ckBbTnPstLrZyh59fV466laeZ9lNXV
	 Ru8sAt222UXDbwOEXO7ukFRXLCwsecznz7C0YHESS4C65s47O3ZkqrPiW+VSyr84Dv
	 7/2wXqy+bZYoPbk6MYX3UP2R+iTissaWHyX1H5tAyXsWFrhK5Bsp93f6tb5OLnZe8i
	 SyAZ03RK3l0cThXBXZLLzUxCpodIMwMGtXleecHxrhd/fIm+iqwGoF8h1CMpuDziuP
	 Y50rEXx46wNIg==
Date: Thu, 29 Aug 2024 11:28:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 06/25] NFSD: Avoid using rqstp->rq_vers in
 nfsd_set_fh_dentry()
Message-ID: <ZtCTlqr-KkEWF77B@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-7-snitzer@kernel.org>
 <f8dd318fba4ece7b4b8e37fe785a3842d668125c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8dd318fba4ece7b4b8e37fe785a3842d668125c.camel@kernel.org>

On Thu, Aug 29, 2024 at 10:28:18AM -0400, Jeff Layton wrote:
> On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Currently, fh_verify() makes some daring assumptions about which
> > version of file handle the caller wants, based on the things it can
> > find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
> > case sometimes has no svc_rqst context, so this logic won't work in
> > that case.
> > 
> > Instead, examine the passed-in file handle. It's .max_size field
> > should carry information to allow nfsd_set_fh_dentry() to initialize
> > the file handle appropriately.
> > 
> > lockd appears to be the only kernel consumer that does not set the
> > file handle .max_size during initialization.
> > 
> > write_filehandle() is the other question mark, as it looks possible
> > to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/lockd.c |  6 ++++--
> >  fs/nfsd/nfsfh.c | 11 +++++++----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index 46a7f9b813e5..e636d2a1e664 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -32,8 +32,10 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
> >  	int		access;
> >  	struct svc_fh	fh;
> >  
> > -	/* must initialize before using! but maxsize doesn't matter */
> > -	fh_init(&fh,0);
> > +	if (rqstp->rq_vers == 4)
> > +		fh_init(&fh, NFS3_FHSIZE);
> > +	else
> > +		fh_init(&fh, NFS_FHSIZE);
> >  	fh.fh_handle.fh_size = f->size;
> >  	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> >  	fh.fh_export = NULL;
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 4b964a71a504..77acc26e8b02 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -267,25 +267,28 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
> >  	fhp->fh_dentry = dentry;
> >  	fhp->fh_export = exp;
> >  
> > -	switch (rqstp->rq_vers) {
> > -	case 4:
> > +	switch (fhp->fh_maxsize) {
> > +	case NFS4_FHSIZE:
> >  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
> >  			fhp->fh_no_atomic_attr = true;
> >  		fhp->fh_64bit_cookies = true;
> >  		break;
> > -	case 3:
> > +	case NFS3_FHSIZE:
> >  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
> >  			fhp->fh_no_wcc = true;
> >  		fhp->fh_64bit_cookies = true;
> >  		if (exp->ex_flags & NFSEXP_V4ROOT)
> >  			goto out;
> >  		break;
> > -	case 2:
> > +	case NFS_FHSIZE:
> >  		fhp->fh_no_wcc = true;
> >  		if (EX_WGATHER(exp))
> >  			fhp->fh_use_wgather = true;
> >  		if (exp->ex_flags & NFSEXP_V4ROOT)
> >  			goto out;
> > +		break;
> > +	case 0:
> > +		WARN_ONCE(1, "Uninitialized file handle");
> >  	}
> >  
> >  	return 0;
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for the review!  But please note that you reviewed the stale
patch I mistakenly sent out, I replied to this patch with:

[PATCH v14.5 06/25] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()

Thanks.


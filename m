Return-Path: <linux-fsdevel+bounces-69998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAECC8DD8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84584E56F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E27315D3E;
	Thu, 27 Nov 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anYvLVKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C917BA2;
	Thu, 27 Nov 2025 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240841; cv=none; b=BXgjg6nE2BYbkzONpHrunJJ0pvWFOufSN6w3tP7a9SXBD4CYH90X5gkKiLHRob+n67vzLl8KghfEUs8RLUTHugSScMuY4C8ZngIuQR5esu6yvxi6BpGWdjWsu30q3kzdG5Wn77sCWmCjIenT4jXLV7OV1IbynCCzlXIf0UPZ+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240841; c=relaxed/simple;
	bh=m908laCROEU9fWyjb2BB4szGW1mRmKkvS+ErKipnKdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHjyWYWq96++AiPfyV4ELOmrOFAyBEXWCQNQy+EZf/JrIQVpcFDGVVwoJ5nTB1hwjnBY4mUJf6+V2AqBhnCTQbtnLsMyjW5hnRU2DJPowzPBzlCp0DrzZ/G2TiGtssRE0pbccKYsK3n05fdrB3e+XMxPM8yDq9smXNV+TO/7NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anYvLVKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DA8C4CEF8;
	Thu, 27 Nov 2025 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764240840;
	bh=m908laCROEU9fWyjb2BB4szGW1mRmKkvS+ErKipnKdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anYvLVKdnBeZh0Re0GdAB1eguMdnMme+JxIizaUmMbGqLmHOtwYgSzPlgU2a+2nOh
	 uYCMarR8Z18I7XdVEptEIiB9ak1Kcpvn+89PMg9gnoljy+4nZ3ILlfOvo7b3jO0fUe
	 oR9i9KqON1ts0muc6dYmBNHIujVbht5sOC13fxf6KmGZOJlmnh86fRkGhiHBEm4H/e
	 PFBlyJoSf2CQoMiLIznE5rRu6Bs3sRmg4yV9I7Rnfk7Bz184NjFkZLbTBto2uVm6zT
	 X/ZWjNiDAQVtZYZRfjoZYfQ54mNFQRFTxcnZZwN+gs/QR/moQQeZs17NKkOv3p+jOo
	 UC8dww1JRPN4Q==
Date: Thu, 27 Nov 2025 11:53:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
Message-ID: <20251127-engel-eschenholz-805b54630656@brauner>
References: <202511252132.2c621407-lkp@intel.com>
 <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
 <176419027888.634289.8284458326359928729@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176419027888.634289.8284458326359928729@noble.neil.brown.name>

On Thu, Nov 27, 2025 at 07:51:18AM +1100, NeilBrown wrote:
> On Wed, 26 Nov 2025, Amir Goldstein wrote:
> > On Wed, Nov 26, 2025 at 11:42 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> > > >
> > > > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >
> > > > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> > >
> > > Neil, can you please take a look at this soon?
> > > I plan on sending the batch of PRs for this cycle on Friday.
> > >
> > > >
> > > > in testcase: filebench
> > > > version: filebench-x86_64-22620e6-1_20251009
> > > > with following parameters:
> > > >
> > > >       disk: 1SSD
> > > >       fs: ext4
> > > >       fs2: nfsv4
> > > >       test: ratelimcopyfiles.f
> > > >       cpufreq_governor: performance
> > > >
> > 
> > Test is copying to nfsv4 so that's the immediate suspect.
> > WARN_ON is in unmount of ext4, but I suspect that nfs
> > was loop mounted for the test.
> > 
> > FWIW, nfsd_proc_create() looks very suspicious.
> > 
> > nfsd_create_locked() does end_creating() internally (internal API change)
> > but nfsd_create_locked() still does end_creating() regardless.
> 
> Thanks for looking at this Amir.  That omission in nfsproc.c is
> certainly part of the problem but not all of it.
> By skipping the end_creating() there, we avoid a duplicate unlock, but
> also lose a dput() which we need.  Both callers of nfsd_create_locked()
> have the same problem.
> I think this should fix it.  The resulting code is a bit ugly but I can
> fix that with the nfsd team once this gets upstream.
> 
> (FYI nfsd_proc_create() is only used for NFSv2 and as it was an nfsv4 test,
>  that could wouldn't have been run)
> 
> Thanks,
> NeilBrown
> 
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 28f03a6a3cc3..481e789a7697 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -407,6 +407,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		/* File doesn't exist. Create it and set attrs */
>  		resp->status = nfsd_create_locked(rqstp, dirfhp, &attrs, type,
>  						  rdev, newfhp);
> +		/* nfsd_create_locked() unlocked the parent */
> +		dput(dchild);
> +		goto out_write;
>  	} else if (type == S_IFREG) {
>  		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
>  			argp->name, attr->ia_valid, (long) attr->ia_size);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 145f1c8d124d..4688f3fd59e2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1633,16 +1633,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return nfserrno(host_err);
>  
>  	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> -	/*
> -	 * We unconditionally drop our ref to dchild as fh_compose will have
> -	 * already grabbed its own ref for it.
> -	 */
>  	if (err)
>  		goto out_unlock;
>  	err = fh_fill_pre_attrs(fhp);
>  	if (err != nfs_ok)
>  		goto out_unlock;
>  	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> +	/* nfsd_create_locked() unlocked the parent */
> +	dput(dchild);
>  	return err;
>  
>  out_unlock:

Thanks for the quick fix. I've added a patch to
vfs-6.19.directory.unlocking which I attributed to you.
It'd be easier if you just shoot something I can apply directly next
time. :)


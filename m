Return-Path: <linux-fsdevel+bounces-27433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B954F96180F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7136228492F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB31D3194;
	Tue, 27 Aug 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1h9lRvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020D1C57AD;
	Tue, 27 Aug 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787339; cv=none; b=OfFq2d9dH6nCLNckyCS02Nzm1514qT78MgTd6bFcB1o6sZ74g+E/5YDaJADK1Tkq8lb5mA4AqDsszcLZI9duoZbBXY0WlAEp4Oj1q6f/5gaaxX90Sb/PYfK5T7xR2f3eKw+FMqtmcCxUdRNYHF+boW3NfnrBHUguVP2tHKdjC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787339; c=relaxed/simple;
	bh=3xebfx98abZsNTu09uno1Zz2dZvo6d+P3yYLgqYYxik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aovk12A0Ek7OF1LbvZnOgdCFdszLvNfAIuMzBGBimRdHhEkFyCURtT/XHWgJzLHVbDiqzr1kgWr+ygTS2+Cpw/5HeCO24UAz1QsmmLGtbvLp+mVLZA8LnEF46XbNa3jQRTffYFeiUUALwmLO1u7yVS/rzh5/r5VrSomJohkU88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1h9lRvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A91C4AF09;
	Tue, 27 Aug 2024 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724787339;
	bh=3xebfx98abZsNTu09uno1Zz2dZvo6d+P3yYLgqYYxik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1h9lRvSh/eoXU54ZmsQ2NF75KOhjLiwXiunznuwBQGg3zKDGMRz1YR0ueMysbhKT
	 /lueMImvZvlpBqKDSzxCHWNpQHGP3lk55U1cLpkI60UUoU6q6ezNNR6HB/M4+jxLom
	 B09eN5hf7AVE4sIaBhshF3OhAInGNVp3U4lxVCrqf8jT5s0pgQYx65P+hvJhqezYML
	 5eSwX3ppvTkKfw14FXZseYhWyiUGYTNCtC0lXZiUt2zjuYWnHn4JNG9LVkD6T0eonP
	 gKp1XmIHwPfdWyKyhkF96c+XT+ReY4ZuxfB2KY72lJd5ZiGQotEiGofJgdwbIgNsHO
	 n9MRGSD/oiJBA==
Date: Tue, 27 Aug 2024 15:35:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <Zs4qisuA5WeGcsOI@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-5-snitzer@kernel.org>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <Zs4hzbVmqwWKqQ3u@kernel.org>
 <Zs4obErc91MR/Kfu@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs4obErc91MR/Kfu@tissot.1015granger.net>

On Tue, Aug 27, 2024 at 03:26:36PM -0400, Chuck Lever wrote:
> On Tue, Aug 27, 2024 at 02:58:21PM -0400, Mike Snitzer wrote:
> > On Sun, Aug 25, 2024 at 11:32:50AM -0400, Chuck Lever wrote:
> > > On Fri, Aug 23, 2024 at 02:14:02PM -0400, Mike Snitzer wrote:
> > > > From: NeilBrown <neilb@suse.de>
> > > > 
> > > > __fh_verify() offers an interface like fh_verify() but doesn't require
> > > > a struct svc_rqst *, instead it also takes the specific parts as
> > > > explicit required arguments.  So it is safe to call __fh_verify() with
> > > > a NULL rqstp, but the net, cred, and client args must not be NULL.
> > > > 
> > > > __fh_verify() does not use SVC_NET(), nor does the functions it calls.
> > > > 
> > > > Rather then depending on rqstp->rq_vers to determine nfs version, pass
> > > > it in explicitly.  This removes another dependency on rqstp and ensures
> > > > the correct version is checked.  The rqstp can be for an NLM request and
> > > > while some code tests that, other code does not.
> > > > 
> > > > Rather than using rqstp->rq_client pass the client and gssclient
> > > > explicitly to __fh_verify and then to nfsd_set_fh_dentry().
> > > > 
> > > > The final places where __fh_verify unconditionally dereferences rqstp
> > > > involve checking if the connection is suitably secure.  They look at
> > > > rqstp->rq_xprt which is not meaningful in the target use case of
> > > > "localio" NFS in which the client talks directly to the local server.
> > > > So have these always succeed when rqstp is NULL.
> > > > 
> > > > Lastly, 4 associated tracepoints are only used if rqstp is not NULL
> > > > (this is a stop-gap that should be properly fixed so localio also
> > > > benefits from the utility these tracepoints provide when debugging
> > > > fh_verify issues).
> > > > 
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > 
> > > IMO this patch needs to be split up. There are several changes that
> > > need separate explanation and rationale, and the changes here need
> > > to be individually bisectable.
> > > 
> > > If you prefer, I can provide a patch series that replaces this one
> > > patch, or Neil could provide it if he wants.
> > 
> > I'm probably not the best person to take a crack at splitting this
> > patch up.
> > 
> > Neil initially had factored out N patches, but they weren't fully
> > baked so when I had to fix the code up it became a challenge to
> > sprinkle fixes across the N patches.  Because they were all
> > pretty interdependent.
> > 
> > In the end, all these changes are in service to allowing for the
> > possibility that the rqstp not available (NULL).  So it made sense to
> > fold them together.
> > 
> > I really don't see how factoring these changes out to N patches makes
> > them useful for bisection (you need all of them to test the case when
> > rqstp is NULL, and a partial application of changes to track down a
> > rqstp-full regression really isn't such a concern given fh_verify()
> > fully passes all args to __fh_verify so status-quo preserved).
> > 
> > All said, if your intuition and experience makes you feel splitting
> > this patch up is needed then I'm fine with it and I welcome your or
> > Neil's contribtion.  It is fiddley work though, so having had my own
> > challenges with the code when these changes were split out makes me
> > hesitant to jump on splitting them out again.
> > 
> > Hope I've explained myself clearly... not being confrontational,
> > dismissive or anything else. ;)
> 
> True, this isn't an enormous single patch, but you gotta draw that
> line somewhere.
> 
> The goal is to make these changes as small and atomic as possible so
> it becomes easy to spot a mistake or bisect to find unintended
> behavior introduced in the non-LOCALIO case. This is a code path
> that is heavily utilized by NFSD so it pays to take some defensive
> precautions.
> 
> Generally I find that a typo or hidden assumption magically appears
> when I've engaged in this kind of refactoring exercise. I've got a
> good toolchain that should make this quick work.

Awesome.

> > > > --- a/fs/nfsd/export.c
> > > > +++ b/fs/nfsd/export.c
> > > > @@ -1077,7 +1077,13 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> > > >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > > >  {
> > > >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > > > -	struct svc_xprt *xprt = rqstp->rq_xprt;
> > > > +	struct svc_xprt *xprt;
> > > > +
> > > > +	if (!rqstp)
> > > > +		/* Always allow LOCALIO */
> > > > +		return 0;
> > > > +
> > > > +	xprt = rqstp->rq_xprt;
> > > 
> > > check_nfsd_access() is a public API, so it needs a kdoc comment.
> > > 
> > > These changes should be split into a separate patch with a clear
> > > rationale of why "Always allow LOCALIO" is secure and appropriate
> > > to do.
> > 
> > Separate patch aside, I'll try to improve that comment.
> 
> Post the comment update here and I can work that in.

Here is the incremental patch:

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index fe36f441d1d9..8b54f66f0e0f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1074,14 +1074,26 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
+ *
+ * Returns 0 if access is granted or nfserr_wrongsec if access is denied.
+ */
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 	struct svc_xprt *xprt;
 
-	if (!rqstp)
-		/* Always allow LOCALIO */
+	if (!rqstp) {
+		/*
+		 * The target use case for rqstp being NULL is LOCALIO,
+		 * which only supports AUTH_UNIX, so always allow LOCALIO
+		 * because the other checks below aren't applicable.
+		 */
 		return 0;
+	}
 
 	xprt = rqstp->rq_xprt;
 


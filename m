Return-Path: <linux-fsdevel+bounces-26557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538195A687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08551B24782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F017B401;
	Wed, 21 Aug 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoT30tL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED6175D3F;
	Wed, 21 Aug 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275438; cv=none; b=vEe0yoQ8OaUnUYy75vhzx20AfrIDEc87ytJuChTi7Qq3YZVEoSUm8M+ngf1OE7NXX4ksjmb4qZ5dMw89qsVRal4zW+032yYY+R3BoNemckOX+608enGR6sstJKG/cpisjaw+MWlsU4PjNOaX8/MOa8M5zrvGhEdbbdwkd/NDxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275438; c=relaxed/simple;
	bh=YVtobdk99oI5Wbod0gUZfcTL2+qrek+ny/V3sW2H8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNhNxahNKhrWYQ6nMKc74sxrFp6s4PPpp4Ayxy3S+r0ToTh28BnXM+gnfYP6bLL3qAM4j2sBeq8qPEhCYawKyAXXymoAxk6ijANYUE/r3+3RC/WawAu0VYfZpiJ1RqAYrW61UqMu9zCE3QTB6k2GucQLGdgwi1UoRRvd+QV8pEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoT30tL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29DEC4AF10;
	Wed, 21 Aug 2024 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724275438;
	bh=YVtobdk99oI5Wbod0gUZfcTL2+qrek+ny/V3sW2H8jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoT30tL9EnH/NhaHhIPDujm4oEdnYxTTfWVIwgzkfDt6qtD9NNhvipcXzC3bworVp
	 BQXTu2dF+B5PUF/KUKJIKHHScySIB0DbPjvC4nmaqB0qxD9M/pJwco/eBNdiUzKWm1
	 CqiNMYAFZEsAyaLRD4j87kwCntoGOgmLuFWS4j+cut5qabZyFoyhvQI/cqs0tlLlhN
	 UlEt8JSfYI2XpBXmYkYb8HZKbSWXjdaify9c1iTTF1RCxPgbCyeNI9LsJ5OSWjTbZk
	 fntlhKOwSvKf9YiDAwX1M0icw5L7iCxT27iRER8V/KjcqZp1j5cLlgsyXFTJJWkRRI
	 WPYwiSGpLy98g==
Date: Wed, 21 Aug 2024 17:23:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Message-ID: <ZsZa7PX0QtZKWt_R@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-6-snitzer@kernel.org>
 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>

On Wed, Aug 21, 2024 at 01:46:02PM -0400, Jeff Layton wrote:
> On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > Fixes stop-gap used in previous commit where caller avoided using
> > tracepoint if rqstp is NULL.  Instead, have each tracepoint avoid
> > dereferencing NULL rqstp.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/nfsfh.c | 12 ++++--------
> >  fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
> >  2 files changed, 25 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 19e173187ab9..bae727e65214 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > *rqstp, struct net *net,
> >  
> >  	error = nfserr_stale;
> >  	if (IS_ERR(exp)) {
> > -		if (rqstp)
> > -			trace_nfsd_set_fh_dentry_badexport(rqstp,
> > fhp, PTR_ERR(exp));
> > +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
> > PTR_ERR(exp));
> >  
> >  		if (PTR_ERR(exp) == -ENOENT)
> >  			return error;
> > @@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > *rqstp, struct net *net,
> >  						data_left,
> > fileid_type, 0,
> >  						nfsd_acceptable,
> > exp);
> >  		if (IS_ERR_OR_NULL(dentry)) {
> > -			if (rqstp)
> > -
> > 				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > +			trace_nfsd_set_fh_dentry_badhandle(rqstp,
> > fhp,
> >  					dentry ?  PTR_ERR(dentry) :
> > -ESTALE);
> >  			switch (PTR_ERR(dentry)) {
> >  			case -ENOMEM:
> > @@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
> >  	dentry = fhp->fh_dentry;
> >  	exp = fhp->fh_export;
> >  
> > -	if (rqstp)
> > -		trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > +	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
> >  
> >  	/*
> >  	 * We still have to do all these permission checks, even
> > when
> > @@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
> >  	/* Finally, check access permissions. */
> >  	error = nfsd_permission(cred, exp, dentry, access);
> >  out:
> > -	if (rqstp)
> > -		trace_nfsd_fh_verify_err(rqstp, fhp, type, access,
> > error);
> > +	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access,
> > error);
> >  	if (error == nfserr_stale)
> >  		nfsd_stats_fh_stale_inc(nn, exp);
> >  	return error;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 77bbd23aa150..d49b3c1e3ba9 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
> >  
> >  TRACE_EVENT(nfsd_fh_verify,
> >  	TP_PROTO(
> > +		const struct net *net,
> >  		const struct svc_rqst *rqstp,
> >  		const struct svc_fh *fhp,
> >  		umode_t type,
> >  		int access
> >  	),
> > -	TP_ARGS(rqstp, fhp, type, access),
> > +	TP_ARGS(net, rqstp, fhp, type, access),
> >  	TP_STRUCT__entry(
> >  		__field(unsigned int, netns_ino)
> >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > @@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
> >  		__field(unsigned long, access)
> >  	),
> >  	TP_fast_assign(
> > -		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
> > -		__assign_sockaddr(server, &rqstp->rq_xprt-
> > >xpt_local,
> > -		       rqstp->rq_xprt->xpt_locallen);
> > -		__assign_sockaddr(client, &rqstp->rq_xprt-
> > >xpt_remote,
> > -				  rqstp->rq_xprt->xpt_remotelen);
> > -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> > +		__entry->netns_ino = net->ns.inum;
> > +		if (rqstp) {
> > +			__assign_sockaddr(server, &rqstp->rq_xprt-
> > >xpt_local,
> > +					  rqstp->rq_xprt-
> > >xpt_locallen);
> > +			__assign_sockaddr(client, &rqstp->rq_xprt-
> > >xpt_remote,
> > +					  rqstp->rq_xprt-
> > >xpt_remotelen);
> > +		}
> 
> Does this need an else branch to set these values to something when
> rqstp is NULL, or are we guaranteed that they are already zeroed out
> when they aren't assigned?

I'm not sure.  It isn't immediately clear what is actually using these.

But I did just notice an inconsistency, these entry members are defined:

                __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
                __sockaddr(client, rqstp->rq_xprt->xpt_remotelen)

Yet they go on to use rqstp->rq_xprt->xpt_locallen and
rqstp->rq_xprt->xpt_remotelen respectively.

Chuck, would welcome your feedback on how to properly fix these
tracepoints to handle rqstp being NULL.  And the inconsistency I just
noted is something extra.

Thanks,
Mike


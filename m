Return-Path: <linux-fsdevel+bounces-26820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31B95BD1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F5B270DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BF1CEAAF;
	Thu, 22 Aug 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCjQba67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484E1CEABA;
	Thu, 22 Aug 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347227; cv=none; b=WknZPVZPphkQkJTUMDIuPxX9sTeBf18icRfIvpU9KFBOKWhFFAmr01i3PnvZAHf00qMzw4ZI2GNvMHf8quFGPzc29Mf6w4vWzcZn8n/BTK06L4nU/46T/OJb8WDje7VXKAwc9ytYrHPwmavL+gLIq/SAgcdBvYHsyHvJiTpHF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347227; c=relaxed/simple;
	bh=KWFjIfxCfoT/6vJkkOGx5auiv4x2TWL6K4hDQgrmkjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu9DVqzsqgKjfDVvr0C3vXBmaJKcsFRtVV2wMpxE94wWHqp7ZCJFJs9ic97qvQeVjtLd77TwraoXT1zyZCymGc4p1t5SNm5TZzPqzdEQrmobaRVegKt2MLpFxtSvnmWF/9pcnR3kG+4y95hm1PNw8vFQS7lIGlX/jn+PVQNtz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCjQba67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057C2C32782;
	Thu, 22 Aug 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347227;
	bh=KWFjIfxCfoT/6vJkkOGx5auiv4x2TWL6K4hDQgrmkjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCjQba676U0FJ6yDEE5vBREirB2xzDwkH0btEnyCzJWsM+5S9s9ELsMO1E72ai1id
	 /JMUZxeZRvt4CUjJnd/shpboc0+b3FHfSGBIv1uCh0InLr82elSu9149p5pkRlCDwA
	 bknjnpa3LeckesLxLgKEGAzrBLA1Xmqu8E6gNL6vk5CdQAlsvwnFgHwAPHRvWIv8bR
	 NXg+IZbDj22Mx4uMkx79X/U32kvcgcc+Zb+YuFeShaPx5uTmuGsg6ZcO6I5yvRfCDp
	 irt8Pf5woNEDAehp6i8S2VXq75TBFFb1RFMBB91VYNCxwvRbjUAn6biUx09ibHA2fp
	 xueg4JOJoxlFA==
Date: Thu, 22 Aug 2024 13:20:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Message-ID: <ZsdzWgWi36GVpr7Q@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-6-snitzer@kernel.org>
 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
 <ZsZa7PX0QtZKWt_R@kernel.org>
 <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>
 <ZsdhhIY8WQCPWete@kernel.org>
 <b6cee2822295de115681d9f26f0a473e9d69e2c4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6cee2822295de115681d9f26f0a473e9d69e2c4.camel@kernel.org>

On Thu, Aug 22, 2024 at 01:07:29PM -0400, Jeff Layton wrote:
> On Thu, 2024-08-22 at 12:04 -0400, Mike Snitzer wrote:
> > On Thu, Aug 22, 2024 at 11:07:47AM -0400, Chuck Lever wrote:
> > > On Wed, Aug 21, 2024 at 05:23:56PM -0400, Mike Snitzer wrote:
> > > > On Wed, Aug 21, 2024 at 01:46:02PM -0400, Jeff Layton wrote:
> > > > > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > > > > Fixes stop-gap used in previous commit where caller avoided using
> > > > > > tracepoint if rqstp is NULL.  Instead, have each tracepoint avoid
> > > > > > dereferencing NULL rqstp.
> > > > > > 
> > > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > ---
> > > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > >  fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
> > > > > >  2 files changed, 25 insertions(+), 23 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > > index 19e173187ab9..bae727e65214 100644
> > > > > > --- a/fs/nfsd/nfsfh.c
> > > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > > @@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > > > > *rqstp, struct net *net,
> > > > > >  
> > > > > >  	error = nfserr_stale;
> > > > > >  	if (IS_ERR(exp)) {
> > > > > > -		if (rqstp)
> > > > > > -			trace_nfsd_set_fh_dentry_badexport(rqstp,
> > > > > > fhp, PTR_ERR(exp));
> > > > > > +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
> > > > > > PTR_ERR(exp));
> > > > > >  
> > > > > >  		if (PTR_ERR(exp) == -ENOENT)
> > > > > >  			return error;
> > > > > > @@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > > > > *rqstp, struct net *net,
> > > > > >  						data_left,
> > > > > > fileid_type, 0,
> > > > > >  						nfsd_acceptable,
> > > > > > exp);
> > > > > >  		if (IS_ERR_OR_NULL(dentry)) {
> > > > > > -			if (rqstp)
> > > > > > -
> > > > > > 				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > > > > > +			trace_nfsd_set_fh_dentry_badhandle(rqstp,
> > > > > > fhp,
> > > > > >  					dentry ?  PTR_ERR(dentry) :
> > > > > > -ESTALE);
> > > > > >  			switch (PTR_ERR(dentry)) {
> > > > > >  			case -ENOMEM:
> > > > > > @@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >  	dentry = fhp->fh_dentry;
> > > > > >  	exp = fhp->fh_export;
> > > > > >  
> > > > > > -	if (rqstp)
> > > > > > -		trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > > > > > +	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
> > > > > >  
> > > > > >  	/*
> > > > > >  	 * We still have to do all these permission checks, even
> > > > > > when
> > > > > > @@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >  	/* Finally, check access permissions. */
> > > > > >  	error = nfsd_permission(cred, exp, dentry, access);
> > > > > >  out:
> > > > > > -	if (rqstp)
> > > > > > -		trace_nfsd_fh_verify_err(rqstp, fhp, type, access,
> > > > > > error);
> > > > > > +	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access,
> > > > > > error);
> > > > > >  	if (error == nfserr_stale)
> > > > > >  		nfsd_stats_fh_stale_inc(nn, exp);
> > > > > >  	return error;
> > > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > > index 77bbd23aa150..d49b3c1e3ba9 100644
> > > > > > --- a/fs/nfsd/trace.h
> > > > > > +++ b/fs/nfsd/trace.h
> > > > > > @@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
> > > > > >  
> > > > > >  TRACE_EVENT(nfsd_fh_verify,
> > > > > >  	TP_PROTO(
> > > > > > +		const struct net *net,
> > > > > >  		const struct svc_rqst *rqstp,
> > > > > >  		const struct svc_fh *fhp,
> > > > > >  		umode_t type,
> > > > > >  		int access
> > > > > >  	),
> > > > > > -	TP_ARGS(rqstp, fhp, type, access),
> > > > > > +	TP_ARGS(net, rqstp, fhp, type, access),
> > > > > >  	TP_STRUCT__entry(
> > > > > >  		__field(unsigned int, netns_ino)
> > > > > >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > > > > > @@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
> > > > > >  		__field(unsigned long, access)
> > > > > >  	),
> > > > > >  	TP_fast_assign(
> > > > > > -		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
> > > > > > -		__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > > > > xpt_local,
> > > > > > -		       rqstp->rq_xprt->xpt_locallen);
> > > > > > -		__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > > > > xpt_remote,
> > > > > > -				  rqstp->rq_xprt->xpt_remotelen);
> > > > > > -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> > > > > > +		__entry->netns_ino = net->ns.inum;
> > > > > > +		if (rqstp) {
> > > > > > +			__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > > > > xpt_local,
> > > > > > +					  rqstp->rq_xprt-
> > > > > > > xpt_locallen);
> > > > > > +			__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > > > > xpt_remote,
> > > > > > +					  rqstp->rq_xprt-
> > > > > > > xpt_remotelen);
> > > > > > +		}
> > > > > 
> > > > > Does this need an else branch to set these values to something when
> > > > > rqstp is NULL, or are we guaranteed that they are already zeroed out
> > > > > when they aren't assigned?
> > > > 
> > > > I'm not sure.  It isn't immediately clear what is actually using these.
> > > > 
> > > > But I did just notice an inconsistency, these entry members are defined:
> > > > 
> > > >                 __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > > >                 __sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
> > > > 
> > > > Yet they go on to use rqstp->rq_xprt->xpt_locallen and
> > > > rqstp->rq_xprt->xpt_remotelen respectively.
> > > > 
> > > > Chuck, would welcome your feedback on how to properly fix these
> > > > tracepoints to handle rqstp being NULL.  And the inconsistency I just
> > > > noted is something extra.
> > > 
> > > First, a comment about patch ordering: I think you can preserve
> > > attribution but make these a little easier to digest if you reverse
> > > 4/ and 5/. Fix the problem before it becomes a problem, as it were.
> > > 
> > > As a general remark, I would prefer to retain the trace points and
> > > even the address information in the local I/O case: the client
> > > address is an important part of the decision to permit or deny
> > > access to the FH in question. The issue is how to make that
> > > happen...
> > > 
> > > The __sockaddr() macros I think will trigger an oops if
> > > rqstp == NULL. The second argument determines the size of a
> > > variable-length trace field IIRC. One way to avoid that is to use a
> > > fixed size field for the addresses (big enough to store an IPv6
> > > address?  or an abstract address? those can get pretty big)
> > > 
> > > I need to study 4/ more closely; perhaps it is doing too much in a
> > > single patch. (ie, the code ends up in a better place, but the
> > > details of the transition are obscured by being lumped together into
> > > one patch).
> > > 
> > > So, can you or Neil answer: what would appear as the client address
> > > for local I/O ?
> > 
> > Before when there was the "fake" svc_rqst it was initialized with:
> > 
> >        /* Note: we're connecting to ourself, so source addr == peer addr */
> >        rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
> >                        (struct sockaddr *)&rqstp->rq_addr,
> >                        sizeof(rqstp->rq_addr));
> > 
> > Anyway, as the code is also now: the rpc_clnt passed to
> > nfsd_open_local_fh() will reflect the same address as the server.
> > 
> > My thinking was that for localio there doesn't need to be any explicit
> > listing of the address info in the tracepoints (but that'd be more
> > convincing if we at least logged localio by looking for and logging
> > NFSD_MAY_LOCALIO in mayflags passed to nfsd_file_acquire_local).
> > 
> > But I agree it'd be nice to have tracepoints log matching 127.0.0.1 or
> > ::1, etc -- just don't think it strictly necessary.
> > 
> > Open to whatever you think best.
> > 
> 
> The client is likely to be coming from a different container in many
> cases and so won't be coming in via the loopback interface. Presenting
> a loopback address in that case seems wrong.

Right, wasn't suggesting to always display loopback interface, was
saying ideal to display reality.  There isn't anything special in the
rpc_clnt address.  The localio RPC client is connecting to the server
using the same rpcclient as NFS (cloned from that used for NFS).

> What would be ideal IMO would be to still display the addresses from
> the rpc_clnt and just display a flag or something that shows that this
> is a localio request. Having to pass that as an additional arg to
> __fh_verify would be pretty ugly though (and may be a layering
> violation).

I agree.  But yeah, I don't have a sense for how to do this cleanly.

Pass rpc_clnt in and only use it for address if mayflags has
NFSD_MAY_LOCALIO set _and_ rqstop is NULL?


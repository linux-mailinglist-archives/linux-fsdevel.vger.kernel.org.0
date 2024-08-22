Return-Path: <linux-fsdevel+bounces-26805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4195BB48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA542843FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF841CCEC1;
	Thu, 22 Aug 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBHmJRXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE513A86C;
	Thu, 22 Aug 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342662; cv=none; b=Pm/q23uc4ZF2OnV8CnuHrIonA63BCiZQKzJt4h1V2BBifdjNOLJN6Cs6ne2/5Y/eP+IFWsln+LNl7T1KBTS+1Uxx+SYy1QqxyXdeHOEuKCIzVt2VJ0CDD+vmm9xmu/rI7Rvdwa41mwv4pLwKeyJhE0dcW9wZQdjUomfGSLIrDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342662; c=relaxed/simple;
	bh=xG/Y4m7UkLbKHl/IZwRhtiEKv0Nt2MuuW46bOqWCLqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEiLr8ka0M1K/PLoIafEXE6wScWd2Ewbp2ExsS3a3L30dAv++MBkrUbu+VM4PpVz2btDYcSXQ5DFGwlb6QGuAT6OyjGnPH5DMHBhfta/y7gNo3pycFh0BZZHi89oQhSxNPafzto7AsrM379dVCrpYwYm1QPnePQv5Jc3aoxsrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBHmJRXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481B0C32782;
	Thu, 22 Aug 2024 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724342661;
	bh=xG/Y4m7UkLbKHl/IZwRhtiEKv0Nt2MuuW46bOqWCLqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBHmJRXdek0AH40mQbdUiLIWWTp7RbnmSQNqjIV8uwsjdG2MIlmvD1/CZEiI0hf5B
	 XI/IyrDfH76ltCXosN4Bgrs7cn7FnnAxhrIdUYve/xr711y2mPuQ0vRYuA3jia5QuV
	 v28AHgX1e1Y0wBeDqUfsjVcIYxF6nhH8VKGn62wvSDyObSPyZNaTlHI0hZ4bWLsfUj
	 U4jTlC7qEkMWbI6eOyMAWDycBkiE7tSi+YrpK5A5rXZPm8YKjjgeESTUGR1/rC3Ibg
	 dc0whXmYxuj4XIVRGNxf0XFSJL4kEUhnWyazBsRxzKzBgbe/g/1Yxsfjedj1x/uwKY
	 2crBW3SvA9PFg==
Date: Thu, 22 Aug 2024 12:04:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Message-ID: <ZsdhhIY8WQCPWete@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-6-snitzer@kernel.org>
 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
 <ZsZa7PX0QtZKWt_R@kernel.org>
 <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>

On Thu, Aug 22, 2024 at 11:07:47AM -0400, Chuck Lever wrote:
> On Wed, Aug 21, 2024 at 05:23:56PM -0400, Mike Snitzer wrote:
> > On Wed, Aug 21, 2024 at 01:46:02PM -0400, Jeff Layton wrote:
> > > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > > Fixes stop-gap used in previous commit where caller avoided using
> > > > tracepoint if rqstp is NULL.  Instead, have each tracepoint avoid
> > > > dereferencing NULL rqstp.
> > > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > >  fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
> > > >  2 files changed, 25 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index 19e173187ab9..bae727e65214 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > > *rqstp, struct net *net,
> > > >  
> > > >  	error = nfserr_stale;
> > > >  	if (IS_ERR(exp)) {
> > > > -		if (rqstp)
> > > > -			trace_nfsd_set_fh_dentry_badexport(rqstp,
> > > > fhp, PTR_ERR(exp));
> > > > +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
> > > > PTR_ERR(exp));
> > > >  
> > > >  		if (PTR_ERR(exp) == -ENOENT)
> > > >  			return error;
> > > > @@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > > *rqstp, struct net *net,
> > > >  						data_left,
> > > > fileid_type, 0,
> > > >  						nfsd_acceptable,
> > > > exp);
> > > >  		if (IS_ERR_OR_NULL(dentry)) {
> > > > -			if (rqstp)
> > > > -
> > > > 				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > > > +			trace_nfsd_set_fh_dentry_badhandle(rqstp,
> > > > fhp,
> > > >  					dentry ?  PTR_ERR(dentry) :
> > > > -ESTALE);
> > > >  			switch (PTR_ERR(dentry)) {
> > > >  			case -ENOMEM:
> > > > @@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > >  	dentry = fhp->fh_dentry;
> > > >  	exp = fhp->fh_export;
> > > >  
> > > > -	if (rqstp)
> > > > -		trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > > > +	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
> > > >  
> > > >  	/*
> > > >  	 * We still have to do all these permission checks, even
> > > > when
> > > > @@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > >  	/* Finally, check access permissions. */
> > > >  	error = nfsd_permission(cred, exp, dentry, access);
> > > >  out:
> > > > -	if (rqstp)
> > > > -		trace_nfsd_fh_verify_err(rqstp, fhp, type, access,
> > > > error);
> > > > +	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access,
> > > > error);
> > > >  	if (error == nfserr_stale)
> > > >  		nfsd_stats_fh_stale_inc(nn, exp);
> > > >  	return error;
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index 77bbd23aa150..d49b3c1e3ba9 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
> > > >  
> > > >  TRACE_EVENT(nfsd_fh_verify,
> > > >  	TP_PROTO(
> > > > +		const struct net *net,
> > > >  		const struct svc_rqst *rqstp,
> > > >  		const struct svc_fh *fhp,
> > > >  		umode_t type,
> > > >  		int access
> > > >  	),
> > > > -	TP_ARGS(rqstp, fhp, type, access),
> > > > +	TP_ARGS(net, rqstp, fhp, type, access),
> > > >  	TP_STRUCT__entry(
> > > >  		__field(unsigned int, netns_ino)
> > > >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > > > @@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
> > > >  		__field(unsigned long, access)
> > > >  	),
> > > >  	TP_fast_assign(
> > > > -		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
> > > > -		__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > >xpt_local,
> > > > -		       rqstp->rq_xprt->xpt_locallen);
> > > > -		__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > >xpt_remote,
> > > > -				  rqstp->rq_xprt->xpt_remotelen);
> > > > -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> > > > +		__entry->netns_ino = net->ns.inum;
> > > > +		if (rqstp) {
> > > > +			__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > >xpt_local,
> > > > +					  rqstp->rq_xprt-
> > > > >xpt_locallen);
> > > > +			__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > >xpt_remote,
> > > > +					  rqstp->rq_xprt-
> > > > >xpt_remotelen);
> > > > +		}
> > > 
> > > Does this need an else branch to set these values to something when
> > > rqstp is NULL, or are we guaranteed that they are already zeroed out
> > > when they aren't assigned?
> > 
> > I'm not sure.  It isn't immediately clear what is actually using these.
> > 
> > But I did just notice an inconsistency, these entry members are defined:
> > 
> >                 __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> >                 __sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
> > 
> > Yet they go on to use rqstp->rq_xprt->xpt_locallen and
> > rqstp->rq_xprt->xpt_remotelen respectively.
> > 
> > Chuck, would welcome your feedback on how to properly fix these
> > tracepoints to handle rqstp being NULL.  And the inconsistency I just
> > noted is something extra.
> 
> First, a comment about patch ordering: I think you can preserve
> attribution but make these a little easier to digest if you reverse
> 4/ and 5/. Fix the problem before it becomes a problem, as it were.
> 
> As a general remark, I would prefer to retain the trace points and
> even the address information in the local I/O case: the client
> address is an important part of the decision to permit or deny
> access to the FH in question. The issue is how to make that
> happen...
> 
> The __sockaddr() macros I think will trigger an oops if
> rqstp == NULL. The second argument determines the size of a
> variable-length trace field IIRC. One way to avoid that is to use a
> fixed size field for the addresses (big enough to store an IPv6
> address?  or an abstract address? those can get pretty big)
> 
> I need to study 4/ more closely; perhaps it is doing too much in a
> single patch. (ie, the code ends up in a better place, but the
> details of the transition are obscured by being lumped together into
> one patch).
> 
> So, can you or Neil answer: what would appear as the client address
> for local I/O ?

Before when there was the "fake" svc_rqst it was initialized with:

       /* Note: we're connecting to ourself, so source addr == peer addr */
       rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
                       (struct sockaddr *)&rqstp->rq_addr,
                       sizeof(rqstp->rq_addr));

Anyway, as the code is also now: the rpc_clnt passed to
nfsd_open_local_fh() will reflect the same address as the server.

My thinking was that for localio there doesn't need to be any explicit
listing of the address info in the tracepoints (but that'd be more
convincing if we at least logged localio by looking for and logging
NFSD_MAY_LOCALIO in mayflags passed to nfsd_file_acquire_local).

But I agree it'd be nice to have tracepoints log matching 127.0.0.1 or
::1, etc -- just don't think it strictly necessary.

Open to whatever you think best.

Mike


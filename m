Return-Path: <linux-fsdevel+bounces-27967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D139654D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 03:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED8A1F2460B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 01:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD354F95;
	Fri, 30 Aug 2024 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD3BmvoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADD3398A;
	Fri, 30 Aug 2024 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982332; cv=none; b=YDFxj5RN+Doqx4c7TRTNPst25rxkVlrlNiX11ooI9Lt4F6Kn66tHPI3HnDLxu09WO5xUB/YmaCxnj/YbOnkjKIIofqBzYvy+HtptAib05hD6/W/+xkELp6HfHvY1xqd5Dsw8MB+pC/pwq9tFIvASEjaVtzPCdAQLjY4E8bUJMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982332; c=relaxed/simple;
	bh=Fdjffkj4EWGbECXKl+lw8/wyl4zTJ9WG3F9bhpbz06Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/MPu2M/avd+ceoyv+altwcYIDT89Q8cHvGIdSqokWXApxk3hjSTIvCV5s0QLXLJ8QxvjiCx05ysuSEWXxstCth5L+a8lr5m1utGuoqlQ+g1m6WJuqHMjp/kt4/raUhG9dKG7Lwklo9Sj+1vdR3DEQm9s63eY64DGTPVavrfcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD3BmvoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9BC4CEC1;
	Fri, 30 Aug 2024 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724982331;
	bh=Fdjffkj4EWGbECXKl+lw8/wyl4zTJ9WG3F9bhpbz06Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BD3BmvoSb6CFb2a2CK84ZGEyFMUaMVVB7eiS5DUaCPHKw/F3HKbNzhJtU4/BypR2z
	 IE7AUAgyFKfCDz7+9jgogr0r/9YFUqnMrFjXDB2IayDqq2nQOoT2vwNJLsQpI+32N0
	 oIExy4BYtqrRcmcI80HDgdajdAhTnI53mg6UVNjJHlHTfhXgB2mJj28EsUoreSCruS
	 zOWK2ftQgzgJ4bbLqiNpyYzvkwRypCdUpbEfbCErhJwNGzVj3V/WNuLS+b5xPTgnxJ
	 e3xCQ9gpRdBbTI5gjD/XRLlYGxgEMJoL/mdhZ2OCTc9omQwIbaAvAFIHCV2n5c6srH
	 PU09wsURGjOkg==
Date: Thu, 29 Aug 2024 21:45:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <ZtEkOsoDgfeQSSjp@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-15-snitzer@kernel.org>
 <172497475053.4433.8625349705350143756@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172497475053.4433.8625349705350143756@noble.neil.brown.name>

On Fri, Aug 30, 2024 at 09:39:10AM +1000, NeilBrown wrote:
> On Thu, 29 Aug 2024, Mike Snitzer wrote:
> 
> > +
> > +bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *dom)
> > +{
> > +	bool is_local = false;
> > +	nfs_uuid_t *nfs_uuid;
> > +
> > +	rcu_read_lock();
> > +	nfs_uuid = nfs_uuid_lookup(uuid);
> > +	if (nfs_uuid) {
> > +		nfs_uuid->net = maybe_get_net(net);
> 
> I know I said it looked wrong to be getting a ref for the domain but not
> the net - and it did.  But that doesn't mean the fix was to get a ref
> for the net and to hold it indefinitely.
>
> This ref is now held until the client happens to notice that localio
> doesn't work any more (because nfsd_serv_try_get() fails).  So the
> shutdown of a net namespace will be delayed indefinitely if the NFS
> filesystem isn't being actively used.
> 
> I would prefer that there were a way for the net namespace to reach back
> into the client and disconnect itself.  Probably this would be a
> linked-list in struct nfsd_net which linked list_heads in struct
> nfs_client.  This list would need to be protected by a spinlock -
> probably global in nfs_common so client could remove itself and server
> could remove all clients after clearing their net pointers.
> 
> It is probably best if I explain all of what I am thinking as a patch.
> 
> Stay tuned.

OK, a mechanism to have the net namespace disconnect itself sounds neat.

Or alternatively we could do what I was doing:

        /* Not running in nfsd context, must safely get reference on nfsd_serv */
        cl_nfssvc_net = maybe_get_net(cl_nfssvc_net);
        if (!cl_nfssvc_net)
                return -ENXIO;

        nn = net_generic(cl_nfssvc_net, nfsd_net_id);

        /* The server may already be shutting down, disallow new localio */
        if (unlikely(!nfsd_serv_try_get(nn))) {

But only if maybe_get_net() will always fail safely...

I feel like we talked about the relative safety of maybe_get_net()
before (but I'm coming up short searching my email):

static inline struct net *maybe_get_net(struct net *net)
{
        /* Used when we know struct net exists but we
         * aren't guaranteed a previous reference count
         * exists.  If the reference count is zero this
         * function fails and returns NULL.
         */
        if (!refcount_inc_not_zero(&net->ns.count))
                net = NULL;
        return net;
}

So you have doubts the struct net will always still exist because I
didn't take a reference? (from fs/nfsd/localio.c):

static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
{
        struct localio_uuidarg *argp = rqstp->rq_argp;

        (void) nfs_uuid_is_local(&argp->uuid, SVC_NET(rqstp),
                                 rqstp->rq_client);

        return rpc_success;
}

I think that's a fair concern (despite it working fine in practice
with destructive container testing, I cannot say there won't ever be a
use-after-free bug).

So all said: consider me staying tuned ;)

Thanks


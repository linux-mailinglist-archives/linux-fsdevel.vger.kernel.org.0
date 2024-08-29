Return-Path: <linux-fsdevel+bounces-27886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF936964AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FA11C24B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F361B1512;
	Thu, 29 Aug 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3OKeoPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6251B2530;
	Thu, 29 Aug 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947274; cv=none; b=f4+NOpHilWoYW9QXjGnCt+FTp70EajqtyXpp7r5hPPm7x/zcG5RY913wT1/YX7Rj7IfO/YMpUTB9Vuo71VFYFJGNgYibuL1UU0QjJhYBfyPuH45x+VNFvCK2BIFEg/15AU/y8Lj+45RHvzTCGGTgBjoVdKkQ8rS6ZMwCgD0ca+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947274; c=relaxed/simple;
	bh=IdNfm2ROo5cJk22oRncMVULWisl4XQJYWrupaZcAAwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p46p5k33Lv0RHZH8wsIulcvPgJH51XGAVU4/47Q9rL7QzwRFe1NAfqp15Z9VxW2Od1ZQevdCJJ2SMTpEifDQO7IYdBUkJajCSMzXUMwVJQsTi+qREdk6kNWBH5cz86Q4RwlyXwhut6TL6lBKwARQqdHqf/ogxsU7Kn/busp4+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3OKeoPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FAC4CEC1;
	Thu, 29 Aug 2024 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947274;
	bh=IdNfm2ROo5cJk22oRncMVULWisl4XQJYWrupaZcAAwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3OKeoPMwpmueaLmWZVz2qD4Gwi0r5GHSKePqRLmuxItgWiyXh49orKmjM+3QH1FV
	 Uck53BY3+ou/FzBLZ6KW/UnY7qygyR47UUDau2dWaxsByTt7RvjyxebkoxCEH58TdU
	 k6N4ij3sGtLW4qeXJmtQHDQ6IFUltbnBD0mORyv+S5XvqGiFcrL0yqCsKu0UvwKfyr
	 ACl5QwrkteWtuXGDclPzhsabRuXv5kWn0Op+25rgsm7WSnohpgDum6HUyx5a8RwTgU
	 3/LMGkI/XMkeH2kcozGmT9JNnQkIvpo63DaehABPrUl/HmXLDnguObgRMb9vQ0LTP0
	 H5txj2o/dSYMQ==
Date: Thu, 29 Aug 2024 12:01:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 10/25] nfsd: add nfsd_serv_try_get and nfsd_serv_put
Message-ID: <ZtCbSHvr2HrxyGLM@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-11-snitzer@kernel.org>
 <d51eb15966a1b879c295d1933b8d9585a6acf3c4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51eb15966a1b879c295d1933b8d9585a6acf3c4.camel@kernel.org>

On Thu, Aug 29, 2024 at 11:57:20AM -0400, Jeff Layton wrote:
> On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
> > to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> > caller of nfsd_serv_try_get releases their reference using nfsd_serv_put.
> > 
> > A percpu_ref is used to implement the interlock between
> > nfsd_destroy_serv and any caller of nfsd_serv_try_get.
> > 
> > This interlock is needed to properly wait for the completion of client
> > initiated localio calls to nfsd (that are _not_ in the context of nfsd).
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/netns.h  |  8 +++++++-
> >  fs/nfsd/nfssvc.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 238fc4e56e53..e2d953f21dde 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/filelock.h>
> >  #include <linux/nfs4.h>
> >  #include <linux/percpu_counter.h>
> > +#include <linux/percpu-refcount.h>
> >  #include <linux/siphash.h>
> >  #include <linux/sunrpc/stats.h>
> >  
> > @@ -139,7 +140,9 @@ struct nfsd_net {
> >  
> >  	struct svc_info nfsd_info;
> >  #define nfsd_serv nfsd_info.serv
> > -
> > +	struct percpu_ref nfsd_serv_ref;
> > +	struct completion nfsd_serv_confirm_done;
> > +	struct completion nfsd_serv_free_done;
> >  
> >  	/*
> >  	 * clientid and stateid data for construction of net unique COPY
> > @@ -221,6 +224,9 @@ struct nfsd_net {
> >  extern bool nfsd_support_version(int vers);
> >  extern unsigned int nfsd_net_id;
> >  
> > +bool nfsd_serv_try_get(struct nfsd_net *nn);
> > +void nfsd_serv_put(struct nfsd_net *nn);
> > +
> >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> >  void nfsd_reset_write_verifier(struct nfsd_net *nn);
> >  #endif /* __NFSD_NETNS_H__ */
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index defc430f912f..e43d440f9f0a 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -193,6 +193,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
> >  	return 0;
> >  }
> >  
> > +bool nfsd_serv_try_get(struct nfsd_net *nn)
> > +{
> > +	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
> > +}
> > +
> > +void nfsd_serv_put(struct nfsd_net *nn)
> > +{
> > +	percpu_ref_put(&nn->nfsd_serv_ref);
> > +}
> > +
> > +static void nfsd_serv_done(struct percpu_ref *ref)
> > +{
> > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > +
> > +	complete(&nn->nfsd_serv_confirm_done);
> > +}
> > +
> > +static void nfsd_serv_free(struct percpu_ref *ref)
> > +{
> > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> > +
> > +	complete(&nn->nfsd_serv_free_done);
> > +}
> > +
> >  /*
> >   * Maximum number of nfsd processes
> >   */
> > @@ -392,6 +416,7 @@ static void nfsd_shutdown_net(struct net *net)
> >  		lockd_down(net);
> >  		nn->lockd_up = false;
> >  	}
> > +	percpu_ref_exit(&nn->nfsd_serv_ref);
> >  	nn->nfsd_net_up = false;
> >  	nfsd_shutdown_generic();
> >  }
> > @@ -471,6 +496,13 @@ void nfsd_destroy_serv(struct net *net)
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv = nn->nfsd_serv;
> >  
> > +	lockdep_assert_held(&nfsd_mutex);
> > +
> > +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> > +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> > +	wait_for_completion(&nn->nfsd_serv_free_done);
> > +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> > +
> >  	spin_lock(&nfsd_notifier_lock);
> >  	nn->nfsd_serv = NULL;
> >  	spin_unlock(&nfsd_notifier_lock);
> > @@ -595,6 +627,13 @@ int nfsd_create_serv(struct net *net)
> >  	if (nn->nfsd_serv)
> >  		return 0;
> >  
> > +	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
> > +				0, GFP_KERNEL);
> > +	if (error)
> > +		return error;
> > +	init_completion(&nn->nfsd_serv_free_done);
> > +	init_completion(&nn->nfsd_serv_confirm_done);
> > +
> >  	if (nfsd_max_blksize == 0)
> >  		nfsd_max_blksize = nfsd_get_default_max_blksize();
> >  	nfsd_reset_versions(nn);
> 
> A little hard to review this one at this point in the series, as there
> are no callers of get/put yet, but the concept seems reasonable.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, yeah Chuck asked that I factor this interlock interface out to
a separate patch because it was a bit much buried in the next patch
that actually consumes it.


Return-Path: <linux-fsdevel+bounces-27400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90E9613AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002C01F233EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC71C93B6;
	Tue, 27 Aug 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTFyVX0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC031A0726;
	Tue, 27 Aug 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774907; cv=none; b=mQrpHCs1WFtS+SeHNn5f001aYSfbG5CSr9rj4ixEpL5/tQOeKFUI4cQMIhICnVQBvQaW+NPoBPBq5zxfvW0HJygUnUY3xDcbLX5bPXu37rxJcvFxFPIUyI0YIrLytzIgMRHoUzutAeggtrdK6so3wGlPIOc4tOnngOO2QfGT48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774907; c=relaxed/simple;
	bh=TXDRS7lXUCRKRE6nQ2+0gejSHVe2zbDjrojORqrRI/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssrbispT/miyDZogMRFTUG460jfXLnOnpdnNVX26EXDnxC33hhXjEDoEr+6LEHrILp2kJonsLHp+sFE9lBxp6Ba4tsxAaYDyEMUYSsiot+Vdep2/cLOAsm0NO29ert9PL/Bnz4jiTOXZNDPKRY2yGa2LVInoMF/PX78GfjJEYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTFyVX0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE52C61076;
	Tue, 27 Aug 2024 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774904;
	bh=TXDRS7lXUCRKRE6nQ2+0gejSHVe2zbDjrojORqrRI/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTFyVX0A19JadU4zgB0qAyng472imX0BNg6NeQRYgGzENal5NmFs9V3HV0jmvICjD
	 5vNHkVMm0FH6eVw208PWk0xwsOUhZ4aoGP32OmJc7INCUB/Dx9yEi8gr2c5QmQZoof
	 J37hUALnTZMRtmJV3+X62AZ9YnsxQcaA64b2E3YkRmyvBBTalPXemacZoM9TAiWMS3
	 zxmS1o5azdBKdQkQxbowNXXfAGz4x2rBpxQGKzgGFq3FV+N51CzHoSKvOv6zrcuxqE
	 0AhuEJFuzHTAsLD0ZT+Wf+ifZe3eZ/rfl8Bj+K/CsVQXeAOJu8h0tqfT7hHpEYDNYI
	 Nrb8ad9G/s/Ow==
Date: Tue, 27 Aug 2024 12:08:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 07/19] SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
Message-ID: <Zs359_29KyHnEqdr@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-8-snitzer@kernel.org>
 <ZstK7BKf02uD17sl@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZstK7BKf02uD17sl@tissot.1015granger.net>

On Sun, Aug 25, 2024 at 11:17:00AM -0400, Chuck Lever wrote:
> On Fri, Aug 23, 2024 at 02:14:05PM -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Add new funtion rpcauth_map_clnt_to_svc_cred_local which maps a
> > generic cred to a svc_cred suitable for use in nfsd.
> > 
> > This is needed by the localio code to map nfs client creds to nfs
> > server credentials.
> > 
> > Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
> > ->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
> > addition, these uid and gid must be translated with from_kuid_munged()
> > so local client uses correct uid and gid when acting as local server.
> > 
> > Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  include/linux/sunrpc/auth.h |  4 ++++
> >  net/sunrpc/auth.c           | 22 ++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
> > index 61e58327b1aa..4cfb68f511db 100644
> > --- a/include/linux/sunrpc/auth.h
> > +++ b/include/linux/sunrpc/auth.h
> > @@ -11,6 +11,7 @@
> >  #define _LINUX_SUNRPC_AUTH_H
> >  
> >  #include <linux/sunrpc/sched.h>
> > +#include <linux/sunrpc/svcauth.h>
> >  #include <linux/sunrpc/msg_prot.h>
> >  #include <linux/sunrpc/xdr.h>
> >  
> > @@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
> >  int			rpcauth_init_credcache(struct rpc_auth *);
> >  void			rpcauth_destroy_credcache(struct rpc_auth *);
> >  void			rpcauth_clear_credcache(struct rpc_cred_cache *);
> > +void			rpcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> > +							   const struct cred *,
> > +							   struct svc_cred *);
> >  char *			rpcauth_stringify_acceptor(struct rpc_cred *);
> >  
> >  static inline
> > diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> > index 04534ea537c8..3b6d91b36589 100644
> > --- a/net/sunrpc/auth.c
> > +++ b/net/sunrpc/auth.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/sunrpc/clnt.h>
> >  #include <linux/sunrpc/gss_api.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/user_namespace.h>
> >  
> >  #include <trace/events/sunrpc.h>
> >  
> > @@ -308,6 +309,27 @@ rpcauth_init_credcache(struct rpc_auth *auth)
> >  }
> >  EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
> >  
> 
> rpcauth_map_clnt_to_svc_cred_local() needs a kdoc comment.
> 
> Since it is called only from fs/nfsd/localio.c -- should this API
>                                 ^^^^
> reside in net/sunrpc/svcauth.c instead of net/sunrpc/auth.c ?
> 

Yes, that makes sense.  I also renamed it to
svcauth_map_clnt_to_svc_cred_local

Thanks.


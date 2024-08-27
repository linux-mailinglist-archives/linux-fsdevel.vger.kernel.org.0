Return-Path: <linux-fsdevel+bounces-27420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F96B9615B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397B21F21962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC41D1F52;
	Tue, 27 Aug 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmwVJHbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10981C6885;
	Tue, 27 Aug 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780753; cv=none; b=elabwE/14QEjR0MWkGMjLrpZh0NrqM7OMr8owhakqts7rjkkNK5BD+F17dTTI1LtMt9AiL/9kQsJFt10YASJXb4Db9q981ANzA46v31LqdJJ089CJFMsEXcXeyTi52qC7v+gov3OQHYrf4fR/rq01tdNrG+zq3z1+Mixt9Zs8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780753; c=relaxed/simple;
	bh=O6kkepmtbXWG69F82jx7uGfAfErWYr3SzzcU865GlgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdBdyIXpm7WUgAtB3ANKhJAnAqNjzdh5rdYXMEDCN5RmUGPpRo9dkE+xjwyBCCb+gPdY7eEbdEPC0hzeqXsErQJFx3B6GVrDMGYI4A0Cb5nDqsSiOhbUC7Q9AwFxIHTPkV/JCOFcxpp5G95USDpscZ7zQODq8KD84oC2gMvDr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmwVJHbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256C0C58295;
	Tue, 27 Aug 2024 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724780753;
	bh=O6kkepmtbXWG69F82jx7uGfAfErWYr3SzzcU865GlgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmwVJHbA4PNdmhvarNo/MxWNroRldSXG3vFPbj+CYm9zIdSeBWDbxaVAmdkmVLJbz
	 i8RoSFD6VszEkWxJMLeHy3yRmwbwf9tTxLyrNDXesrzYje0L/nTMoabkk9+zI3PdnQ
	 05+9F2XRBu60yMnqicR13QJ7lb6HL3up0UkBtdTtR/IMiyKUQQcWe2J487hI8q/vwk
	 5U5JavTNK5NRw+msYBuzhZM3GYGFCZeEY/MFLkgzsqtHwNdvh6KYg/VcOyoaVFKDpM
	 JvcMiU+VdEVMNEm4EsSd+opW/i33JqiCcvSkU85T807oCbUyooTE55zpZzFCS8N5/4
	 kOImCcE8EKVcw==
Date: Tue, 27 Aug 2024 13:45:52 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 09/19] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <Zs4Q0FqoHEKUjrDj@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-10-snitzer@kernel.org>
 <172463235065.6062.5648288713828077276@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172463235065.6062.5648288713828077276@noble.neil.brown.name>

On Mon, Aug 26, 2024 at 10:32:30AM +1000, NeilBrown wrote:
> On Sat, 24 Aug 2024, Mike Snitzer wrote:
> > 
> > Also, expose localio's required nfsd symbols to NFS client:
> > - Cache nfsd_open_local_fh symbol (defined in next commit) and other
> >   required nfsd symbols in a globally accessible 'nfs_to'
> >   nfs_to_nfsd_t struct.
> 
> I'm not thrilled with the mechanism for getting these symbols.
> 
> I'd rather nfsd passed the symbols to nfs_uuid_is_local(), and it stored
> them somewhere that nfs can see them.  No need for reference counting
> etc.  If nfs/localio holds an auth_domain, then it implicitly holds a
> reference to the nfsd module and the functions cannot disappear.
>
> I would created an 'nfs_localio_operations' structure which is defined
> in nfsd as a constant.
> The address of this is passed to nfs_uud_is_local() and that address
> is stored in nfs_to if it doesn't already have the correct value.
> 
> So no need for symbol_request() or symbol_put().

I'm not seeing why we'd want to actively engineer some even more
bespoke way to access nfsd symbols.  The symbol refcounting is only
done when the client first connects as part of the LOCALIO handshake
(or when client is destroyed and LOCALIO enabled), so it isn't getting
in the way.

Happy to revisit this but I'd really prefer to use standard convention
(symbol_request and symbol_put) to establish nfs's dependency on
nfsd's symbols.

> > +
> > +DEFINE_MUTEX(nfs_uuid_mutex);
> 
> This doesn't need to be a mutex - a spinlock is sufficient.

Fixed, thanks.

> > +
> > +bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *dom)
> > +{
> > +	bool is_local = false;
> > +	nfs_uuid_t *nfs_uuid;
> > +
> > +	rcu_read_lock();
> > +	nfs_uuid = nfs_uuid_lookup(uuid);
> > +	if (nfs_uuid) {
> > +		is_local = true;
> > +		nfs_uuid->net = net;
> 
> It looks odd that you don't take a reference to the net.
> It is probably correct but a comment explaining why would help.
> Is it that the dom implies a reference to the net?

No, I just made the code tolerate the net having been torn down
(see: fs/nfsd/localio.c:nfsd_open_local_fh), but it'd be safer to take
a proper reference here.

I'll work through it once more and update accordingly.

Thanks!


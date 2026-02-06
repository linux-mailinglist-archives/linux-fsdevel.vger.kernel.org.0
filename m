Return-Path: <linux-fsdevel+bounces-76526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULiYIvlthWnqBQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:28:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BAFA112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB543016CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6E2DC323;
	Fri,  6 Feb 2026 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbrxPkFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720802DB78C;
	Fri,  6 Feb 2026 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352112; cv=none; b=LW3rIYiJvtBvp94GuHS6L43SQo50EwsfGgD5udTho7SeviCCVwYS/rZZCWnfYX7+jaFg6dMAwxg/LJu+KXBq9NcqEyN10ZuKwum3PnpSMRiymyEsWhehYslNoTUMfsXvFVMJlKJuHxZv4aSMvmpF0Dquxxu3bhpT9TvM6tIK188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352112; c=relaxed/simple;
	bh=Wz1kRHJUntz7LRbt3bVmepmT5kV6NKUoQRkVeWcKn8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyL3deyH2ceZ3vJ60hQ13377FLA22nxbQuxSet1mim0LLYn1bYBhpuCTiw8OAqZiXOpuCaPlipIiOD4DikwRNYSJcu4QVF4l/IJpHKcFgSGA7GRbR8ekvM16TaN8MhTAOxMEEDUItjR3gWU0BazB/FX8R7h0Q9MuvIG3EASmmwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbrxPkFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F1C116C6;
	Fri,  6 Feb 2026 04:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770352112;
	bh=Wz1kRHJUntz7LRbt3bVmepmT5kV6NKUoQRkVeWcKn8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbrxPkFR5Ox0bQJo3+leFcWRawXTeA1NxkTk4RnocaM+9RNZFT6SSb9ebh08AO9Ci
	 9LuvO24XqsKN9qc9i00XkVIrS3Q7PsPFT2la+u5sNJzmPh664FaSxo+ygietO78m34
	 Q9DWb7KplmQpe8gT6231KkFWumKlmgOhSjHlwUszpP03KOhnaedFlMzqb0D+/uEM/M
	 /wCKmK3txZE9Oh1vhYvCU9UZzag68lZSL3EIjcAU85MNtz0lZ5dx+fmOt+cWRcYy3Y
	 HaOjRjkKtL2PUJBlbvc5U0u5xzexz/sWgxJyNoFiaq1MoThto9dHMRCIPggU80g9N8
	 ak35xLBIZ8aEQ==
Date: Thu, 5 Feb 2026 20:28:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] fuse: use the iomap cache for iomap_begin
Message-ID: <20260206042831.GK7686@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
 <176169812141.1426649.7329768881025739080.stgit@frogsfrogsfrogs>
 <20260205185327.1776495-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205185327.1776495-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76526-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E5BAFA112
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:52:04AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Look inside the iomap cache to try to satisfy iomap_begin.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit 705acf20a7890a2ba0ab24fe6bf523b99c1a1f32
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: use the iomap cache for iomap_begin
> 
> Look inside the iomap cache to try to satisfy iomap_begin.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > index eade8dad8a570..cf46824dc50bf 100644
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> 
> [ ... ]
> 
> > @@ -238,9 +239,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
> >  	const unsigned int blocksize = i_blocksize(inode);
> >  	uint64_t end;
> >
> > -	/* Type and flags must be known */
> > +	/*
> > +	 * Type and flags must be known.  Mapping type "retry cache" doesn't
> > +	 * use any of the other fields.
> > +	 */
> >  	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
> >  		return false;
> > +	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
> > +		return true;
> >  	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
> >  		return false;
> 
> [ ... ]
> 
> > @@ -271,6 +277,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
> >  		if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
> >  			return false;
> >  		break;
> > +	case FUSE_IOMAP_TYPE_RETRY_CACHE:
> > +		/*
> > +		 * We only accept cache retries if we have a cache to query.
> > +		 * There must not be a device addr.
> > +		 */
> > +		if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
> > +			return false;
> > +		fallthrough;
> >  	case FUSE_IOMAP_TYPE_DELALLOC:
> >  	case FUSE_IOMAP_TYPE_HOLE:
> >  	case FUSE_IOMAP_TYPE_INLINE:
> 
> Does the validation at lines 280-287 ever execute? Looking at
> fuse_iomap_check_mapping(), the early return at line 248-249 handles
> FUSE_IOMAP_TYPE_RETRY_CACHE:
> 
>     if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
>         return true;

Indeed, this means we can't ever hit the RETRY_CACHE case in the switch
statement.

> This means the function returns before reaching the switch statement that
> contains the new RETRY_CACHE case. The validation check 'if (BAD_DATA(!
> fuse_inode_caches_iomaps(inode))) return false;' at lines 284-285 appears
> to be dead code because RETRY_CACHE mappings are accepted without verifying
> the inode has a cache, contradicting the comment "We only accept cache
> retries if we have a cache to query."
> 
> Either the fuse_inode_caches_iomaps check should move to the early return
> path like this:
> 
>     if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE) {
>         if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
>             return false;
>         return true;
>     }

That's the simplest resolution to the problem; I'll go with that.

> or the early return should be removed to let RETRY_CACHE fall through to
> the switch statement validation.

Nah, we definitely don't need to proceed with more validation.  Good
catch!

--D


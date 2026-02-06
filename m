Return-Path: <linux-fsdevel+bounces-76527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFvLLTlwhWnqBQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:38:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5EFFA240
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4C5301B90A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4D2E5B1B;
	Fri,  6 Feb 2026 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqxI3qj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABC16DC28;
	Fri,  6 Feb 2026 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352685; cv=none; b=tWYJASPui1cNsCIoJEmSBn34BtBgVaIfhOoS1dNUkLQY7hZ52SJzn2gATviwWO3CvuYkAtOotUOYC37jNnRAO1isUy9OBlkTWvzOOMTsCS6q7VecOG5UbZyvPDPEJubbfSlKJwVbqmt16XdAiy3aBYg4YPxtmIr+2EdxWgx/d1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352685; c=relaxed/simple;
	bh=Simv44eYMgo0+Y3rdnagGilQqLr4vBSpaYCIOWLIJlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fReLEWqJ4D9cQVDzE+Go3Cz1gzcTqUropyxjN0b2mHlkp34cpYoDjwhmpUvF9++011EkfMPEh1CTOYXba2mIuqBZ9FSq5dbZGOZfX6G1t53GhAgTMG+hCTTGf1EEqvV4JHtbqaRCqk78aE64gOAicdYAYyXT7YgILzgFw7sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqxI3qj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB3CC116C6;
	Fri,  6 Feb 2026 04:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770352685;
	bh=Simv44eYMgo0+Y3rdnagGilQqLr4vBSpaYCIOWLIJlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqxI3qj0kXE7tUYaY5ny3IQMo7z9RNknP9oSD21/wixvnoCa1k42CRgp+MGc+5mUT
	 0IeMXGzNrspZ8dI6rPGvDri5o0Xfi6dDp2NEioFu6qono52AGYo4O2jmXPkKC66Ehz
	 vBofthXX54pRgQakr7Y8GCaE99TmGmJ73z8vmKhkI6uiOnZJFovD00oZZZdWOi4Peu
	 9hCSNNRnMOo4zwE5KW0e/M71ub3tnDJ/D7tvB3p24Kqe7f9FwEqTIwmWiUXMWObmEs
	 GnrsUJ/iJOLN8WchWSQYxVP+qCmVjL2QKJcAPGBk7VMr5IYlvNnGSAMo4sJnD6hk1k
	 B5Ag4gH96FOhw==
Date: Thu, 5 Feb 2026 20:38:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/10] fuse: invalidate iomap cache after file updates
Message-ID: <20260206043804.GL7686@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
 <176169812184.1426649.3326330857378130332.stgit@frogsfrogsfrogs>
 <20260205184620.1682986-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205184620.1682986-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76527-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F5EFFA240
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:44:40AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > The kernel doesn't know what the fuse server might have done in response
> > to truncate, fallocate, or ioend events.  Therefore, it must invalidate
> > the mapping cache after those operations to ensure cache coherency.
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
> commit 8cd55ddf79a7cd6b1c8afbe08b72d8896da67306
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: invalidate iomap cache after file updates
> 
> This commit fixes a cache coherency bug by adding cache invalidation
> calls after file-modifying operations to prevent stale cached iomap
> entries from being used.
> 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> 
> [ ... ]
> 
> > @@ -3202,7 +3205,9 @@ struct fuse_copy_file_range_in inarg = {
> >  		goto out;
> >  	}
> >
> > -	if (!is_iomap)
> > +	if (is_iomap)
> > +		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);
> 
> In __fuse_copy_file_range(), does this code pass the correct value to
> fuse_iomap_copied_file_range()?
> 
> When using the FUSE_COPY_FILE_RANGE_64 API (fc->no_copy_file_range_64
> is false), the response goes into 'outarg_64', not 'outarg'. The
> 'outarg' struct remains uninitialized in this path.
> 
> Looking at the code earlier in the function:
> 
>     if (fc->no_copy_file_range_64) {
>         args.out_args[0].size = sizeof(outarg);
>         args.out_args[0].value = &outarg;
>     } else {
>         args.out_args[0].size = sizeof(outarg_64);
>         args.out_args[0].value = &outarg_64;
>     }
> 
>     /* ... */
> 
>     if (args.out_args[0].value == &outarg_64)
>         bytes_copied = outarg_64.size;
>     else
>         bytes_copied = outarg.size;
> 
> The 'bytes_copied' variable correctly handles both API versions. The
> else branch (non-iomap path) already uses 'bytes_copied' for
> truncate_inode_pages_range().
> 
> When the 64-bit API succeeds, could the cache invalidation use
> garbage/zero data for the range instead of the actual bytes copied,
> potentially leaving stale mappings in the cache?

Yes, fuse_iomap_copied_file_range should have its @written parameter
changed to u64.  I forgot to make that amendment after
FUSE_COPY_FILE_RANGE_64 was introduced last cycle.  It is a very good
sign that your AI prompts can catch bitrot during development!

--D

> 
> > +	else
> >  		truncate_inode_pages_range(inode_out->i_mapping,
> >  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
> >  				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
> 
> 


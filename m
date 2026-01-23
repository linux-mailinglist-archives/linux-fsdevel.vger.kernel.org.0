Return-Path: <linux-fsdevel+bounces-75232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHPOMw0jc2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:28:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70F71B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595A8301E959
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A0360746;
	Fri, 23 Jan 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcNePfvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33919357706;
	Fri, 23 Jan 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153221; cv=none; b=hplm1rmbE+dE6pDMq9c+OHjSzcRM5XwzfC7yN1HByU57a9hWnBohGIPj7K9qZPQNFe7Yg6tUYG9uuu/X9BGH6rhOS1jNCv8B70Ke3yLHKplrzL84rIhKkTRbrHCDWRcxyHULQoolWBmnjIXhW5Mh3smrnN6wSX539l+KpBFFETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153221; c=relaxed/simple;
	bh=D6L6uggzwbERQGIcTWaQxpEbJ0bnMfxXzcyyOAv9mrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkmwdPLWqEBWepqhgPtoZ6KPOHFNPWJpFlAJt0QrEL/bfft1IK+G6ECjxSqhKi1XFeZ6/fc9CbgZlymh/uctkhDUfE5EpMWQmQmBaiPYqfHvRRWE1FqQzryiS9HbqTG+fTj85sPSzjNVxmOCENrV2XJUhlnVWUoHdNNx0Nx5jdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcNePfvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF3C19423;
	Fri, 23 Jan 2026 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769153221;
	bh=D6L6uggzwbERQGIcTWaQxpEbJ0bnMfxXzcyyOAv9mrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcNePfvbE/VnwxQ8Hr96u1uN2SPFhTA1vMlXY9NutF8ZcMSv4IRzpjLzixxqy0vBV
	 tkN6RMnW1rcFuWmrhK84a6KP8z8TNfxSqFOVV+QHEbfHMXpqAOKMKSISpj7XQQBKvC
	 BYLXtqLBsk5Xu283pF7NNuDLqBwan43MIrH6iKdseuF5FI2Sb2HpFSImHgmBJOkFw5
	 iWrfX+m8OdXdSRLSLsfAGswEGNAgB3vjQYVspg68O7IHj9bWt8gd6l53HGX9R+XblZ
	 C+o9mcRJZ1AzxC6vYWU1a4kSs5Iz9qHH8lT7Qvb5JWbAt86XiWvWHqWtN8JrxzKsfw
	 QL6ozPyMEnf3w==
Date: Thu, 22 Jan 2026 23:27:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260123072700.GN5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
 <20260122220420.GI5910@frogsfrogsfrogs>
 <20260123052723.GE24123@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123052723.GE24123@lst.de>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75232-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E70F71B70
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 06:27:23AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 02:04:20PM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 22, 2026 at 09:22:07AM +0100, Christoph Hellwig wrote:
> > > Use the kernel's resizable hash table to find the fsverity_info.  This
> > 
> > Oh is that what the 'r' stands for?  I thought it was rcu.  Maybe it's
> > both. :P
> 
> From the lib/rhashtable.c:
> 
>  * Resizable, Scalable, Concurrent Hash Table
> 
> > > Because insertation into the hash table now happens before S_VERITY is
> > > set, fsverity just becomes a barrier and a flag check and doesn't have
> > > to look up the fsverity_info at all, so there is only one two two
> > 
> > "one two two" <confused>?
> 
> one or two, sorry.  The cover letter actually explains this in more
> detail, which this should be updated to.
> 
> > > +static const struct rhashtable_params fsverity_info_hash_params = {
> > > +	.key_len		= sizeof(struct inode *),
> > 
> > 	.key_len		= sizeof_field(struct fsverity_info, inode),
> > 
> > Perhaps?
> 
> That should work, yes.
> 
> > > -	kfree(vi->tree_params.hashstate);
> > > -	kvfree(vi->hash_block_verified);
> > > -	kmem_cache_free(fsverity_info_cachep, vi);
> > > +	return rhashtable_lookup_fast(&fsverity_info_hash, &inode,
> > > +			fsverity_info_hash_params);
> > 
> > Hrm.  The rhashtable stores a pointer to the rhash_head, but now we're
> > returning that as if it were a fsverity_info pointer.  Can I be pedantic
> > and ask for a proper container_of() to avoid leaving a landmine if the
> > struct layout ever changes?
> 
> rhashtable_lookup_fast returns the struct containing the rhash_head.
> The paramters store the rhead_offset for that purpose.  See rht_obj
> as used by rhashtable_lookup.

Ahah.  That's right, but (imo) a weird quirk of the rhashtable
interface.  Though I only say that because *I* keep tripping over that;
maybe everyone else is ok.

> > > @@ -323,9 +323,9 @@ fsverity_init_verification_context(struct fsverity_verification_context *ctx,
> > >  				   struct fsverity_info *vi)
> > >  {
> > >  	ctx->inode = inode;
> > > -	ctx->vi = vi;
> > 
> > Can this function drop its @vi argument?
> 
> No..
> 
> > 
> > > +	ctx->vi = fsverity_get_info(inode);
> 
> ... but this extra lookup should have been removed and got messed up by a
> rebase, causing a pointless extra lookup.  (Which still is completely
> in the noise in my runs).

Ah ok, I was mildly confused by all this.

--D


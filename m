Return-Path: <linux-fsdevel+bounces-75401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHFaCJvudmkHZAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:33:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88083E94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CA63007CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35A30C611;
	Mon, 26 Jan 2026 04:33:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4F295511;
	Mon, 26 Jan 2026 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401996; cv=none; b=rOuRK/KEGnsZV9IlGCShMcVuZYIHfhkt7Lqjlq/3om42pzhCjdxOEzU4QCnHWtvaCwmNO+7gQtLBy1I/fXIUZqbzJx9vFj5SfdnvLBs+kZdjO2+zXS08zCqbmWcEF/e7SSaWpGX5Txiwaen6+CpWQvU6yF9BR8ED34g3AI91c3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401996; c=relaxed/simple;
	bh=RE7ir2TtXqgklqUp7zQMs3F6Y48rSvyMCBqXJ+NJjOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXzGAbl13ktDpUy2gyo/TUfh1nA4xAHy3tliJg0oEHXZ8Y+JoluqplQt7LROZy+lcY47h90GTOfCfZFN6YrbyQoe8IvPgao25gmMLe9QUeW9+s6Ag59w2wHuHubT1k3d5bmEyv4sw0xe19cPLVAI36Pnhj8QB4qfmybAMIhaKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3E6F227A88; Mon, 26 Jan 2026 05:33:11 +0100 (CET)
Date: Mon, 26 Jan 2026 05:33:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 06/11] fsverity: push out fsverity_info lookup
Message-ID: <20260126043311.GC30803@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-7-hch@lst.de> <20260124211956.GF2762@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124211956.GF2762@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75401-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AA88083E94
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 01:19:56PM -0800, Eric Biggers wrote:
> This patch introduces another bisection hazard by adding calls to
> fsverity_info_addr() when CONFIG_FS_VERITY=n.  fsverity_info_addr() has
> a definition only when CONFIG_FS_VERITY=y.
> 
> Maybe temporarily add a CONFIG_FS_VERITY=n stub for fsverity_info_addr()
> that returns NULL, and also ensure that it's dereferenced only when it's
> known that fsverity verification is needed.  Most of the call sites look
> okay, but the second one in ext4_mpage_readpages() needs to be fixed.

I've added an external declaration for fsverity_info_addr in the
CONFIG_FS_VERITY=n so that the linker catches unguarded references.  It 
caught two, which I fixed by adding IS_ENABLED checks that also reduce
the code size for non-fsverity builds.

> > -	fsverity_init_verification_context(&ctx, inode);
> > +	fsverity_init_verification_context(&ctx, inode, vi);
> 
> Note that fsverity_info has a back-pointer to the inode.  So,
> fsverity_init_verification_context() could just take the vi and set
> ctx->inode to vi->inode.
> 
> Then it wouldn't be necessary to get the inode from
> bio_first_folio_all(bio)->mapping->host (in fsverity_verify_bio()) or
> folio->mapping->host (in fsverity_verify_blocks()).
> Similarly in fsverity_readahead() too.
> 
> (It might make sense to handle this part as a separate patch.)

To be able to nicely used this vi->inode needs to lose the const
qualifier.  I've done that, and also added a const qualifiers
to ctx->vi while at it in prep patches.  With that just using
vi->inode in this patch is easy enough.



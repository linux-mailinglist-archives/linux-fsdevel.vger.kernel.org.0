Return-Path: <linux-fsdevel+bounces-75688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB3ZJmWDeWmexQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:32:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76C9CB99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8BEC300D370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798032E721;
	Wed, 28 Jan 2026 03:32:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792092EC541;
	Wed, 28 Jan 2026 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571169; cv=none; b=UmoiSb8bOe4vvhCpN9F7VC35Nmpvrk4reIv9xH4O3T7ftUv96WTgZWIGs/S4aaoZbynKL49z6rCbd41sJJkNpwfzuokDCfgLsZhJ1nepFVZ4HnB+ePbSs8acwxSVUDfyPRLeeSkICMHQ6/CFTtxEZzcOZ6Uw52IY8ECfYpyC+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571169; c=relaxed/simple;
	bh=x52DZyXdYjEMp/4jMGysGGKN52uAmZWnI1NPmvzi8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6rruSNk/fDFNw8DI/dljQI5cLPrOjh3fLW+A4EAIIbYDyx2w5qzG+mwIOxQ4Avh5MxZXvLhhl1DLYoSu86cq+Q5w7atVXKd9vKeA7CyapbNKE5EqRAktH5InLNR23nOznbOBsMpGQhyzYLaRiPcP+psMU8OQRz8se2iY7RB2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FFA4227A8E; Wed, 28 Jan 2026 04:32:42 +0100 (CET)
Date: Wed, 28 Jan 2026 04:32:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
Message-ID: <20260128033242.GA30830@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-10-hch@lst.de> <20260128032203.GA2718@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128032203.GA2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid,lst.de:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75688-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7E76C9CB99
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:22:03PM -0800, Eric Biggers wrote:
> On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> > struct fsverity_info contains information that is only read in the
> > verification path.  Apply the const qualifier to match various explicitly
> > passed arguments.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/verity/verify.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Did you consider that fsverity_info::hash_block_verified is written to?
> It's a pointer to an array, so the 'const' doesn't apply to its
> contents.  But logically it's still part of the fsverity information.

Well, it doesn't apply by the type rules.  But if you don't like the
const here just let me know and I'll drop it.



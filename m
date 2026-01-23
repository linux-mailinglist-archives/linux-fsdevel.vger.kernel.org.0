Return-Path: <linux-fsdevel+bounces-75204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNpCCMMEc2kFrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:18:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81124706A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 440C2301624B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A49366049;
	Fri, 23 Jan 2026 05:18:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C667313E3E;
	Fri, 23 Jan 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769145527; cv=none; b=UwlHrQxj8FyIOHwQrbS573cK3JhdpKltCHXGc1ruPZQIdjEY0Rafpq2yam8Zq2Kos39RaX1Jsdbgh0hXAmKuGE8cF7PuZivG3mfSfw8tsdMraFMpAPN8NFFGmnZWruaBHVStdua2UWYLPWgmp+HsOxLlJd0jmRjQXOzXvnxll4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769145527; c=relaxed/simple;
	bh=utRuWXi2BFH/GlT4amXhsrjsG1YSbK+N6GLLW3J/48Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhGj4C1dzrW0gvuYNHlUF6D5BA9iEgQyAyNlMrT2AQH7OEW1wsLRv3U5/RV+b1shBPsWm3S4hBEYUTtErDv1UuycBlgcUVyzJhxssG4chKTYRLRzIpU1j/X3D5lwvKpRUNQqV+HW35OJwllbEfbuBNt80NGqoZhTEscAW0jsVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56C74227AAE; Fri, 23 Jan 2026 06:18:36 +0100 (CET)
Date: Fri, 23 Jan 2026 06:18:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 08/11] ext4: consolidate fsverity_info lookup
Message-ID: <20260123051836.GD24123@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-9-hch@lst.de> <20260122215457.GH5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122215457.GH5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75204-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 81124706A4
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 01:54:57PM -0800, Darrick J. Wong wrote:
> > +			if (folio->index <
> > +			    DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> 
> I keep seeing this predicate, maybe it should go into fsverity.h as a
> helper function with the comment about mmap that I was muttering about
> in the previous patch?

Right now it is not generic.  Nothing in the generic fsverity code
known about the offset, ext4 and f2fs just happened to chose the
same constant (and the ext4 one leak to buffer.c), while btrfs stores
the verity hashed totally differently.  I hope the xfs works ends up
with a consolidated way of doing this, at which point such a helper
would be useful.

> Or maybe a "get verity info for given folio index" helper?

How would that make sense?

> /*
>  * Grab the fsverity context needed to verify the contents of the folio.
>  *
>  * <Big fat comment from before, about mmap and whatnot>
>  */
> static inline struct fsverity_info *vi
> fsverity_folio_info(const struct folio *folio)
> {
> 	struct inode *inode = folio->mapping->host;
> 
> 	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> 		return fsverity_get_info(inode);
> 	return NULL;
> }

Tthe offset right now is entirely file system specific,
so we can't do this.  Maybe that'll change with further consolidation.



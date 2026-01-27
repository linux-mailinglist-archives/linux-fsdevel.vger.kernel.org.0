Return-Path: <linux-fsdevel+bounces-75576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIBOJ5JYeGkNpgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:17:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F080D9055A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E63F530490C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA632AAD3;
	Tue, 27 Jan 2026 06:15:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F76299920;
	Tue, 27 Jan 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494558; cv=none; b=VEAssm2wvNgo7BLEQQ6NA0wFHMxWURmrbWunUURkrzBuHwV04I3g9QDqEpcdorS6SGe0GJPrBttkvxz0Xgsd+ZNGvJ2Ar2J1MVBO7wsKRB0/3TU2LeBRzS/aCJ8AfoKZ6t7PX5vcATUyoZNOY+vhH4BZQfW7NNOhfuN/hLZNIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494558; c=relaxed/simple;
	bh=A+Qvt7PJ1zzJc5nC8vIE7nhGKBhLxaI43psasrisBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doyJaGh2JS4S/O74cRQUPsnHjftvSEC95rhf5ABNnNXD6fvc4zgNlgSfMUGTrLQVsVC+VPvXpd68hBID5wAHvBamdgCjl7tE+gVFNdP/NbbM/dhXB+UoBFNYuI6cHwaPkVRg23oU/gF2wm+/3pAjGG3HcnG7Fv+7W3zg12CqmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F41D227AAE; Tue, 27 Jan 2026 07:15:52 +0100 (CET)
Date: Tue, 27 Jan 2026 07:15:51 +0100
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
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
Message-ID: <20260127061551.GA25522@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-17-hch@lst.de> <20260126204030.GC30838@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126204030.GC30838@quark>
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75576-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F080D9055A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:40:30PM -0800, Eric Biggers wrote:
> On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> > The file open path uses rhashtable_lookup_get_insert_fast,
> > which can either find an existing object for the hash key or insert a
> > new one in a single atomic operation, so that concurrent opens never
> > allocate duplicate fsverity_info structure.
> 
> They still do, though.  But that's unchanged from before.
> ensure_verity_info() frees the one it allocated if it finds that one got
> set concurrently.

You're right.  We allocate them, but never register them.  I'll fix
that up.

> 
> > Because insertion into the hash table now happens before S_VERITY is set,
> > fsverity just becomes a barrier and a flag check and doesn't have to look
> > up the fsverity_info at all, so there is only a single lookup per
> > ->read_folio or ->readahead invocation.  For btrfs there is an additional
> > one for each bio completion, while for ext4 and f2fs the fsverity_info
> > is stored in the per-I/O context and reused for the completion workqueue.
> 
> btrfs actually still looks up the verity info once per folio.  See:
> 
>     btrfs_readahead()
>         -> btrfs_do_readpage()
>             -> fsverity_get_info()

True.  I've fixed up btrfs to avoid extra lookups.


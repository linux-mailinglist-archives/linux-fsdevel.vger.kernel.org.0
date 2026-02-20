Return-Path: <linux-fsdevel+bounces-77797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QByjGU9+mGlMJQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:31:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC493168E79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F14D303FDE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301903126D6;
	Fri, 20 Feb 2026 15:31:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136729D29D;
	Fri, 20 Feb 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601478; cv=none; b=bz4H+uVIYG7wjPUFNBwdrLb9S6eRxzTBi7nwMjYdhtvMoT5nUlsgPAckcpSJX7ACHjzBKaGgLySn1zTUmGmm4VRFGVmJ41xI/wWEKW5bQk2cPe0tY244saXFD2zIxO5B7+0mTIlDelQhzP0J9MpzJ2ZC/fewaA3i8oot8vNjFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601478; c=relaxed/simple;
	bh=fUcOx96hUH2xxWt5q41bPTjE5PJ87yVEHYVDDLnSaIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuFpPI6xCluokuHP9Dji3xE5caklVVW3l/gS76TLLm1T688u1LRArMnH1otD+6c1f3ZqYLMy3x3qpSJUTl7RtptnZ/dUfjjoHByls8M8ONqlxw+S9s6JEa1nJntQ4GeHSN62BUlT4wslCbX8FCfqxBqCxp1CQdKqweui04Yk0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50A3A68B05; Fri, 20 Feb 2026 16:31:14 +0100 (CET)
Date: Fri, 20 Feb 2026 16:31:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <20260220153113.GA14359@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-12-aalbersh@kernel.org> <20260218063606.GD8600@lst.de> <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig> <20260219060420.GC3739@lst.de> <qheg77kxcl4ecqdrsnmz4acfvszjlamlb7ilgxxyf3pmt4r7ah@5fzzmcpurdfp> <20260219133829.GA11935@lst.de> <bltgc6uliclhzkuqd4la2tzp6x7vsww73nvjedxh7s624tby3k@jw4ij5irh6ni>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bltgc6uliclhzkuqd4la2tzp6x7vsww73nvjedxh7s624tby3k@jw4ij5irh6ni>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77797-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: BC493168E79
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 03:23:11PM +0100, Andrey Albershteyn wrote:
> On 2026-02-19 14:38:29, Christoph Hellwig wrote:
> > On Thu, Feb 19, 2026 at 12:11:18PM +0100, Andrey Albershteyn wrote:
> > > > > fsverity descriptor. This is basically the case as for EOF folio.
> > > > > Descriptor is the end of the fsverity metadata region. If we have 1k
> > > > > fs blocks (= merkle blocks) we can have [descriptor | hole ] folio.
> > > > > As we are not limited by i_size here, iomap_block_needs_zeroing()
> > > > > won't fire to zero this hole. So, this case is to mark this tail as
> > > > > uptodate.
> > > > 
> > > > How do we end up in that without ctx->vi set?
> > > 
> > > We're reading it
> > 
> > Did a part of that sentence get lost?
> 
> I mean that to have ctx->vi we need to read fsverity descriptor
> first. When iomap is reading fsverity descriptor inode won't have
> any fsverity_info yet.

So for ext4/f2fs the pattern is that it is set by:

	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
		vi = fsverity_get_info(inode);

i.e., only for reading the data.  OTOH, for iomap we do:

	if (fsverity_active(iter.inode)) {
		ctx->vi = fsverity_get_info(iter.inode);

which means it now is set for all I/O on fsverity files, which
is subtly different.

(You don't actually need the fsverity_active chck, fsverity_get_info
already does that, btw).

I'm still not sure what "When iomap is reading fsverity descriptor
inode" means.

> > Another overly long line here.  Also we should avoid the
> > fsverity_active check here, as it causes a rhashtable lookup.  F2fs
> > and ext4 just check ctx->vi, but based on the checks above, we seem
> > to set this also for (some) reads of the fsverity metadata.  But as
> > we exclude IOMAP_F_FSVERITY above, we might actually be fine with a
> > ctx->vi anyway.
> 
> Don't you confused this with fsverity_get_info()? I don't see how it
> could cause lookup.

Yeah.  Still, having ctx->vi implies fsverity_active, and follows
what we're doing elsewhere.

> 
> > 
> > Please document the rules for ctx->vi while were it.
> > 
> 
> Hmm, the vi is set in iomap_read_folio() [1] and then used down
> through I/O up to ioend completion. What info you would like to see
> there?

See above, unlike ext4/f2fs we set it for all I/O on fsverity inodes.
And afaik we don't actually need it, the only use in the fsverity
metadata path is the fill zeroes hash values check (which I'm still
totally confused about).



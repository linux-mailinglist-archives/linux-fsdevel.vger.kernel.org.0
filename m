Return-Path: <linux-fsdevel+bounces-76124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAIdG8SJgWnuGwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:38:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D44D4C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D82AC300B505
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AD366DB9;
	Tue,  3 Feb 2026 05:36:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EB271464;
	Tue,  3 Feb 2026 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096971; cv=none; b=m3hqk3eh/ZWYwjrIDIYgiNVdir7TpF4hjM+RrgRW5AHAi58ii/T43sQEkYX9nENSxvQbzWOr3IpdQIdBrgNAz1ET3Zil9OowAouJasRIRRyTZIYRxkd0ENCnPAVz6z+KdQ1yFSD3XTh1Xi6Pdwa4Kty3AiFCKbNSIgAnQ/9nVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096971; c=relaxed/simple;
	bh=cC/qk4dm1B5K6YpfaVGKmBECm1eO3/9Kot5iyWUeUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL70yqCP0tQFdib4rl8vG9EZNAcKyvMjW/WUuakCOxXL1fKcL+xN1EIgwM11gS0M1ZXrCaVxHPA9WlYNrxgbvEfXATmx31fOvWeU8P42S3s+efgpx6cQ5dkZERFjvcJ0aHi+3IJDdq0SV6qtk8p+q3DnhXosRvX3yIrm6d6TX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E866E68AFE; Tue,  3 Feb 2026 06:36:04 +0100 (CET)
Date: Tue, 3 Feb 2026 06:36:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: fsverity speedup and memory usage optimization v5
Message-ID: <20260203053604.GC15956@lst.de>
References: <20260202060754.270269-1-hch@lst.de> <20260202211423.GB4838@quark> <20260202223404.GA173552@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202223404.GA173552@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76124-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 02D44D4C4F
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:34:04PM -0800, Eric Biggers wrote:
> On Mon, Feb 02, 2026 at 01:14:23PM -0800, Eric Biggers wrote:
> > On Mon, Feb 02, 2026 at 07:06:29AM +0100, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series has a hodge podge of fsverity enhances that I looked into as
> > > part of the review of the xfs fsverity support series.
> > > 
> > > The first part optimizes the fsverity read path by kicking off readahead
> > > for the fsverity hashes from the data read submission context, which in my
> > > simply testing showed huge benefits for sequential reads using dd.
> > > I haven't been able to get fio to run on a preallocated fio file, but
> > > I expect random read benefits would be significantly better than that
> > > still.
> > > 
> > > The second part avoids the need for a pointer in every inode for fsverity
> > > and instead uses a rhashtable lookup, which is done once per read_folio
> > > or ->readahead invocation plus for btrfs only for each bio completion.
> > > Right now this does not increse the number of inodes in
> > > each slab, but for ext4 we are getting very close to that (within
> > > 16 bytes by my count).
> > > 
> > > Changes since v5:
> > >  - drop already merged patches
> > >  - fix a bisection hazard for non-ENOENT error returns from
> > >    generic_read_merkle_tree_page
> > >  - don't recurse on invalidate_lock
> > >  - refactor page_cache_ra_unbounded locking to support the above
> > >  - refactor ext4 and f2fs fsverity readahead to remove the need for the
> > >    first_folio branch in the main readpages loop
> > 
> > Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
> > 
> > (Though it's getting late for v6.20 / v7.0.  So if there are any
> > additional issues reported, I may have to drop it.)
> 
> Unfortunately this silently conflicts with changes in the f2fs tree.
> Resolution doesn't look too bad, but we'll need to handle this.
> Christoph, Jaegeuk, and Chao, let me know if this looks okay:

I ended up with the same merge, and it looks good to me.



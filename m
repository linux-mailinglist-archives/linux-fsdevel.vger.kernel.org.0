Return-Path: <linux-fsdevel+bounces-75202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEY9JtADc2n5rgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:14:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC570632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3402300C00F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A7396D30;
	Fri, 23 Jan 2026 05:14:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E27392C5B;
	Fri, 23 Jan 2026 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769145281; cv=none; b=nLHVow8fTPE1LOnwPlmq8Ymu+D1+eVGtmyy/kRK3NP4yLrazlB+pzOBQFN6u4Jw4dcWMZI+fNdQnS8Bq7Mc6Cy/AYRQNKxaU9/ex/qKBK31AhQRS44GbmX9Or6hGBEr44HM+Go4v8tzwmUEqyZ7Q9VKTDaNUH3CtlWV72Nxjfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769145281; c=relaxed/simple;
	bh=S2k3klXik6+I/jlQdoWxLlXNPXFYXFCH58KKTyU8OfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHeQBa1iQSkzXLnTOZGbCU4WeMa3eMgpbn10MNOr8diKm+nxD+Qd8ryAGO/Em3zQ/rpOmBtPaoqeHXM2klBCfE87pBSZVHxp/spnlAOKmp9CqGgzL3Qzl0MOIFLOHgYA10xEijuDFu3kIF8qQ6BYrHlHtjWvb+Er9eln1M2CdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3175E227AAE; Fri, 23 Jan 2026 06:14:30 +0100 (CET)
Date: Fri, 23 Jan 2026 06:14:29 +0100
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
Subject: Re: [PATCH 05/11] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260123051429.GB24123@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-6-hch@lst.de> <20260122214227.GE5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122214227.GE5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75202-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 02CC570632
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 01:42:27PM -0800, Darrick J. Wong wrote:
> > +		if (first_folio) {
> > +			if (ext4_need_verity(inode, folio->index))
> > +				fsverity_readahead(folio, nr_pages);
> 
> Ok, so here ext4 is trying to read a data page into memory, so we
> initiate readahead on the merkle tree block(s) for that data page.

Yes.

> > +	__fsverity_readahead(inode, vi, offset, last_index - index + 1);
> 
> I went "Huh??" here until I realized that this is the function that
> reads merkle tree content on behalf of some ioctl, so this is merely
> starting readahead for that.  Not sure anyone cares about throughput of
> FS_VERITY_METADATA_TYPE_MERKLE_TREE but sure why not. 

It is trivial to provide and will make the ioctl read much faster.

> > +	const struct merkle_tree_params *params = &vi->tree_params;
> > +	u64 start_hidx = data_start_pos >> params->log_blocksize;
> > +	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
> > +			params->log_blocksize;
> 
> I really wish these unit conversions had proper types and helpers
> instead of this multiline to read shifting stuff.  Oh well, you didn't
> write it this way, you're just slicing and dicing.

Agreed.  Just not feeling like turning everything totally upside down
right now :)

> So if I read this correctly, we're initiating readahead of merkle tree
> (leaf) data for the file data range starting at data_start_pos and
> running for (nr_pages<<SHIFT) bytes?  Then going another level up in the
> merkle tree and initiating readahead for the corresponding interior
> nodes until we get to the root?

Yes.  That's a difference to the old code that just did readahead
for the leaf nodes.



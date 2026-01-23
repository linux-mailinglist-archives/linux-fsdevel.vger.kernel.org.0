Return-Path: <linux-fsdevel+bounces-75228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LtkFLYhc2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:22:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED471A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 262A8301A7D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5753563F6;
	Fri, 23 Jan 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag+3xAAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC7337692;
	Fri, 23 Jan 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152938; cv=none; b=gNXKd11IE9q2opPo96Xy8uYVHMsyMEtBOvRnEEAfHQPKqXrw3EOQqDpuwyOmYab7H2c9SHCPfG9sE975m7YEFBziPF5oQDOdR5wvMJWxMQNBCsWfpwd6dgayI4JyM7H7bfsCvvstUpBTV2CxUXNFM6xyIMwv95dWKx6FkJGvP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152938; c=relaxed/simple;
	bh=xv7Ciia1o4TzkfhiJeMNZ7afzQQkd0wZmCmSkOnW3D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW8cC6drsScc+pcBCCyOFiw84IAafpJX5dUVsM+25E/JIEz4SWP9M2haMsI3KHD0+DcPxjpf0hFqVnkpbXo+wb19diDwuAoaxdUclSeaP3UK1/XTImywcuTH71fHk7dHySloi1Ezn9myw1Ehi50p5maJzJ5zHgkQ8DC460lxFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag+3xAAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631EBC4CEF1;
	Fri, 23 Jan 2026 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769152938;
	bh=xv7Ciia1o4TzkfhiJeMNZ7afzQQkd0wZmCmSkOnW3D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ag+3xAAMAiEobo8tr0xQ+pzcrO/vVQSUK1Ag76ICSV8GT7q49niWT+pofKmzKsG8d
	 Jw39Di1WR6hLI1vHcojDjdN67CQ0NZ4hT6qBh6VKNpuT+NwwIGeFCoVzI/Cw7PFD8H
	 iDuF0Gf2+DPUBr/9WjkqNurr6hBOvGEbVBDUSzw/q/xGgutFraBC7WtwpfTz4uSSV3
	 05dE5Th7Oj5wPPLqdrF+TxQtBTjE8Jpq8Hgi5LkNg9Eac+189i5VZfNF/Sxr89VkxQ
	 HkR9HEZf+DjnbaULQQHgzisWBIN1hfRryZZ7oPJMvM5Tg+TZjXUU7ROBmPVPkNk1aQ
	 DE5y1rbi3NWNg==
Date: Thu, 22 Jan 2026 23:22:17 -0800
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
Subject: Re: [PATCH 05/11] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260123072217.GK5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-6-hch@lst.de>
 <20260122214227.GE5910@frogsfrogsfrogs>
 <20260123051429.GB24123@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123051429.GB24123@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75228-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDED471A4A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 06:14:29AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 01:42:27PM -0800, Darrick J. Wong wrote:
> > > +		if (first_folio) {
> > > +			if (ext4_need_verity(inode, folio->index))
> > > +				fsverity_readahead(folio, nr_pages);
> > 
> > Ok, so here ext4 is trying to read a data page into memory, so we
> > initiate readahead on the merkle tree block(s) for that data page.
> 
> Yes.
> 
> > > +	__fsverity_readahead(inode, vi, offset, last_index - index + 1);
> > 
> > I went "Huh??" here until I realized that this is the function that
> > reads merkle tree content on behalf of some ioctl, so this is merely
> > starting readahead for that.  Not sure anyone cares about throughput of
> > FS_VERITY_METADATA_TYPE_MERKLE_TREE but sure why not. 
> 
> It is trivial to provide and will make the ioctl read much faster.
> 
> > > +	const struct merkle_tree_params *params = &vi->tree_params;
> > > +	u64 start_hidx = data_start_pos >> params->log_blocksize;
> > > +	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
> > > +			params->log_blocksize;
> > 
> > I really wish these unit conversions had proper types and helpers
> > instead of this multiline to read shifting stuff.  Oh well, you didn't
> > write it this way, you're just slicing and dicing.
> 
> Agreed.  Just not feeling like turning everything totally upside down
> right now :)
> 
> > So if I read this correctly, we're initiating readahead of merkle tree
> > (leaf) data for the file data range starting at data_start_pos and
> > running for (nr_pages<<SHIFT) bytes?  Then going another level up in the
> > merkle tree and initiating readahead for the corresponding interior
> > nodes until we get to the root?
> 
> Yes.  That's a difference to the old code that just did readahead
> for the leaf nodes.

Cool!  In that case I think I understand what's going on here well
enough to say:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D



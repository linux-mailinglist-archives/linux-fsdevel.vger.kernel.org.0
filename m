Return-Path: <linux-fsdevel+bounces-75531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BZuCozQd2mxlQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:37:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CC8D214
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F6D301B929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C2C2D73A0;
	Mon, 26 Jan 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg5YvHs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDC2BEFEE;
	Mon, 26 Jan 2026 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459836; cv=none; b=ivTWJF2rNDOPUnUg9iC9MpmCEv7ZjrUYjlQQTxhGLC9HQpYSg9Oob4yiU53a1VtlhiZgu91OTPMM3pY61E62EyQR4rXoPYl3x9FzJbzY5y3D/M0K4CXLZp9FOaBBkWKm4gNXFX71jIPuIQoXE1BF8w4zS6Zq8bmHnIp8mXT6B88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459836; c=relaxed/simple;
	bh=Vi4Xz7fQzexF/Gc4dDWOqmZz3iRT/ILc3hdzXJ0Me+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN242SgVgbcMCf810ODZHWkU9wVsDj9u219Xx8tsK0/Ie6xVvnW/mRDL4YHbVjN9Ibuk4T8knXxyfuwn48Yupkt3YNMKsID8DbQcSQFq73jNZU0iwsM2CIsHbNXAdmBaOfmzWj9jza29nvPPlGvKcY12KUPYGquF+/OSdi5r/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg5YvHs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D79C116C6;
	Mon, 26 Jan 2026 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459835;
	bh=Vi4Xz7fQzexF/Gc4dDWOqmZz3iRT/ILc3hdzXJ0Me+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eg5YvHs3EZveAc2fR+o4fsx/gIND0/Kb1Wtc2K2cc5EclCuFQJ8P8+TUfhzZH7LXf
	 q92uZ6rWr4uJfFmo7UiTiUaJkM4Y+GFzxHaGXdodeWQfsJk2hKmZ5DqAghx8iY1YvB
	 DSAz/N8Z6fHx6akeFxkfWFCXRGPzfTFgmhhyZKCt/2/wuSJ1tnulAGPbaF2mSOQw2k
	 gGuPRbRWfQci+bRobOMZR3wgwwBnVGsBLanijKuaI5N2Y4X36PbTq+odJEddmFGVzh
	 LDOISU3iveR0gaiZJOzpIHn8o0z9w0X+V21EHIboDC1xcCGP3Rwa/59fS3UUKAeO81
	 TneEpalt0ph2Q==
Date: Mon, 26 Jan 2026 12:37:12 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/16] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260126203712.GB30838@quark>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-9-hch@lst.de>
 <20260126192655.GS5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126192655.GS5910@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-75531-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B53CC8D214
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:26:55AM -0800, Darrick J. Wong wrote:
> > +/**
> > + * generic_readahead_merkle_tree() - generic ->readahead_merkle_tree helper
> > + * @inode:	inode containing the Merkle tree
> > + * @index:	0-based index of the first page to read ahead in the inode
> > + * @nr_pages:	number of data pages to read ahead
> 
> On second examination: *data* pages?  I thought @index/@index are the
> range of merkle tree pages to read into the pagecache?
> 
> I'd have thought the kerneldoc would read "number of merkle tree pages
> to read ahead".

Agreed, please make it clear that this function is working on Merkle
tree pages.

> > +	for (level = 0; level < params->num_levels; level++) {
> > +		unsigned long level_start = params->level_start[level];
> > +		unsigned long next_start_hidx = start_hidx >> params->log_arity;
> > +		unsigned long next_end_hidx = end_hidx >> params->log_arity;
> > +		pgoff_t long start_idx = (level_start + next_start_hidx) >>
> > +				params->log_blocks_per_page;
> > +		pgoff_t end_idx = (level_start + next_end_hidx) >>
> > +				params->log_blocks_per_page;
> 
> The pgoff_t usage here makes the unit analysis a bit easier, thanks.

"pgoff_t long" should be just "pgoff_t".

(It compiles anyway because it expands to "unsigned long long"...)

- Eric


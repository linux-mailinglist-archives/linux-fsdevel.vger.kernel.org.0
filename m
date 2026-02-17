Return-Path: <linux-fsdevel+bounces-77336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ExEKRoBlGnH+QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 06:48:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F9148DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 06:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FCC3302689E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9202BEFF5;
	Tue, 17 Feb 2026 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHO2hvNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB829E10B;
	Tue, 17 Feb 2026 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307267; cv=none; b=F5UXiq1JZGzRoOBfJdZCHlU086iP8U+HRBf3belykBpZyz+dHlPFu4MRs/BSHqXcaOKzQ/xYD25/RrP+kmELt0ct8toTn5RemLWYFEFHTydsfKA9ogTDOHmV91ITfIjQQkJt27coMCzMjbhyy1rsu5LOYiKi+TslDJmixozrD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307267; c=relaxed/simple;
	bh=g/f4NezhcDQw8e6C5JeZ5QoxbIl7mTa1sZGndcU+W8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq3pcOkx2f6HGsofwl8N62Ni66oJN7Q+6MTbdfkrM3dX8/rbb1vBIjKckChB01lBcHGfaxMVqpE6izG6EMrQkd/P6BNMjm4IB/fkIV0sSFOoasMStiCLuE7PcQ8Wcqv34lkqeoNDAAULlWtlXd//l73V+wrZ7Ik0v2U7VCo0vzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DHO2hvNT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YzNOZthFSOONuB5w2UVLPMtPkSnlHbO7epniVUgOA5Y=; b=DHO2hvNTnE2ocZ2PNMqbq1t2Sg
	vz3IOvG6BLb5oWxbWhAtRGgMqkoh5SsdHbFcFytPgZ/w68v6vzDaMVsMFhoZ+KeVfhxeJtvTnBvwV
	XgWTZby99GA9YbShZUmkQ73QlfoFCWNdoPHh5Y7AUcoTG8hDBN0UdqvpoEYFzW/GyTqKw2tHtGwrr
	6VvEYhW24+So2ZGVJDqk61LC0FVPHZH/FGMl3NMi37x7F+Aut0UV2S6/WVFw+Q6FffvftcQyMocCw
	T/UMPFmMFrrGlBjS/bBv9kXdzZ7kHTrhsKEm0A/AMFto3M2gGG1Qxy6ZVnXnrDobyFeElFwWKzJyd
	ZoAqJD9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsDw1-00000007f3x-18j5;
	Tue, 17 Feb 2026 05:47:45 +0000
Date: Mon, 16 Feb 2026 21:47:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <dgc@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <aZQBAYCc5ouSoVXe@infradead.org>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
 <aY-n4leNi4NCzri1@dread>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY-n4leNi4NCzri1@dread>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77336-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 5D8F9148DE2
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 09:38:26AM +1100, Dave Chinner wrote:
> Yeah, that seems like a bug that needs fixing in the
> ioend_writeback_end_bio() function - if there's an IO error, it
> needs to punt the processing of the ioend to a workqueue...

The iomap code doesn't have a workqueue currently.  The way we split
the code, we left the workqueue handling in XFS, because it is anchored
in the inode.  I've been wanting to have it generic, as it would help
with various other things, though.

For XFS we might be able to just always hook into our I/O completion
handler and shortcut the workqueue for pure overwrites without errors,
but that won't help other users like the block device code, zonefs and
gfs2.  Maybe we'll need an opt-in for the fserror reporting now to
exclude them?

On something related, if we require a user context for fserror_report
anyway, there is no need for the workqueue bouncing in it.



Return-Path: <linux-fsdevel+bounces-79271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGmFO2MTp2mfdQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:59:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CE1F43CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886683124CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A4E49218E;
	Tue,  3 Mar 2026 16:55:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571B3ACA5D;
	Tue,  3 Mar 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556954; cv=none; b=NBIIWZpt1diixhsyUoQEgP8ghhJXg2EBSCRlaLUuTdaQpkerBOUxK97CiHuzSVY51JoV3uWbBOtkJSlV3W54Dap1COjobVX2Vy3o5wN0BmaqaqbZwMF2TJzNYZkPIGhqDJ3rTirebQzy8wTXE/iXoVsugmVLVe5PiOyyC1bUSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556954; c=relaxed/simple;
	bh=79X5NrHvvHxgfkw5HXWmqlDll4X75GNj1FkPLgg6Ehg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alRS2rD0X+Nbl39PmsAQOppCyrL3/a/rrIE11GV6e0U8KP2uA+czIGtSf0XirJyQPySjiRlS53m7/0RiNqOCpAVCKuEn5sl2/OWN8k0FTg1My13icU2Hm8z0Fgx6jn0dnl9qhcyY9sbAvta3ofuiFAu5C4gEHavLhpel6Bib/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7B6F68BEB; Tue,  3 Mar 2026 17:55:47 +0100 (CET)
Date: Tue, 3 Mar 2026 17:55:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: dropping the non-inline mode for fscrypt?
Message-ID: <20260303165546.GA10279@lst.de>
References: <20260302142718.GA25174@lst.de> <20260302212236.GA2143@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302212236.GA2143@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: 9B6CE1F43CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79271-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:22:36PM -0800, Eric Biggers wrote:
> On Mon, Mar 02, 2026 at 03:27:18PM +0100, Christoph Hellwig wrote:
> > After just having run into another issue with missing testing for one of
> > the path, I'd like to ask if we should look into dropping the non-inline
> > mode for block based fscrypt?
> 
> Yes, I think that's the way to go now.
> 
> I do think the default should continue to be to use the well-tested
> CPU-based encryption code (just accessed via blk-crypto-fallback
> instead).  Inline encryption hardware should continue to be opt-in via
> the inlinecrypt mount option, rather than used unconditionally.  To
> allow this, we'll need to add a field 'allow_hardware' or similar to
> struct bio_crypt_ctx.  Should be fairly straightforward though.

Sounds fine.  Given that you're more familiar with this can I sign
up you to do it?  Otherwise I can add it to my todo list, but chances
are that I'll get some of the subtle interactions wrong.

> I think it would be pretty safe to drop support for IV_INO_LBLK_32 with
> blocksize != PAGE_SIZE entirely, given that that case already doesn't
> work with inlinecrypt.  The whole point of IV_INO_LBLK_32 is to be able
> to use eMMC inline encryption hardware that support only 32-bit IVs.

That sounds even better.



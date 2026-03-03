Return-Path: <linux-fsdevel+bounces-79278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPxdGuU3p2lwfwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 20:35:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F801F6169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 20:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A39306511E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5C38422F;
	Tue,  3 Mar 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKwV9a/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC93976BA;
	Tue,  3 Mar 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566349; cv=none; b=YPO5Y7MJkX6pBYmuI2ZYGeS60HbKi6BffCsAoK/rhCGGxINFC4jrPEXCq1EBau5Dlggn+cmFhY4K9C22JMp3kOcL388OM0nBxGSckRnHrm9KtmLg0cJtO5fCB9/bUpytnAeXnxrN+2Q+sFtHJlu3Fp1/iJrB6VeXBgoubD+K4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566349; c=relaxed/simple;
	bh=Qvm9osd3NbM07fGmYu29877ROhWfzaUOKV3/F60cpSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN2/2UsxOLli53h55FgkolsaCE/remnvD55kNv/yMIvFYesKyyn2OHCNpDYqOwVcEkkvDgEf96kMjBuKN95KnIxZrCDe3elSeIgJHdiLWKX2eWtACaveVRdofmoMW0qJcqGUMwRJ+Q8Vf63UORJjlqKmcbLlyyrXjrZtGIs2FAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKwV9a/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D36C19425;
	Tue,  3 Mar 2026 19:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772566349;
	bh=Qvm9osd3NbM07fGmYu29877ROhWfzaUOKV3/F60cpSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKwV9a/d/CJfcDyWK37t/bnHWgL25knCd9uHssJ0Ji65kngzXcqLgaloo+3kB4I8j
	 i8FISrqjgtBKQ69fQ4BCHwlWio1ftxdCN4deWjlefRbuZE8GEMLeS/iPbEMuVUb8Rj
	 czIkSF6HnJh9hMqMbzQ9LGtYk40h6u8GxJT/7Q6F7DAiE675Fx56PT3ovZUV5qNigw
	 TyzpQUog05Lhe/SLl9YAAMsoov238FJJTi9kPuRfcR2TctnQZVenT+V11sfkrEXVyn
	 K1v1zn4U0Ng2s6k/vOTzmlG+k4wMFkaAz77dIN6w+7TqLrpdxrq++3c9Qyd5Ndd6Id
	 RemVNWcGWNO9Q==
Date: Tue, 3 Mar 2026 11:31:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: dropping the non-inline mode for fscrypt?
Message-ID: <20260303193133.GB2846@sol>
References: <20260302142718.GA25174@lst.de>
 <20260302212236.GA2143@quark>
 <20260303165546.GA10279@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303165546.GA10279@lst.de>
X-Rspamd-Queue-Id: 48F801F6169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79278-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:55:46PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 01:22:36PM -0800, Eric Biggers wrote:
> > On Mon, Mar 02, 2026 at 03:27:18PM +0100, Christoph Hellwig wrote:
> > > After just having run into another issue with missing testing for one of
> > > the path, I'd like to ask if we should look into dropping the non-inline
> > > mode for block based fscrypt?
> > 
> > Yes, I think that's the way to go now.
> > 
> > I do think the default should continue to be to use the well-tested
> > CPU-based encryption code (just accessed via blk-crypto-fallback
> > instead).  Inline encryption hardware should continue to be opt-in via
> > the inlinecrypt mount option, rather than used unconditionally.  To
> > allow this, we'll need to add a field 'allow_hardware' or similar to
> > struct bio_crypt_ctx.  Should be fairly straightforward though.
> 
> Sounds fine.  Given that you're more familiar with this can I sign
> up you to do it?  Otherwise I can add it to my todo list, but chances
> are that I'll get some of the subtle interactions wrong.

Yes, I'll try to find time for this.

- Eric


Return-Path: <linux-fsdevel+bounces-79267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKsTF+8Pp2k0cwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:44:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC71F406B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF28300F95A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2E370D42;
	Tue,  3 Mar 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHmMXCv1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D5370D4A;
	Tue,  3 Mar 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555909; cv=none; b=EixPcUouPsYJG0eUO/gWgkAjdEBSo0pwD4C4B10gPy6XZcvTtktgzFCfHnvxdQp35uqfJQS6hHaMS6oi96N08gUBW75RX7raRVv9Ksx2u9i/S3gbOCnq/YyL3ErWiwoYzoHfHKP4qJcY49nGfvsClZ+LuSm+BLPxbngelTYSiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555909; c=relaxed/simple;
	bh=td5tzea6Xp4RN2nFykvpRDtfXDPa6TnzFtAZISE44Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/T+dHZem1O1m0bEQtGUTEb2wNOvvFXO+nRixpVLjnOCi5oRwORAbsxSyp7x64DoRJ/ifJ/0EwFFr2tfa34KACy2tNCjlEe1gZWFLcTjYT54qp7pEMZcPiTyBn4lXhekmc/SMJkkq6nliYO3QAdZg40706vV3IK6TdB+c8U9xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHmMXCv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB212C116C6;
	Tue,  3 Mar 2026 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555908;
	bh=td5tzea6Xp4RN2nFykvpRDtfXDPa6TnzFtAZISE44Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHmMXCv1wGeCzc7f0UchMuQlBuLKqZxerFjlAu96qaEThJ+o569CKTpuSMSvPfX33
	 6lGCYD/vOCUBoEUwcR3toUAPaj9qIkeJlBimDS7fwhqDb1MN7fXT0q6bttmoRxSjJJ
	 y29uJ2syrFNP+iu7TvHxAlh/PBr2hi5L9LOgO1UGEGrOJIH8rW4J3hNaiSm6XzWCHh
	 FApRSjH8POSE951IbtSPT55pk5Kj28ZLfzGe2Y2SfxupjJM+JD521NnnMyuYhSBYkc
	 6B7f0QN9hu9BPOURnF2DD5onpj4lAAW3WNT7ODUl74hLMq/o2Q7dR6GhOUL2lTIcWs
	 5iEdK2Ik1vkgQ==
Date: Tue, 3 Mar 2026 08:38:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, amir73il@gmail.com,
	jack@suse.cz, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <20260303163828.GI57948@frogsfrogsfrogs>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <aab2JbAZI8RFq_XE@infradead.org>
 <87ldg83nj7.fsf@mailhost.krisman.be>
 <aacIh7YJps8rp7gi@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacIh7YJps8rp7gi@infradead.org>
X-Rspamd-Queue-Id: 0BAC71F406B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[krisman.be,redhat.com,vger.kernel.org,lst.de,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79267-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:12:55AM -0800, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 11:06:52AM -0500, Gabriel Krisman Bertazi wrote:
> > Christoph Hellwig <hch@infradead.org> writes:
> > 
> > >> +// SPDX-License-Identifier: GPL-2.0
> > >> +/*
> > >> + * Copyright 2021, Collabora Ltd.
> > >> + */
> > >
> > > Where is this coming from?
> > 
> > This code is heavily based, if not the same, to what I originally wrote
> > as a kernel tree "samples/fs-monitor.c" when I was employed by
> > Collabora.  I appreciate Darrick keeping the note actually.
> 
> The note is good.  But if we import code from somewhere, we should
> document where it is coming from, both for attribution and to ease
> any future resyncs if needed.

Yeah, I copied this straight from the kernel tree, which is why it
contains this wart:

> > >> +#ifndef __GLIBC__
> > >> +#include <asm-generic/int-ll64.h>
> > >> +#endif
> > >
> > > And what is this for?  Looks pretty whacky.
> > 
> > Comes from kernel commit 3193e8942fc7 ("samples: fix building fs-monitor
> > on musl systems") to fix building with musl.  We don't need it here.
> 
> In the place that needs it it really should have a comment explainig
> the logic behind it.

I don't know that people *don't* try to run fstests with musl.  But as
they seem surprisingly patient with continuously fixing up xfsprogs,
perhaps it's ok to clean this up on the way into fstests.

I'll add more attribution for the c file pointing back to where it came
from.

--D


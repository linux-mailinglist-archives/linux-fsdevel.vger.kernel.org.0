Return-Path: <linux-fsdevel+bounces-79263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB57Jq8Ip2k7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:13:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C951F36BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11238303D6B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A64A3403;
	Tue,  3 Mar 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RY1qS2zt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84763B5840;
	Tue,  3 Mar 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554378; cv=none; b=RnuzvSP7sAKDyBuHQGq9lklLwbv98CApg5XofgGv4Foasm71Ttsg4TCphQOO0+N21UFh/BtP2Jeuoq0psFMKn6gMBCHXTLJTZwDEHAicI/FhcU6VWbXX3q3P0fNOZL2DOGT+/BwYn0I5zMyKWtTXSPwrEGvA1MDekgk5yhMjdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554378; c=relaxed/simple;
	bh=KhB9ELTOeynhh//iB0PKyH93KHWnqbQMCKrNAaPcFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/xDev0YGMN7ROMkCjrc8wnNCRIXH8feplmrSGWE8dCfoKf0MCfVwaEeYYuChPvphhdVefixZ9NhPPYtjx49TxwlbHiedbEYVCoWKwunEpwmooclkMFeBwtFwLm3+ruByJdNmDy3nB1dVmo2tgyJEnlUzoTqhz49UGAQ0YboKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RY1qS2zt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xH67VzYcBp5utoAGI6Gx1l1REfSpyFZcE6w/U37h8TA=; b=RY1qS2zttGZw+//8ov57EuqF+F
	/ZR3FeT9mJXVgtDLYqjCk006VEqjFDp6RBH0EEz5nlcHeaGNiW3gB24wYByij/kXmSaFDD2mPcuYU
	OsJAH70WxlGSqxNc3tzNHv//4MoaVEQj3Ej4auWz3CK1LvDGoXdueNLbmBs7GdR4kzpwVkWS5GQbs
	mRPuQU5MDJhp9bCPzFfCd8LVNm7HkwOKaxnyqLqT1yP/W4LpBm0n2RRwHwGKq9i6Prqd+F0+AFstu
	k5tDoKTt9+0v38BDRjutOxAHEZ5LKgPJdVjOtY89iggdr70YN5zWs23/+7KWs9HLlY5jRnIoen20k
	rutwgRuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSMh-0000000FXQG-3yLK;
	Tue, 03 Mar 2026 16:12:55 +0000
Date: Tue, 3 Mar 2026 08:12:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, amir73il@gmail.com,
	jack@suse.cz, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <aacIh7YJps8rp7gi@infradead.org>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <aab2JbAZI8RFq_XE@infradead.org>
 <87ldg83nj7.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldg83nj7.fsf@mailhost.krisman.be>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 33C951F36BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,redhat.com,vger.kernel.org,lst.de,gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-79263-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:06:52AM -0500, Gabriel Krisman Bertazi wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright 2021, Collabora Ltd.
> >> + */
> >
> > Where is this coming from?
> 
> This code is heavily based, if not the same, to what I originally wrote
> as a kernel tree "samples/fs-monitor.c" when I was employed by
> Collabora.  I appreciate Darrick keeping the note actually.

The note is good.  But if we import code from somewhere, we should
document where it is coming from, both for attribution and to ease
any future resyncs if needed.

> >> +#ifndef __GLIBC__
> >> +#include <asm-generic/int-ll64.h>
> >> +#endif
> >
> > And what is this for?  Looks pretty whacky.
> 
> Comes from kernel commit 3193e8942fc7 ("samples: fix building fs-monitor
> on musl systems") to fix building with musl.  We don't need it here.

In the place that needs it it really should have a comment explainig
the logic behind it.



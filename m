Return-Path: <linux-fsdevel+bounces-74815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KDQIvuEcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:49:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637753074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66BBA4EB71A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57600304BDC;
	Wed, 21 Jan 2026 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3PgJEqLa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430373BF307
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981746; cv=none; b=nyzao+Lvdtv1lHJwFcVdyVH4+EKynbYKobJDhZxwH3poNth2Obt8Dnff6kAsnYJWwF/SbdeFnTkcxm+LPLEKzRsiSxJJpiAftmk1C7u7HTxrTR+RYoGrVViq9oAIsWMIOvkfuEh1vxBkhKBNNfzIamLFqCI3eatE7IbyFMgjfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981746; c=relaxed/simple;
	bh=uEV3nffG8vN4HfZsmaWu+WmBMmCaSv2drdcBL+6Xics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahIK1Xlqa+aV4Zf3FnCX47RhoBULZ59z2L+ooVeg2p/T5ICSZKioZyWudkBl1ToUDpAdnIVO5Kzf1RR5QpHK2Tf4Rh8K5umqjpOQC9+WI3yS7oId4R61S1/to9rdDqzV1FOhOTBVo+zRNkX1nf3MOXuix4+Bqjr1OaS5QUGZaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3PgJEqLa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EquTN4VmIO/MzkXq9Nr8w/etR/m8vWaMQEG3HhOupsk=; b=3PgJEqLaNYEXRh8sV6ETgpwean
	xgaJTAOQc71aSXzje1M6bjKaPDzM8oyd/J/dSgkCpefj+bCJ59zCMrdaE2wFNZFNzqoZskaxpjhYL
	g8hLLsAY4VPKSdSUbXiNf3q68yZHMq+lmVRtYewwynFgNJd0d7uuXD3q5wL6dexxoloxJM/0Uhb/o
	oClNyL4I4kCaykTqlev1Sf97OqS1/wt4moykSVnVFlolDWcnm7Y90IjNQuqTAiMLuDGzP/6FzqMSW
	g+XbTvszVSR5/mImy72DEHHERw8XUy5PtgQIgS7a2J8R5a4NL5dS+PGvJbr9090t4JlFh6PndhHC1
	UHZDDcIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viSxa-000000052PA-0pEV;
	Wed, 21 Jan 2026 07:49:02 +0000
Date: Tue, 20 Jan 2026 23:49:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, djwong@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after
 folio_end_read()
Message-ID: <aXCE7jZ5HdhOktEs@infradead.org>
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116200427.1016177-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	TAGGED_FROM(0.00)[bounces-74815-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 0637753074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 12:04:27PM -0800, Joanne Koong wrote:
> If the folio does not have an iomap_folio_state struct attached to it
> and the folio gets read in by the filesystem's IO helper,
> folio_end_read() may have already been called on the folio.

Not just can, but it has to, as there is no other way to track when
folio_end_read would need to be called.

> Fix this by invalidating ctx->cur_folio when a folio without
> iomap_folio_state metadata attached to it has been handed to the
> filesystem's IO helper.

Fix what?

for read_folio nothing ever looks at cur_folio, so I guess that is not
what is being fixed, and it's readahead in some form.  Can you explain
what went wrong and how it is being fixed here a bit better?

>  			*bytes_submitted += plen;
> +			/*
> +			 * If the folio does not have ifs metadata attached,
> +			 * then after ->read_folio_range(), the folio might have
> +			 * gotten freed (eg iomap_finish_folio_read() ->
> +			 * folio_end_read() followed by page cache eviction,
> +			 * which for readahead folios drops the last refcount).
> +			 * Invalidate ctx->cur_folio here.
> +			 *
> +			 * For folios without ifs metadata attached, the read
> +			 * should be on the entire folio.
> +			 */
> +			if (!ifs) {
> +				ctx->cur_folio = NULL;
> +				if (unlikely(plen != folio_len))
> +					return -EIO;
> +			}

I think the sanity check here is an impossible to hit condition and
should probably be a WARN_ON_ONCE?

So to answer the above, I guess the issue that for readahead, the

	if (ctx->cur_folio &&
	    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {

in iomap_readahead_iter does a double completion?

I don't really love how this spreads the cur_folio setup logic from
iomap_readahead_iter to here, but the other options I can think off to
pass that logic to iomap_readahead_iter (overload return value with a
positive return, extra output argument) don't feel all that enticing
either because they'd now have to spread the ifs logic into
iomap_readahead_iter.  So I guess this version it is for now.

Maybe in the future I'll look into moving all the cur_folio logic
from iomap_readahead_iter into iomap_read_folio_iter and see if
that improves things, but that should not get into the way of the
bug fix.



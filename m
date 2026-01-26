Return-Path: <linux-fsdevel+bounces-75553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E92BuH+d2lqnAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A008E591
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73D45300723D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC7310771;
	Mon, 26 Jan 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkNtVSl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E462BEFF8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471705; cv=none; b=pBkRVJVKAp0pWIljzPAvs6QNTGvT7dFCRR5UZJ0T4I2PvA1JJS3lRkEferQ/eIjNkRIDdNVLP3hhEjjSOxFHBED99GKhBDeWXW1BYu3CpAaezglMYmU4KjLCwzhXw2ie7nlxIKAhQwV9CDzDuGsoXAFyUi/Za89pRydkXUWHdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471705; c=relaxed/simple;
	bh=rKRk4wsqBH0Gv2F7TieNj9wY69VomdSGd/Cl2snhNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dalmTiT/amHZvNSFgTqezpfHIMFiaSvfjorlTY15PBlIqGcdEey1hKCInobi/MCAemRkFn0EQ5HjMMwHGUrCzZAsATBecPaU0V8xy2A+0woLcBDtOckfx+2zSvT0Yq3yUQOk8F5WCmPbE4r7odYm5QvlpWfFRbMgXIlQZHX4nPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AkNtVSl7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EjJ6+OmIEuCTxEODoja8rkS2u9zO5qR6qU5FJeucNZ8=; b=AkNtVSl7ZpW7Hk13ZPk6iEY/+l
	0BF9eMl0aBFNHx9UokmwCybJmXsESaCcHvtBzT4prSz7zst0iVfFSWh9U8p5MD/wBPLJtpRPT6bg/
	prwVJTgMNVHAdAE7gaNJcjcj8sB1a4FK+nbx/5mGeCOTLKVz1fUKvz4ewXeAWTaKzW1c89o0MF1Wk
	ZBvCyF5KFkKhY2GIFncXQCNaxQdF4frfeNE78RzC5/QaIOgW7QWyARZpNlsTGbJFM3Z9UoZcC9vuC
	kvgKoydhzYxsVZGFFx7j9FCCnGUR+kYmcTpt9L15Fs6fW3Pug0AHJpsnCu/xImYfURQqWZYdnalKk
	D4eyux5g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkWQ6-00000006eCT-07aj;
	Mon, 26 Jan 2026 23:54:58 +0000
Date: Mon, 26 Jan 2026 23:54:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXf-0c8uLowOW8NQ@casper.infradead.org>
References: <20260126224107.2182262-1-joannelkoong@gmail.com>
 <20260126224107.2182262-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126224107.2182262-2-joannelkoong@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75553-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 29A008E591
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:41:07PM -0800, Joanne Koong wrote:
> If the folio does not have an iomap_folio_state (ifs) attached and the
> folio gets read in by the filesystem's IO helper, folio_end_read() will
> be called by the IO helper at any time. For this case, we cannot access
> the folio after dispatching it to the IO helper, eg subsequent accesses
> like
> 
>         if (ctx->cur_folio &&
>                     offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> 
> are incorrect.
> 
> Fix these invalid accesses by invalidating ctx->cur_folio if all bytes
> of the folio have been read in by the IO helper.
> 
> This allows us to also remove the +1 bias added for the ifs case. The
> bias was previously added to ensure that if all bytes are read in, the
> IO helper does not end the read on the folio until iomap has decremented
> the bias.
> 
> Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


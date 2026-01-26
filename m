Return-Path: <linux-fsdevel+bounces-75542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id couuAcDfd2kWmQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:42:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E148DB1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20FC301E96C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5002EB5B8;
	Mon, 26 Jan 2026 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HM22eG84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02D29B224
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463736; cv=none; b=D0yNsisg0+wLrfEYfMvmewPZk/j4AY+w4ydOphFoGJdwHIGvGckOmTg6S7kzRIzcjg2vQ3N2p05LpozT7xWKYMD75vQKuJRMB6HqZohQ3wkKdDH1iw7JoDpp5M+LXr2m1OhThuiCym06aexYmbFhNGXB8H8C58h/rZWJDQAqZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463736; c=relaxed/simple;
	bh=JzmEIGgT60zP4LeaTWmkhOLMWRrdOD2nG+c43yMKwno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YigFg4p3l3AUJAc4BRNcFKpToyrPPK1C5s1dR80KkTU5am9Tp1ic7TLE/jWUIznwTeWWrsToUWbHiVaew7su84ctkdDkhTDy8mCn6URA1nJWOIS2yW/SVqNES8Vlt+0g5tD/fPfMJ7ZBXflHwCBo16l6SIGlPVW3Cpd2mSsxLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HM22eG84; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gyuWqgYWgc8LlmjsbqQnqbVSZ6W5J3xLQ7nZ4jsYIY8=; b=HM22eG84BxtOWsM8INzUhzEFPl
	ImlMsGDoEVyWMdiU5qap4l4dz2+tnG6H/oFmKVh44hvwmmYvGxO5fnjiRu/4aJXk7pD/LQ0Kqzf61
	MkySsywgVzYcyZBVhOLJKU7KrjRwNQJ5J/taBRmkcGmOqsk4A3ZNTcEbBobsyGWUHO2DcAFACkxaC
	347zbgwgfulvPIYv3GB40EWtUI1XH5cprm1mj14QhGjafp+i5bYMIyHa9c/K6vHJxPXLq4n7QQyn2
	tY/kh7tp8+zIXDC1W2a2Ja6nZayTF3EAHKkaf9VQyfMVCTN9B8LQqtzkuDK3yWgrWyzGeZk0XtQ/W
	HwzD+jcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkULb-00000006W40-3rdF;
	Mon, 26 Jan 2026 21:42:11 +0000
Date: Mon, 26 Jan 2026 21:42:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXffs1jcO0u85KpO@casper.infradead.org>
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com>
 <aXb_trkyt-uzdIkd@infradead.org>
 <aXeAY8K12KKf9d4_@casper.infradead.org>
 <CAJnrk1aQ8s04Co_Ncd41EpbMJEexPEF2qtAhGnG1rop8LLvWHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aQ8s04Co_Ncd41EpbMJEexPEF2qtAhGnG1rop8LLvWHA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75542-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 45E148DB1E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:36:21PM -0800, Joanne Koong wrote:
> I don't think there's a separate bug. The number of bytes submitted
> is tracked per-folio across iterations/mappings. If the first call to
> iomap_iter() succeeds and the second one fails, iomap_read_folio()
> still calls iomap_read_end() and decrements ifs->read_bytes_pending /
> does any folio unlocking it might need to do.
> 
> This change to iomap_read_folio() is a fix for the original bug (eg
> for folios without an ifs, the IO helper might have already called
> folio_end_read(), so ctx->cur_folio() needs to be used instead of the
> direct folio pointer).

Oh yes, I got confused.  You're right.

> I'll drop the change for the new iomap_read_submit_and_end() helper
> and submit that later as a separate patch to Christian's tree.

I don't think it deserves to be factored out into a separate function,
honestly.


Return-Path: <linux-fsdevel+bounces-78277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE+KOyfBnWnzRgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:17:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEF188E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FEC3014C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB03803C5;
	Tue, 24 Feb 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWJMr0f7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D681A2C0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946209; cv=none; b=FqrpI39OCjHU6LseBuU122VR3LTJx3eRqfb3m8zHXyGw1+JGjHe2pfyQLKpm+wr47+E3De6K6sp+T/urOHEWhUMq2PvGuwK2U+8p+2E4EW0MpnKczZTXazlbwDtr60vtMZoZxkhApsYgfYhZDbe+enzqJAk6dRYdqHZDzI8h758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946209; c=relaxed/simple;
	bh=Mxlg1ANq24WxEc2AYt3PC8nX+3sAtUtqtW/el81V+DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIcc5duiMEvPDdu/XcfWSPHBglqv6xffxRRjrifWL9QK9L0V1U9tUuydIrY2esMmNjjS4KXOSE2JrCRPlTgGRHG1Ph/bDcfgpERNpA93LjOMJsqd3bv5GnH0XdLRqW7nSLKt4MPSUN8B97swPTAKpxAERDRqfNwbtkO2/thQLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZWJMr0f7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bdq4r65KWAK9EOSSvggqu+cTC0+EuaDlx8bobu/peho=; b=ZWJMr0f71ySZ4JX+aGbNxEXss2
	fyOmO/mb1RrxXlkIVxle3W3vKKBc1NcVDNudBwWIuODrtPu+R02yzE2ajoNp3ZkGkzd1xCn9WsgEv
	ifs4GtAbBu745BuPyqFpLdCrup2j5VM6P+v9nD1E+PKOnw41oGd9gr2N9B4mRSCI/VYpzIYY57cDy
	8xqH/3UFoSwxcIHmlzzTEniiyd3O+yiUiaZO2jFB/QKHzfpHvRlYXVkpgrF59Sr02NQQrfymT7G7+
	1BkFn/gcSCNBz2Yjv+X0AqfxAjiJKVHw4msUcZi1aHsvtRcxXhgb9Mi/PsOe76iWt3vvd4gdnu/Pg
	fP5t5EBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuu9X-00000002IZk-1F5L;
	Tue, 24 Feb 2026 15:16:47 +0000
Date: Tue, 24 Feb 2026 07:16:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, brauner@kernel.org,
	wegao@suse.com, sashal@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <aZ3A39jztKdUmWoT@infradead.org>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
 <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org>
 <20260220234521.GA11069@frogsfrogsfrogs>
 <CAJnrk1Zk1hHCoC4xaY_KT0m_04CQ=pO6j3e1tGrdj7LTf5BHsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Zk1hHCoC4xaY_KT0m_04CQ=pO6j3e1tGrdj7LTf5BHsA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78277-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 47BEF188E7B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:53:15PM -0800, Joanne Koong wrote:
> > There are three ways that iomap can be reading into the pagecache:
> > a) async ->readahead,
> > b) synchronous ->read_folio (page faults), and
> 
> b) is async as well. The code for b) and a) are exactly the same (the
> logic in iomap_read_folio_iter())

Yes.

> > This is confusing to me.  It would be more straightforward (I think) if
> > we just did it for all cases instead of adding more conditionals.  IOWs,
> > how hard would it be to consolidate the read code so that there's one
> > function that iomap calls when it has filled out part of a folio.  Is
> > that possible, even though we shouldn't be calling folio_end_read during
> > a pagecache write?
> 
> imo, I don't think the synchronous ->read_folio_range() for buffered
> writes should be consolidated with the async read logic.

Yes.  I've been thinking about that on and off, but unfortunately so far
I've not come up with a good idea how to merge the code.  Doing so would
be very useful for many reasons.

The problem with that isn't really async vs sync; ->read_folio clearly
shows you you turn underlying asynchronous logic into a synchronous call.
It's really about the range logic, where the writer preparation might
want to only read the head and the tail segments of a folio.

But if we can merge that into the main implementation and have a single
core implementation we'd be much better off.

Anyone looking for a "little" project? :)


Return-Path: <linux-fsdevel+bounces-79663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nZPVI3k3q2mkbAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:22:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABE227743
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E9C30495CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00186449EC3;
	Fri,  6 Mar 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Zph/wY/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmepC9T4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1C7081E;
	Fri,  6 Mar 2026 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828530; cv=none; b=syaxeqvbDvllO6moLaIj5MpmX61VBAVIJ+SRk9zjFED51fCEht2QaiNR/bycSYdkImd9czOStGPusQ5dl4W6GyM5f+KBIgXK3wQX74Kh55Pv/AIPqHvDEUACvshK7RiP7odew3CGK36ETc7IjXUzzq/MZ2SUTgty4ZDGGW61uS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828530; c=relaxed/simple;
	bh=K0y817XrEcM6UP0c/zCyihz+HLAEaHeZKH+FSYuUoOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPrEnXIUimVTLKJLRVyvC4LFsbKojCfdRSFuSwMQA+jvZoovyO6jeYnrFaK/ir/JGTZTlDWr8NYaEoHCu2x+ExRugVX9Ep5l1UgalSPCojhj7jKnTAcQ789BrKuZ7pvpCb5xdN+R+sv4Dc39CPH/8UwG73J42Sd/ftff3wIjSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Zph/wY/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmepC9T4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C59EEC0647;
	Fri,  6 Mar 2026 15:22:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 15:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772828528; x=
	1772914928; bh=j7EtY5Lz6n2cvujZXVeWfFZYsYZf69ABvyin+RZQ0Q8=; b=Z
	ph/wY/IEol1x6H1EYgH2MfUvAJKVETBUvihjPzrfUUItMoike+nJP6Gjj79USsjY
	G7Nb/VnJRaIVJHiErMWaFPvnSnAzieGuMrr4Xnz3ZZpQ642Bx1b2hy+sm935SU8l
	VM6PDuujyIYot89qIOxlT9vWV1an7kyJ5pVkXC2NpB/4YCkHPohTo2hSpWp8AFVy
	X2mn8H5+v/gJAxDiZhwtyGikHJFETr+Mb5yhirLfjRHL66s97sPBQpd4+IVOkXXG
	pPNqFWlRGl9q6WOEL/QZcx9ApmNR8nfcS4FhHGY/BKyXf7A04U9tdXKZ6LYP5rNC
	rzLmgPXSaJXSzyZW9OKvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772828528; x=1772914928; bh=j7EtY5Lz6n2cvujZXVeWfFZYsYZf69ABvyi
	n+RZQ0Q8=; b=nmepC9T4PQNYNzYu49wyYt1WVTI6wLnAja7EtozQ1LHUkeid0cB
	2tgb+inndnKSBw7vz93cQMoPjEGlNTnTiNRxSuHZZ+7ZndbVs+YHgRcnbCjigZWO
	YxN4QH6EoFFLBd0ggivx8jJIiHEsWJqUjZJ1lbLN/XZOQVVSvyJpx/X4dz5OzHLH
	U+KW+6e8MUiKe5z/Ty8dTkldeyiG8oNSArU77r/ShgQowhaDK69PtVHPGzFtMzKG
	yWj5iZJ9Y2qYgkRp3kYmFYHK4ovy40DBM2xhe4cWy4MfBAV0mqZ7MqJcZbTv/o2Q
	0+KDCQ7MqzusyTVEdvs26iSIodocTIatMvg==
X-ME-Sender: <xms:cDeraSZhD4Xwlu_I3Z1J0RQ-KeKpb8zuPO7xZo1L_rEqZboM-ub6pg>
    <xme:cDeraT6_Ytt1kLE2krgGHFNRiFMM7_Ds8f9pzCsR40TH74pUjKA8w_TY37oxXOlgQ
    XmZUt_1vtl4kHc5lyyZETXxJ4CsAjKUpnvkthOwtS4WF3Caq_Gt3leY>
X-ME-Received: <xmr:cDeraTw9AagwnLWuCdOrY2z87huJaKQOxy0Ug5U30NEWbZfagYez9IRwpocZIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhhgvghssegtlhhouhgufh
    hlrghrvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopeifihhllhhirghmrdhkuhgthhgrrhhskhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgtohhm
X-ME-Proxy: <xmx:cDeraUpGQfIldLXk9682Y-7o3-0avsfdCeLPvweJ2txluqIzbPmTUQ>
    <xmx:cDeraV2nKJNfik5xLjmnu0juch-DbW-UEyJXOagtDunSKkpj9faPIw>
    <xmx:cDeradBOoVoIFMshR7OdjXpiRWvJYKzWnpnM2z4-cJfet_aYtTyPXQ>
    <xmx:cDeraWN06mmr6a1wz-k43bwLuWXGhsRw5XMFtXdUKow1R8ga8zLvPA>
    <xmx:cDeraZFrnNViXYE_CX8se2lR_I46rCB7Os4DqptuezI4km-YkMR99bzp>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 15:22:06 -0500 (EST)
Date: Fri, 6 Mar 2026 20:21:59 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Chris Arges <carges@cloudflare.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aas3E9P0BP03O8ma@thinkstation>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aas06mfCrJuzZd0-@20HS2G4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aas06mfCrJuzZd0-@20HS2G4>
X-Rspamd-Queue-Id: E4ABE227743
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-79663-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shutemov.name:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:11:22PM -0600, Chris Arges wrote:
> On 2026-03-06 16:28:19, Matthew Wilcox wrote:
> > On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > > folio_split() needs to be sure that it's the only one holding a reference
> > > > to the folio.  To that end, it calculates the expected refcount of the
> > > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > > freezing will fail.
> > > > 
> > > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > > the entire folio_split can happen, then it calls folio_try_get() and
> > > > succeeds, but it no longer covers the index we were looking for.  That's
> > > > what the xas_reload() is trying to prevent -- if the index is for a
> > > > folio which has changed, then the xas_reload() should come back with a
> > > > different folio and we goto repeat.
> > > > 
> > > > So how did we get through this with a reference to the wrong folio?
> > > 
> > > What would xas_reload() return if we raced with split and index pointed
> > > to a tail page before the split?
> > > 
> > > Wouldn't it return the folio that was a head and check will pass?
> > 
> > It's not supposed to return the head in this case.  But, check the code:
> > 
> >         if (!node)
> >                 return xa_head(xas->xa);
> >         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
> >                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
> >                 entry = xa_entry(xas->xa, node, offset);
> >                 if (!xa_is_sibling(entry))
> >                         return entry;
> >                 offset = xa_to_sibling(entry);
> >         }
> >         return xa_entry(xas->xa, node, offset);
> > 
> > (obviously CONFIG_XARRAY_MULTI is enabled)
> >
> Yes we have this CONFIG enabled.
> 
> Also FWIW, happy to run some additional experiments or more debugging. We _can_
> reproduce this, as a machine hits this about every day on a sample of ~128
> machines. We also do get crashdumps so we can poke around there as needed.
> 
> I was going to deploy this patch onto a subset of machines, but reading through
> this thread I'm a bit concerned if a retry doesn't actually fix the problem,
> then we will just loop on this condition and hang.

I would be useful to know if the condition is persistent or if retry
"fixes" the problem.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-fsdevel+bounces-12069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7085AFFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 01:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911BE1C22626
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D621259B;
	Tue, 20 Feb 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eHEgPEMA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AqAbl95u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eHEgPEMA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AqAbl95u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1815BB;
	Tue, 20 Feb 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388505; cv=none; b=uBD11+qh9T4ZwpYYbQf+DPHOH94Ex6vtrjCfpVCF4kgCJIVJ6+A9UELq84KdboD9ukxo2TwDIlOcB43xLxjTyEgEqJGbG/5RDripNr5d/gb9QSeWQaeDrZd2EV3MyIQqLvGV9oEiBU6gwIG5QxeZVjtR1RRyCLwAZQCUpBP/2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388505; c=relaxed/simple;
	bh=HoYfSU1LERQNtThH9A+NVMysOQp+ECNTZweM8N3vBII=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dDgi9j2Xo+jdf/NCW2A/A/og6h8BPLG9nMQGl5ghtiro1aitLJAvA66DDKLz8ephvo89BIA9IANMhQiF/oe++7VmdRMiG0FqwUvQNBGnNLPxRZorVmmPrpVtJtIpjh8KJdr737J64DeqgUiogod2I0tg/N+I83SYP3HTSJu9U3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eHEgPEMA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AqAbl95u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eHEgPEMA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AqAbl95u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9F2121EAD;
	Tue, 20 Feb 2024 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708388501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCStDtcRffeU4jURBHp/euC2Vn/pS2u4zscwEUzLt+k=;
	b=eHEgPEMAEvAjhowMWVtD1L45v2+oTmGs40a7GZOJ1Ov9Jb9s5RNEuhdI/LqkTAnSckTKAJ
	xfUbQrIRGupq65EmcwwUqT+dl/wp3Vn/I5B1feDMhJv4MQfRlAcEH77ONSSW6Ocsj9HK2+
	lGA0/CFkumnx/sZEaFmPNPhFZu0ydRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708388501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCStDtcRffeU4jURBHp/euC2Vn/pS2u4zscwEUzLt+k=;
	b=AqAbl95uLUKL7GTueZQ3qWuww7EqxAm3/78Jlrz4vkGAoFUdNbY3/TvYsv215SIX5ySpk0
	4UPPxuSKOkij04Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708388501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCStDtcRffeU4jURBHp/euC2Vn/pS2u4zscwEUzLt+k=;
	b=eHEgPEMAEvAjhowMWVtD1L45v2+oTmGs40a7GZOJ1Ov9Jb9s5RNEuhdI/LqkTAnSckTKAJ
	xfUbQrIRGupq65EmcwwUqT+dl/wp3Vn/I5B1feDMhJv4MQfRlAcEH77ONSSW6Ocsj9HK2+
	lGA0/CFkumnx/sZEaFmPNPhFZu0ydRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708388501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCStDtcRffeU4jURBHp/euC2Vn/pS2u4zscwEUzLt+k=;
	b=AqAbl95uLUKL7GTueZQ3qWuww7EqxAm3/78Jlrz4vkGAoFUdNbY3/TvYsv215SIX5ySpk0
	4UPPxuSKOkij04Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 657EF139D0;
	Tue, 20 Feb 2024 00:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KtjvBpLw02UVagAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 20 Feb 2024 00:21:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Mike Rapoport" <rppt@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
In-reply-to: <ZdPkWsxKZN8CvQTN@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>,
 <Zb9pZTmyb0lPMQs8@kernel.org>, <ZcACya-MJr_fNRSH@casper.infradead.org>,
 <ZcOnEGyr6y3jei68@kernel.org>, <ZdO2eABfGoPNnR07@casper.infradead.org>,
 <170838273655.1530.946393725104206593@noble.neil.brown.name>,
 <ZdPkWsxKZN8CvQTN@casper.infradead.org>
Date: Tue, 20 Feb 2024 11:21:35 +1100
Message-id: <170838849545.1530.13553329646368488958@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eHEgPEMA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AqAbl95u
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.10)[-0.487];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.65%]
X-Spam-Score: -1.43
X-Rspamd-Queue-Id: A9F2121EAD
X-Spam-Flag: NO

On Tue, 20 Feb 2024, Matthew Wilcox wrote:
> On Tue, Feb 20, 2024 at 09:45:36AM +1100, NeilBrown wrote:
> > On Tue, 20 Feb 2024, Matthew Wilcox wrote:
> > > The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
> > > and it's a helper function for filemap_range_needs_writeback().
> > > filemap_range_needs_writeback() has kernel-doc, but nobody should be
> > > calling filemap_range_has_writeback() directly, so it shouldn't even
> > > exist in the htmldocs.  But we should have a comment on it saying
> > > "Use filemap_range_needs_writeback(), don't use this", in case anyone
> > > discovers it.  And the existance of that comment should be enough to
> > > tell our tools to not flag this as a function that needs kernel-doc.
> > > 
> > 
> > Don't we use a __prefix for internal stuff that shouldn't be used?
> 
> No?  Or if we do, we are inconsistent with that convention.  Let's
> consider some examples.
> 
> __SetPageReferenced -- non-atomic version of SetPageReferenced.
> Akin to __set_bit.
> 
> __filemap_fdatawrite_range() -- like filemap_fdatawrite_range but
> allows the specification of sync_mode
> 
> __page_cache_alloc() -- like page_cache_alloc() but takes the gfp mask
> directly instead of inferring it from mapping_gfp_mask()
> 
> __folio_lock() -- This does fit the "don't call this pattern"!
> 
> __set_page_dirty() -- Like set_page_dirty() but allows warn to be
> specified.
> 
> __filemap_remove_folio() -- Like filemap_remove_folio() but allows it
> to be replaced with a shadow entry.
> 
> __readahead_folio() -- Another internal one
> 
> I mostly confined myself to pagemap.h for this survey, but if you've
> conducted a different survey that shows your assertion is generally true
> and I've hit on the exceptions to the rule ... ?
> 

Yes, __ is used for other things too.
It would be nice to have some consistency with naming, but probably
impossible.

And with 1074 functions named __foo having kernel doc already, it is too
late to close that gate.
:-(

Thanks,
NeilBrown


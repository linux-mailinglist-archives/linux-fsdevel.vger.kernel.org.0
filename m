Return-Path: <linux-fsdevel+bounces-52321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060AEAE1BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE7A178A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58B28C5DB;
	Fri, 20 Jun 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEB+ug4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT+Yo9OV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEB+ug4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT+Yo9OV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F621754B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425309; cv=none; b=PfMscgnlDIL4o/04eip3UucNtptwLl4TMz4DU7zZiNlv20YBbjaaYNHdP6LkNWw6wOuZLvAa90bmm+bdU5jJVSVrN4Bgkfj4dFkbqhvpt4W06bLtAZQJ7Scp4ILxXbvrzuJ2gSC+iU6lopC6mVozIFLDpoSuwe3TmZfarDF4ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425309; c=relaxed/simple;
	bh=je76kGXG4+1kXDpwCgSpCTIG4FaPVJQnG5bQBNqG4Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdopHt+4LRPLq7kBUDlCrIAUCvbUp45/re8dGETZ96GlGH2tE3YKGFJh4LcpNFHPiJO5UfiV/FhXxOCrxAm0yRaO5pUcd1ho3p4abqbBu0MuFtOpWZdAqXPkymOH55ELjBk2yDhAeB3WdsxS/cMnPnl2PVfNSIx6tcX6IkOENbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEB+ug4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT+Yo9OV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEB+ug4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT+Yo9OV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6E081F38D;
	Fri, 20 Jun 2025 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D24GwzWGzROMuiBukeaSM6+Y6O+u+7V8pF5wtkdPY2g=;
	b=cEB+ug4R8upAoH5hKHCrgp9D0jGdiFjH5v757mS6Lmvxs6prlE3cSBcmRu46pJZasMJueR
	WC3t8+FNaRsMSw7Vomcu/9z9rEB7SmxkVRJZrd/zR+3kTTkonqmadzQb/GhjJM3CWnKBpA
	4b3AuzIWqn9/DjeFMEwAFktHEMEHGfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D24GwzWGzROMuiBukeaSM6+Y6O+u+7V8pF5wtkdPY2g=;
	b=nT+Yo9OVG1f0R8/JQaNQhyo9Nsyj+2fzzDMaVXIC3TshxmEbipDSOzyWpcbjU2bh9L877t
	3K1jB0z1PWVeCrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D24GwzWGzROMuiBukeaSM6+Y6O+u+7V8pF5wtkdPY2g=;
	b=cEB+ug4R8upAoH5hKHCrgp9D0jGdiFjH5v757mS6Lmvxs6prlE3cSBcmRu46pJZasMJueR
	WC3t8+FNaRsMSw7Vomcu/9z9rEB7SmxkVRJZrd/zR+3kTTkonqmadzQb/GhjJM3CWnKBpA
	4b3AuzIWqn9/DjeFMEwAFktHEMEHGfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D24GwzWGzROMuiBukeaSM6+Y6O+u+7V8pF5wtkdPY2g=;
	b=nT+Yo9OVG1f0R8/JQaNQhyo9Nsyj+2fzzDMaVXIC3TshxmEbipDSOzyWpcbjU2bh9L877t
	3K1jB0z1PWVeCrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A03B4136BA;
	Fri, 20 Jun 2025 13:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFyCJtleVWjGNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 13:15:05 +0000
Date: Fri, 20 Jun 2025 15:14:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Convert test_find_delalloc() to use a folio
Message-ID: <20250620131456.GW4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250613190705.3166969-1-willy@infradead.org>
 <20250613190705.3166969-2-willy@infradead.org>
 <aFN62U-Fx4RZGj6Q@casper.infradead.org>
 <f1cc6120-0410-4c69-b5ec-19194508148a@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1cc6120-0410-4c69-b5ec-19194508148a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 19, 2025 at 03:11:16PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/19 12:20, Matthew Wilcox 写道:
> > On Fri, Jun 13, 2025 at 08:07:00PM +0100, Matthew Wilcox (Oracle) wrote:
> >> @@ -201,17 +200,16 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
> >>   	 *           |--- search ---|
> >>   	 */
> >>   	test_start = SZ_64M;
> >> -	locked_page = find_lock_page(inode->i_mapping,
> >> +	locked_folio = filemap_lock_folio(inode->i_mapping,
> >>   				     test_start >> PAGE_SHIFT);
> >> -	if (!locked_page) {
> >> -		test_err("couldn't find the locked page");
> >> +	if (!locked_folio) {
> >> +		test_err("couldn't find the locked folio");
> >>   		goto out_bits;
> >>   	}
> >>   	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
> >>   	start = test_start;
> >>   	end = start + PAGE_SIZE - 1;
> >> -	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
> >> -					 &end);
> >> +	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
> >>   	if (!found) {
> >>   		test_err("couldn't find delalloc in our range");
> >>   		goto out_bits;
> > 
> > Hm.  How much do you test the failure paths here?  It seems to me that
> > the 'locked_folio' is still locked at this point ...
> 
> Yep, you're right, the error paths here should have the folio unlocked
> (all the error handling after fielmap_lock_folio()).
> 
> It's just very rare to have a commit that won't pass selftest pushed to 
> upstream.
> 
> Mind to fix it in another patch or you wish us to handle it before your 
> series?

Please fix it separately before the series, this needs runtime testing
and is specific to the selftest environment, while the folio conversions
are API-level and straightforward.


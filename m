Return-Path: <linux-fsdevel+bounces-52318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3750AE1B66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C11C7A8AE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC628B3E2;
	Fri, 20 Jun 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hq3XgJqI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdCwZG1N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQcPSCTa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hVW/UE2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886B236442
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424635; cv=none; b=k2A+AKvKNbtRrJ5QXey1kJcQQaMYETmm/tTOhDK8JnoLU4Q6asibGXTw6BY7sfX9zSa6M/Hwr8b8llId7wB9DVXt3TICPkDYxnhsNl3DknJCum+c23cTl2M/scRo2cdcTAiAXkOR5ZF4F59Jw0e8iD7GrxK7tQ47WjKTbaeXzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424635; c=relaxed/simple;
	bh=rKw7zT553+VrDVDcyVKl5NBe3JdWXDfAqqIOIeRrKWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDuWxyqK9HMKy5n6MKSQam7diDdOQ+5joiC911FLzOlxnjJTC1HJvwwt8O9cmZU321HEnKOpJLdKXlKu5lFpFrMJUY4i/nC4m6UP68gjIuJUsu1ZCXEs71VuajDGxQTH5EZPPVTCyJ3OfOULG4SYGLOgefR9Nr7Ux1znsbnPYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hq3XgJqI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdCwZG1N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQcPSCTa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hVW/UE2h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 889DF1F7ED;
	Fri, 20 Jun 2025 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750424625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZPMsIov+WlFXzBA1raHyOxqETTr2SaOSTXMsN+EJIg=;
	b=Hq3XgJqIb8GcYhoVKtj8AM/8m0CjiUyb91LjSWD9aMQlLIuFX4/IFlF61pKCnEHwmVkFAy
	nClId7snAju6aFPc1wzrT4rP5CyqTgzYHbwYS/dHXSUGqDoB0C8fJdNxVwHlcMrzS5d2FG
	Drt1LtdknSRu9YBCu9wIz/wksAivW+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750424625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZPMsIov+WlFXzBA1raHyOxqETTr2SaOSTXMsN+EJIg=;
	b=wdCwZG1N2PcKTjGyYIbclhjzDyaRT6hieOEJTiEGkw2uMGg0MFNk67iE8vuaE1HDggDa6E
	RbcRqVER/pFb4CCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nQcPSCTa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="hVW/UE2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750424613;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZPMsIov+WlFXzBA1raHyOxqETTr2SaOSTXMsN+EJIg=;
	b=nQcPSCTaOOqELm89zZzHvGlL9MhO4XNlEl5vMXjZ6y99zty/EHjowrEZfbt0wdZqemFZrj
	DPcl+lOfHVRe6Kw4sRL+1Qgh1g02tOYDY0HeEm+0gxNHAf1MGoQQt0fJOg7RUfVyQ63VS1
	UfecWcZj8dEPBXBiyHd9rF8h3F/JP0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750424613;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZPMsIov+WlFXzBA1raHyOxqETTr2SaOSTXMsN+EJIg=;
	b=hVW/UE2hPAxl0T9JtGj4ZdHRQWW17OwfxIJCXz+475oB1Rct63e63W9sS5sBEVhlWXVt7H
	qnjHfPPNa9ZiesCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70BDF136BA;
	Fri, 20 Jun 2025 13:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uP5NGyBcVWhhMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 13:03:28 +0000
Date: Fri, 20 Jun 2025 15:03:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Convert test_find_delalloc() to use a folio
Message-ID: <20250620130327.GU4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250613190705.3166969-1-willy@infradead.org>
 <20250613190705.3166969-2-willy@infradead.org>
 <aFN62U-Fx4RZGj6Q@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFN62U-Fx4RZGj6Q@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 889DF1F7ED
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:query timed out];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[dsterba.suse.cz:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 19, 2025 at 03:50:01AM +0100, Matthew Wilcox wrote:
> On Fri, Jun 13, 2025 at 08:07:00PM +0100, Matthew Wilcox (Oracle) wrote:
> > @@ -201,17 +200,16 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
> >  	 *           |--- search ---|
> >  	 */
> >  	test_start = SZ_64M;
> > -	locked_page = find_lock_page(inode->i_mapping,
> > +	locked_folio = filemap_lock_folio(inode->i_mapping,
> >  				     test_start >> PAGE_SHIFT);
> > -	if (!locked_page) {
> > -		test_err("couldn't find the locked page");
> > +	if (!locked_folio) {
> > +		test_err("couldn't find the locked folio");
> >  		goto out_bits;
> >  	}
> >  	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
> >  	start = test_start;
> >  	end = start + PAGE_SIZE - 1;
> > -	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
> > -					 &end);
> > +	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
> >  	if (!found) {
> >  		test_err("couldn't find delalloc in our range");
> >  		goto out_bits;
> 
> Hm.  How much do you test the failure paths here?  It seems to me that
> the 'locked_folio' is still locked at this point ...

I think we don't paid too much attention to the failure paths of tests,
it means one has to go to check the new code first. If the tests pass
then they will clean up everything, in case of error it's usually
followed by reboot.


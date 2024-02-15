Return-Path: <linux-fsdevel+bounces-11710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9385651A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC14E1C2133D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703A131742;
	Thu, 15 Feb 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HIH47Xn3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fchA0G6G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEE/25LG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mDNcQHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A612FF72;
	Thu, 15 Feb 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005438; cv=none; b=WDvnEL5NOd+qNV+WYBTCeCD/14DDJ+DadnIVf7XwTbf3+C0V0E/Gjsneh/dz9He4alj/jN0MGd0Tu+S4ySMXiT+T2lVvAF7FM/9wUQ8gsNEt1ZgmvKNYmRF9+pWtUEjrdAs/MeHcwyXn8QZUD/HZiOntlZRS/oP1rvFqXDi8YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005438; c=relaxed/simple;
	bh=dtRNCSG2drdSUn0qgLJnB4PgsNhEWPSz3Sxfby/2528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAH2qJAf1TCal91HNAihLh01eAc/KgOeHa1jTBOz+J4EYX8l2T5cZDksfcWdFPzyCCgYsPEHPYbzv07+ELJqaVWlnuj/yEyvQjmzVkPRSh419h+HySrTslhEPPAnSq71225skNFaIpSM8LQ5Q5t9DwGbDAub274HHOGlKm1Nv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HIH47Xn3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fchA0G6G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hEE/25LG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mDNcQHO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDA9D1F8A4;
	Thu, 15 Feb 2024 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708005434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/uzfX85UNWZjIaQT+BrrcGbq6mDrktdy+t3iMmxTo=;
	b=HIH47Xn3s/imS2dkQ1Piz1H5w78/hNxlmrwhDtdrRM0HVrgXtMa3mKprq/akNODAVx2Rke
	sJqgmILq0pRTyWtapSrt1ZS2+LPxTEexpvYquSnnYrg4ZbK13tSvYMfdpDsA3N3+ixGfgU
	DFAlVN6jBajl0b+5h8Wfi6Cxg83ELEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708005434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/uzfX85UNWZjIaQT+BrrcGbq6mDrktdy+t3iMmxTo=;
	b=fchA0G6G5rNTNN7cXH4hHdZGb7aiFIcGVSNj2mSJNDJtYC0IwCMmRSK/er0IU2dirvLXzB
	t27uqU/wSnAshOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708005433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/uzfX85UNWZjIaQT+BrrcGbq6mDrktdy+t3iMmxTo=;
	b=hEE/25LGdzh4bXpEiRTRx+86eDxd/7KOXRgqaPiLm9HGq8fCHw49WHOMdaIOqQ55W1puRN
	Tz6epXQOl2G0WnBx2KuuTYth7sjEzSnB6TGwFUTUW9QKJ+5F8psSPE9dESQ2A16rjW0w8k
	bgflJUZXrgNW78GqEDdKncPo3Yn8uAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708005433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM/uzfX85UNWZjIaQT+BrrcGbq6mDrktdy+t3iMmxTo=;
	b=1mDNcQHOi1hfjcKMwI4r6uz91XwTDRduxm3/BP9dKJufAIbxwn8kdECOHkFXlaX0uWOc/F
	hj5jOl0O4HHTGYDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D51421346A;
	Thu, 15 Feb 2024 13:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zpAANDkYzmUAIQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 13:57:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78BB8A0809; Thu, 15 Feb 2024 14:57:09 +0100 (CET)
Date: Thu, 15 Feb 2024 14:57:09 +0100
From: Jan Kara <jack@suse.cz>
To: Adrian Vovk <adrianvovk@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240215135709.4zmfb7qlerztbq6b@quack3>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 29-01-24 19:13:17, Adrian Vovk wrote:
> Hello! I'm the "GNOME people" who Christian is referring to

Got back to thinking about this after a while...

> On 1/17/24 09:52, Matthew Wilcox wrote:
> > I feel like we're in an XY trap [1].  What Christian actually wants is
> > to not be able to access the contents of a file while the device it's
> > on is suspended, and we've gone from there to "must drop the page cache".
> 
> What we really want is for the plaintext contents of the files to be gone
> from memory while the dm-crypt device backing them is suspended.
> 
> Ultimately my goal is to limit the chance that an attacker with access to a
> user's suspended laptop will be able to access the user's encrypted data. I
> need to achieve this without forcing the user to completely log out/power
> off/etc their system; it must be invisible to the user. The key word here is
> limit; if we can remove _most_ files from memory _most_ of the time Ithink
> luksSuspend would be a lot more useful against cold boot than it is today.

Well, but if your attack vector are cold-boot attacks, then how does
freeing pages from the page cache help you? I mean sure the page allocator
will start tracking those pages with potentially sensitive content as free
but unless you also zero all of them, this doesn't help anything against
cold-boot attacks? The sensitive memory content is still there...

So you would also have to enable something like zero-on-page-free and
generally the cost of this is going to be pretty big?

> I understand that perfectly wiping all the files out of memory without
> completely unmounting the filesystem isn't feasible, and that's probably OK
> for our use-case. As long as most files can be removed from memory most of
> the time, anyway...

OK, understood. I guess in that case something like BLKFLSBUF ioctl on
steroids (to also evict filesystem caches, not only the block device) could
be useful for you.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


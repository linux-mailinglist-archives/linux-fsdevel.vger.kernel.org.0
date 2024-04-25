Return-Path: <linux-fsdevel+bounces-17802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FC8B2465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF2D1F24547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECA14A600;
	Thu, 25 Apr 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLqnk9jj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjFH6c8J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLqnk9jj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjFH6c8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3114A4F3;
	Thu, 25 Apr 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056702; cv=none; b=AoDa2+oHyAgfGlbvPnl9TPwEyiLDVm++T3Gay+cvDr10f4Fq4Zm1xxZWCc5vhJLxfyNi6XxrHgMEz5Px79HBUeGJ2JgSJAMxO96NV3oQkEVyDMeBnHlO6XLlMA4OmNaTqlFUuoiqM89zQld9bC1MEYf6FEA1D+9QMu6N2lPWkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056702; c=relaxed/simple;
	bh=Zucwudz612hd27b6C0HsYBcki2eesBG2akernFmMeew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnjYC41HlImWEZ+06EoXfMMV9DZJIHn9Z1k+SGNbkCPatTDWz/kwPeJbPA5LJfoRO6Ew7I2HysR626Qdv6O9SInJEzBCBQCddypxQ17tqzahwys1CWk3uszWzFT1jFgKvT6lYUhSoJHsdR3GtAZRQ/0AQXTsK3p3pS909w5OfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DLqnk9jj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjFH6c8J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DLqnk9jj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjFH6c8J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12F5A33DC0;
	Thu, 25 Apr 2024 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714056698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH8Qt7y91O7e10TF4B6+mtgFX7Yt+aZGRDAj8mYFVXA=;
	b=DLqnk9jj7ae2cIgZ8R7najSUa5E1flzNeK+z9ggI6Hddq7Fe9hGpd4BNUmhzsN9ku3s3Dd
	TfCMEH8k7+rrz9UHPHl3vW6rrFeuqAYjcB9MFymaiQfeRbyn6g2hBubF4C/H8acRi0dEJl
	yD6K/JQ1Mchxny2hwxHt/bndVV7sw3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714056698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH8Qt7y91O7e10TF4B6+mtgFX7Yt+aZGRDAj8mYFVXA=;
	b=PjFH6c8JzTMwKv+ruBVmSVClglZkstUiHaGR1h7mWP75OFtp3VjBVgxfEjCvcSHleBM891
	+VGM5cR+ZVU991DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DLqnk9jj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PjFH6c8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714056698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH8Qt7y91O7e10TF4B6+mtgFX7Yt+aZGRDAj8mYFVXA=;
	b=DLqnk9jj7ae2cIgZ8R7najSUa5E1flzNeK+z9ggI6Hddq7Fe9hGpd4BNUmhzsN9ku3s3Dd
	TfCMEH8k7+rrz9UHPHl3vW6rrFeuqAYjcB9MFymaiQfeRbyn6g2hBubF4C/H8acRi0dEJl
	yD6K/JQ1Mchxny2hwxHt/bndVV7sw3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714056698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH8Qt7y91O7e10TF4B6+mtgFX7Yt+aZGRDAj8mYFVXA=;
	b=PjFH6c8JzTMwKv+ruBVmSVClglZkstUiHaGR1h7mWP75OFtp3VjBVgxfEjCvcSHleBM891
	+VGM5cR+ZVU991DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF98613991;
	Thu, 25 Apr 2024 14:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CnNQOvltKmaMCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Apr 2024 14:51:37 +0000
Date: Thu, 25 Apr 2024 16:44:03 +0200
From: David Sterba <dsterba@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/30] btrfs: Use a folio in write_dev_supers()
Message-ID: <20240425144403.GQ3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420025029.2166544-3-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.58
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 12F5A33DC0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.58 / 50.00];
	BAYES_HAM(-2.37)[97.07%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6]

On Sat, Apr 20, 2024 at 03:49:57AM +0100, Matthew Wilcox (Oracle) wrote:
> @@ -3812,8 +3814,7 @@ static int write_dev_supers(struct btrfs_device *device,
>  		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
>  		bio->bi_private = device;
>  		bio->bi_end_io = btrfs_end_super_write;
> -		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> -			       offset_in_page(bytenr));
> +		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);

Compilation fails when btrfs is built as a module, bio_add_folio_nofail()
is not exported. I can keep __bio_add_page() and the conversion can be
done later.


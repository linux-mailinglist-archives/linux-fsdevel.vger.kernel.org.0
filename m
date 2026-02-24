Return-Path: <linux-fsdevel+bounces-78266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK/4Cu2tnWmgQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:55:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A118816A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CFF13023A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DD39E6F0;
	Tue, 24 Feb 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MT1kUN+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6EFemYbm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MT1kUN+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6EFemYbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E762405E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941314; cv=none; b=T3h7AccB68CNCScuktBxASS31FT3owIflo7rp+fdk0z8JTjhRrD/Fcoi0hauluG1NVJgvUHyyi1Ofll4RRDWAZLoNE/LYS61RjcLsyT8Ok4qY5sgeKFjGEscwpkn2czftNbWE52vtVecVMWqgkeVOrQ1LduOX/PVV8aTAwRhXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941314; c=relaxed/simple;
	bh=Y83YN3Z+oLSinJ7NVQEsEsHz/fpDH/jnmePEQ8Rq+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeM9q3NNzFFcvyDamtK3qJvSM6wXGqV3HPdbBjGcYnAFE0nr9Zh/tN6GRhayc7bzkXac4GN8FSvWk/gxuEgb9rgnhcgVOY5Jqo9D50QkB98KFMP+87Orqcv2rL9pa0CpMpIsOdCatK0DipYupLN6B02LVwZ/RZT0a897MJaw1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MT1kUN+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6EFemYbm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MT1kUN+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6EFemYbm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 013293F251;
	Tue, 24 Feb 2026 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
	b=MT1kUN+gGMsCoUB7Gjf+X+6FRCA4P14szw92f6JxsRV9UMCUBkcWJ/9jC42VOyxmQsQ3Ps
	iQZMh7ZKItwreVqdT0dkT/MVXaUQUyAzinPYWwXqVuomUEFjzWu09pIxdXe6uVgKTQ9nuj
	huY1D4lmsDtGpbQaHXgiCDySZqFGOhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
	b=6EFemYbm6sEj3mrcQ6sGZxLXHy3au4fcdkZjOBJZG/c8rQEr1EOhkmXX1kXnTMf41r2YMZ
	ZGAmaWkNO5ITBFBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MT1kUN+g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6EFemYbm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
	b=MT1kUN+gGMsCoUB7Gjf+X+6FRCA4P14szw92f6JxsRV9UMCUBkcWJ/9jC42VOyxmQsQ3Ps
	iQZMh7ZKItwreVqdT0dkT/MVXaUQUyAzinPYWwXqVuomUEFjzWu09pIxdXe6uVgKTQ9nuj
	huY1D4lmsDtGpbQaHXgiCDySZqFGOhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwteX+3st/BoFz5qXCpVjpTwTwtYXckuDq7ibdYt4EA=;
	b=6EFemYbm6sEj3mrcQ6sGZxLXHy3au4fcdkZjOBJZG/c8rQEr1EOhkmXX1kXnTMf41r2YMZ
	ZGAmaWkNO5ITBFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6473EA68;
	Tue, 24 Feb 2026 13:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HV7MbytnWkuJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 13:55:08 +0000
Date: Tue, 24 Feb 2026 14:55:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Message-ID: <20260224135507.GT26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260221204525.30426-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78266-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: C98A118816A
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.
> 
> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
> index 76d1c5971b82..b20882963ffb 100644
> --- a/fs/verity/Kconfig
> +++ b/fs/verity/Kconfig
> @@ -1,9 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  config FS_VERITY
>  	bool "FS Verity (read-only file-based authenticity protection)"
> +	# Filesystems cache the Merkle tree at a 64K aligned offset in the
> +	# pagecache.  That approach assumes the page size is at most 64K.
> +	depends on PAGE_SHIFT <= 16

Makes sense to me, we have "depends on PAGE_SIZE_LESS_THAN_256KB" since
somebody tried to use btrfs on the 256K system.


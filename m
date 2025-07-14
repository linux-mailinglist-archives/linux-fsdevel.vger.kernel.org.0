Return-Path: <linux-fsdevel+bounces-54831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98691B03BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB5E27A3084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C5244667;
	Mon, 14 Jul 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ap/pMeF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HN9v3Utl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ap/pMeF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HN9v3Utl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B923C8C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488082; cv=none; b=qkuOA/CKaIzoyrHpcvX5vTOZrT5yqQzy484es+bfz5b4/A6MSCeWIINxZBkcGgbbyIrEn7FW8d4ca/a3vUuEP4kQCiiUzMkF4OPKEfaUK6uFLXQZeSfCASPOgS/jj9qD6pD9rwKAAs59vnqyzcwqZ89ZtR3YNsdxg+MmNIobnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488082; c=relaxed/simple;
	bh=bxPCPZkBqygcjQUJ8wCl7ybAhFRpP9YPcYzUs3KI4VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4lrZwy1j5tsLgwoQ4Aqdxds2YQOKKcFp3lBcPklGhXjxzlPq7KRK/h8tCUHtpD1ghioX+cepQc3FCB8qTlohobUmgRtqh/dfuSAyJYm2k6Plqp3HZT/Zta3Gp7Ek+dHA7aOfO4uOpRXfT1o2uWlYmaT8NjfccZbNCLa4UcmOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ap/pMeF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HN9v3Utl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ap/pMeF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HN9v3Utl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 085082123C;
	Mon, 14 Jul 2025 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752488079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21gKFNfrYdVgl2DpNmazOhXhXWUvteXiX68c7Wn1jkk=;
	b=ap/pMeF7jPIptu1igxuOLsLkOCZ/IcC0Jr0NXexYTNPGgCGnyVJVZ0k/vrjUO4AmytP4Qd
	2HtfcFfNQkKtPuwmVBeBLsZDtJGpAoIhJU1TsjbTfWYj7ErWaQvryFh4LFMdYRS5ztaN6G
	d6bpSnP7KpQxzH+bIoxk7c5EKdL2M8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752488079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21gKFNfrYdVgl2DpNmazOhXhXWUvteXiX68c7Wn1jkk=;
	b=HN9v3UtlviZnprco4sJRJ+E6X2AXRFL0Ue4mC9jzu/Wlzpq8cndMr61na38Y8mwzoz/qYL
	Els/jbGJVDlikrCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752488079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21gKFNfrYdVgl2DpNmazOhXhXWUvteXiX68c7Wn1jkk=;
	b=ap/pMeF7jPIptu1igxuOLsLkOCZ/IcC0Jr0NXexYTNPGgCGnyVJVZ0k/vrjUO4AmytP4Qd
	2HtfcFfNQkKtPuwmVBeBLsZDtJGpAoIhJU1TsjbTfWYj7ErWaQvryFh4LFMdYRS5ztaN6G
	d6bpSnP7KpQxzH+bIoxk7c5EKdL2M8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752488079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21gKFNfrYdVgl2DpNmazOhXhXWUvteXiX68c7Wn1jkk=;
	b=HN9v3UtlviZnprco4sJRJ+E6X2AXRFL0Ue4mC9jzu/Wlzpq8cndMr61na38Y8mwzoz/qYL
	Els/jbGJVDlikrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2C2913306;
	Mon, 14 Jul 2025 10:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkA8O47YdGjkTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Jul 2025 10:14:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A055EA0802; Mon, 14 Jul 2025 12:14:38 +0200 (CEST)
Date: Mon, 14 Jul 2025 12:14:38 +0200
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v5 1/6] fs: add a new remove_bdev() callback
Message-ID: <cshm6g2qr4r5tmkrcitdvlwz3bdf2yo4a3opd57ndjcgabq3hz@w7vvckwuitxq>
References: <cover.1752470276.git.wqu@suse.com>
 <09909fcff7f2763cc037fec97ac2482bdc0a12cb.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09909fcff7f2763cc037fec97ac2482bdc0a12cb.1752470276.git.wqu@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 14-07-25 14:55:57, Qu Wenruo wrote:
> Currently all filesystems which implement super_operations::shutdown()
> can not afford losing a device.
> 
> Thus fs_bdev_mark_dead() will just call the ->shutdown() callback for the
> involved filesystem.
> 
> But it will no longer be the case, as multi-device filesystems like
> btrfs and bcachefs can handle certain device loss without the need to
> shutdown the whole filesystem.
> 
> To allow those multi-device filesystems to be integrated to use
> fs_holder_ops:
> 
> - Add a new super_operations::remove_bdev() callback
> 
> - Try ->remove_bdev() callback first inside fs_bdev_mark_dead()
>   If the callback returned 0, meaning the fs can handling the device
						   ^^^ handle

>   loss, then exit without doing anything else.
> 
>   If there is no such callback or the callback returned non-zero value,
>   continue to shutdown the filesystem as usual.
> 
> This means the new remove_bdev() should only do the check on whether the
> operation can continue, and if so do the fs specific handlings.
> The shutdown handling should still be handled by the existing
	       ^^^^ I'd remove this word.

> ->shutdown() callback.
> 
> For all existing filesystems with shutdown callback, there is no change
> to the code nor behavior.
> 
> Btrfs is going to implement both the ->remove_bdev() and ->shutdown()
> callbacks soon.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Besides the spelling fixes looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/super.c         | 11 +++++++++++
>  include/linux/fs.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 80418ca8e215..7f876f32343a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1459,6 +1459,17 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	if (!sb)
>  		return;
>  
> +	if (sb->s_op->remove_bdev) {
> +		int ret;
> +
> +		ret = sb->s_op->remove_bdev(sb, bdev);
> +		if (!ret) {
> +			super_unlock_shared(sb);
> +			return;
> +		}
> +		/* Fallback to shutdown. */
> +	}
> +
>  	if (!surprise)
>  		sync_filesystem(sb);
>  	shrink_dcache_sb(sb);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..6a8a5e63a5d4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2367,6 +2367,15 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	/*
> +	 * If a filesystem can support graceful removal of a device and
> +	 * continue read-write operations, implement this callback.
> +	 *
> +	 * Return 0 if the filesystem can continue read-write.
> +	 * Non-zero return value or no such callback means the fs will be shutdown
> +	 * as usual.
> +	 */
> +	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
>  	void (*shutdown)(struct super_block *sb);
>  };
>  
> -- 
> 2.50.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


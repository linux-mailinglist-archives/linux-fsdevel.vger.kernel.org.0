Return-Path: <linux-fsdevel+bounces-60153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1AB421FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F0E18962F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5230AAC4;
	Wed,  3 Sep 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxxNdZMa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZR76TAP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxxNdZMa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZR76TAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37B3043CD
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906721; cv=none; b=rRLIgPbNL13pre8xvMyNfcSfwXWCqvm0QzMvVLsUlpy5veaxWKwzYJJbr6cNKI5r+ruABOQoMy8MjSx42SL0bo7AreNU++iZN97xcCYmAPibUbDoiNdoLDzWOZJtA6sxHBgtITGHVFNuULAQ6HLgsw4UCLxfHKsauIgzRI7MRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906721; c=relaxed/simple;
	bh=4JIySaL3Mh/8qjNkkDqTu6Mk38+NocPiJ2wIb1wJiYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvww2Vs6e1m3usgIpcwGnKtT1Nf54eBE+v8cRNuxUiXmS5mSjzRU5Y5k4787Hlza06C4BBJ2uqtKSuJe1Uut7mGaeADBCcTfEhzp2X3mcQG9puGffynQ8CJz0pIF5k5wmwlv75FFxeeH5yfhpg9tPecqFhd0sFmbkM9BwFyvWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxxNdZMa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZR76TAP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxxNdZMa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZR76TAP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A32A721201;
	Wed,  3 Sep 2025 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756906717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqi0RseEPwrCMkpiKuYXBC3Ujuc7IzFljPiRR8JZxmU=;
	b=zxxNdZMaKA49YmqqaU9z5EVovnG8sKc1rgjFoFgE/dKkMjuuyV60Z2CAVaq+LrfF/2k4hi
	wJ3MM6ci3za+vmrSgjUxnWEBoHXCxvoMmWf7xtsYjtqQHOejOdJAb5kkBwUqcpavfY36VA
	VuUPv9Ds0A3czqMNvR/kuM4RExSIoaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756906717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqi0RseEPwrCMkpiKuYXBC3Ujuc7IzFljPiRR8JZxmU=;
	b=IZR76TAP4YljLZy6Qv+ffriIueGWUiDU+IcFqEhuQfUBarTh6ixMM2/K/VTQlnLIizDE52
	4NSxZvb2O8WZgVBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zxxNdZMa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IZR76TAP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756906717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqi0RseEPwrCMkpiKuYXBC3Ujuc7IzFljPiRR8JZxmU=;
	b=zxxNdZMaKA49YmqqaU9z5EVovnG8sKc1rgjFoFgE/dKkMjuuyV60Z2CAVaq+LrfF/2k4hi
	wJ3MM6ci3za+vmrSgjUxnWEBoHXCxvoMmWf7xtsYjtqQHOejOdJAb5kkBwUqcpavfY36VA
	VuUPv9Ds0A3czqMNvR/kuM4RExSIoaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756906717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqi0RseEPwrCMkpiKuYXBC3Ujuc7IzFljPiRR8JZxmU=;
	b=IZR76TAP4YljLZy6Qv+ffriIueGWUiDU+IcFqEhuQfUBarTh6ixMM2/K/VTQlnLIizDE52
	4NSxZvb2O8WZgVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3180013888;
	Wed,  3 Sep 2025 13:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MI+aCt1EuGjtRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Sep 2025 13:38:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 07357A0809; Wed,  3 Sep 2025 15:38:33 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:38:33 +0200
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH RFC 2/2] iomap: revert the iomap_iter pos on
 ->iomap_end() error
Message-ID: <ggcriup7z23ol3lpyz545hjguv33dxh6vznwpwflsycvxb3ni2@oyydc6xrjtnc>
References: <20250902150755.289469-1-bfoster@redhat.com>
 <20250902150755.289469-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902150755.289469-3-bfoster@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A32A721201
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 02-09-25 11:07:55, Brian Foster wrote:
> An iomap op iteration should not be considered successful if
> ->iomap_end() fails. Most ->iomap_end() callbacks do not return
> errors, and for those that do we return the error to the caller, but
> this is still not sufficient in some corner cases.
> 
> For example, if a DAX write to a shared iomap fails at ->iomap_end()
> on XFS, this means the remap of shared blocks from the COW fork to
> the data fork has possibly failed. In turn this means that just
> written data may not be accessible in the file. dax_iomap_rw()
> returns partial success over a returned error code and the operation
> has already advanced iter.pos by the time ->iomap_end() is called.
> This means that dax_iomap_rw() can return more bytes processed than
> have been completed successfully, including partial success instead
> of an error code if the first iteration happens to fail.
> 
> To address this problem, first tweak the ->iomap_end() error
> handling logic to run regardless of whether the current iteration
> advanced the iter. Next, revert pos in the error handling path. Add
> a new helper to undo the changes from iomap_iter_advance(). It is
> static to start since the only initial user is in iomap_iter.c.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks sensible to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/iter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 7cc4599b9c9b..69c993fe51fa 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -27,6 +27,22 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
>  	return 0;
>  }
>  
> +/**
> + * iomap_iter_revert - revert the iterator position
> + * @iter: iteration structure
> + * @count: number of bytes to revert
> + *
> + * Revert the iterator position by the specified number of bytes, undoing
> + * the effect of a previous iomap_iter_advance() call. The count must not
> + * exceed the amount previously advanced in the current iter.
> + */
> +static void iomap_iter_revert(struct iomap_iter *iter, u64 count)
> +{
> +	count = min_t(u64, iter->pos - iter->iter_start_pos, count);
> +	iter->pos -= count;
> +	iter->len += count;
> +}
> +
>  static inline void iomap_iter_done(struct iomap_iter *iter)
>  {
>  	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> @@ -80,8 +96,10 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  				iomap_length_trim(iter, iter->iter_start_pos,
>  						  olen),
>  				advanced, iter->flags, &iter->iomap);
> -		if (ret < 0 && !advanced && !iter->status)
> +		if (ret < 0 && !iter->status) {
> +			iomap_iter_revert(iter, advanced);
>  			return ret;
> +		}
>  	}
>  
>  	/* detect old return semantics where this would advance */
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


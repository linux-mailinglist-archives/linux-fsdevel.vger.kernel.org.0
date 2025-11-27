Return-Path: <linux-fsdevel+bounces-70031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0414C8EB00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BC23B104D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D565320CB2;
	Thu, 27 Nov 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D/JQvHXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwSAGEnL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D/JQvHXE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwSAGEnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25667287507
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251811; cv=none; b=Q+1w0M/+QTOtqGSmuHAcMnA6H9HNBXSpWyejqv8S2qlFGINCXrSQrfq/EqSgalKxEbjuWdb3ypWZdbww3S65eDsOuPUAg2HO4Fpy8A0q2K6yt0BbvkvPol+1p+uE83lrEB6pbWkzjr65M5RoIdtOmM6XruD+Ap2LuI8a3t0EMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251811; c=relaxed/simple;
	bh=ZZHiB/OWiLfJothgrkeOgMA+Qm0lCjCCoS4U2E2+cAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcL+th3uPK3lxqoyWEDRNiVarfyFFMWRx+mqYgy9BbdMXQ3/pC1aWX/m+2WCC1xVMEmGWyhBLPUCm2geHLVYvi4AvjQ1Pyuev6EG2Fonk7XsKfG3V80MhK4w95t+UFToH7nPGsHePjbbZ6LaIdO1Z5LmA21un+soPmPJhE/Qc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D/JQvHXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwSAGEnL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D/JQvHXE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwSAGEnL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29CB95BD3D;
	Thu, 27 Nov 2025 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764251808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuXf+TdPQ+S+htUrTSpTlEEOwx8iA2NlWWGvVRONBKg=;
	b=D/JQvHXEcFGuTtdTwfjwDcZUQdF/HViFbx6hFBzW7BVK+XuOkLYIifwEkN07N7RlpT98vQ
	UYyNLvHxchELQr1mgZuyDiJjvD9WFGDTgaK2P7Z+fPDZIEWoCO1mDfSVJndE+yLSGJC4TR
	SxqZ7Rf8cRPDpeWkkpBXEOG1HqT9/8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764251808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuXf+TdPQ+S+htUrTSpTlEEOwx8iA2NlWWGvVRONBKg=;
	b=vwSAGEnLTr4CuQ0YuL73CCt5/neRVRRPbypxczv28YzfrBu3gMxXBTBB3jrEJUi16oV1KK
	WffBK6lX/UekJKAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764251808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuXf+TdPQ+S+htUrTSpTlEEOwx8iA2NlWWGvVRONBKg=;
	b=D/JQvHXEcFGuTtdTwfjwDcZUQdF/HViFbx6hFBzW7BVK+XuOkLYIifwEkN07N7RlpT98vQ
	UYyNLvHxchELQr1mgZuyDiJjvD9WFGDTgaK2P7Z+fPDZIEWoCO1mDfSVJndE+yLSGJC4TR
	SxqZ7Rf8cRPDpeWkkpBXEOG1HqT9/8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764251808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuXf+TdPQ+S+htUrTSpTlEEOwx8iA2NlWWGvVRONBKg=;
	b=vwSAGEnLTr4CuQ0YuL73CCt5/neRVRRPbypxczv28YzfrBu3gMxXBTBB3jrEJUi16oV1KK
	WffBK6lX/UekJKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 191FD3EA63;
	Thu, 27 Nov 2025 13:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qwUcBqBYKGlvaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 13:56:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7754EA0C94; Thu, 27 Nov 2025 14:56:47 +0100 (CET)
Date: Thu, 27 Nov 2025 14:56:47 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] dcache: touch up predicts in __d_lookup_rcu()
Message-ID: <45aykcsznrxvbb2pvd5g65dakrz6gtzlab6zlzidssmmemgxbz@2w7qgdpgh6ac>
References: <20251127131526.4137768-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127131526.4137768-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]

On Thu 27-11-25 14:15:26, Mateusz Guzik wrote:
> Rationale is that if the parent dentry is the same and the length is the
> same, then you have to be unlucky for the name to not match.
> 
> At the same time the dentry was literally just found on the hash, so you
> have to be even more unlucky to determine it is unhashed.
> 
> While here add commentary while d_unhashed() is necessary. It was
> already removed once and brought back in:
> 2e321806b681b192 ("Revert "vfs: remove unnecessary d_unhashed() check from __d_lookup_rcu"")
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> - move and precit on d_unhashed as well
> - add commentary on it
> 
> this obsoletes https://lore.kernel.org/linux-fsdevel/20251127122412.4131818-1-mjguzik@gmail.com/T/#u
> 
>  fs/dcache.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 23d1752c29e6..dc2fff4811d1 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2342,11 +2342,20 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
>  		seq = raw_seqcount_begin(&dentry->d_seq);
>  		if (dentry->d_parent != parent)
>  			continue;
> -		if (d_unhashed(dentry))
> -			continue;
>  		if (dentry->d_name.hash_len != hashlen)
>  			continue;
> -		if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
> +		if (unlikely(dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0))
> +			continue;
> +		/*
> +		 * Check for the dentry being unhashed.
> +		 *
> +		 * As tempting as it is, we *can't* skip it because of a race window
> +		 * between us finding the dentry before it gets unhashed and loading
> +		 * the sequence counter after unhashing is finished.
> +		 *
> +		 * We can at least predict on it.
> +		 */
> +		if (unlikely(d_unhashed(dentry)))
>  			continue;
>  		*seqp = seq;
>  		return dentry;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


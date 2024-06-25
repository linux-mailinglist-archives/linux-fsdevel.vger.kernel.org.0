Return-Path: <linux-fsdevel+bounces-22336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53089166A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130521C22EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA414C58A;
	Tue, 25 Jun 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="edHRB77Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIF2rEDA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="edHRB77Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIF2rEDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2A149DF4;
	Tue, 25 Jun 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316490; cv=none; b=BBCx6BkmuIVB9lWvI3Dakb3lOilQ5qyDxj7sc5V0bIYH2xFxeXzUEzXRRzJ/ODPMqje0OwXJF4pr5UjXFOOkwg7cba/TLCcVvY3MNKMtxjjKqHa/9bUINroYBu7Ymez3sAlZFt3cE88laOIyllGuV4qTXoe8p9umBaItNVoe4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316490; c=relaxed/simple;
	bh=PJ7ErXWG500saiAxVcKKjlwKKVYdVfoy1Ml+rQGLJQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0qHsNZr3fGgkJlsO3WwnyOtjxCL8ymHYDTWyLXr9xTnCNisIy6rmDL/AlT/bAppjppYFKk56YkGuYHjx2T45lP1j23cV87h3sRNv28ThZ4Kn/7WWykc3YgkzDEMfPYENLazqhZ1YC6g2xWSh9Stc4Mvp9sxwvjNpm9MD/EsL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=edHRB77Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIF2rEDA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=edHRB77Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIF2rEDA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB1A21A62;
	Tue, 25 Jun 2024 11:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719316487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOBP0/BgNiXJStCQytdDfMso+Ko+QG94c4ckyvD1P74=;
	b=edHRB77Z+ojnXoKkCZz2zHEplzVQfBL6t7VpXlP4PFo7dRBkZ12S/B3pSe1tQVCJA9C0eN
	hb697MfuwGpKw2ugk2FkIkVuAZ9MpFELBjo3gRjKt95JAIM4v4ktORyHlM/XN+Poao6Ofo
	LmHPSyv2HkhT/1gYeUkfxp8j15NU3k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719316487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOBP0/BgNiXJStCQytdDfMso+Ko+QG94c4ckyvD1P74=;
	b=qIF2rEDAFMZsmF4NGa63rtch6yoi2HoDylwniyiNFG3vYvQwTpbrI/Hs7wL3h4+Vq9D1rK
	VZ43cNCEy3V8YFAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=edHRB77Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qIF2rEDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719316487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOBP0/BgNiXJStCQytdDfMso+Ko+QG94c4ckyvD1P74=;
	b=edHRB77Z+ojnXoKkCZz2zHEplzVQfBL6t7VpXlP4PFo7dRBkZ12S/B3pSe1tQVCJA9C0eN
	hb697MfuwGpKw2ugk2FkIkVuAZ9MpFELBjo3gRjKt95JAIM4v4ktORyHlM/XN+Poao6Ofo
	LmHPSyv2HkhT/1gYeUkfxp8j15NU3k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719316487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOBP0/BgNiXJStCQytdDfMso+Ko+QG94c4ckyvD1P74=;
	b=qIF2rEDAFMZsmF4NGa63rtch6yoi2HoDylwniyiNFG3vYvQwTpbrI/Hs7wL3h4+Vq9D1rK
	VZ43cNCEy3V8YFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01AD413A9A;
	Tue, 25 Jun 2024 11:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EyVnAAewemaleAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 11:54:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABFB6A087B; Tue, 25 Jun 2024 13:54:42 +0200 (CEST)
Date: Tue, 25 Jun 2024 13:54:42 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 2/3] fs/file.c: conditionally clear full_fds
Message-ID: <20240625115442.kkrqy6yvy6qpct4y@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-3-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622154904.3774273-3-yu.ma@intel.com>
X-Rspamd-Queue-Id: 0DB1A21A62
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat 22-06-24 11:49:03, Yu Ma wrote:
> 64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
> likely that a bit in full_fds_bits has been cleared before in
> __clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
> clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
> ("vfs: conditionally clear close-on-exec flag") for a similar optimization.
> Together with patch 1, they improves pts/blogbench-1.1.0 read for 27%, and write
> for 14% on Intel ICX 160 cores configuration with v6.10-rc4.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 50e900a47107..b4d25f6d4c19 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -268,7 +268,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
>  static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
>  {
>  	__clear_bit(fd, fdt->open_fds);
> -	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
> +	fd /= BITS_PER_LONG;
> +	if (test_bit(fd, fdt->full_fds_bits))
> +	    __clear_bit(fd, fdt->full_fds_bits);
>  }
>  
>  static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


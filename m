Return-Path: <linux-fsdevel+bounces-27581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB1962897
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EC81C20D8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79B187859;
	Wed, 28 Aug 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gGFZAlaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uyOpuk+j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gGFZAlaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uyOpuk+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A616BE30;
	Wed, 28 Aug 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851609; cv=none; b=om+yRYy6Jdc/MNpJbvTWu/XRHWpZOj+pbav7jZUVdP4V3eT4acElBdjyNzil6dK4IifPCt23+ZJJ2Q3jNCOzDW55J6yXFDF7ZCtqcHazPN4OHTcy3ZYnPTMTiTpIBFLUa/eevSK4turgiSJXO6PtwtaB+7rxLXxp0YlGuqRLB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851609; c=relaxed/simple;
	bh=7BbU5dLovWDFORgSLFgRyj4fzAjLCu/oXgappiGEN7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiozCog0REfwoizK6dSWdYmU1gNC8yDLnu9boayivQWvKBDaEVh6DxZCT+3sdmvJm8ozMjTSyT3RrYTq1dqa9+WIaqKA3CU8SHsnKWQr0Myf/kJLKCZXvUVQ1rHzBotRAFLT/qglPrBdSweJG2jjtnUm+1y2cOwS92eJ8ynTf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gGFZAlaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uyOpuk+j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gGFZAlaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uyOpuk+j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 589331FBBF;
	Wed, 28 Aug 2024 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724851605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyUIc0iZ+ZifEEA8zobhhlH2+HprB79+jaE7STT3510=;
	b=gGFZAlaIfmh4x7eegJ3pSAbPn1at4ndXZyXRO1e46NXX1Wsl2zHBv0eSak+JHJyaqRw/CX
	0RV27RwFNhem2n/lDWNa1RSyvK3QzbkEmz3Yn7k9N8nY0EQK5LznRqX+EmUKY5tCdl2u+T
	0kONASN0lfBTSmYCnKZUW3SfxnGZnbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724851605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyUIc0iZ+ZifEEA8zobhhlH2+HprB79+jaE7STT3510=;
	b=uyOpuk+jgh3b7bSMpIsDhZzaSt5GQHdG87HIN4O2Ra6f7eXPtFFfMLh8iJ10ULdvLfrffv
	61m6HzM5Xsyo/tBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gGFZAlaI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uyOpuk+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724851605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyUIc0iZ+ZifEEA8zobhhlH2+HprB79+jaE7STT3510=;
	b=gGFZAlaIfmh4x7eegJ3pSAbPn1at4ndXZyXRO1e46NXX1Wsl2zHBv0eSak+JHJyaqRw/CX
	0RV27RwFNhem2n/lDWNa1RSyvK3QzbkEmz3Yn7k9N8nY0EQK5LznRqX+EmUKY5tCdl2u+T
	0kONASN0lfBTSmYCnKZUW3SfxnGZnbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724851605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyUIc0iZ+ZifEEA8zobhhlH2+HprB79+jaE7STT3510=;
	b=uyOpuk+jgh3b7bSMpIsDhZzaSt5GQHdG87HIN4O2Ra6f7eXPtFFfMLh8iJ10ULdvLfrffv
	61m6HzM5Xsyo/tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4273D138D2;
	Wed, 28 Aug 2024 13:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O14zEJUlz2a+JgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 13:26:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4B33A0968; Wed, 28 Aug 2024 15:26:40 +0200 (CEST)
Date: Wed, 28 Aug 2024 15:26:40 +0200
From: Jan Kara <jack@suse.cz>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net,
	Bart Van Assche <bvanassche@acm.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240828132640.baglvrg3vkybjkys@quack3>
References: <20240826001624.188581-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826001624.188581-1-gpiccoli@igalia.com>
X-Rspamd-Queue-Id: 589331FBBF
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 25-08-24 21:15:11, Guilherme G. Piccoli wrote:
> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> 
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V4: More improvements in the wording (thanks Jens and Darrick!)
> 
> V3 link: https://lore.kernel.org/r/20240823180635.86163-1-gpiccoli@igalia.com
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..d521d444a35c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -517,6 +517,18 @@
>  			Format: <io>,<irq>,<mode>
>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>  
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability to open a block device for
						    ^^ a mounted block device

Otherwise looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> +			writing, i.e., allow / disallow writes that bypass
> +			the FS. This was implemented as a means to prevent
> +			fuzzers from crashing the kernel by overwriting the
> +			metadata underneath a mounted FS without its awareness.
> +			This also prevents destructive formatting of mounted
> +			filesystems by naive storage tooling that don't use
> +			O_EXCL. Default is Y and can be changed through the
> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> +
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.
>  
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


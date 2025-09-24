Return-Path: <linux-fsdevel+bounces-62581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CF0B9A0C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DAE3A2484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797C30217E;
	Wed, 24 Sep 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7il4ovA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ADFZbxPq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQJ29mvW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VD64gcjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE6218AD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720908; cv=none; b=IdzaCn2R3b7RTzMuzHdKQz/u6htv7PAr6Wxs+lQja3SZqF8tfEbXnZKsPoY1Zphluh29sjeSv0s+cmBcHieyNw17XbmqD2b+8Hi9CFNptSYO9J/q03FRP3tD+zBo4osP/XMDJcn7acaqWPSRguGdj/Nd2iFk1TbZ6RPRN9CCLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720908; c=relaxed/simple;
	bh=aHq8oMJhP9hml0QDEQYjSNYdOQT3xaD0OHm4W+DfttU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRkE7wAfWTDe7ND3DpUxKcYIo9pYAPNFpHjUkgfjIQl4zKF1ij8CYTDGi6qxzMA/fMfLlN8cGguGRaMW88vS8FCfvSyT5ZxCj6lAM4chl8vrGNNogXkbuJ0OvktYsM9YPZ0TXjXe2mmEkETD2yDxNg7awltEqcy9nb6TptUib6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7il4ovA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ADFZbxPq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aQJ29mvW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VD64gcjY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D8325BCE3;
	Wed, 24 Sep 2025 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758720904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsjTbcjdH1SxOxf81CmjWZ5twm8nVmfIdq2YTZynjHw=;
	b=H7il4ovA/k0ZoswbCcJFrnsw9xf9gU7BxtxF1x+LcVJJ2lH//aO1M6ej5QxFhyxS4tW32X
	RTBvtjjuJ3FhoXyEDxCo+Wf+5RIlrz61F6FySfXcymdyfVStl+Dbtr/KQUcwDxwypjmzqU
	TDyAowADjLdOkzBd/R0m+k2FN2XYrEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758720904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsjTbcjdH1SxOxf81CmjWZ5twm8nVmfIdq2YTZynjHw=;
	b=ADFZbxPqrohAE0MQ4J95/wLKPmy66tMzOOM8nXHROCGYwbIctFQf0/5qX5Ro7kg1VLCJzB
	xdmMNeKKuvdCkoDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aQJ29mvW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VD64gcjY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758720903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsjTbcjdH1SxOxf81CmjWZ5twm8nVmfIdq2YTZynjHw=;
	b=aQJ29mvWrSAWi/CIaiD21pRE1evHXu4QCmub2HX8Q2q/CyhqLevjUzvUnHNGoREAgQhpBA
	YWp3lQ4xF5QvZuq7xKfB8tgnnM18zlpfE+yfDH7vZD/NLSI0eV7+tKcSYYw0tt/nPnCf6i
	pKMTxoDJuhilMPLA8mGtnZJZfJYYNNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758720903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsjTbcjdH1SxOxf81CmjWZ5twm8nVmfIdq2YTZynjHw=;
	b=VD64gcjYXEqK0oYDsIeiRD7VGRZhevYcEAoBdDuxIlszy+UiuYiDnLO8pP2+uwdSt4pZXt
	W4glGhKRo40FnXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CCCA13A61;
	Wed, 24 Sep 2025 13:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id abCLGofz02gSbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 13:35:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C206A2A9E; Wed, 24 Sep 2025 15:35:02 +0200 (CEST)
Date: Wed, 24 Sep 2025 15:35:02 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Replace simple_strtol with kstrtoint to improve
 ramdisk_start_setup
Message-ID: <c57sgqgrx5kxigr6kweh5skxxfxflno2grfv2qeg4rhgv6w3ha@h5zgwfbg7rpv>
References: <20250918162447.331695-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918162447.331695-1-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8D8325BCE3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 18-09-25 18:24:47, Thorsten Blum wrote:
> Replace simple_strtol() with the recommended kstrtoint() for parsing the
> 'ramdisk_start=' boot parameter. Unlike simple_strtol(), which returns a
> a long, kstrtoint() converts the string directly to an integer and
> avoids implicit casting.
> 
> Check the return value of kstrtoint() and reject invalid values. This
> adds error handling while preserving existing behavior for valid values,
> and removes use of the deprecated simple_strtol() helper.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  init/do_mounts_rd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa..79d5375ad712 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -28,8 +28,7 @@ int __initdata rd_image_start;		/* starting block # of image */
>  
>  static int __init ramdisk_start_setup(char *str)
>  {
> -	rd_image_start = simple_strtol(str,NULL,0);
> -	return 1;
> +	return kstrtoint(str, 0, &rd_image_start) == 0;
>  }
>  __setup("ramdisk_start=", ramdisk_start_setup);
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


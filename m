Return-Path: <linux-fsdevel+bounces-24086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4139392A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9B91F2158B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC316EBEA;
	Mon, 22 Jul 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YuLshQKy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ES3zeIgF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YuLshQKy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ES3zeIgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6C16EB7C;
	Mon, 22 Jul 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666266; cv=none; b=roxgkslgOKGuFM1xbFSdmlK7NHV50CN2A4pgcA6y396+j+QZeeWVrc3GGe8jXq4dZ+S0/Ayo6MlSIwBdVTurVoo+yH8cAlGIq+eMHVtlkHoR7RXCcRIc/N1xpYTBcIZtjFCpx9iOKf3A/lmAQMva3uWn+R1FAIjtinPJFQ/TfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666266; c=relaxed/simple;
	bh=zMJJCnis1Uq0BYRZKiBmLhe9OCX+ANKrKj/5upTlcT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbfQkG2v3EaJVl/fCL+STyMK+WkwkJ8bh6UINUHPHNKOMQ2Va71wbB+6jQzOJXJ7igZkIuv5g861qwaEuEY6+RCuNpU6FXTIkMGJLRzfzc3kNvtbE8vGSzTclRrBS9bEPqOTvvSBovl34pXa1SSRZet5mr5zu/qKad9JMK3Fk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YuLshQKy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ES3zeIgF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YuLshQKy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ES3zeIgF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FBFD1F889;
	Mon, 22 Jul 2024 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721666262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN/CUoY5IR9jUefIrJ0Rg5RXTiKLyTOlYaJplowL7rw=;
	b=YuLshQKyOKLrk9v5NsF/drfQIb97OnM3J5SSCygrq5hpt5UNOBqcLXrysukfAPBc8cD/r9
	Iz3vcx/Wh7tRUjNIwFKkBe49td8T4rvKLObjS8YHcPOTDIVCvlz1Lk1fRM77FzsL4w9isb
	bH0sb3H1m65eI0P7JSZzk6vPWOjUAoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721666262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN/CUoY5IR9jUefIrJ0Rg5RXTiKLyTOlYaJplowL7rw=;
	b=ES3zeIgF9mQXmZO6Hx1Xr5ufmoRFPOovvntVPnJi/kN6dXBjeQfWmVmLxGqzS/JVGeCwdk
	2e7TOgc7a3g9arDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721666262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN/CUoY5IR9jUefIrJ0Rg5RXTiKLyTOlYaJplowL7rw=;
	b=YuLshQKyOKLrk9v5NsF/drfQIb97OnM3J5SSCygrq5hpt5UNOBqcLXrysukfAPBc8cD/r9
	Iz3vcx/Wh7tRUjNIwFKkBe49td8T4rvKLObjS8YHcPOTDIVCvlz1Lk1fRM77FzsL4w9isb
	bH0sb3H1m65eI0P7JSZzk6vPWOjUAoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721666262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN/CUoY5IR9jUefIrJ0Rg5RXTiKLyTOlYaJplowL7rw=;
	b=ES3zeIgF9mQXmZO6Hx1Xr5ufmoRFPOovvntVPnJi/kN6dXBjeQfWmVmLxGqzS/JVGeCwdk
	2e7TOgc7a3g9arDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42F8F136A9;
	Mon, 22 Jul 2024 16:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c0W5D9aKnmbpcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jul 2024 16:37:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5790A08BD; Mon, 22 Jul 2024 18:37:41 +0200 (CEST)
Date: Mon, 22 Jul 2024 18:37:41 +0200
From: Jan Kara <jack@suse.cz>
To: 47 Mohit Pawar <mohitpawar@mitaoe.ac.in>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Fixed: fs: file_table_c: Missing blank line warnings
Message-ID: <20240722163741.us3r3v5pe2d76azk@quack3>
References: <20240713180612.126523-1-mohitpawar@mitaoe.ac.in>
 <CAO-FDEOhDSxOw8jyxtdqhJP8-wz8QP+Veo0yGehXTM9F=4bsnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-FDEOhDSxOw8jyxtdqhJP8-wz8QP+Veo0yGehXTM9F=4bsnA@mail.gmail.com>
X-Spam-Score: -0.60
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Level: 

On Mon 15-07-24 09:26:29, 47 Mohit Pawar wrote:
> From: Mohit0404 <mohitpawar@mitaoe.ac.in>
> 
> Fixed-
>         WARNING: Missing a blank line after declarations
>         WARNING: Missing a blank line after declarations

The patch is missing your Signed-off-by tag. Please add it. Also I'm not
sure how Christian sees these pure whitespace cleanups but in this case it
is probably at least a readability win so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 4f03beed4737..9950293535e4 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
>         register_sysctl_init("fs", fs_stat_sysctls);
>         if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
>                 struct ctl_table_header *hdr;
> +
>                 hdr = register_sysctl_mount_point("fs/binfmt_misc");
>                 kmemleak_not_leak(hdr);
>         }
> @@ -384,6 +385,7 @@ struct file *alloc_file_clone(struct file *base, int
> flags,
>                                 const struct file_operations *fops)
>  {
>         struct file *f = alloc_file(&base->f_path, flags, fops);
> +
>         if (!IS_ERR(f)) {
>                 path_get(&f->f_path);
>                 f->f_mapping = base->f_mapping;
> 
> --
> 2.34.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


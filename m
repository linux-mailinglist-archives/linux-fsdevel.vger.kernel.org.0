Return-Path: <linux-fsdevel+bounces-24431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D593F477
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D011C21F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFFC14658D;
	Mon, 29 Jul 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ch5gCmXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yH1hbNV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r9/A1NFm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtZdSplE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BC13AA26;
	Mon, 29 Jul 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253811; cv=none; b=ODlUk8swkcAibeYxWRCjGJieusODCD5QZPe3owYzN5r4IRWkQmjjRAI4F8PMKF0ckk9mHdwW3ln/yB+JX721UYAdIe9d6Q83jeRF0bSMHDpxPSjm4wWbNAkvTUAQK222Y1zWXU4nFjiI5yfZVLFSSgOnrniPjfcYGlJjy53YYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253811; c=relaxed/simple;
	bh=vflESx+RwYGCXjHJ/F0x2Q74Zpg0GCpO+YVUkEqPyR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFZew7xndz8vE4R2rkVZMMoiYSUuu2S2X0smCeXtaeLoxg45xwDx3OFeAtO35bYVMXNOr2riZM0ScM3mB7wHtm/JnWRzA2RrEibUM6sXtavi/8i0LWbf6/Od5PKIv/KA4BTO4iN4YSVRlS1iABB+EFTcIfzoA82lvXRxFMxWyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ch5gCmXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yH1hbNV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r9/A1NFm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtZdSplE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D56061F790;
	Mon, 29 Jul 2024 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722253808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2SpeZCMfnPe28cYGli29hQINLIW7jIo2yLrFjcKqEc=;
	b=Ch5gCmXp0sbzN35nOicOEmYbvv34FcULDnzDOTecWXEDES/PLUQ7xeW/XyxbL6q3if05NV
	i8iXZZi03eGOViMr9XbtoJkbIruJ8NpWB/bCzbWIPKfLraRd2WKL8kRTsrJYRCzWI2GwvB
	WR97aW/w63+2iywb0VPXZdl07nFadsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722253808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2SpeZCMfnPe28cYGli29hQINLIW7jIo2yLrFjcKqEc=;
	b=0yH1hbNVAt8kRN9pmVweEW57WmZwugAhbMHhs6EUQ2pl/rWHU6zOrCQ9T6387OzF/HYbnq
	WHzyhmfd13W4yHAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722253807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2SpeZCMfnPe28cYGli29hQINLIW7jIo2yLrFjcKqEc=;
	b=r9/A1NFmlMo3dikoSExETh5Y/c4rWqqmcTOYaulMGBqYRs2Wm6MIJ3Eo7dN3X97XgUSL//
	vca0/Z5vZu1qc8RzTd9WlergLZ/4RNKIIH8E0STj+3c2n1hXuxi+kTaTC2CLtp/KP4mdcl
	YyvgtBNlI+gBPS8yAPATRuQt4nPXOkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722253807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2SpeZCMfnPe28cYGli29hQINLIW7jIo2yLrFjcKqEc=;
	b=RtZdSplEKwVNV3/TwPuwufG9GvNTqujlgLJmhr7YP8xmk42J6iUlPAbezuS0NpJwtP3LFH
	nzGR2+0qp5u+WLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA89F1368A;
	Mon, 29 Jul 2024 11:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CqRyMe+Bp2azNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jul 2024 11:50:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7B265A099C; Mon, 29 Jul 2024 13:49:59 +0200 (CEST)
Date: Mon, 29 Jul 2024 13:49:59 +0200
From: Jan Kara <jack@suse.cz>
To: mohitpawar@mitaoe.ac.in
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed: fs: file_table_c: Missing blank line warnings and
 struct declaration improved
Message-ID: <20240729114959.lxhpjhve7lhpf2jm@quack3>
References: <linux-fsdevel@vger.kernel.org>
 <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
 <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Sat 27-07-24 12:51:34, mohitpawar@mitaoe.ac.in wrote:
> From: Mohit0404 <mohitpawar@mitaoe.ac.in>
> 
> Fixed-
> 	WARNING: Missing a blank line after declarations
> 	WARNING: Missing a blank line after declarations
> 	Declaration format: improved struct file declaration format
> 
> Signed-off-by: Mohit0404 <mohitpawar@mitaoe.ac.in>
> ---
>  fs/file_table.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ca7843dde56d..306d57623447 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
>  	register_sysctl_init("fs", fs_stat_sysctls);
>  	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
>  		struct ctl_table_header *hdr;
> +
>  		hdr = register_sysctl_mount_point("fs/binfmt_misc");
>  		kmemleak_not_leak(hdr);
>  	}
> @@ -383,7 +384,10 @@ EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
>  struct file *alloc_file_clone(struct file *base, int flags,
>  				const struct file_operations *fops)
>  {
> -	struct file *f = alloc_file(&base->f_path, flags, fops);
> +	struct file *f;
> +
> +	f = alloc_file(&base->f_path, flags, fops);
> +

When you separated the function call from the declaration of 'f' this empty
line is superfluous. Maybe Christian can fix it up in his tree (or maybe he
already did). Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


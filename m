Return-Path: <linux-fsdevel+bounces-30240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A99882D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C7B282ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291B188CBC;
	Fri, 27 Sep 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQEUiJAv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZuLmhuNe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQEUiJAv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZuLmhuNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4ED176231
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434509; cv=none; b=kkEBP7b0/ODF9O0WREO9ReodTVUEnPV9yPONP8Giefo4jQL+4Cmsx2PTv9kOhGn2HQ8uVubDQV6qDcK2O6LSH+YvosvKUfSs0a/9o70B1oHfDxyt9K2AAIJo34B9LT3ULIFmBj5n690TFEU4SkgjW25ZHkjL5bHGWJ1pnRDj3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434509; c=relaxed/simple;
	bh=ZyfQw22KgB/ibIzMZPRihKlywrVSMxqUczhzmV/pMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrPSCKW5wL73ilcXugUoyuR9z0WaDYNVy7XHylkaesT+vCjyppo61+0QVfgAoBzE5CUHq6lu5RGKEJtgcgZP7DF9SLljlXGFBMZgm2EqdPx5j3CBQ6Q//aLf3Ul9JjF+YnSMhJPzxJmYDf77zyZaNFRy+eJ4eIrYqHMxp/UvoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQEUiJAv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZuLmhuNe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQEUiJAv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZuLmhuNe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF75A21BB9;
	Fri, 27 Sep 2024 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727434505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEAp0yGU5MKDzteEdQw185GrFZqs8mc/7Grx4/FS4cM=;
	b=sQEUiJAvAHIWqhS/fn2tgT5Ku0k05/uLL6+MYx2uZsAnPbOtYClNgmu2AYgcMFRI2CGFZA
	Q3CYKra0N7APCIm3txBsphi2ALy9im69RpL+y7nqYPjaOc6e/OcZSxO4glk0xZws47sx7s
	IJ51MVFpv0PhVy60fGZPUL/UKlrKoM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727434505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEAp0yGU5MKDzteEdQw185GrFZqs8mc/7Grx4/FS4cM=;
	b=ZuLmhuNeHqUkvL7lNTzNb3RpTtNPfZ7/R9LKuorH9PHlyBW1Lm87usx4Bp7hPKvi+NrcmE
	dUezeoDyemkL3yAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sQEUiJAv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZuLmhuNe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727434505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEAp0yGU5MKDzteEdQw185GrFZqs8mc/7Grx4/FS4cM=;
	b=sQEUiJAvAHIWqhS/fn2tgT5Ku0k05/uLL6+MYx2uZsAnPbOtYClNgmu2AYgcMFRI2CGFZA
	Q3CYKra0N7APCIm3txBsphi2ALy9im69RpL+y7nqYPjaOc6e/OcZSxO4glk0xZws47sx7s
	IJ51MVFpv0PhVy60fGZPUL/UKlrKoM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727434505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEAp0yGU5MKDzteEdQw185GrFZqs8mc/7Grx4/FS4cM=;
	b=ZuLmhuNeHqUkvL7lNTzNb3RpTtNPfZ7/R9LKuorH9PHlyBW1Lm87usx4Bp7hPKvi+NrcmE
	dUezeoDyemkL3yAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A00761386E;
	Fri, 27 Sep 2024 10:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eZTCJgmP9mYTYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 10:55:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5381CA0826; Fri, 27 Sep 2024 12:55:05 +0200 (CEST)
Date: Fri, 27 Sep 2024 12:55:05 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH v2] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
Message-ID: <20240927105505.mfg7h5pybtd7km3y@quack3>
References: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: AF75A21BB9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 27-09-24 14:53:25, Julian Sun wrote:
> Keep the errno value consistent with the equivalent check in
> generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> more appropriate value to return compared to the overly generic -EINVAL.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/remap_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 6fdeb3c8cb70..1333f67530c0 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -47,7 +47,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	/* Ensure offsets don't wrap. */
>  	if (check_add_overflow(pos_in, count, &tmp) ||
>  	    check_add_overflow(pos_out, count, &tmp))
> -		return -EINVAL;
> +		return -EOVERFLOW;
>  
>  	size_in = i_size_read(inode_in);
>  	size_out = i_size_read(inode_out);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


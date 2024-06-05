Return-Path: <linux-fsdevel+bounces-21024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4948FC6A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32491C2303B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1E1946DB;
	Wed,  5 Jun 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="078Tre/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qyr1ndeB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="078Tre/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qyr1ndeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0204A11;
	Wed,  5 Jun 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576558; cv=none; b=eqLsFOKtQaSdG9hezwISmhdb1JlRBZNfHQPxPFdHDp/Gs/cwcMg6v3liVilDRCTA4wm0nwl9uaLpuH8FfpCeUdAKeIduhIA1LdBl57kegGNIpov0q7qroJHAD6grHhmexo3AyztIIopA79+DtdWWLHzTH6W1HLnFIbG7M3Dv5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576558; c=relaxed/simple;
	bh=0pQwQGLnrRqi4ZpBNPD2igxT3WIUyBTq3rTM8UuY7RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5ZOpKdTsbRi6z79p4BV5XH6EV9MdExbTkoJJGPoMNoD9nY8NBo22YEQ8pguKtgqgpSyGgkx264RbbRsWe5IG9Y/Ko05oyM5reF2jzAe6QDvmHT5YLnc37I7XQ9Nwmk918azg7PLG6sODlIr4+APmX2mi7M8V17gsZDfAdplUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=078Tre/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qyr1ndeB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=078Tre/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qyr1ndeB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C66BD216E7;
	Wed,  5 Jun 2024 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717576554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TvQX13j+85jesRrC3K1xLONdQ11oVJErvF9uxA3O1Y=;
	b=078Tre/sA2OhOBOLlEMXVPuYaENCubf1dCLtUCbjBN4ywIwTwHZW8F1VVNqQsJc0Hug+fy
	PCmNyBQBeVSNJTZum0Wbw45/lr+lMbgTlb91aq+MP8/ZbvEGUssVvz2bnHPpbFtjR22Nke
	D8Q/Tr15zQoh0iLZAh9E555bX/0GJOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717576554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TvQX13j+85jesRrC3K1xLONdQ11oVJErvF9uxA3O1Y=;
	b=Qyr1ndeBV9QyZPAEvBUZMsd7aIkIqU+bdUrz/EkLswNEsg7VDvGXlxRERtWKiC1lIPEwXl
	S3sNGPamVEJO+OAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="078Tre/s";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qyr1ndeB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717576554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TvQX13j+85jesRrC3K1xLONdQ11oVJErvF9uxA3O1Y=;
	b=078Tre/sA2OhOBOLlEMXVPuYaENCubf1dCLtUCbjBN4ywIwTwHZW8F1VVNqQsJc0Hug+fy
	PCmNyBQBeVSNJTZum0Wbw45/lr+lMbgTlb91aq+MP8/ZbvEGUssVvz2bnHPpbFtjR22Nke
	D8Q/Tr15zQoh0iLZAh9E555bX/0GJOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717576554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TvQX13j+85jesRrC3K1xLONdQ11oVJErvF9uxA3O1Y=;
	b=Qyr1ndeBV9QyZPAEvBUZMsd7aIkIqU+bdUrz/EkLswNEsg7VDvGXlxRERtWKiC1lIPEwXl
	S3sNGPamVEJO+OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC14213AA1;
	Wed,  5 Jun 2024 08:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BbfqLWojYGZmOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 08:35:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BB97A088A; Wed,  5 Jun 2024 10:35:50 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:35:50 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] isofs: add missing MODULE_DESCRIPTION()
Message-ID: <20240605083550.th47cyxnrp3vawja@quack3>
References: <20240526-md-fs-isofs-v1-1-60e2e36a3d46@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526-md-fs-isofs-v1-1-60e2e36a3d46@quicinc.com>
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C66BD216E7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,quicinc.com:email,suse.com:email,suse.cz:dkim]

On Sun 26-05-24 12:05:23, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/isofs/isofs.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/isofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 93b1077a380a..2bb8b422f434 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1625,4 +1625,5 @@ static void __exit exit_iso9660_fs(void)
>  
>  module_init(init_iso9660_fs)
>  module_exit(exit_iso9660_fs)
> +MODULE_DESCRIPTION("ISO 9660 CDROM file system support");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 416ff45264d50a983c3c0b99f0da6ee59f9acd68
> change-id: 20240526-md-fs-isofs-4f66f48f9448
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


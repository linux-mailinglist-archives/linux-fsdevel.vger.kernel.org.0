Return-Path: <linux-fsdevel+bounces-27532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC596235D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0991C216E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D616088F;
	Wed, 28 Aug 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAVUYfuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SiHkstRf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAVUYfuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SiHkstRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74E1607B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837345; cv=none; b=sRivouUQ1fekbdfCPF44MTqLu0J6tdCEXF1l6TZXk+MCCIRlZrlqlNSdzwgY1AfCJ2/FzX4PPJaZ//kMX1BzMDcoQwyZ+7daUE8oBHEm1otZSLNdi/84koWpF1Ai7RhWbXVSSYRfoGbwYDkRMGC6shJ8iQ60KUvZ23kxHalKNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837345; c=relaxed/simple;
	bh=hzErxGP7Sq8mXDNrDSzb6/CcMd+Rl//5OW6/03cDBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ6Frx9WOtEYJS/FiZUu0P/Sw9QxGHHw/F+FApzXNoyyJDAwG5hsFPmgpns1Zuud9mr3wRngODrYm8MNqFL/FzZ77EC6Z7MrwA+UEFyZ+naFBdv1ai4GxsUV+KnfXAd5SMKodTLRcnEJfV2OEHfKjvzfv1vua2kkVzDy01Suj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAVUYfuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SiHkstRf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAVUYfuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SiHkstRf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46CAC1FBED;
	Wed, 28 Aug 2024 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724837341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rw74xpNFJ52VzvdxjNqCm/GTQqm0JttK8nmWlSqcd3M=;
	b=eAVUYfufwhyvVbNPioRTlNXowNiylINL55+d5jvoX+Ya0Uaoo2euiR/aOySUiUFWAZkGxz
	6zTlpIE1ywwJfR4Eo2/kpjrqUOHZtZjtrv99O+kc28VYh26ts7s3339vUmpFfLK8Goyq0D
	+t8XuDJh4K+b1rIIij0ZyUKpo118U54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724837341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rw74xpNFJ52VzvdxjNqCm/GTQqm0JttK8nmWlSqcd3M=;
	b=SiHkstRfg0H/HcEOKm9DC7ErBntpEGxVdyfD4cGiPSUDdoqPmoABjLp4JbTjGUtCF1wTQW
	Paj0+4mF1/zYQxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724837341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rw74xpNFJ52VzvdxjNqCm/GTQqm0JttK8nmWlSqcd3M=;
	b=eAVUYfufwhyvVbNPioRTlNXowNiylINL55+d5jvoX+Ya0Uaoo2euiR/aOySUiUFWAZkGxz
	6zTlpIE1ywwJfR4Eo2/kpjrqUOHZtZjtrv99O+kc28VYh26ts7s3339vUmpFfLK8Goyq0D
	+t8XuDJh4K+b1rIIij0ZyUKpo118U54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724837341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rw74xpNFJ52VzvdxjNqCm/GTQqm0JttK8nmWlSqcd3M=;
	b=SiHkstRfg0H/HcEOKm9DC7ErBntpEGxVdyfD4cGiPSUDdoqPmoABjLp4JbTjGUtCF1wTQW
	Paj0+4mF1/zYQxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C3871398F;
	Wed, 28 Aug 2024 09:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mj7KDt3tzmZ9VgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 09:29:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9A34A0968; Wed, 28 Aug 2024 11:28:56 +0200 (CEST)
Date: Wed, 28 Aug 2024 11:28:56 +0200
From: Jan Kara <jack@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] fs: use LIST_HEAD() to simplify code
Message-ID: <20240828092856.2gyeootlfcyxwlbo@quack3>
References: <20240821065456.2294216-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821065456.2294216-1-lihongbo22@huawei.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 21-08-24 14:54:56, Hongbo Li wrote:
> list_head can be initialized automatically with LIST_HEAD()
> instead of calling INIT_LIST_HEAD().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e55ad471c530..31a9062cad7e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -774,12 +774,11 @@ EXPORT_SYMBOL(block_dirty_folio);
>  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
>  {
>  	struct buffer_head *bh;
> -	struct list_head tmp;
>  	struct address_space *mapping;
>  	int err = 0, err2;
>  	struct blk_plug plug;
> +	LIST_HEAD(tmp);
>  
> -	INIT_LIST_HEAD(&tmp);
>  	blk_start_plug(&plug);
>  
>  	spin_lock(lock);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


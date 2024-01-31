Return-Path: <linux-fsdevel+bounces-9638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82423843E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A703E1C27CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B646F067;
	Wed, 31 Jan 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJmBHfiC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbMqUVa4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJmBHfiC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbMqUVa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4922619;
	Wed, 31 Jan 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699932; cv=none; b=qCA6CWG9p89KeluRBZLPEc4WF2lJ0gWN4bfnNU/KJsDJYXbVPwuvG3cxMpeYPgPmKiJmhXSkOUwQ94tRvIcJm59KhsUXRtmi1kEwde+K/4Us1OsuVVMlL1WF5KgZopfKIoL6qMUvUaPuAgqD4PtOaqgdabHmb9hQE9UXO/8ORks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699932; c=relaxed/simple;
	bh=z9HbznpTxs+hCXQiVU7KW8JJixJG05vmA2WmM1tQPp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhbULiljWGGnpanlqZQT/9iJTTa9KvVzHOcZLwqHmmDn1005EjV3ccgvOA/cjVjmy4AxUrWoK+I6mZivcNJRp2C6f4FMWsgctgf84rgMl1FDzmOPohFp845AV7Uj9WYpZuKln1oe9qkmdTN8HZnbgFeWiJ/6q6QPCJwksYBIl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJmBHfiC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbMqUVa4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJmBHfiC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbMqUVa4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FAF3220D8;
	Wed, 31 Jan 2024 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706699928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ZO5rd8ho25EDHOwsCAfpvNPINlx/FEPMDsaLbJtlU=;
	b=PJmBHfiC7xG2mBNl4fVz4ZMxB408aQXuHiTFFzo0JyNZATQI7feB3jddU5o8vkHOioI7Be
	DPBsV3WwCITrcpCLQDj8V9fDRtnhQq40hex2mdBPhKJn8fXJ9bQ4MVVNlAMmnMkZGZAoBp
	vdroEjYzJnXDsfFx392A6jPJ8HDYsZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706699928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ZO5rd8ho25EDHOwsCAfpvNPINlx/FEPMDsaLbJtlU=;
	b=LbMqUVa4p4c3thd9uNPo8J21zMTzrTGzjegRDDs2Q9ihllp+fpVcClz5Zp+DQADRZHSJ3u
	/Agzat4MaI626NAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706699928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ZO5rd8ho25EDHOwsCAfpvNPINlx/FEPMDsaLbJtlU=;
	b=PJmBHfiC7xG2mBNl4fVz4ZMxB408aQXuHiTFFzo0JyNZATQI7feB3jddU5o8vkHOioI7Be
	DPBsV3WwCITrcpCLQDj8V9fDRtnhQq40hex2mdBPhKJn8fXJ9bQ4MVVNlAMmnMkZGZAoBp
	vdroEjYzJnXDsfFx392A6jPJ8HDYsZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706699928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+ZO5rd8ho25EDHOwsCAfpvNPINlx/FEPMDsaLbJtlU=;
	b=LbMqUVa4p4c3thd9uNPo8J21zMTzrTGzjegRDDs2Q9ihllp+fpVcClz5Zp+DQADRZHSJ3u
	/Agzat4MaI626NAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 41134132FA;
	Wed, 31 Jan 2024 11:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JyzUD5gsumXGQAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 11:18:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8398A0809; Wed, 31 Jan 2024 12:18:47 +0100 (CET)
Date: Wed, 31 Jan 2024 12:18:47 +0100
From: Jan Kara <jack@suse.cz>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: miklos@szeredi.hu, amir73il@gmail.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Use KMEM_CACHE instead of kmem_cache_create
Message-ID: <20240131111847.ujdhhab6wdebo6fn@quack3>
References: <20240131070941.135178-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131070941.135178-1-chentao@kylinos.cn>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PJmBHfiC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LbMqUVa4
X-Spamd-Result: default: False [-2.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.86%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4FAF3220D8
X-Spam-Level: 
X-Spam-Score: -2.78
X-Spam-Flag: NO

On Wed 31-01-24 15:09:41, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/backing-file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index a681f38d84d8..740185198db3 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -325,9 +325,7 @@ EXPORT_SYMBOL_GPL(backing_file_mmap);
>  
>  static int __init backing_aio_init(void)
>  {
> -	backing_aio_cachep = kmem_cache_create("backing_aio",
> -					       sizeof(struct backing_aio),
> -					       0, SLAB_HWCACHE_ALIGN, NULL);
> +	backing_aio_cachep = KMEM_CACHE(backing_aio, SLAB_HWCACHE_ALIGN);
>  	if (!backing_aio_cachep)
>  		return -ENOMEM;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


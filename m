Return-Path: <linux-fsdevel+bounces-74826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC1JOcKfcGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:43:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E35499F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35BF0829C73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE76426EB5;
	Wed, 21 Jan 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTx+ZT4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/wZGFPjS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTx+ZT4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/wZGFPjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C2426697
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987655; cv=none; b=eRFQ5cRjwclpivbNEy7P86HeMCZ5UTx++XG0Zf8SK1rc7S3QXRGh4rlQqsWEO29arg5JOD7IEWzG+8POds7nvC2ErpacEMcA8XUomtUlTRrmE6Sf2J/4iIyTE9thwEuh9UiikDPL4kuUtKdWRdWILp/RfsatZ4WJCcpBRWAhf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987655; c=relaxed/simple;
	bh=FLV6OIX8bI4cPpdR3/pOMYqoQcrHK5tfGUPRtMmoVp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD6wFZCTgYXlMwQdHE1eM7fX69uC66NnNP3huzdHH0pPIeGPLgUJgmIzXTR3Xef/mEsZDHGazyrtmYodUnbw0DgMj7G6SbF/LF9wuMv1OMLks4ipcTpAqPHKBJX5xe3k9QyjDekuXli3thEexzUn09BzjOg2tJjB7DUdP/yN46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTx+ZT4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/wZGFPjS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTx+ZT4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/wZGFPjS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F84533689;
	Wed, 21 Jan 2026 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768987651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiKwOMoCRausz+2CUDrvJsACKQl8xSoxw7FMUrFRFqQ=;
	b=zTx+ZT4apUbaxjD9brbHNTXpwn3/5RoDfMDa6/ZH00Ky9Z7eGayLP+zWi2o8E1joY62vtG
	7fcTQHqa9XYdr7VLtuRfT6twKI89mxzxwr0kuuULQhv0Nc/m9BWv45c6k8eRIRbiBi6hJt
	2zkm8qIHjOJTzRmItkZ5rMs3U0OEU5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768987651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiKwOMoCRausz+2CUDrvJsACKQl8xSoxw7FMUrFRFqQ=;
	b=/wZGFPjSpny+p+twG79fGmL/Sv4mVACk1NvdR1YVwjeWW4WpAGxC0ZhpG3CrFffHURnt8n
	4PrhGoe5NoxjB4BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zTx+ZT4a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/wZGFPjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768987651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiKwOMoCRausz+2CUDrvJsACKQl8xSoxw7FMUrFRFqQ=;
	b=zTx+ZT4apUbaxjD9brbHNTXpwn3/5RoDfMDa6/ZH00Ky9Z7eGayLP+zWi2o8E1joY62vtG
	7fcTQHqa9XYdr7VLtuRfT6twKI89mxzxwr0kuuULQhv0Nc/m9BWv45c6k8eRIRbiBi6hJt
	2zkm8qIHjOJTzRmItkZ5rMs3U0OEU5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768987651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiKwOMoCRausz+2CUDrvJsACKQl8xSoxw7FMUrFRFqQ=;
	b=/wZGFPjSpny+p+twG79fGmL/Sv4mVACk1NvdR1YVwjeWW4WpAGxC0ZhpG3CrFffHURnt8n
	4PrhGoe5NoxjB4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94FE73EA63;
	Wed, 21 Jan 2026 09:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XYZWJAOccGkpOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 09:27:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50D9EA09E9; Wed, 21 Jan 2026 10:27:31 +0100 (CET)
Date: Wed, 21 Jan 2026 10:27:31 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pid: reorder fields in pid_namespace to reduce false
 sharing
Message-ID: <cvcwp4bhcragrerbux2kkedoae3stxnil26r43bv4ys2fnl7wj@le2fi3dq3vge>
References: <20260120204820.1497002-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120204820.1497002-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74826-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D0E35499F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 21:48:20, Mateusz Guzik wrote:
> alloc_pid() loads pid_cachep, level and pid_max prior to taking the
> lock.
> 
> It dirties idr and pid_allocated with the lock.
> 
> Some of these fields share the cacheline as is, split them up.
> 
> No change in the size of the struct.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks ok. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> this is independent of other patches
> 
> i got an inconsistent win in terms of throughput rate, but relative
> contention between pidmap lock and the rest went down
> 
>  include/linux/pid_namespace.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 0e7ae12c96d2..b20baaa7e62b 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -27,6 +27,13 @@ struct pid_namespace {
>  	struct idr idr;
>  	struct rcu_head rcu;
>  	unsigned int pid_allocated;
> +#ifdef CONFIG_SYSCTL
> +#if defined(CONFIG_MEMFD_CREATE)
> +	int memfd_noexec_scope;
> +#endif
> +	struct ctl_table_set	set;
> +	struct ctl_table_header *sysctls;
> +#endif
>  	struct task_struct *child_reaper;
>  	struct kmem_cache *pid_cachep;
>  	unsigned int level;
> @@ -40,13 +47,6 @@ struct pid_namespace {
>  	int reboot;	/* group exit code if this pidns was rebooted */
>  	struct ns_common ns;
>  	struct work_struct	work;
> -#ifdef CONFIG_SYSCTL
> -	struct ctl_table_set	set;
> -	struct ctl_table_header *sysctls;
> -#if defined(CONFIG_MEMFD_CREATE)
> -	int memfd_noexec_scope;
> -#endif
> -#endif
>  } __randomize_layout;
>  
>  extern struct pid_namespace init_pid_ns;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


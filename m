Return-Path: <linux-fsdevel+bounces-37730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC11A9F661F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3DF1890CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3851AA1DA;
	Wed, 18 Dec 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1kMHtJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="US1gSQwQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1kMHtJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="US1gSQwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E679199FC5;
	Wed, 18 Dec 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525703; cv=none; b=Zo0Cu55n4J+V+5LBzYLy8zQ3JsaAch3+ytlSalcifRfKRV6b5yDnTi2b4FRHJ2nywHp3jr2YUuoZ6LVyyha7ZqTrNdXjjsSiFxJ+RJI8HxHPSoVWHV42NuAuZNGRrzpgGK8vXcJncG8niGmNJs0AzTYpLps03ZPXxReQ9w3fxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525703; c=relaxed/simple;
	bh=ZEbfjjlEWNZwJUFPktpb4OEGxovy1yFldtWeefbqQ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ORHtg4opmKC7uUlstst2nkIYUKTdpql8T5YJG8cjgLWj8IJ5mrlicEI77tnV2XLYHE2MMxrIlxkTs8t+mIpz7CwT7YGjSuphxzvD4Z354c3sS5gAg6CshVnTtbv2Fyf57rcaBpFpbPkmT2XPGEvI2n9Czyu5aCBUA/Bwm6sKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1kMHtJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=US1gSQwQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1kMHtJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=US1gSQwQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 201E6210F8;
	Wed, 18 Dec 2024 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734525699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hqnptq+HirQ1DDJTxskxC9f1v49wCxaXFL73Rd8Fbs=;
	b=D1kMHtJJpCG8xYuyXSfu4AedD6TSCdgICeZ1rW8dpLWLtsl0z1d7+AB6gcA92eCZXA9Edi
	uHHAuD29uQ5NkO3jhcH1tbwzRVN4ROB0mtYWgmvMOuopFXYEOc9tkCKCmYEMJYwmf//POM
	dmnsl+Ky5ojugv5O9WL4/Afkil5cweU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734525699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hqnptq+HirQ1DDJTxskxC9f1v49wCxaXFL73Rd8Fbs=;
	b=US1gSQwQQTiM2Rr/jcC1/EOF6EGuhYzTV8de0Ed/Umw6OrWVGSV8cl208wTtUP67dEVoa/
	+yQEIVOrrcqcKjDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D1kMHtJJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=US1gSQwQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734525699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hqnptq+HirQ1DDJTxskxC9f1v49wCxaXFL73Rd8Fbs=;
	b=D1kMHtJJpCG8xYuyXSfu4AedD6TSCdgICeZ1rW8dpLWLtsl0z1d7+AB6gcA92eCZXA9Edi
	uHHAuD29uQ5NkO3jhcH1tbwzRVN4ROB0mtYWgmvMOuopFXYEOc9tkCKCmYEMJYwmf//POM
	dmnsl+Ky5ojugv5O9WL4/Afkil5cweU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734525699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hqnptq+HirQ1DDJTxskxC9f1v49wCxaXFL73Rd8Fbs=;
	b=US1gSQwQQTiM2Rr/jcC1/EOF6EGuhYzTV8de0Ed/Umw6OrWVGSV8cl208wTtUP67dEVoa/
	+yQEIVOrrcqcKjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11915137CF;
	Wed, 18 Dec 2024 12:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hCoABAPDYme2AwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 12:41:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B652EA0935; Wed, 18 Dec 2024 13:41:38 +0100 (CET)
Date: Wed, 18 Dec 2024 13:41:38 +0100
From: Jan Kara <jack@suse.cz>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 2/2] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <20241218124138.lxelrc6z6lc6cin5@quack3>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
 <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>
X-Rspamd-Queue-Id: 201E6210F8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 17-12-24 14:29:07, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> fixes underflow value setting risk in vm_table but misses vdso_enabled
> sysctl.
> 
> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> avoid negative value writes but the proc_handler is proc_dointvec and
> not proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> 
> The following command thus works :
> 
> `# echo -1 > /proc/sys/vm/vdso_enabled`
> 
> This patch properly sets the proc_handler to proc_dointvec_minmax.
> 
> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/sysctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48f..6d8a4fceb79aa 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2194,8 +2194,9 @@ static struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(vdso_enabled),
>  #endif
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra1		= SYSCTL_ONE,
>  	},
>  #endif
>  	{
> -- 
> 2.47.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


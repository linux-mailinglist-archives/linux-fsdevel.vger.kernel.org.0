Return-Path: <linux-fsdevel+bounces-16369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E789C72D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB15284141
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FFF13E3EE;
	Mon,  8 Apr 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cg32Qols";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PLkJLud";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cg32Qols";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PLkJLud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C97C1CD21;
	Mon,  8 Apr 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586988; cv=none; b=rT3HWskZsB4h5co9oUtwtiQjsNFC2v5n8BhlVMmAOJRGS612c/T4QGS5ly+xzmeUwac/hhdqmf/NbQCcbgqkzGoj1YH+KXvLG7Yf6LjFQ+QWFK+KcmEcFMemMrhOgo0Mw3VFT3HeQR4GjTYG1kLk+B5+i4ghY/08HRxXAngNHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586988; c=relaxed/simple;
	bh=+cphjScDx/N1LVEGUDOhYmryp/xfMJ5Vvr5hDEuq1D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUnbIADmQ77HBRfSIVsuaIFmPZZCeQAmq4TLCzPya+T6s50G3Pgafzq4BXiYI5e6gYBRv6/C2P0mRagohUex2d9KWXLrv17xCII6Y3hnwLyouFUBVizbVXkSJwP/7VCt97+910XugWVp/bs0tFHT0jJwdAZDpHE1u6kqhOWHWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cg32Qols; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PLkJLud; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cg32Qols; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PLkJLud; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 378D4229CA;
	Mon,  8 Apr 2024 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712586984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLImobEPZznORyc/WCud4eu71GPBDbbHtA/ZDIXEBEU=;
	b=Cg32QolsCFAjD8mTI7jyVbL+nlEtamG5yOH6w9yEvtAWkPMu1mpAC6c5XYGov+3h+ByrWq
	GXe78PL0efcpmDcuX8iCdnECGB+y1fG1qlEv7dzFC8D84TavmxhupMqzFK7ttxr5HygSG+
	bfXPfl/GiuVGxDM8lrJLy5yv7pbtjkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712586984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLImobEPZznORyc/WCud4eu71GPBDbbHtA/ZDIXEBEU=;
	b=1PLkJLudwmhqPbV9ebbqJT4Hpqh+jkJN2lxpOMUHPyc7hJI3NkP/y+MBBKTnL5TAAl3qb6
	riWOndtqNc6Pq5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cg32Qols;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1PLkJLud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712586984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLImobEPZznORyc/WCud4eu71GPBDbbHtA/ZDIXEBEU=;
	b=Cg32QolsCFAjD8mTI7jyVbL+nlEtamG5yOH6w9yEvtAWkPMu1mpAC6c5XYGov+3h+ByrWq
	GXe78PL0efcpmDcuX8iCdnECGB+y1fG1qlEv7dzFC8D84TavmxhupMqzFK7ttxr5HygSG+
	bfXPfl/GiuVGxDM8lrJLy5yv7pbtjkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712586984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLImobEPZznORyc/WCud4eu71GPBDbbHtA/ZDIXEBEU=;
	b=1PLkJLudwmhqPbV9ebbqJT4Hpqh+jkJN2lxpOMUHPyc7hJI3NkP/y+MBBKTnL5TAAl3qb6
	riWOndtqNc6Pq5CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 299381332F;
	Mon,  8 Apr 2024 14:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CzwdCugAFGZzcQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 08 Apr 2024 14:36:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEA97A0814; Mon,  8 Apr 2024 16:36:23 +0200 (CEST)
Date: Mon, 8 Apr 2024 16:36:23 +0200
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
Message-ID: <20240408143623.t4uj4dbewl4hyoar@quack3>
References: <20240408075052.3304511-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408075052.3304511-1-arnd@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 378D4229CA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 08-04-24 09:50:43, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> orangefs_statfs() copies two consecutive fields of the superblock into
> the statfs structure, which triggers a warning from the string fortification
> helpers:
> 
> In file included from fs/orangefs/super.c:8:
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
> 
> Change the memcpy() to an individual assignment of the two fields, which helps
> both the compiler and human readers understand better what it does.
> 
> Link: https://lore.kernel.org/all/20230622101701.3399585-1-arnd@kernel.org/
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: devel@lists.orangefs.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Resending to VFS maintainers, I sent this a couple of times to the
> orangefs maintainers but never got a reply
> ---
>  fs/orangefs/super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index fb4d09c2f531..152478295766 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -201,7 +201,10 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  		     (long)new_op->downcall.resp.statfs.files_avail);
>  
>  	buf->f_type = sb->s_magic;
> -	memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
> +	buf->f_fsid = (__kernel_fsid_t) {{
> +		ORANGEFS_SB(sb)->fs_id,
> +		ORANGEFS_SB(sb)->id,
> +	}};

Frankly, this initializer is hard to understand for me. Why not simple:

	buf->f_fsid[0] = ORANGEFS_SB(sb)->fs_id;
	buf->f_fsid[1] = ORANGEFS_SB(sb)->id;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


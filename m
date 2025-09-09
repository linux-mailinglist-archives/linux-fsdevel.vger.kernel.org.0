Return-Path: <linux-fsdevel+bounces-60658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595CB4AB73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 13:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46157B9177
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C031D72A;
	Tue,  9 Sep 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSZeoAzT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/dMNDg4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VivbzfG5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltmbBXeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5623D28B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416536; cv=none; b=W212TvT0qYktc62sdWmpeUcnjAJl1tX/0P7Qt4+X0vgTSmOrGbiiG4kXxjqCbSmV9OGDbPMJNPwoAEVfY4eAdkyi0icS/k9FImksHpj5isDmU0+SamFiXMqUBvQP970QH5EpyuPniZyWt29Lrc88GUl6D+ttv9RIh2vyCOa8LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416536; c=relaxed/simple;
	bh=O3TEiaw1+7teyVKstejTcLqUilda4KsWONDq9nbX3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek45wh8G+YPdEb8eJkNt5k27OXBzDfCck1l7KSiPuiGOwNZHkpg7tBbNsaK+LrWZysve03O/AWMWn83zsFIZst1ycpzxP9UwA0A6KfYhxBO9kRVScyYv8Ewlf5dsZnDP6K2vYEp2liEiuP126ZblIl0Nvm6dWT2oE89YrFi3NQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSZeoAzT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/dMNDg4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VivbzfG5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltmbBXeY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3BCB3403C;
	Tue,  9 Sep 2025 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757416533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfnkCNemqaFEQ4UzPQm8Dp36KFI130lGgkIksLe8fUA=;
	b=vSZeoAzTFNTWKRCXJRTe9GDLNqOcbo8uhSzOS7lnasMIBvbgPF6n58sO7peITE63MYZUQe
	9ceFbb/uvc9q3XlmRweUOzOw9lTvmUBtk5oPctMtQy7c+fIBUxQvcnr8sbNEQBNrXaZiDR
	YbFTqT7snd5O3IZKczFq2CTAz7eg6DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757416533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfnkCNemqaFEQ4UzPQm8Dp36KFI130lGgkIksLe8fUA=;
	b=1/dMNDg4Xbj85dmxMCVmcu3czp3nemusAibeRdlV02B+ope0QKXaP46M7tdQNXAgBdet8T
	TfH6qMHTlk8wKdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VivbzfG5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ltmbBXeY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757416532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfnkCNemqaFEQ4UzPQm8Dp36KFI130lGgkIksLe8fUA=;
	b=VivbzfG5AdrTLlsrU5Ld8n1k84CqF2pQSClQ0OIAE/PIXV//OK7ee+vyw3eg0iqEHWAzGb
	NbkZBO88YknUaVZFLE4lxrXXw/U52+uPqjmGcBhd9DDvzaRlSNSMPSCwjrS1jsACroVCg4
	cbdo12w5JLOWtGSuBiExQziFs51nnIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757416532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfnkCNemqaFEQ4UzPQm8Dp36KFI130lGgkIksLe8fUA=;
	b=ltmbBXeYIp89qsUNny49x3o19X+gnPlXLzciB0W0G8bqROAzRMhP55jEvDYSMZjoym4B5K
	ZS5r+SlJpOacCgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D20181365E;
	Tue,  9 Sep 2025 11:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCQ6M1QMwGhcMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 11:15:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F295A0A2D; Tue,  9 Sep 2025 13:15:28 +0200 (CEST)
Date: Tue, 9 Sep 2025 13:15:28 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use the switch statement in init_special_inode()
Message-ID: <w5sw3strd7svki6qasodohqzontf3qajhyos54ukrroy5yxuxa@tbu2kj3yj4sy>
References: <20250909075459.1291686-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909075459.1291686-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E3BCB3403C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 09-09-25 09:54:58, Mateusz Guzik wrote:
> Similar to may_open().
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks sane. Just one style nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> -	else if (S_ISSOCK(mode))
> -		;	/* leave it no_open_fops */
> -	else
> +		break;
> +	case S_IFSOCK:
> +		/* leave it no_open_fops */
> +		break;
> +	default:
>  		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o) for"
>  				  " inode %s:%lu\n", mode, inode->i_sb->s_id,
>  				  inode->i_ino);
> +		break;

We usually don't bother with 'break' for the 'default' label.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


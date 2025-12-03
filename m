Return-Path: <linux-fsdevel+bounces-70551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B0C9EB24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC54C4E13EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFD2E9726;
	Wed,  3 Dec 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyGvm33k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vh+glGqL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyGvm33k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vh+glGqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324B2E8B97
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757691; cv=none; b=IrS1aEuK68i9y6h7uhnPvWQu15jZr4C61oABYAnW5nYulvLtzgu9CN3Ffkh5tMgQyueTK0eoSQe44OyG8ForzBkSEQG2uwQN7eRmC2AR2qgJD5j9q1dW+gL/xSYS0Rq3BubndtIf18ebrSczSXVv/M883TYG4tGJsa/E2/q0Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757691; c=relaxed/simple;
	bh=bBm1XISCQMZt9hkHFGKf/reMn0k6IokUuwXazYwLJlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6lU77UzgMsfF4L5S8pIWRs8KtQ1zICSNuSLn1qpg/5OcJ6koW1daHprkBxuOuexo6NbbKNqxUSkk8eq26aT7LcILAZH0h/opxCZTltBCePsc38WFz+Tj2UHruU2s8mJegVWkDZqQey3djifXenJ7sWTp3s2d6ku/jZTlGcTj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyGvm33k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vh+glGqL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyGvm33k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vh+glGqL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2534A33691;
	Wed,  3 Dec 2025 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764757688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUQCxuG3dyjrug8giRN/d0IkFW6Tuad1reC6FPiZWL4=;
	b=MyGvm33kI2kUCM2D6JWLA/gCJ4CLpDxa7dsRWHDkUrCcSVyiXop3wd8EuZmxx8U5anRPLE
	l3H1v0e7wZD20LQ6Ufjm/VU9H2NlsR1/c09zra9X8eSf/K6qKk7r1hmeljpVxoHn3lTTp+
	RyAdqCSyLgsEe0zyq558hKr1wiGJPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764757688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUQCxuG3dyjrug8giRN/d0IkFW6Tuad1reC6FPiZWL4=;
	b=Vh+glGqLft6CgR6p7INKxm0AYkALS8biLVyyPZe4r56vo6f2OpxjWGYD66Gu03U7BRbmSo
	cXThki1psfkh/PAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764757688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUQCxuG3dyjrug8giRN/d0IkFW6Tuad1reC6FPiZWL4=;
	b=MyGvm33kI2kUCM2D6JWLA/gCJ4CLpDxa7dsRWHDkUrCcSVyiXop3wd8EuZmxx8U5anRPLE
	l3H1v0e7wZD20LQ6Ufjm/VU9H2NlsR1/c09zra9X8eSf/K6qKk7r1hmeljpVxoHn3lTTp+
	RyAdqCSyLgsEe0zyq558hKr1wiGJPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764757688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUQCxuG3dyjrug8giRN/d0IkFW6Tuad1reC6FPiZWL4=;
	b=Vh+glGqLft6CgR6p7INKxm0AYkALS8biLVyyPZe4r56vo6f2OpxjWGYD66Gu03U7BRbmSo
	cXThki1psfkh/PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AE893EA63;
	Wed,  3 Dec 2025 10:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0zWCBrgQMGldRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Dec 2025 10:28:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD6D3A09B4; Wed,  3 Dec 2025 11:28:03 +0100 (CET)
Date: Wed, 3 Dec 2025 11:28:03 +0100
From: Jan Kara <jack@suse.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] fs: PM: Fix reverse check in
 filesystems_freeze_callback()
Message-ID: <biwoc3mkrh3ynxl5wftj7caasxf2rkjwhb23vmbqaxeus4iuwu@g6kjgdsfsgvk>
References: <12788397.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12788397.O9o76ZdvQC@rafael.j.wysocki>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 02-12-25 19:27:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The freeze_all_ptr check in filesystems_freeze_callback() introduced by
> commit a3f8f8662771 ("power: always freeze efivarfs") is reverse which
> quite confusingly causes all file systems to be frozen when
> filesystem_freeze_enabled is false.
> 
> On my systems it causes the WARN_ON_ONCE() in __set_task_frozen() to
> trigger, most likely due to an attempt to freeze a file system that is
> not ready for that.
> 
> Add a logical negation to the check in question to reverse it as
> appropriate.
> 
> Fixes: a3f8f8662771 ("power: always freeze efivarfs")
> Cc: 6.18+ <stable@vger.kernel.org> # 6.18+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1188,7 +1188,7 @@ static void filesystems_freeze_callback(
>  	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
>  		return;
>  
> -	if (freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
> +	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
>  		return;
>  
>  	if (!get_active_super(sb))
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-fsdevel+bounces-24605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D889412EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9760BB243E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7335519EEAB;
	Tue, 30 Jul 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGGO1l8e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVyqYBef";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGGO1l8e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVyqYBef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F90173;
	Tue, 30 Jul 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345495; cv=none; b=UlhwGHUi3KKLfdAvom+4OmBMSD151l77ZMs+eX+dz+GN9iIZXT7pNQ7sMTPqS60Ks0rz0VO1XIbz16wbLRlI8qWr6kT62L4vwsrFCIEz1Bh3yXJR4q86L7X2dafbHGfS7e5SiF9RgkTia9mg8xuHvuCcMW+KNwVcwF1df2auOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345495; c=relaxed/simple;
	bh=xamD4VFyFg+7SV3hMPDxJwpAcJ8b84ZdB/0TyEecUI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL1Jl+IMnfWRIGxFaXOckVYAvQ3YVHP29Vj762vI6hg6n112YgSyP0YlMLa83r/yPb48beBMSjRXTjQvYd3kbJTyEWvpG05XiF8gePo0kcZn2LktLcC7KFV5ZnP6U9SPpnwua21Y8zmfRuDwF444TZJvF6kMZKz7u97hP7NJoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGGO1l8e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVyqYBef; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGGO1l8e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVyqYBef; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C52221B0B;
	Tue, 30 Jul 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2LvjMHL8XIy2cGicmRezmNNMWvHfYrbwwXBqDRNrcM=;
	b=bGGO1l8euTxa8wyb5EaaLfF+BwsdfQ9FKojvGLYpnhkddXQa+YjeXpE6XWvz4XEe+fPWLr
	vw6VnvY/Y0YPGn0D5yQHpWCvAX+ek0zyZ4ZORqL7phnsx76rZ5QeGbMSxCq+nuAMPQqJTR
	vfqWT0HIV06W7d0gb64BKRbieZJP+C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2LvjMHL8XIy2cGicmRezmNNMWvHfYrbwwXBqDRNrcM=;
	b=NVyqYBefC7FCKAy3/DNZbRb2Qk/TUzX6TmmOSoehe3/5udyXiK1Ob+EIGy3ZXjswlXCGPt
	Q0A/ziNcQj7lzUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2LvjMHL8XIy2cGicmRezmNNMWvHfYrbwwXBqDRNrcM=;
	b=bGGO1l8euTxa8wyb5EaaLfF+BwsdfQ9FKojvGLYpnhkddXQa+YjeXpE6XWvz4XEe+fPWLr
	vw6VnvY/Y0YPGn0D5yQHpWCvAX+ek0zyZ4ZORqL7phnsx76rZ5QeGbMSxCq+nuAMPQqJTR
	vfqWT0HIV06W7d0gb64BKRbieZJP+C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2LvjMHL8XIy2cGicmRezmNNMWvHfYrbwwXBqDRNrcM=;
	b=NVyqYBefC7FCKAy3/DNZbRb2Qk/TUzX6TmmOSoehe3/5udyXiK1Ob+EIGy3ZXjswlXCGPt
	Q0A/ziNcQj7lzUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A65A13983;
	Tue, 30 Jul 2024 13:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1oX8DRToqGYhVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:18:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D35CFA099C; Tue, 30 Jul 2024 15:18:11 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:18:11 +0200
From: Jan Kara <jack@suse.cz>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/aio: Fix __percpu annotation of *cpu pointer in
 struct kioctx
Message-ID: <20240730131811.66uevttpqar2afmy@quack3>
References: <20240730121915.4514-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730121915.4514-1-ubizjak@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 14:18:34, Uros Bizjak wrote:
> __percpu annotation of *cpu pointer in struct kioctx is put at
> the wrong place, resulting in several sparse warnings:
> 
> aio.c:623:24: warning: incorrect type in argument 1 (different address spaces)
> aio.c:623:24:    expected void [noderef] __percpu *__pdata
> aio.c:623:24:    got struct kioctx_cpu *cpu
> aio.c:788:18: warning: incorrect type in assignment (different address spaces)
> aio.c:788:18:    expected struct kioctx_cpu *cpu
> aio.c:788:18:    got struct kioctx_cpu [noderef] __percpu *
> aio.c:835:24: warning: incorrect type in argument 1 (different address spaces)
> aio.c:835:24:    expected void [noderef] __percpu *__pdata
> aio.c:835:24:    got struct kioctx_cpu *cpu
> aio.c:940:16: warning: incorrect type in initializer (different address spaces)
> aio.c:940:16:    expected void const [noderef] __percpu *__vpp_verify
> aio.c:940:16:    got struct kioctx_cpu *
> aio.c:958:16: warning: incorrect type in initializer (different address spaces)
> aio.c:958:16:    expected void const [noderef] __percpu *__vpp_verify
> aio.c:958:16:    got struct kioctx_cpu *
> 
> Put __percpu annotation at the right place to fix these warnings.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 6066f64967b3..e8920178b50f 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -100,7 +100,7 @@ struct kioctx {
>  
>  	unsigned long		user_id;
>  
> -	struct __percpu kioctx_cpu *cpu;
> +	struct kioctx_cpu __percpu *cpu;
>  
>  	/*
>  	 * For percpu reqs_available, number of slots we move to/from global
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-fsdevel+bounces-59036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E6B33FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B523BBD3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848015C158;
	Mon, 25 Aug 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pF8Nbxm9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UwKMu/qY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pF8Nbxm9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UwKMu/qY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F5347DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125543; cv=none; b=kTLggc3sh/41tfYT832Ood64GUiCW9yXSJJXOxA1I3/qmy+OFckpzkFUK8MBap+nCr9L5BGPmNwD/qTKfNE5db9BNrRfwwLaE8ZiXIdojc4+rqu6tMdzpuMRGO1MkZexhAD4wnu2M7714HBaskvwuMOSzRKB3ImGP85mJx47gEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125543; c=relaxed/simple;
	bh=nBPAYeu9e9tVWwWJnynzfIihrGzIWQ0uk8dvTyD5EGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppPE6xDQptxRFwAj0MvFhgYg3DXYPu9z/grqRMRogNrY3NLsgs1H2xFi3sq9D8jxY+hDbvcebgmiH60dLjUInSxnzp9FCyxG6NqQ304TJ5Ig2hPJHCME7BfvrSK85oYCbNYfLjQDkPeLNM9fhJKxkY+icwTsUv5/FCoohVufnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pF8Nbxm9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UwKMu/qY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pF8Nbxm9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UwKMu/qY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A04281F79B;
	Mon, 25 Aug 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756125539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQKERY0gFCIR+jm7WWR7qikFq9VvvmVNurg4iIGtOY8=;
	b=pF8Nbxm9gj1Z5xXl6uSSIYEOwEi52SmimrLEyhfrWIs7QEjumdSRA3EHjI39LBXYf01AiQ
	9KZpef6117k5aPn00Xg8+bap+FIIrFbUraKmj7sYeRDkZDhCb9nPmssfR2hkHiP622XEHL
	j5u/LCiH2449VsVAhJujc99MjZ+xgCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756125539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQKERY0gFCIR+jm7WWR7qikFq9VvvmVNurg4iIGtOY8=;
	b=UwKMu/qY/z8l23SMxk7OZpRviw8TS7SSuVySOG77bLeav4F0mFrFhvN6J6WNPT2xL63DAb
	NdtLw9qup/qATPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756125539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQKERY0gFCIR+jm7WWR7qikFq9VvvmVNurg4iIGtOY8=;
	b=pF8Nbxm9gj1Z5xXl6uSSIYEOwEi52SmimrLEyhfrWIs7QEjumdSRA3EHjI39LBXYf01AiQ
	9KZpef6117k5aPn00Xg8+bap+FIIrFbUraKmj7sYeRDkZDhCb9nPmssfR2hkHiP622XEHL
	j5u/LCiH2449VsVAhJujc99MjZ+xgCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756125539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQKERY0gFCIR+jm7WWR7qikFq9VvvmVNurg4iIGtOY8=;
	b=UwKMu/qY/z8l23SMxk7OZpRviw8TS7SSuVySOG77bLeav4F0mFrFhvN6J6WNPT2xL63DAb
	NdtLw9qup/qATPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F84136DB;
	Mon, 25 Aug 2025 12:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GeamIWNZrGjiFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 12:38:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40D2EA0951; Mon, 25 Aug 2025 14:38:59 +0200 (CEST)
Date: Mon, 25 Aug 2025 14:38:59 +0200
From: Jan Kara <jack@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Fix incorrect type for ret
Message-ID: <5vuf4s75su54l7rximdssebspytj64yivk6adlrydyu7lyduux@am2vv2rs2hac>
References: <20250825073609.219855-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825073609.219855-1-zhao.xichao@vivo.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,vivo.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 25-08-25 15:36:09, Xichao Zhao wrote:
> In the setup_arg_pages(), ret is declared as an unsigned long.
> The ret might take a negative value. Therefore, its type should
> be changed to int.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Indeed, all three functions for which it is used are returning int. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..5d236bb87df5 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  		    unsigned long stack_top,
>  		    int executable_stack)
>  {
> -	unsigned long ret;
> +	int ret;
>  	unsigned long stack_shift;
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = bprm->vma;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


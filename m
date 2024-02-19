Return-Path: <linux-fsdevel+bounces-11993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30A85A207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077928218A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDEB2C1BF;
	Mon, 19 Feb 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dk+P21/i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ty+8KCsT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wQMfl/kC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/46827Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166592C1A4;
	Mon, 19 Feb 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342488; cv=none; b=T6SSid9D5HlHTzbI8eG367FOUKXkweLHigvIFIDd4Pzg3YBtUJkkQ17Obhv0J7FJs04mHtI0fg2QHIirt/bRRHMldnRafWN9+rH1Z2AsVRU5Nuun8sreNV2TyM/yis6CQOLY2mvVKB5tegvXspsnZ3FVB4QsbByeXdrASck+ZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342488; c=relaxed/simple;
	bh=04zZQvErufDHrsOkOYmWa71v/CV/vTUEjZZ/qUxq2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odUoMM+vI7G/7lxFKXZ/k9zLmfEp1tpgymbELxn2PvH8AS14svm/CfYw2Ra8haWtnlwyJv3ryfVqWsPiMsvENJW6x9aEfmOYU7W74tlkwcbD3oYGoZphgvkqVj0q0a/ziGsd0IZKn4yiCciPjIgo6tadPLG+p1nhyinh3//YFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dk+P21/i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ty+8KCsT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wQMfl/kC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/46827Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6116E1FD0F;
	Mon, 19 Feb 2024 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxr37yjvsBDH8ImiBOjxjncGbh787kSDIXFry4Onmac=;
	b=dk+P21/iZjdfWn1OMr58LZnfRoDNJTOmLtmGN1+2VeomfGvmKRppzti0v5qXd/Q03Xf2Fg
	C8QltB8mRQHRiatUwi3RZaV24EFAxUtYACmEgiFn5zdcL4/qs739dHXoY2N9bh/ESHI5BZ
	ypDkhVpmtYeHkZRyga1261rfb79laqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxr37yjvsBDH8ImiBOjxjncGbh787kSDIXFry4Onmac=;
	b=ty+8KCsTwu+4P1tXchJB/zd9m+HPb2ztbLnMkiSsh1ee4/ZsRMQCmclrtLUXEtAr968ISP
	0pHv51k6REhAUaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxr37yjvsBDH8ImiBOjxjncGbh787kSDIXFry4Onmac=;
	b=wQMfl/kC8LYtLbRSxqJXIbM12ekeEdeqIBXvBHVD6Y5Cs1QO/pjnemurukXSO1QOfKE6b0
	5KKfQA2D1UOVd3y3yz1nOSipqEvqXrN/ySHoGG4gbfT6tUEn8nEmuI0GT7LrXbCU6qRsfL
	rwPmYN5BMSdtna1mCLUCTbVozWCdJLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxr37yjvsBDH8ImiBOjxjncGbh787kSDIXFry4Onmac=;
	b=h/46827Ys+ElhiiA4KhHcwVXMyzywj/2kcYR6KPT5sTOm8njw/mFhKE2zEtrWF036CEem3
	ruaVIjSZ+O2HKDBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5196A13585;
	Mon, 19 Feb 2024 11:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /56mE9I802VDawAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:34:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5B27A0806; Mon, 19 Feb 2024 12:34:37 +0100 (CET)
Date: Mon, 19 Feb 2024 12:34:37 +0100
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Message-ID: <20240219113437.y7vxeyhvjnxo7rlh@quack3>
References: <20240216202352.2492798-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202352.2492798-1-arnd@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.66%]
X-Spam-Flag: NO

On Fri 16-02-24 21:23:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A while ago, we changed the way that select() and poll() preallocate
> a temporary buffer just under the size of the static warning limit of
> 1024 bytes, as clang was frequently going slightly above that limit.
> 
> The warnings have recently returned and I took another look. As it turns
> out, clang is not actually inherently worse at reserving stack space,
> it just happens to inline do_select() into core_sys_select(), while gcc
> never inlines it.
> 
> Annotate do_select() to never be inlined and in turn remove the special
> case for the allocation size. This should give the same behavior for
> both clang and gcc all the time and once more avoids those warnings.
> 
> Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good (if this indeed works with clang ;). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c          | 2 +-
>  include/linux/poll.h | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 11a3b1312abe..9515c3fa1a03 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -476,7 +476,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
>  		wait->_key |= POLLOUT_SET;
>  }
>  
> -static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
> +static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
>  {
>  	ktime_t expire, *to = NULL;
>  	struct poll_wqueues table;
> diff --git a/include/linux/poll.h b/include/linux/poll.h
> index a9e0e1c2d1f2..d1ea4f3714a8 100644
> --- a/include/linux/poll.h
> +++ b/include/linux/poll.h
> @@ -14,11 +14,7 @@
>  
>  /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
>     additional memory. */
> -#ifdef __clang__
> -#define MAX_STACK_ALLOC 768
> -#else
>  #define MAX_STACK_ALLOC 832
> -#endif
>  #define FRONTEND_STACK_ALLOC	256
>  #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
>  #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


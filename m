Return-Path: <linux-fsdevel+bounces-39390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF6A1375E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00193A131A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E51DDA14;
	Thu, 16 Jan 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNUiIMTu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2rLBEvWR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fIEj4ViH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3b5AICxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5B156C76;
	Thu, 16 Jan 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021921; cv=none; b=Iu83JUiolOP3qBmBCRUoPNfbhp9ea0q/eVcKahApDeqiJgFqXn+N8i/wN5lFvFsoKvx6l6RK33lL6whwlZHBZ9LC8ov6fHLy6iuu9TzwBZ2GydJJCwqmLL+wj7O9MThg3jUwdo+OPEjyptoKLsL+s9Myg7yr3MMgVZWRWvl717g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021921; c=relaxed/simple;
	bh=+wVPh5TPzlykFYiaVlpap3o1xfjYd+xQ49U84h3iYSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILk/FTo3MCvtv9yBVx195XMbnvpHQInFZUKufFq0o6tnX2tSMDmD22XSMuxCc5tIql8Y6YfxVoVGeTqoT4udI8Kp7bSUpVSqe+xZweMtsQN22WNBbY+ybzQATn02tONAbLEFYECRN6HrFTK4le1J5HfzWux7pnCjsJa2xyrZLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pNUiIMTu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2rLBEvWR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fIEj4ViH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3b5AICxt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 640601F799;
	Thu, 16 Jan 2025 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdVoHTVDvwfQ1Z3Yz3nMwRWMw4l8IUr7XtNDf85j00=;
	b=pNUiIMTu2hdRUC3C2aqZbsqCio3cqy7n2A5+YiryOECheY3uwNb9xXFWFrc6gVikXPwUbd
	tDKgdIr6oLmeH9cy8k8zrP/elsALU3lZuS5kBrTRQZR6Ci/tk8k0jLMbFlwmHPkzaRLrFQ
	hXPMvuIBtjqXPEL0kyoFudiIHOBBMlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdVoHTVDvwfQ1Z3Yz3nMwRWMw4l8IUr7XtNDf85j00=;
	b=2rLBEvWRnNnVDbmI67uovKO9bnc/1sGKkpJu1EHNfKcoa6ePg7vjfHZEUtKwZ9bdhiX7KC
	jXK0FjnkHKhrxECA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdVoHTVDvwfQ1Z3Yz3nMwRWMw4l8IUr7XtNDf85j00=;
	b=fIEj4ViHftHQl+5uZRf63YLPWP50ewUeIra3enBCkEWtzj5xOerbu04M7IsrLIS+n1vJTc
	XMD397P/z9Uba8TmX3W8VFjTRL5KG6qR0UTZ6K1SxrS5u/3KSVa9BflLdOGm+rkA2mDYK3
	H8mewZPqERs06AXzzZGqxr6kNcsWkRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdVoHTVDvwfQ1Z3Yz3nMwRWMw4l8IUr7XtNDf85j00=;
	b=3b5AICxtWuJvDKJ+TRRzXLqPi8TfVe8/682+aRoW5H4xl+lIV3pqo42OPd0AsT3OkklDHb
	vxk60MwIZ+iA8BBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58D4D13A57;
	Thu, 16 Jan 2025 10:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ciCqFdvZiGf5CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 10:05:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C1C0A08E0; Thu, 16 Jan 2025 11:05:07 +0100 (CET)
Date: Thu, 16 Jan 2025 11:05:07 +0100
From: Jan Kara <jack@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous
 regions
Message-ID: <s5sympphh3hztthvypdrf6si5debskxfwcnsvrv5v7x5m6rvbc@2tyjjv3mpl52>
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
X-Spam-Level: 
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tavianator.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 15-01-25 23:05:38, Tavian Barnes wrote:
> dump_user_range() supports sparse core dumps by skipping anonymous pages
> which have not been modified.  If get_dump_page() returns NULL, the page
> is skipped rather than written to the core dump with dump_emit_page().
> 
> Sadly, dump_emit_page() contains the only check for dump_interrupted(),
> so when dumping a very large sparse region, the core dump becomes
> effectively uninterruptible.  This can be observed with the following
> test program:
> 
>     #include <stdlib.h>
>     #include <stdio.h>
>     #include <sys/mman.h>
> 
>     int main(void) {
>         char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>                 MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>         printf("%p %m\n", mem);
>         if (mem != MAP_FAILED) {
>                 mem[0] = 1;
>         }
>         abort();
>     }
> 
> The program allocates 1 TiB of anonymous memory, touches one page of it,
> and aborts.  During the core dump, SIGKILL has no effect.  It takes
> about 30 seconds to finish the dump, burning 100% CPU.
> 
> This issue naturally arises with things like Address Sanitizer, which
> allocate a large sparse region of virtual address space for their shadow
> memory.
> 
> Fix it by checking dump_interrupted() explicitly in dump_user_pages().
> 
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

Thanks for the patch! The idea looks good to me as a quick fix, one
suggestion for improvement below:

> diff --git a/fs/coredump.c b/fs/coredump.c
> index d48edb37bc35..fd29d3f15f1e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -950,6 +950,10 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  			}
>  		} else {
>  			dump_skip(cprm, PAGE_SIZE);
> +			if (dump_interrupted()) {
> +				dump_page_free(dump_page);
> +				return 0;
> +			}

So rather than doing the check here, I'd do it before cond_resched() below
and remove the check from dump_emit_page(). That way we have the
interruption handling all in one place.

>  		}
>  		cond_resched();
>  	}

Bonus points for unifying the exit paths from the loop (perhaps as a
separate cleanup patch) like:

		if (page)
			ret = dump_emit_page(...)
		else
			dump_skip(...)
		if (dump_interrupted())
			ret = 0;
		if (!ret)
			break;
		cond_resched();
	}
	dump_page_free(dump_page);
	return ret;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


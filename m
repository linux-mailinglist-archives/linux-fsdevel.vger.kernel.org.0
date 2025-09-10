Return-Path: <linux-fsdevel+bounces-60822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C3B51C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17CCB62E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE032C33F;
	Wed, 10 Sep 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mE5JItwS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2CdR7nu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tNUhQ5dX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wketGrD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681E327A3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519304; cv=none; b=sXHP9DGfGGT+t/AvQmuWEtc49nda1bBndXyDusYhP94v4m8BoSf0tSTcPqUWhB5KB/tbkYA1q+66YNTa59gOg6fEK6dGRQMb7Mgfm4mztdIxsQfqRRRLfy97DAvguYoZfs0NxZnlCH/U/Axjqwxz8C8cguACG1+7B4Xvtt5S4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519304; c=relaxed/simple;
	bh=523Ci022C3f4FlEiw0E+5BqweO7UB3kj+ojuHiTDzUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmBij+bybAs+W4/U9ik0nGJTS+EbX86+2GuzxsBi0lgB/IRqFQ33V0Vjr9TM6DCM024F94ST5XSGzFN60ttnEANvbmcfD/kHbXFzk7DvxVkDbOmHyY8MLoGAS+ws1TTUBiQDZnNA0HiJ+fjMBf84OnDtc/cOQcjZA/BdpnyiZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mE5JItwS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2CdR7nu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tNUhQ5dX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wketGrD4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB7EE37EF1;
	Wed, 10 Sep 2025 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaWvMxpb8Ns4qwJJs7/pnIWdJsAZBETo2QPX7ztSweA=;
	b=mE5JItwSu4Y5fM3LV/baQMXomzyo3q91aK9nWVjYm3sTghFWQ3YjRpRZwnDfcxhf3VtHHc
	0mxgawfr5k3kgf6lxv8e9RNYqXRDbrdVh809Y1+jdemhhfH1p6lWqDXhi3HmBmf2zx4q8J
	kjEBlgdw/Hses9D1ADQkEqnLDehn0V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaWvMxpb8Ns4qwJJs7/pnIWdJsAZBETo2QPX7ztSweA=;
	b=o2CdR7nuVdLUEBy2nFMIO3RTf2/Kkqo2At8HF1WnUlQSbpCG3ElO7Vve0xJx474Y7TrUQ1
	tvCqbcFAHuOgCHCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757519298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaWvMxpb8Ns4qwJJs7/pnIWdJsAZBETo2QPX7ztSweA=;
	b=tNUhQ5dXFj46AUkaqL2isKzb0vm4NIwrij31/avinfzVc74wdy8zBDYsv5gVFotewUzBag
	uR8fzd7BQIrqBrMMKFujmlonwplxW1v+AUq6lZmyEFrJwtE/WGU/RFtkgZlpfFCL27g6Qi
	E1goHCwCSLZYSucgTIfLMenWNt4IkvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757519298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaWvMxpb8Ns4qwJJs7/pnIWdJsAZBETo2QPX7ztSweA=;
	b=wketGrD4yuT1e9LxG7SzuOM4rRfDNOy2ACzWxtg0rHKpwHJjjII/5dEqNunsijhMWr3pFx
	98nfjR5Zd5LTUEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 550D613310;
	Wed, 10 Sep 2025 15:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sVnBFMKdwWiMPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:48:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 13310A0A2D; Wed, 10 Sep 2025 17:48:11 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:48:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 15/32] ns: remove ns_alloc_inum()
Message-ID: <dz7tomtgcicj5woujey3uxmo23ou5bi4wdtmvuannbbyj3xcru@j5giavsztsyl>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-15-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-15-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 10-09-25 16:37:00, Christian Brauner wrote:
> It's now unused.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/proc_ns.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index dbb119bda097..e50d312f9fee 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -66,12 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
>  
>  #endif /* CONFIG_PROC_FS */
>  
> -static inline int ns_alloc_inum(struct ns_common *ns)
> -{
> -	WRITE_ONCE(ns->stashed, NULL);
> -	return proc_alloc_inum(&ns->inum);
> -}
> -
>  static inline int ns_common_init(struct ns_common *ns,
>  				 const struct proc_ns_operations *ops,
>  				 bool alloc_inum)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


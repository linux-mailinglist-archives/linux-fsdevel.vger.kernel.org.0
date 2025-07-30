Return-Path: <linux-fsdevel+bounces-56327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B2B16095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 14:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A455418C86AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896A298CA6;
	Wed, 30 Jul 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7G9ogLr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/hhTd3Jd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7G9ogLr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/hhTd3Jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33E292B3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879582; cv=none; b=CpXSED37zk0sCgVFTKdyE/MKEQmE8GAwpDDSaJu6HQOPhUpXax2/judxJc8x7mDTmL2iFs1XqhKbbdt5/vhcYdd5uJ18uthCTdEr04J6T3FGIan7ApeUIawPkMtR/LtMLam4jm4kDW7jHKYNxElyDR583OqLYkPeCo98DjVEpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879582; c=relaxed/simple;
	bh=I8gMSAOPqIJPJPpm6H9XWt86KZF2ChGcnv17lwvcSLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLitLW6+LZMQc9Df+v1TW6RkqV0EMt/zk0Teto/pZQRvQvsc2WojCgnz1zCgWtY9Zk7+1KmgSuur7XIVOc7DEkc+pHShfcu7OedLPwTLyumUeYO/0+ACy1mgaptqZcxyCIEKqOWPFm9cSW+0GCn1m+Go3ZMdXSfgcVDmWUsTx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7G9ogLr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/hhTd3Jd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7G9ogLr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/hhTd3Jd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D59C1F824;
	Wed, 30 Jul 2025 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753879578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knp2fxkmXvk17gJTrh/FJdGeoC12T60JnOb1l3j4R30=;
	b=x7G9ogLrX3Rqndd840nJNqpCFX02drWF+72kTneHgb5NxO1KwGtHU36CX0r0s7OS6F6EUF
	FmJkGIsKM+SDfpt6hnm3SG8vRzQ8dpcABTMsGXfealzcj4Cxh/zn1xQhd3H62A6iatFl1t
	GT6tplG8KWGmY4OZww8IgPYmIONcuVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753879578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knp2fxkmXvk17gJTrh/FJdGeoC12T60JnOb1l3j4R30=;
	b=/hhTd3JdCVBFyeat7L3QDkJ9GBwe0dfflR6GRki3T7Uhl0TfSH3WVnOHbOwIeUP1u6KHNR
	zWF9LEg0m8HgUwAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753879578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knp2fxkmXvk17gJTrh/FJdGeoC12T60JnOb1l3j4R30=;
	b=x7G9ogLrX3Rqndd840nJNqpCFX02drWF+72kTneHgb5NxO1KwGtHU36CX0r0s7OS6F6EUF
	FmJkGIsKM+SDfpt6hnm3SG8vRzQ8dpcABTMsGXfealzcj4Cxh/zn1xQhd3H62A6iatFl1t
	GT6tplG8KWGmY4OZww8IgPYmIONcuVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753879578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knp2fxkmXvk17gJTrh/FJdGeoC12T60JnOb1l3j4R30=;
	b=/hhTd3JdCVBFyeat7L3QDkJ9GBwe0dfflR6GRki3T7Uhl0TfSH3WVnOHbOwIeUP1u6KHNR
	zWF9LEg0m8HgUwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 732871388B;
	Wed, 30 Jul 2025 12:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yFcXHBoUimixLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 12:46:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FFE8A094F; Wed, 30 Jul 2025 14:46:18 +0200 (CEST)
Date: Wed, 30 Jul 2025 14:46:18 +0200
From: Jan Kara <jack@suse.cz>
To: Dai Junbing <daijunbing@vivo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 2/5] select/poll: Make sleep freezable
Message-ID: <5pqwouyalbjgggcxxnu6yah6jzurmksk7jnepk3x22qtospo4j@6rky4lp4d7tk>
References: <20250730014708.1516-1-daijunbing@vivo.com>
 <20250730014708.1516-3-daijunbing@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730014708.1516-3-daijunbing@vivo.com>
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 30-07-25 09:47:03, Dai Junbing wrote:
> When processes sleep in TASK_INTERRUPTIBLE state during select(2)
> or poll(2) system calls, add the TASK_FREEZABLE flag. This prevents
> them from being prematurely awakened during system suspend/resume
> operations, avoiding unnecessary wakeup overhead.
> 
> The functions do_select() and do_poll() are exclusively used within
> their respective system call paths. During sleep in these paths, no
> kernel locks are held. Therefore, adding TASK_FREEZABLE is safe.
> 
> Signed-off-by: Dai Junbing <daijunbing@vivo.com>

This looks sensible to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..8a1e9fe12650 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
> +		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
>  					   to, slack))
>  			timed_out = 1;
>  	}
> @@ -955,7 +955,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
> +		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
>  			timed_out = 1;
>  	}
>  	return count;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-fsdevel+bounces-56425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F394AB1739E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C00EA8349E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2441D6DB9;
	Thu, 31 Jul 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBIyAI53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NjKsRzi0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyBODI4Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/g63xHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87072A8C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974034; cv=none; b=AC2DNmY5wIX9D6677c4fynvwVexvK+rvTFwZGQAih7ENBSwWXHT/+aO6nzYgQEhg2pMm3ArKtr26Qm0N72muZ1rwrij4V3B0ekGnsmY/OS1QQvFgGjJm693TeG62HISfN6dK4hzwkWWBAdZBjsFIbahUTw37hbKXAHvng2haH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974034; c=relaxed/simple;
	bh=8iBsCXSMxFp3Z/rGX3sNPO2dPgydWh+KZVQ3cFcbulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqpqe89VOsmfDJ8jBUamIm3F6eEqoWQtpNysWoz8F40TNsvhPU9te/4WgonLckhqGJJO2cSuJe5hXx+xt+6By3eIxXDS+3RC0K3TpDIiszae3VaRCZgT3pZR7vD+MroamfN5CNu/NnXE8x7FBi9UBNX6/xpfCqbVw9TMojUudic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBIyAI53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NjKsRzi0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyBODI4Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/g63xHM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCFCC1F813;
	Thu, 31 Jul 2025 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753974030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbyXKL6HQV1X+cVz8ZhvI4n3efWkggHWZs0n6HYR1QY=;
	b=XBIyAI53DOXNI6entUsH9ymjzostaKVYJBfPnjBKyiUtMTrZ3V1/eShXtGbKWq9NV/Ij/7
	F1Rp2ZQeOBG35rZ+fo2/JmfIOWqKAHGTuGbMwdDri6wzPtlxtZVVQATR4YiycSWGDsdGje
	KysdAMyKeZdTaO2xp6JqC9ZQKfxoXWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753974030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbyXKL6HQV1X+cVz8ZhvI4n3efWkggHWZs0n6HYR1QY=;
	b=NjKsRzi0tj2F4CPPA3nrVjB0UvNq4CyHyuroECRbpZXojqVfT8wnq5fwlBWu0s2nJTItwN
	qUCq04GiLGctlqDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vyBODI4Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="h/g63xHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753974029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbyXKL6HQV1X+cVz8ZhvI4n3efWkggHWZs0n6HYR1QY=;
	b=vyBODI4ZHQC1KoN75OrPqBU1UGQr/0JzkHoUeoDdadLH36PbgHTk+QXilebcwJ7gMoROUk
	pzeSFS1oxY17Chj7Na2spmSQ7CZJRq+z/yYHzfD3tGV/rZuKTiYUgRRGQcbM6XBHUW8cwc
	xAPbu0yZuMtI6gzJDe3xMcHuGmu3oOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753974029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbyXKL6HQV1X+cVz8ZhvI4n3efWkggHWZs0n6HYR1QY=;
	b=h/g63xHMS4BDuyzhlwaaJ4lZqzLbSpwBKx1MpMKUhACYpc7/muDwrIdZxyY4n7vQe1PVri
	7LQoNsJK+ZqAaPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF92D13876;
	Thu, 31 Jul 2025 15:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 68fWKg2Fi2jmCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Jul 2025 15:00:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39ABBA0A02; Thu, 31 Jul 2025 17:00:29 +0200 (CEST)
Date: Thu, 31 Jul 2025 17:00:29 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/2] aio-dio-write-verify: Add O_DSYNC option
Message-ID: <rmevgqdu6jqphqgxx35oye7ukhakijvalgbbn24zxblajaf75m@ag3t4ksa4wv6>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BCFCC1F813
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Thu 31-07-25 18:05:54, Ritesh Harjani (IBM) wrote:
> This patch adds -D for O_DSYNC open flag to aio-dio-write-verify test.
> We will use this in later patch for integrity verification test with
> aio-dio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Cool. Both patches look good to me and they fail without the iomap fix I've
submitted so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

and

Tested-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  src/aio-dio-regress/aio-dio-write-verify.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index 513a338b..0cf14a2a 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -40,6 +40,7 @@ void usage(char *progname)
>  	        "\t\tsize=N: AIO write size\n"
>  	        "\t\toff=M:  AIO write startoff\n"
>  	        "\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
> +	        "\t-D: uses O_DSYNC flag for open. By default O_DSYNC is not used\n"
>  	        "\t-N: no_verify: means no write verification. By default noverify is false\n"
>  	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
>  	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
> @@ -298,7 +299,7 @@ int main(int argc, char *argv[])
>  	int o_sync = 0;
>  	int no_verify = 0;
>  
> -	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
> +	while ((c = getopt(argc, argv, "a:t:SND")) != -1) {
>  		char *endp;
>  
>  		switch (c) {
> @@ -316,6 +317,9 @@ int main(int argc, char *argv[])
>  		case 'S':
>  			o_sync = O_SYNC;
>  			break;
> +		case 'D':
> +			o_sync = O_DSYNC;
> +			break;
>  		case 'N':
>  			no_verify = 1;
>  			break;
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


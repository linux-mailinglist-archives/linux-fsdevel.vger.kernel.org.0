Return-Path: <linux-fsdevel+bounces-21026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB548FC7F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE82829F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0D1946CB;
	Wed,  5 Jun 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZqa1nTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8118FDA9
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579946; cv=none; b=TRlUD68dkS9wgnSYEd749qjg0acUu/m1t++DrnImvViaOOs2SB3GDBSr2TkT1wVZJ9NIU1/xV/tPgqmF4AfYrG2HLI+2tuaooTg7TVTOVqR34IA4rXgoHkNKqHtp8IivCsEpNnkllU0Xn3jL7JLRWqSZcU0u0bZ1cwwYfjuvp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579946; c=relaxed/simple;
	bh=A/gOzPUwckRQSfrNHNR843u/F/x3yV4eQiL9bWvwnB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbAgXUz2xtmYDRwcQrUtYVckVOs2ZIMiEqYBnoeyEhjiW51gFczFoqFgj6DRnF+WskU8ZmGD/BWX2EG8KeLQKjtHGhL+eiY3VM7QZCtWidrW2QJD/A+m6Rq8LqRVdD49yaHg1nN5nlyu5WccctEmnGSybWOJ6Ax2iGfAJOXXvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZqa1nTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717579943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIHWoHv/QvLBTsW9LF2D/X7toxaXXwp5mTAPZT4vSL4=;
	b=PZqa1nTmU2uapPVHxr4IromQM2gN/8Zpb1RyAq5sODJLJytvfbNNN46uOeBTnL1Lz2oJSS
	glpeMVpIK+Z+JntcY+dz9mkMmR+BCW5wu1Kqi7WWVx932Y44wN2O9lDhFDx48JWMVOL19s
	bCfzAqSNNGdwccB5oDAR31bPuBX0gQQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-h_646ekmMcm1QyA0TxsC8g-1; Wed, 05 Jun 2024 05:32:22 -0400
X-MC-Unique: h_646ekmMcm1QyA0TxsC8g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ae19130518so23337186d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 02:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579941; x=1718184741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIHWoHv/QvLBTsW9LF2D/X7toxaXXwp5mTAPZT4vSL4=;
        b=rldNbug45SaTLQwmsaU4KB0ddSYS5ZgdHW7ng3zqo/IU2W5hmRSbjlbSWPY3TzlMrk
         /HJMhnOYrhstdIakx/jVZ4NxxyW0cpnbEc5ws/m6Itdmbm+1wdujExRekYql+tXUfz37
         sgUxV6nmB0swFOgq7Lpk1s3LYxiBJ7ursJFBohaT8w6H0NELZ/DoMYPnA7rA1GH5zp2J
         IzVjvkcynMUVupd28pUpVu/L42FKtNrCMgRLLrK3rnrxYVWFz8SH1BBbc1KnO3jDxoKc
         GGYZjisANLI8mlpntkwOI8qPQF17CPocUhW72G93wPt176MSckNap7EVhmmnsx9s7FSq
         INFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGi33elxy0imDXWxiCvty8UT0UDQiLbBKKdPLnJ/UlX3CUWceb/GZ2A3F1m5yj41PoRqVlodfV/PR/Tmdh6H6VyOLeTFx6k4k3jLkNDA==
X-Gm-Message-State: AOJu0Yx4zM7IMACwdSrNkPLc1YKKTPkkgSaNG61NLXZfGk3jYUTgZgU6
	61GLzTOipCzF7tn71hyDJ+4braYdvtLOCN5Adr8imAsySnPGLRn/pKCjDxVZznQYPqfYl6/BiyJ
	8w96ddZU7n7lGMgl7YBLHEA+5UO3mhRcqkwuMUhPdRpIsIyVLhxT/ep2CFQUUEWA=
X-Received: by 2002:a05:6214:3a89:b0:6af:2676:1a67 with SMTP id 6a1803df08f44-6b02bf749b2mr20745046d6.28.1717579941385;
        Wed, 05 Jun 2024 02:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ikW1FE7KKc1M+K4oFqEtBv+CXhwGrhdL4tT32ka2r1ldJIrtTLooEIM1RfE/m26z2wnCxA==
X-Received: by 2002:a05:6214:3a89:b0:6af:2676:1a67 with SMTP id 6a1803df08f44-6b02bf749b2mr20744926d6.28.1717579941039;
        Wed, 05 Jun 2024 02:32:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b405e14sm46658136d6.80.2024.06.05.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:32:20 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:32:15 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH printk v2 00/18] add threaded printing + the rest
Message-ID: <ZmAwn3pc5wpyA8fm@jlelli-thinkpadt14gen4.remote.csb>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos>
 <875xunx13r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xunx13r.fsf@jogness.linutronix.de>

On 05/06/24 10:15, John Ogness wrote:

...

> Yes, that probably is a good candidate for emergency mode.
> 
> However, your report is also identifying a real issue:
> nbcon_cpu_emergency_flush() was implemented to be callable from
> non-emergency contexts (in which case it should do nothing). However, in
> order to check if it is an emergency context, migration needs to be
> disabled.

I see.

> Perhaps the below change can be made for v2 of this series?

Yes, this seems to cure it.

Thanks for the super quick reply and patch!

Best,
Juri

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b9645e7ed70..eeaf8465f492 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1581,8 +1581,19 @@ void nbcon_cpu_emergency_exit(void)
>   */
>  void nbcon_cpu_emergency_flush(void)
>  {
> +	bool is_emergency;
> +
> +	/*
> +	 * If the current context is not an emergency context, preemption
> +	 * might be enabled. To be sure, disable preemption when checking
> +	 * if this is an emergency context.
> +	 */
> +	preempt_disable();
> +	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
> +	preempt_enable();
> +
>  	/* The explicit flush is needed only in the emergency context. */
> -	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
> +	if (!is_emergency)
>  		return;
>  
>  	nbcon_atomic_flush_pending();
> 



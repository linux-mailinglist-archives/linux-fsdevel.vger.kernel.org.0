Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF26AD7C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfIILSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 07:18:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42865 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbfIILSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:18:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so12301601lje.9;
        Mon, 09 Sep 2019 04:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YU5F/Heic/wQrryXNlwp20GNT69t9CUbHvlrLA5dbAc=;
        b=J5QdkebkgJNQn7971ElrZEaGBPIM9nw8WPDH2K2qw4xfiHukTeYSoQdmX7B/ypiaXY
         GQYNVMuyIAdfUivwq2/K2N7pj0GAw3omgFOR7/McV2iqAWvKJVP7rvUyTXHIURI4Tfsj
         1knS7eWtPGtcVs5GMLzHPsvmq4nBSmbCs1rfUud6xQRLalNMxGqljJz1AvuTS5Izm87p
         DofkeNkPakDGfxsyj5eZwiIAsZRTU96tdUB9DkyhTnefjzctGDe9grPOgsAnZaRmMTok
         tbAzTJsC5jyuciG9V9tXybp2xt6LZBn5MvfRy1JchesEv0FPABA7k9NWl/8f5xrFaOUd
         C89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YU5F/Heic/wQrryXNlwp20GNT69t9CUbHvlrLA5dbAc=;
        b=lekWKFT6bgFzdDNd824FtSBymfHrYOPQUvQx6wAQ0dIntTo/bD0bCzXWq0T+kReK5F
         QzwEX7WZjQZa13g5EVkjdxBsSZNh3AlrQ8CxebajZ0yljfjSTVEhx3k7qAwiMLsTLXSv
         Q6qfnb2uWMajVKt9qVHzYjtgs2oZaHO/+++PXboYy8Coval1BwR0/IMZcHVI2PVrFJzb
         2cVUjLFsuFDGrPMNi/CnV3MfYntVqzU36wOtBVfGxY8eql5spIE+PduuYSdoggeiDAuB
         wykrMn6UFg6qyuimhRqE9GuWI5+vdXrfUPHsrMuWmz29VtEDhJ3c9G055x2u60Wqrmvx
         gylA==
X-Gm-Message-State: APjAAAV9OVLZHQnbB/DSOQ+pMsrqgZQMJyGj+zQrft4Z/eM1nL9yY6Kl
        Hz9u9S175F24coQA03hvbj8=
X-Google-Smtp-Source: APXvYqz8eKtHx0wT8yiot80F7C+Rmg4f3j7RlGKd1Wu/G19OvFfB4uhTW7qxsQGlIOuCwdVKwWeyzw==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr15421306lji.20.1568027895520;
        Mon, 09 Sep 2019 04:18:15 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id p12sm2916453ljn.15.2019.09.09.04.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 04:18:14 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0CE07460667; Mon,  9 Sep 2019 14:18:12 +0300 (MSK)
Date:   Mon, 9 Sep 2019 14:18:12 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
Message-ID: <20190909111812.GB1508@uranus>
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909102340.8592-5-dima@arista.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 11:23:35AM +0100, Dmitry Safonov wrote:
> Shift on s64 is faster than division, use it instead.
> 
> As the result of the patch there is a hardly user-visible effect:
> poll(), select(), etc syscalls will be a bit more precise on ~2.3%
> than before because 1000 != 1024 :)
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

> ---
>  fs/select.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 12cdefd3be2d..2477c202631e 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -51,15 +51,14 @@
>  
>  static long __estimate_accuracy(ktime_t slack)
>  {
> -	int divfactor = 1000;
> -
>  	if (slack < 0)
>  		return 0;
>  
> -	if (task_nice(current) > 0)
> -		divfactor = divfactor / 5;
> +	/* A bit more precise than 0.1% */
> +	slack = slack >> 10;
>  
> -	slack = ktime_divns(slack, divfactor);
> +	if (task_nice(current) > 0)
> +		slack = slack * 5;
>  
>  	if (slack > MAX_SLACK)
>  		return MAX_SLACK;

Compiler precompute constants so it doesn't do division here.
But I didn't read the series yet so I might be missing
something obvious.

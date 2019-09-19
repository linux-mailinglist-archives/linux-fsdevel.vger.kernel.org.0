Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D084AB7B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfISOFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 10:05:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37549 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfISOFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:05:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so2474905lff.4;
        Thu, 19 Sep 2019 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+oYWN2bIpXs7KBEHPN+VQbt2Knn5M+tAZIEiVvjPno=;
        b=WnOLmi4XV+fV599arvh4a2gZ61D35bWIW65sZl4YLcHgL7/9m9nDOASpZ6mqQ6XC2l
         GdZWsGc4tJambYUGw8KGL/NNyUy7l299bfuYXj/nOWdH++cO+ylhE/dFDT82KOEyfrUX
         74HB9Fleun4Lz8khKtFolG4hQaZl5sV2UmAljYww8q47VrwS/bkYe4Va/kMf/9HZQlpI
         5r4xitcBI4tfwi88E2mrI0pNqbUQkPNGJ1B7lMib2+rioqqqVhmabKllheM+RC5A+hU3
         paH5b4MgaKleBDPJ+9I+uf0pON8CCULTEmCC3VBBRx5xANQlSBhDWcrLwjj60ED1wDLX
         tRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+oYWN2bIpXs7KBEHPN+VQbt2Knn5M+tAZIEiVvjPno=;
        b=bo2qawVqye7fJMJYGiRHm7LaG6xnr3sXxaub8lIosO8q1iKMO5w/O6WRR1YjeF8e8l
         7FPWr6FoHAaPRHnBrG4vwxVhOQYxyvMoyCZSS86wjbf2rJ4mIUPoZsk2HUyLK8pvMgJy
         8aAGNH4h86RGGmSjace3+mZ32UZ8RBcn2JNEDRnyAA6qgeJ6d31GPkzLmDTaCEvBtmN1
         oK5eHw3cxTWM3UJTc17yobxQ59uPGaUMIwOcFxcuAfXKuZU/RQrqkp+RznV8ixMkZBxf
         aXtO/ns6xrQdg8h1FgceH5hAIYT6cfbMDCy5568mn4oHVdYCA6ZmFs1iHn1vIsz/oYuw
         trjw==
X-Gm-Message-State: APjAAAUwl3D+3tWgPmUCbCMzvBs1bah2ubJM1tZdgtpu4njZXqOrlUmq
        nGy9VS6vGZQ6TWucluK+wNI=
X-Google-Smtp-Source: APXvYqxsPhcRFukc4IhdmQrXZloLSMPMyygyC8uuqAoW+bU7v9Y6FGk9oe/nfiOdkCTm7I9+kXY4xA==
X-Received: by 2002:a19:ef05:: with SMTP id n5mr5030008lfh.192.1568901949733;
        Thu, 19 Sep 2019 07:05:49 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id 77sm1689625ljf.85.2019.09.19.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:05:48 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id ED6ED4614AD; Thu, 19 Sep 2019 17:05:47 +0300 (MSK)
Date:   Thu, 19 Sep 2019 17:05:47 +0300
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
Message-ID: <20190919140547.GC2507@uranus.lan>
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909102340.8592-5-dima@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

Btw, don't you better use <= here?

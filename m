Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234F519AC5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbgDANEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 09:04:24 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:50406 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbgDANEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:04:23 -0400
Received: by mail-pj1-f50.google.com with SMTP id v13so2702281pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0LpzoKBtxdE1EIqwH+WF8IajwEfMlbTxCiToqeJLDs=;
        b=tov01zkTfCr9FMYEJul4OL8VaNLUaBlzf/RcwE0BPr2KU1CVsxY6RKar2CCpfgzTCM
         bL9ic0N5EYKLR2EUA2uhbzznwmB6ZQNSDc487iEJ3f1pc+R0AmCmHejAU3uKXB/+TjX3
         q+9eTf2Byp6cfKtxIeiVEK1z7UkE1TiLx4crWq1UCQd7pDSO3MDV8xopar00us5oFJPR
         0lgDS1sUEQysL/u6G1lj+LuJeI2a7cHDmrMcxXvxCkgwf9RRTWrz86qZmEnkQe5qsPCx
         4y2OHPd7uGJ3g0p96CA2spRQoymHtZ3+Q/aC9hvRQm8xMLp2ZZIOKk7EaZQwlePp/ofM
         zn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0LpzoKBtxdE1EIqwH+WF8IajwEfMlbTxCiToqeJLDs=;
        b=q7Bph+96J4lEJQqyIC5EY4mQopQ4QH1WTcEY/p5XlueXbMLTX32cgtb1tX/cHvmD05
         NlPozlh6y8R/Uq91Cf9ZTdTz6tnqRXvTaeP2rQyIWegCBjIF+fJFSkrq/2c264Fa4Vxo
         xoSO8MA1NBeF1Ja9wxtHPo+hUolESgvsVBKcZNG0TpRBqhU5IQyIXkxm1rj2BvTPBj6s
         uFKaUQyhlN2xyXW6sISSkbyC5jElNISrXQOm1ESBkBNcvx/xvvEe/A/OwgdNQ7DKN4ka
         EBUJomfJJOH47kDhF6bzD0rVQMJ/C1uwsOfvFl+fPnUTCcc6hXWF1Im3bHHIYt/Nohc5
         L+3g==
X-Gm-Message-State: AGi0PuaesYcUfZwdL4bcSAoquBdwBnoBMcTwep0eZ5cPjItMn6FKo3+4
        k9oYW8g++PxGssADcNmTErXTZA==
X-Google-Smtp-Source: APiQypILcnoRSadC9assugQKxNMol2Dzlqx/Bor8ULFQrBWMqeL0mRPSNW/G6wO6FnHSJSkXW7vPXw==
X-Received: by 2002:a17:90a:8a17:: with SMTP id w23mr4541353pjn.94.1585746262705;
        Wed, 01 Apr 2020 06:04:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id kb18sm1810284pjb.14.2020.04.01.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 06:04:21 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add missing finish_wait() in io_sq_thread()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200401091933.17536-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2097c01-4f55-90f8-9ae5-60aaa6623964@kernel.dk>
Date:   Wed, 1 Apr 2020 07:04:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401091933.17536-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/1/20 3:19 AM, Hillf Danton wrote:
> 
> Add it to pair with prepare_to_wait() in an attempt to avoid
> anything weird in the field.

Applied, thanks.

-- 
Jens Axboe


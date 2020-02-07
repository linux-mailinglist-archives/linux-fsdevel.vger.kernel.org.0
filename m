Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6E155B77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGQMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 11:12:42 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44311 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:12:42 -0500
Received: by mail-il1-f194.google.com with SMTP id s85so2124254ill.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lAnZ0KfpoJFXJXqEJp2h1hR24YKg8DCqzE8GT1Sg/80=;
        b=ou7OV9nXB1rt4NAnNWVFHl5DT/z7arx3n217cok5UsX7/dZAEB/6gZZdgo5CRHKbtq
         5MlVqxPBMVocDORdwmh/qiT1eSTmkMlpW+xIzeN3lYZj98PTiGVeUysgpuqebVnyMfiq
         THrIoHPrfTrSpAMEGRQRuOOADT1okKx60iaHfjSi1C1VhnvFObLxss+/wqKfXI7daUDo
         pU/yQEV036+gvU2gQoav9vyoYArKiK9vm0yjiEh4WmHKM/WvGTROd9a/JsKEr/iXZJcR
         ldiZWBGMsC3THXrmtMnOunfqXpg7KjPd+OY2Uh2TwkySzeCQVCs2nUoko9r8tFVpqwk3
         j47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAnZ0KfpoJFXJXqEJp2h1hR24YKg8DCqzE8GT1Sg/80=;
        b=gCYiRlf7uweqiOpsbZH1L3TSEiSiAUWTtIIgfDijJECcvJ273PR8dR2cSRsY/iE3o8
         3shfbtbLmgWuy+Ep3u4VVb49ICn6UY/vEj2lswUJUzWsivqeTgI4MZp7eGWl8MkZ3ZvV
         xJumjeN4SoR6f3rQr3mQHx3p3lLV9Gc5Nn7TbBYklpnSBZGFKHBUvxTLm34E8co2FepG
         pmuM8pBpcgIh4GPYBQhd3jT/N7Lf2dsTKGtXJl81uRWtxPv5mHd1l9ymSjIeXzgwzyAd
         uiM9CqYPDam4K4oRgDKo6jx5FFOYr58qds+jY7NRBvw/mJxaIEL/LkS/uc4J3jYz6CRq
         wARQ==
X-Gm-Message-State: APjAAAWIDe0beHDxyq58AGIJWbEV6O4C8pD5kMv21m35EggMLhUxfTdV
        mbYyck7JH5FmDZG3WDr0Uw8kgg==
X-Google-Smtp-Source: APXvYqxlLfKpSh0/MAQWoZOGzqwYq4/oCYfhJFBjQabCpXWy7DdmtSgrXlico21x2I3TZIkM7UM2Dw==
X-Received: by 2002:a92:3a07:: with SMTP id h7mr87346ila.203.1581091961049;
        Fri, 07 Feb 2020 08:12:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d7sm999245iof.14.2020.02.07.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:12:40 -0800 (PST)
Subject: Re: [PATCH] io_uring: flush overflowed CQ events in the
 io_uring_poll()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org
References: <20200207121828.105456-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
Date:   Fri, 7 Feb 2020 09:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207121828.105456-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/20 5:18 AM, Stefano Garzarella wrote:
> In io_uring_poll() we must flush overflowed CQ events before to
> check if there are CQ events available, to avoid missing events.
> 
> We call the io_cqring_events() that checks and flushes any overflow
> and returns the number of CQ events available.
> 
> We can avoid taking the 'uring_lock' since the flush is already
> protected by 'completion_lock'.

Thanks, applied. I dropped that last sentence, as a) it doesn't
really matter, and b) we may very well already have it held here
if someone is doing a poll on the io_uring fd itself.

-- 
Jens Axboe


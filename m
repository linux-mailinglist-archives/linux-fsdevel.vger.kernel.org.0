Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BD235391
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHARC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgHARC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:02:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159FC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 10:02:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so5674786plb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gVjl1fxVk2phmm6E3dsUk+Vd8Kon2yS4EGOlu+DC8qA=;
        b=xoGV0gXlv0W7TosbAf87l0OGfBJMV7uZa+lmmZpczEuAWDna/mwq+dGD1Luj2HWsJ/
         r/incAFP942ignqie8l3t+1D25tkhIb5d8rFNgEN6UNwCqrmCPk2BWTkRgJemUPcgXEH
         nrblQmguOw6tZ+0cylPpmFuh86sYQs665GcdjWO8/ZFXRC12pBkfvgvr505huIp73Qfb
         LUMQBKgXDJPzOxETWdHmlpBqvlcxtWWZhGNNzt2O088uGtZvrCDOdxKqJUQSrLVV6lcC
         /Od5XWQ+3r6czO9wjniVOXkVvjokqhpdjgCIxEHme4ozSQqQ/DHQrQL9NoyYHPFRV5dz
         8JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVjl1fxVk2phmm6E3dsUk+Vd8Kon2yS4EGOlu+DC8qA=;
        b=ATDBlJBqHZRdB0ApvLt5LeKns5DjtToWiRgd9e8CLmXOhDjz52t7MgB3K1X1EcfO32
         xDf8iRMl4cv02QoJEo+nLUo84vnoG66/zQKm40S1INh2MCCM4zYeIQV8e2nLn9oXacmS
         hdQ7IQXzy55JgASg7BCydIa8dlDmNJf+I+++KoavnEI5n0Yjuxce3vPRsjgL6Hsl3Yt4
         l+EOTLrlWRnqDtUHrCr01Mg0ygMBGnj/GrBG6rA6PO4vi/DRcYJ/g2pJ6PcLR1IFX5bu
         t7sZ6+ji3YSDrGBMZRJR+AjsS1a9+RzwTtmiOWhRCu4ifip23LqLePLdibg7a8pi8OWy
         t+2A==
X-Gm-Message-State: AOAM532BHHnzGU97tUsr1V5YPJiTgGmjMdab1eZDuv//wdIPIOC9QZxB
        Fw59Qt+zjW2YBDQUCd/XzF5btg==
X-Google-Smtp-Source: ABdhPJxHlTc2y+Bx7N7BqErBz0zEsNyD0GOHmEURfyOD725Rvk/bWYX4uIqsf9dLKUMjXxcQHdC2FA==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr8251008pls.244.1596301345796;
        Sat, 01 Aug 2020 10:02:25 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id oc4sm9226846pjb.51.2020.08.01.10.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:02:25 -0700 (PDT)
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <636faf6f-4c85-0582-2482-b99002888d0d@kernel.dk>
Date:   Sat, 1 Aug 2020 11:02:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/1/20 4:36 AM, Pavel Begunkov wrote:
> Use a local var to collect flags in kiocb_set_rw_flags(). That spares
> some memory writes and allows to replace most of the jumps with MOVEcc.

I've picked this one up.

-- 
Jens Axboe


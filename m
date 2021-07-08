Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17ED3BF3AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 03:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGHBzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhGHBzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:55:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602DC061574;
        Wed,  7 Jul 2021 18:52:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b5so2116540plg.2;
        Wed, 07 Jul 2021 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LpL7qx90kO/NgJfcn2pzZvgiawADIWqcEOHPJQejQw0=;
        b=ED2uT3QB1HhsWxq1L45xwQou5AP4Y9WzFSN7zd9p3D1IF3z4fKaxHBfgzMtKaGl8kB
         wYCq5bstM1hSbqb0JUlCcIjSpFgugdwjJQ/YJFt5+lgApZCzYWAjkaryJTGM6w27n0uN
         TxT2ow0e00/iPygqFBfSESLftaH0KoyCj8Y+7AeANXFXHxwZfgiDqP1kr9kbV8z4AUEn
         dWOEIcoxRjuVj2KZ7PVn9BxSvF4gdsa7bSypTxCkLCrxGxG94neeAg6KE4XYWvkg6IdN
         6CFjTqkgCQnmbCm4IaJ3CuX3wp6rjMGtvpz3Tmk+Rk/cu4dORuidAIcGq6lZ59eqHAWD
         KGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpL7qx90kO/NgJfcn2pzZvgiawADIWqcEOHPJQejQw0=;
        b=K1o5B0kU6ZeDQOxq7SmL7v/N43U/2U0h1QyoUkSGG9OdbhgREI7T8XYIIFp2fKaPk6
         KDMg2nsDon54t1EdO1xOVOvdxVeOX/R9cz6euUv0YY7cpIz66xrSvXz703B02YhAMQwO
         QiRjkH1tYk1o3OwgW64TFXiFYypDJnMBRKSuuccvJKuLipHNF5DWBfoyNWyVEteJ49mW
         ronPZCi85KCHCOuM9v8MjC58EfbM+M1FpOVKmzA7vRUoX0vg7ENyTB5kFM8ovDR9DzI0
         FbVzvzGc3Ue2IZa91UEu6+Hm69why+sns8k1mL+cjH01Us0FvAbwv1hQ6P2X485rPWEb
         OQ4Q==
X-Gm-Message-State: AOAM530v+R6ZNQ/ErPonHwhpCs5jIK+pFX1SYATBclt//42bTT9WxqPZ
        CXbsWxeCrTtrneu8LBgzc1o=
X-Google-Smtp-Source: ABdhPJyCISuCbgDROL/gqJ0JBv5xppQzbfXoTRY1Of4YmEnuf7J/NnVqeEWvz0Q6P6hvE1E01bB4JA==
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr12177096pjb.37.1625709143189;
        Wed, 07 Jul 2021 18:52:23 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id f2sm491957pfe.23.2021.07.07.18.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 18:52:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] fcntl: fix potential deadlocks
To:     Jeff Layton <jlayton@kernel.org>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210707074401.447952-1-desmondcheongzx@gmail.com>
 <15fbc55a3b983c4962e9ad2d96eeebd77aad3be6.camel@kernel.org>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <12c41697-e9ea-3326-b906-bf15a0a4dece@gmail.com>
Date:   Thu, 8 Jul 2021 09:52:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <15fbc55a3b983c4962e9ad2d96eeebd77aad3be6.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/7/21 1:06 am, Jeff Layton wrote:
> On Wed, 2021-07-07 at 15:43 +0800, Desmond Cheong Zhi Xi wrote:
>> Hi,
>>
>> Sorry for the delay between v1 and v2, there was an unrelated issue with Syzbot testing.
>>
>> Syzbot reports a possible irq lock inversion dependency:
>> https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b
>>
>> While investigating this error, I discovered that multiple similar lock inversion scenarios can occur. Hence, this series addresses potential deadlocks for two classes of locks, one in each patch:
>>
>> 1. Fix potential deadlocks for &fown_struct.lock
>>
>> 2. Fix potential deadlock for &fasync_struct.fa_lock
>>
>> v2 -> v3:
>> - Removed WARN_ON_ONCE, keeping elaboration for why read_lock_irq is safe to use in the commit message. As suggested by Greg KH.
>>
>> v1 -> v2:
>> - Added WARN_ON_ONCE(irqs_disabled()) before calls to read_lock_irq, and added elaboration in the commit message. As suggested by Jeff Layton.
>>
>> Best wishes,
>> Desmond
>>
>> Desmond Cheong Zhi Xi (2):
>>    fcntl: fix potential deadlocks for &fown_struct.lock
>>    fcntl: fix potential deadlock for &fasync_struct.fa_lock
>>
>>   fs/fcntl.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
> 
> Looks like these patches are identical to the v1 set, so I'm just going
> to leave those in place since linux-next already has them. Let me know
> if I've missed something though.
> 
> Thanks!
> 

Yep, there's no change outside of the commit message. But I think after 
the discussion and with config DEBUG_IRQFLAGS, that is fine.

Thanks again, Jeff!

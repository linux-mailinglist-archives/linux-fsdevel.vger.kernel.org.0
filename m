Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6147F9B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 03:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhL0CDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 21:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0CDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:03:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C411C06173E;
        Sun, 26 Dec 2021 18:03:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mj19so12291663pjb.3;
        Sun, 26 Dec 2021 18:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CX8RPFqWxmhuiVbKNQ4FRnbHGl327frRd5MQyfbYU5o=;
        b=SkVSEBC+WnWQHfBwRMVBlgMGQHQ3PnLzPy1yC/PTMRU7Xh+jbaHq5XsadJwSUWh/5G
         j883urY7a00EbAyfKOhvGGkwNTcxzB+einvMknl78hpSShRlSrDd+/AlqBP/AE3YEpEJ
         OQe2YsqWGC9U9+R80qfX/i1en4WDHWS6o9oZvHDe5lgCipOAR8nw3n/eUDUH6lmH2reH
         fMbXLObfyfMs8aDm3l50DyXhTayqUE2moS4Yr1EdCau3Rk9862oDumoToycKpWQwT53A
         Jg4fEQcDISNjoHvol0BkihC01usi8mVsvnCzdL7i6FRmrrPfmrB8rrZOIvUW4Z8q0zkR
         FAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=CX8RPFqWxmhuiVbKNQ4FRnbHGl327frRd5MQyfbYU5o=;
        b=yO6NyR+oCx2CGPORNNV9WXg+v1m89rcNRemV6RP0A9fGybCJNIm+hIS6Aict7hsWHf
         bZXw/kFcuR1cdoUcP8KJgQvo0FEZTLRo53yLieTsuk3c7l7ii5f2aN1G3a3vfOJIkRVP
         7UzLoWArZfb0dydIDt7epJh556Sm7TNNUOaPCd9pscNKuFzPhr0XhyRL2aW4R9Iwrc4W
         pLgkUcY8X9lVwFOz1xBF2pYUir3t4829iFL7Tp8nTrTojW3zcYN94bP+6wQyslNpjqPM
         xbFoEDa2C9pYDLIaKOHIOFnRTOP6yuRJ6/Tws7xq2qj2moS3URpyGGyCn1J0Jjog7QNt
         teSQ==
X-Gm-Message-State: AOAM532Tb/rZaxwAYlwZ/JZQUbyxn4fDidHCDSvO37E3PKRtLlKA1Q1w
        K9IdSP7awgSo9SzkHjLKcBdyJ/wY3Bg=
X-Google-Smtp-Source: ABdhPJx9dp/ISjZkX0GFCT7ZHg5zUj2X6FUNNQAIL8tHfuC/vnpQIWWCd5moAcra8W/SfkGluOQyxw==
X-Received: by 2002:a17:90b:38c6:: with SMTP id nn6mr19144122pjb.26.1640570618594;
        Sun, 26 Dec 2021 18:03:38 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.127])
        by smtp.gmail.com with ESMTPSA id oo6sm16806044pjb.7.2021.12.26.18.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 18:03:38 -0800 (PST)
To:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: super: possible ABBA deadlocks in do_thaw_all_callback()
 and freeze_bdev()
Message-ID: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
Date:   Mon, 27 Dec 2021 10:03:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

My static analysis tool reports several possible ABBA deadlocks in Linux 
5.10:

do_thaw_all_callback()
   down_write(&sb->s_umount); --> Line 1028 (Lock A)
   emergency_thaw_bdev()
     thaw_bdev()
       mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 602 (Lock B)

freeze_bdev()
   mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 556 (Lock B)
   freeze_super()
     down_write(&sb->s_umount); --> Line 1716 (Lock A)
     down_write(&sb->s_umount); --> Line 1738 (Lock A)
   deactivate_super()
     down_write(&s->s_umount); --> Line 365 (Lock A)

When do_thaw_all_callback() and freeze_bdev() are concurrently executed, 
the deadlocks can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if them are real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai

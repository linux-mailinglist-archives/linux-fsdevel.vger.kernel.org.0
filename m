Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3957B243C04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHMO4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMO4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:56:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6EC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 07:56:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so7573682ioh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2N3vz3aoKozJuLd8HhRVAVV0+DlbtHXg7rxrCEwGelY=;
        b=2Av2azx9MhIvUoXaAZXBnYYlP5YN9u45JAgTOqjgnW9MJlQOpjRtOVGtv6zITH6N20
         34yQMx+43blJDN9CwZEFY2EGFBSsba0p7OCFNYfgpJSDFcynpdO0ziqX1zJsENMYMkzE
         /YFiX8ORzlZ5qq/qP0TrVKNgjawRTN2sOsyMErmwsJ1hspoYM3E2/JB38VF7rRMBQALL
         RK2riwofKiC7kxl4YkPouojYjjgcZLoi3D7TOPvCuSvY39rCq/W9EkN5PFt1Aul+2Z2O
         Su1r9y0eBcGqgPhekBoedLpDnYcwNO121jDyo36iJnos86vrInbGyoO/LfAa6EhlqzMT
         G/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2N3vz3aoKozJuLd8HhRVAVV0+DlbtHXg7rxrCEwGelY=;
        b=fUHdcwap/bvuOqNuMGeSsG9580WPvFjI7pEhQ4n5YgbgIuw/B08A+l6KyRGk599T4P
         7m5DxOpEC4o7oxWRIa8cnWVaYVnRq+YgfyAE8aIjoMQG5ejx8WUDHN6E+c0PXROl2xLR
         DdDgR9TDMt6Wta1dA+EzMceGUqOHEgZ3rIojyCIz+MJeo2Aa+zRN9cC33oBwiLSivB9x
         57f7fc1SSBXZRklQ9e7LQQaHYi+r3ikX90APvJwoR9Hoijmx1Jw7wAYT4kutR59Uc4oF
         kQ86hJ0egwdJ857NTzxBgqrslk3SVyqeMbJx3LzYGPQfzEL+h0emS4NGi70zXSXbYllY
         TG9g==
X-Gm-Message-State: AOAM531xJlk8od70X8HK1oBF57ICGfr3ohuzDQOFcDb6NnEXGLgfsDzp
        kGpjg3H5LtcxI+DgTK1W7TGcbr1fLpQ=
X-Google-Smtp-Source: ABdhPJw2yxzFwbHDrUKj9GjW5VjBSwwvqRtbrnuWKdCOX0w5kMRjsicXpo2Tt4m8J+or3X1H7vOCdQ==
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr5296096jaf.139.1597330591852;
        Thu, 13 Aug 2020 07:56:31 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm2892965ilt.2.2020.08.13.07.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:56:31 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: Fix uninitialized variable is referenced
 in io_submit_sqe
To:     Liu Yong <pkfxxxing@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200813065644.GA91891@ubuntu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fd08f8f-8c89-9c59-6d9e-5933ccc65967@kernel.dk>
Date:   Thu, 13 Aug 2020 08:56:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813065644.GA91891@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 12:56 AM, Liu Yong wrote:
> the commit <a4d61e66ee4a> ("<io_uring: prevent re-read of sqe->opcode>") 
> caused another vulnerability. After io_get_req(), the sqe_submit struct 
> in req is not initialized, but the following code defaults that 
> req->submit.opcode is available.

Thanks, I'll add this for 5.4-stable, it doesn't affect any kernels newer
than that.

-- 
Jens Axboe


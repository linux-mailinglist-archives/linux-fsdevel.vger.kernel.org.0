Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B812E2CE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 03:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgLZCmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 21:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgLZCmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 21:42:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6AC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Dec 2020 18:41:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m5so3222089pjv.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Dec 2020 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sz967Nqj1/pd7bQUVbnHkxFH6yQ0h6Xp7ixrXUk89/8=;
        b=vSwpSFmCPplJ9v5fFXpePWTVhZJvocxqvlAfdYx0e4txIvnpXJNJGGT3F8jK3DdNHs
         VpXbIW8SpTWCmMmwtGC3fGy/hdRsW4UUM4k198PxXMZVj1dZfdoq1fxBcTsUTRPqFQah
         HlIiFSBVy4A7MEg6+FMLZTomMG//rsW6laDu6zFURUQhbdLtR5S4ionVVxk/ONZ5Tic+
         zbrP253lvbAxgCnFqSdV0sv/V/noKTq0KGeyoHxdNUY6Go4VSlr04PUCPGUAubeiZWSf
         +mlAOt2j8efRwKg1vniw+C7l4LzDZrVNsdZchnZKd6gJJiosJNXjkbE+O3c6V+NtWN3f
         wnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sz967Nqj1/pd7bQUVbnHkxFH6yQ0h6Xp7ixrXUk89/8=;
        b=GjH/YatDr9H7zjTfrm1hGYXB1KUD155s+Y3d69vPcZkb52Zhb+B/ZGTu6s/s078tlj
         KLaV75nrN94BWhD8TtuqtgWgCSqAxoy+ZvLaUM1nRFqn1tOdVScEOkTssf417UG7rELC
         LORce61EHOUc36oyTIN1+ayxCoOWEfE5yTrfUYcmJEHIObIw9U0fR9+JU3UVozTLObTg
         123w9/b4FE+zq7v8KeThe0sED8oelGpfMsF6og8xpf1Ne9dHzE760w6ISOFiJHsLRC/U
         D0IULdwM1WiyiBFY3aLy8fh0+i9GrSQu2wngqQ1VRsaUqBT6hx5FCyi5wlJOnY8RGKiS
         nZDg==
X-Gm-Message-State: AOAM532EMgG0VE6wN7dtKe1bHC6wH1298QwjGwRupEc+STZxfoJ2+dmy
        EKD/I/euh0voRvKpS+AXCeBTIVsC+VwxIQ==
X-Google-Smtp-Source: ABdhPJyASFpoRNWXZPNDPj7L+WwzB6DO/dTRSPQs6xWtnLao2nj+fURQNjzXgsPg5JiwC7L6ZBN52A==
X-Received: by 2002:a17:90a:658c:: with SMTP id k12mr10771501pjj.31.1608950477926;
        Fri, 25 Dec 2020 18:41:17 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 68sm3541788pfe.33.2020.12.25.18.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 18:41:17 -0800 (PST)
Subject: Re: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
References: <20201217161911.743222-1-axboe@kernel.dk>
 <20201217161911.743222-2-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
Date:   Fri, 25 Dec 2020 19:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217161911.743222-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/20 9:19 AM, Jens Axboe wrote:
> Most callers check for non-zero return, and assume it's -ECHILD (which
> it always will be). One caller uses the actual error return. Clean this
> up and make it fully consistent, by having unlazy_walk() return a bool
> instead. Rename it to try_to_unlazy() and return true on success, and
> failure on error. That's easier to read.

Al, were you planning on queuing this one up for 5.11 still? I'm fine
with holding for 5.12 as well, would just like to know what your plans
are. Latter goes for the whole series too, fwiw.

-- 
Jens Axboe


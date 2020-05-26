Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206E1CC234
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEIOnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbgEIOnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 10:43:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C75C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 07:42:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w65so2482875pfc.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8qtmaJLYw4IC+4FDva3MHRax/v6YPJc7TOvGR5mHtPY=;
        b=X9FK/JC5//r6bN8vdxWdP6Knl5vDy4zg+XMFdHWIkRlywRYquT31GmeuUUp+0estnx
         PvZkQoE119/yNyqOE5+6bpy3vJL3qLTdRiBm4JqVkxA2x7S67+ye74gufcsMBjMNsjxM
         CFqx5sx7TR+RtPusFB+CZ2q+RfRdRGsK+c3U5YqsCazDh1zMos2M3/kOD1dVPhc/zq9B
         MG5bUUeoN7mXP1r+eqsZr2kFdFXcVAGIFDyT4WA8LPrbHclWxyx9P+P0A7IxoBxRWBIf
         5siU0VxFuiJ3QvZGEysjwmKkxTdNcn85P+LLdwxuiNu4JcabL03NynLeiQrHdz4hXh0A
         hYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qtmaJLYw4IC+4FDva3MHRax/v6YPJc7TOvGR5mHtPY=;
        b=UPcqOsG7ecuA20Fy05mn3luWBT3Sq1i8kHpiDpo7MKA+l86IxKSHHIPOhJzmemn39M
         jPsxJfNorJbbQ36UeCKIQHmOzj9mfz6DN/20+rG6mqTjgza/6gwnNmX5FCdBpXNmAPBY
         tZpCpohdMO9Zs5IU40xMSWrOJ2y685yVddiUaZz7lbmRaXUDwzLdAHIREPjC47H8+pjT
         kADvS3x+6SaWnMdV6eGgR6SOYr1dGbgysPWPf3a3OFNUGfJUHTN2nYoY6xtknpPLlt0N
         SUh4czqAJlNERVXb2bioxlP6fgpM1MVd+AwLuwV3HNQltqt1EMA7kA0LlwNnz/ToquRb
         3WMg==
X-Gm-Message-State: AGi0PubAnLRDrBMwBVh0+gRt8hZDRVQsfoHwqK56VX4EP17XmU7Uv/eN
        8buUJfB+g6NWtPibEdhdnnETcp2WP4g=
X-Google-Smtp-Source: APiQypLeRR1OSt+0AcoaHdeXNyu/1vZfyZ/IXuWQ6Zk+bz9jVct5eEG+6jPSmcmKcQXQaO6L87T43g==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr6829910pgc.269.1589035379319;
        Sat, 09 May 2020 07:42:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w125sm3796396pgw.22.2020.05.09.07.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 07:42:58 -0700 (PDT)
Subject: Re: [RFC] splice/tee: len=0 fast path after validity check
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <14d4955e8c232ea7d2cbb2c2409be789499e0452.1589013737.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29de6592-8d62-5b5d-9859-d7adcc58759b@kernel.dk>
Date:   Sat, 9 May 2020 08:42:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <14d4955e8c232ea7d2cbb2c2409be789499e0452.1589013737.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/20 2:46 AM, Pavel Begunkov wrote:
> When len=0, splice() and tee() return 0 even if specified fds are
> invalid, hiding errors from users. Move len=0 optimisation later after
> basic validity checks.
> 
> before:
> splice(len=0, fd_in=-1, ...) == 0;
> 
> after:
> splice(len=0, fd_in=-1, ...) == -EBADF;

I'm not sure what the purpose of this would be. It probably should have
been done that way from the beginning, but it wasn't.  While there's
very little risk of breaking any applications due to this change, it
also seems like a pointless exercise at this point.

So my suggestion would be to just leave it alone.

-- 
Jens Axboe


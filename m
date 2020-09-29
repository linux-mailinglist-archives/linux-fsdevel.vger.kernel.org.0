Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0D27CFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgI2Nv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgI2Nv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:51:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE11C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 06:51:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so4850122iom.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WMGmtQa6ClPKTk9I0Qe27ZlY0TWICUs47q8H5rtasZQ=;
        b=RwnVJiqjR7A6uB4vz9E0Hl3Uaz7PqUw5pEA7JYBDirM1jpuHZbHGShYEFxeHRu+luw
         TrDMOzXRcVmK4fSozUu+g00fZLSkZUZg+6p6OWiag+ZAHNS09Ct2cihob+vv5vxw8QEa
         MZY9sXpiiW+j5Szb7SHNFsE8S0voiaWXCihESKgxepWPNadISVOG6Sx/7sEKMbdBP8MP
         rpLjg7PotTz6X8wYxofaTnSaIBtYQsKp5MwLCzpHBKQrTw+i064emrMKygCM9U3PN9O4
         1ydL651S90YYK9gy+9GvD/pmM36QTCEEPwpa2Fh0tOkbfl+6RBWYjOGRTVjPocDXNRan
         BOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMGmtQa6ClPKTk9I0Qe27ZlY0TWICUs47q8H5rtasZQ=;
        b=E+AKsg4QPK09WtFO5abH9KrMf3WpiJ5+vQm132Ipqaex6tf4eIP5OeM/Rb2Hao9Bbw
         WS6VNjrJKwdVTzEwPxI384dwQPQuw+FU6wc7UvA7qj6UiMwpUPb1d1OMg2GOlIWz9Rae
         mfeMxxvsWIFP207j1bx2I0gfjPkF652CdcDuEeOS9eVWE/U3NtHCwnEtmXj3KL0mvPGJ
         hBFCVJmdl1zB67izl29wIs6dJo7+niUvaqfVbiuT8b96y6GE43PGtfnwCqNWKHSnhHUZ
         q9rjzkDAoAEFa2FeCfNxRix6y4nHKeC/vXVToynu9qtEmIhuJ9W3IMPgCDjyFpYuID5Z
         YWHw==
X-Gm-Message-State: AOAM531eOurkv7RFey348UxRN6FQgAI7A7zuI95/4hLJYU/P/Jqg0H3C
        DhgAW/pIkTC1G+mgGCwlkVzPog==
X-Google-Smtp-Source: ABdhPJwBipjRGAd/WYNkjmrd5zb834hQvg99Ll5t5VuQ66gayLCoS3zLN+dUWPhlE4wQ+qZsUOSlfA==
X-Received: by 2002:a02:8782:: with SMTP id t2mr2973143jai.56.1601387517454;
        Tue, 29 Sep 2020 06:51:57 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f2sm2441545ilk.38.2020.09.29.06.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 06:51:56 -0700 (PDT)
Subject: Re: [PATCH] io_uring: support async buffered reads when readahead is
 disabled
To:     Hao Xu <haoxu@linux.alibaba.com>, io-uring@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <1601380845-206925-1-git-send-email-haoxu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ef7da28-f6a6-827e-4881-dd78a4b92bf5@kernel.dk>
Date:   Tue, 29 Sep 2020 07:51:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601380845-206925-1-git-send-email-haoxu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/20 6:00 AM, Hao Xu wrote:
> The async buffered reads feature is not working when readahead is
> turned off. There are two things to concern:
> 
> - when doing retry in io_read, not only the IOCB_WAITQ flag but also
>   the IOCB_NOWAIT flag is still set, which makes it goes to would_block
>   phase in generic_file_buffered_read() and then return -EAGAIN. After
>   that, the io-wq thread work is queued, and later doing the async
>   reads in the old way.
> 
> - even if we remove IOCB_NOWAIT when doing retry, the feature is still
>   not running properly, since in generic_file_buffered_read() it goes to
>   lock_page_killable() after calling mapping->a_ops->readpage() to do
>   IO, and thus causing process to sleep.

Thanks, this looks great, and avoids cases of io-wq punt where we don't
need it. I'm going to run this through full testing, but I think this
looks good to me.

-- 
Jens Axboe


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A88C36B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfJAOJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 10:09:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34041 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388693AbfJAOJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:09:24 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so48312291ion.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=Ghk4OsGG6Oz7tZ5M6eRx1P6XEdLbmrF2aEY6vccsaJberBmlyClMkjTnCDUvfgSoy8
         oNi1eKeNRo3+bYcSn0gvIlsZKya2riDbF2MmiNMpb7tr9rGA5cB4bFPRVNLp4ol9yMiW
         QOU8U5m+QQemvlzF+O/n94HQ8AEX+KydRPxZLaXLyFrOhBDD0qb8JoT7+7HaiAsuSv5X
         3yeuYt/vsr2NBT/WYeEUw/mYX2/5yk5mfMBYthUynDq3HY2i1hMmJq87rszhxXsnTUL4
         vfcatmG2SXm3yADHfu0rFgwrswiTFriyhC9Ak6WlppWNDCzwuRW1URjT03nKqaIGOZ8v
         YlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=SjhS6fmYeTu17MNEdZ0Y4Oro5VS9qiRbJwXMI/jNLKfRfWKa1PtbGAHZAIv5LohZ4C
         DlbvF3Xx3urYAqgCj4Ah7u0FJfAgagJoMIls0dqRpd89XeccHTPgmis1SKw2b2D0t7j4
         W/BpUO0gHJD0/+3TUtZ6G+avmtxVfUfdjDVjPcI3AdmNix8qytX8D4Q/ijpfYd7zHjli
         BZcwT+NEaITlda7vyK204xYJ1ZGU1klgn/rz1Du9/ZQ4EVwJEGjqOi4qkS5tW4QPP9nj
         ++xn+w78FPF2phef86TAiU3eu6MV5REFMvwceHJ9Yy+vrNIEAiqqJqj2PofwISLlWBBB
         2zcg==
X-Gm-Message-State: APjAAAXWfeKC1IKvPcJ8ZTLW8fCqy2YjE3T0K2wmtupAtpTTGiGqMrfN
        W2of/WJEc88Gj8/pxeW/xf1OqQ==
X-Google-Smtp-Source: APXvYqwIU8KTZ8E+y38iJxYiNYbx3DqPrbV92LcVOROG8LhAavzL5GtuetwG67KAKXV7C4rnKXRPBw==
X-Received: by 2002:a92:6507:: with SMTP id z7mr23935789ilb.191.1569938961846;
        Tue, 01 Oct 2019 07:09:21 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm7177343iod.42.2019.10.01.07.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:09:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190930202055.1748710-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Date:   Tue, 1 Oct 2019 08:09:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930202055.1748710-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/30/19 2:20 PM, Arnd Bergmann wrote:
> All system calls use struct __kernel_timespec instead of the old struct
> timespec, but this one was just added with the old-style ABI. Change it
> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
> the need for compat handlers on 32-bit architectures.
> 
> Any user space caller will have to use __kernel_timespec now, but this
> is unambiguous and works for any C library regardless of the time_t
> definition. A nicer way to specify the timeout would have been a less
> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
> change that as this would impact both 32-bit and 64-bit users.

Thanks for catching that, Arnd. Applied.

-- 
Jens Axboe


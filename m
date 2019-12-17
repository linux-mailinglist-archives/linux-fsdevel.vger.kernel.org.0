Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF33122FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLQPQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 10:16:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40408 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLQPQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:16:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id b8so5687213edx.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 07:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oo5dfyG2tT7KW4ai4U1JQW/HcOx4QSEZ7es4QC1dN3g=;
        b=DFmKYPmrl6MB4C7iv+/j5aC++xi8uesL8p+EHf946Mv0lrHFbnoJm0rt87ipWFc0Oe
         EK2fjpziGKLUba8QLnazMixZtW4C5C3AjHdBgzIxie3xCwrslADJt04ixPkurTG4kLhn
         GCSn15OISqRrLlZLMOMudMLsDflQjrSxxa6ifPL0Scx4l7gJNTlBLYy9Il0Opbz4w32P
         2YRzbAWfPeQ74ZDQuJsqxLp8Sy1DP+vlWYotS+SKcHkymfuQ5JY+JxNOIqoVDobZbA0N
         0u2FhjywTJLamXhzMajSssHTv0Ya2lfvg4SbVQX1M+8wKmm1kUtW3tejNc4TMSR+TFKO
         61qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oo5dfyG2tT7KW4ai4U1JQW/HcOx4QSEZ7es4QC1dN3g=;
        b=gPF9lwER56ZPeYFIkqZV9+0VIaCXDHMpdBuRjjz9WWd3EWZd0VfXn0JxtHm10zQ1+G
         vYsZozZ3EJm5qRKtKO5UkqDPL45MjR/S9NOXec0UkrnMrTUZFB51IrkNcAWGsrD8bW5G
         OLBUNNSWYexF3qd2Sz3TEZQbEM72r4zWNswDdGQmxjxn/T/sK2BaHW2h//Cpn8Mqmf2E
         1e1QQJKZKkK3gE7+vmInOl5qwenJpu9yldnh4abl5Pmr04qooZGRDehTQFQU6xrRdfIf
         N+VOr2gY93bh8hrBr9HRyjMdLHbpD2qA3g+fQPb/CJ7KidGjWbnb1JENM0UyMouGedmo
         x2xA==
X-Gm-Message-State: APjAAAW69HvGzEZ5TeUtLnPrq9l6Bm8365yhhsrLTMcr5hJ76G2ox6Wh
        bejt10/LtqG0jtapSjOobe6MXg==
X-Google-Smtp-Source: APXvYqyNK5O/+F8eW07W9dexy3Sw+pAdXZu8yDWlHgzxnV7z2k3f6kSU9ASk5K09eEz5bfXZ0BqPug==
X-Received: by 2002:a50:b066:: with SMTP id i93mr5808711edd.251.1576595802144;
        Tue, 17 Dec 2019 07:16:42 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:f83b:3dd6:f8d3:a846? ([2001:1438:4010:2540:f83b:3dd6:f8d3:a846])
        by smtp.gmail.com with ESMTPSA id u34sm4316edc.83.2019.12.17.07.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:16:41 -0800 (PST)
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <1d0bf482-8786-00b7-310d-4de38607786d@cloud.ionos.com>
Date:   Tue, 17 Dec 2019 16:16:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191217143948.26380-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/17/19 3:39 PM, Jens Axboe wrote:
> If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
> pages for the buffered reads. These pages will never be inserted into
> the page cache, and they are simply droped when we have done the copy at
> the end of IO.
>
> If pages in the read range are already in the page cache, then use those
> for just copying the data instead of starting IO on private pages.
>
> A previous solution used the page cache even for non-cached ranges, but
> the cost of doing so was too high. Removing nodes at the end is
> expensive, even with LRU bypass. On top of that, repeatedly
> instantiating new xarray nodes is very costly, as it needs to memset 576
> bytes of data, and freeing said nodes involve an RCU call per node as
> well. All that adds up, making uncached somewhat slower than O_DIRECT.
>
> With the current*solition*, we're basically at O_DIRECT levels of

Maybe it is 'solution' here.

Thanks,
Guoqing

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB53E26D99D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIQKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgIQKv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:51:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DCC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 03:51:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so2629660ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGELJOdeW4b71Bd2hOfjUNQx1LOgRfzHQbemIj8oBT0=;
        b=O0TtsmLM1mEFIkrW6anX3vSM03iH1kz/jz/9BRDaIXPnsJg4HNTPwrPH4S6h6v+QxH
         fo3b8B+eccCAlrXekzTvJqfBUJuYybnyedE9Wy9kbhmxLRc/11586mNEUSmOQHqYDEAK
         nl0xhJ3jWt3e9gODjq5Bwm9y12LpEoA/KHf1Egr2NupjbXOqGFf/r5r2GumD2Tc1Nm0v
         ECojT+VG2co/i0QGYzk4xjMUpNSHcROAkpbT/B/99nZwOcYcMjLZBo76NdBhz9fkwMCJ
         9Z0ofblkD/ibR0p1939tW5trBtib1MJ64i+b3Ftxgph6z5pGoUswJBsy/bZW+JI81ZEq
         fXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGELJOdeW4b71Bd2hOfjUNQx1LOgRfzHQbemIj8oBT0=;
        b=dkKrlgsbVYkBg9lJjXi3MPw5T0g3d626Cd9blYGOMez6q6vFLl+YAKq+ITnEe1wTJl
         EZwPhqbyla//J8Oki0FQSiQeXO6s8gNsGJvnW0uYxXB1j9adKQojcgVrz1Vn6ATPUNQy
         G+wuRs78NgIaL4x3Ou2ot7yoykpSaKb1nqJsPMZ4RqR0xwmj4KxnT1FyAlhnOZPb87iu
         t6lCsDBQj6wArKnOeNXHU+gdZjIhA6Ft3EYZo7/+PvpUTYdrZa35rK1qqVPWbTDTlmj+
         Q8oo7P2FK9zT9Nsu1+N7zmXVRuvGGE5oqKAui5+Z6y/Q/u+zFuMZdG0mmPngd6blxMgZ
         Nn0A==
X-Gm-Message-State: AOAM5306hoqqjNHJy/O54B0PtVFgft/ipYn+W+DEF4D8yNE1F1miYulN
        7oAMMVdNXnVpV9k3nsQyAJP0tw==
X-Google-Smtp-Source: ABdhPJzJfw93qfgF7JBy0y8RzBEbFoASNUOTDTI5xFQKbX5C9c6f9EmP5lkwoB3UUsK73XcUntjoWw==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr30523847ejk.328.1600339906107;
        Thu, 17 Sep 2020 03:51:46 -0700 (PDT)
Received: from ?IPv6:2a02:587:d40:1d00:c424:9586:23a2:8162? ([2a02:587:d40:1d00:c424:9586:23a2:8162])
        by smtp.gmail.com with ESMTPSA id x6sm14706311ejf.59.2020.09.17.03.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 03:51:45 -0700 (PDT)
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
To:     Hou Tao <houtao1@huawei.com>, peterz@infradead.org,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
Date:   Thu, 17 Sep 2020 13:51:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/09/2020 15:32, Hou Tao wrote:
<>
> However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.
> 
> v4.19.111
> no writer, reader cn                               | 24        | 48        | 72        | 96
> the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
> the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920
> 

I believe perhaps Peter Z's suggestion of an additional
percpu_down_read_irqsafe() API and let only those in IRQ users pay the 
penalty.

Peter Z wrote:
> My leading alternative was adding: percpu_down_read_irqsafe() /
> percpu_up_read_irqsafe(), which use local_irq_save() instead of
> preempt_disable().

Thanks
Boaz

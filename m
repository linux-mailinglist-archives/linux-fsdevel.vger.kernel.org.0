Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2433243E09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMRIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMRIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:08:53 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A12C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:08:52 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v1so1110063qvn.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NmNovEDZlcWHy1ny9mfMxwEkyJh8qjK2WB5f1VhQ5Jk=;
        b=YJux2siIvei4QmzcMG2WxFrcVF3HetJD0AOZrZjr4wCCvD9XIxA/bT08r9OrTO/uJz
         SN1KlxCU4qabzO4I/pjgyhiTKTb03pgYi2rq/3ZPZLkhdOd2c/911Pi0kQpKU5K6IKDB
         DphHqJbzNANS1TFNZtCMGHAey2kjYTqI/rIzGxbiK/AqdEKMSv6WEFzgfsJPUkCgOHz+
         mqk72KdcdnW8sWes0FOiT169XVvRjSE3qzkY0Ap08AoCwc/MXJbdjJto5MRGFLEEu+wT
         TTzYwrB34WFCVDvSEiv9mP1sl9KQaOrE6+zqznwGmpVb4BXuBWxhQ4q23D3FKJml+py5
         M16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmNovEDZlcWHy1ny9mfMxwEkyJh8qjK2WB5f1VhQ5Jk=;
        b=rI9padfeBHxNRoF5JsWXwS+injN8qdp0xSCE4xP+GFlTr8ni8AGiR3yPeFzB9T4IKb
         re9mJJnEpoDklH2+ilwP/8zVURKVjzLC43YKWDBv23Ko6eotphsLirVszW1wbieSbotK
         iTaJ0FT30rFYAxw4u0CKTpW9bkoj48C/dsstI7rHoqpK9xR05DfwXCcIfEzdpXhSkyjA
         pq0u8u9o5vvyHvzwBS9s00DRQFjfK2tiFR0cEotYj87JCYrIangaeGTaUdiMjU4XG3mz
         /Aq0xGCEyfKjG/b9yhYJtPjIObeNsu3BoMJDpxtW3qO5TPZT9dzx3TWkv6VKsNit3ncd
         AHSA==
X-Gm-Message-State: AOAM5323e9chxH0VhbiHaJqGtHMOH4ZNSgYu1EszysYS6pZRdjH0pZqx
        d/u1LbPXmV+YbM/pQTKd2hbfDQ==
X-Google-Smtp-Source: ABdhPJyUBrakPKr2w44MWVC7H8LAiHsfTAcql04AVLj1TrZRj+3lq0DcZdtx8B5TeWcs0/ULjjX5SQ==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr5659507qve.158.1597338531900;
        Thu, 13 Aug 2020 10:08:51 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:fe9c])
        by smtp.gmail.com with ESMTPSA id k31sm7048362qtd.60.2020.08.13.10.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:08:51 -0700 (PDT)
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
To:     David Laight <David.Laight@ACULAB.COM>, "hch@lst.de" <hch@lst.de>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <714c8baabe1a4d0191f8cdaf6e28a32d@AcuMS.aculab.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <72ea0ff5-4706-d2e9-c2cf-c8827e576399@toxicpanda.com>
Date:   Thu, 13 Aug 2020 13:08:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <714c8baabe1a4d0191f8cdaf6e28a32d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 12:19 PM, David Laight wrote:
> From: Josef Bacik
>> Sent: 13 August 2020 15:53
>>
>>    sysctl: pass kernel pointers to ->proc_handler
>>
>> we have been pre-allocating a buffer to copy the data from the proc
>> handlers into, and then copying that to userspace.  The problem is this
>> just blind kmalloc()'s the buffer size passed in from the read, which in
>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
>> awesome, and since we can potentially allocate up to our maximum order,
>> use vmalloc for these buffers.
> 
> What happens if I run 'dd bs=16M ...' ?
> 
> 	David
> 

         /* don't even try if the size is too large */
         error = -ENOMEM;
         if (count >= KMALLOC_MAX_SIZE)
                 goto out;

is above this code, thanks,

Josef

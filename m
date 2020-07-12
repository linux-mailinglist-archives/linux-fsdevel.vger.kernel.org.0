Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8407321C929
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jul 2020 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGLLgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgGLLgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 07:36:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF563C08E6DC
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2020 04:36:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so10117027wru.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2020 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5A9cDnFjTG3NBzPmqHsPL3YmbPK4apFGGEKOIxq7+1E=;
        b=ZiuD87Dsu+6b7jF8K06Oi76ztxdd7tcCfM24FD0meQMd0en5C46y3i/vjGou1ps+mp
         IINa+5udjSzWkifAEdUzA21DvZcisQqApTQfvyUaleXNt2uCllIdltFhYN4TsL5IU3Wz
         f+67WzizA9s7b3wjdRsNSf6wAguRT8/W0xLrxIM+zD0y19fcSXwwmG//8Ba/KKYoH/ck
         XZSqpzoX6xVbBJ0gnk3TJFGiHv4bUtwLjQfHq1aCeVkUR8byjONl687PUWDkIYlUScSe
         ptjblxeDeZ6iP9JetGcVIDSG8L9WbbwkPQFwcQ+DIzroN6zwuC1FzvfZxRMeeZ9Ml1LC
         0N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=5A9cDnFjTG3NBzPmqHsPL3YmbPK4apFGGEKOIxq7+1E=;
        b=DeDL8RJnVArVji6hFf1uZGAQPkb0iKAlquY3AyAFGKkLxXdeTG5KZdZJzuGvgbw1e9
         Ay8ovmEhKvlLOve4ceoGa10Ibm3U+OM68McoYyjbwI1YEkrp+uLTvVyWCw6G/M2zydqb
         lU7gt0YJJGED7uIJaxcSkuBKjjmn+7znyld2tkCqcLZ41T9GO7LjPGHftABBc0hB7xOT
         SpKwPGeWs0KThkONRMthy9p6XUwI1ERI54ork+pE0ySuqP/KijR7k4hmBG818Mk28cJS
         z0iBL9ZGwhP175StIbgkNGxaAFK+fHvZ2S60Fz9c671OzRDfER+K1BauZHun5SX1+2dn
         8CIw==
X-Gm-Message-State: AOAM530+VO8uSdbRHS1ldJXHFm0zt6VSEI5H8/8VVZcdx76BoiZswYfN
        EA+KH8Ryvs8LyVKnbNgq/3HYIQ==
X-Google-Smtp-Source: ABdhPJz33AclGjgkKPm9J3Ofni7d342G+PScmj88XhlgW6hBgx7woi/nEA1w/wuw9KvF7wt1x0wiRg==
X-Received: by 2002:adf:f889:: with SMTP id u9mr82733150wrp.149.1594553793471;
        Sun, 12 Jul 2020 04:36:33 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id m2sm7020970wmg.0.2020.07.12.04.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 04:36:32 -0700 (PDT)
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de> <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org> <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org>
 <20200709022527.GQ2005@dread.disaster.area>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <f86a687a-29bf-ef9c-844c-4354de9a65bb@scylladb.com>
Date:   Sun, 12 Jul 2020 14:36:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709022527.GQ2005@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/07/2020 05.25, Dave Chinner wrote:
>
>> Nobody's proposing changing Direct I/O to exclusively work through the
>> pagecache.  The proposal is to behave less weirdly when there's already
>> data in the pagecache.
> No, the proposal it to make direct IO behave *less
> deterministically* if there is data in the page cache.
>
> e.g. Instead of having a predicatable submission CPU overhead and
> read latency of 100us for your data, this proposal makes the claim
> that it is always better to burn 10x the IO submission CPU for a
> single IO to copy the data and give that specific IO 10x lower
> latency than it is to submit 10 async IOs to keep the IO pipeline
> full.
>
> What it fails to take into account is that in spending that CPU time
> to copy the data, we haven't submitted 10 other IOs and so the
> actual in-flight IO for the application has decreased. If
> performance comes from keeping the IO pipeline as close to 100% full
> as possible, then copying the data out of the page cache will cause
> performance regressions.
>
> i.e. Hit 5 page cache pages in 5 IOs in a row, and the IO queue
> depth craters because we've only fulfilled 5 complete IOs instead of
> submitting 50 entire IOs. This is the hidden cost of synchronous IO
> via CPU data copying vs async IO via hardware offload, and if we
> take that into account we must look at future hardware performance
> trends to determine if this cost is going to increase or decrease in
> future.
>
> That is: CPUs are not getting faster anytime soon. IO subsystems are
> still deep in the "performance doubles every 2 years" part of the
> technology curve (pcie 3.0->4.0 just happened, 4->5 is a year away,
> 5->6 is 3-4 years away, etc). Hence our reality is that we are deep
> within a performance trend curve that tells us synchronous CPU
> operations are not getting faster, but IO bandwidth and IOPS are
> going to increase massively over the next 5-10 years. Hence putting
> (already expensive) synchronous CPU operations in the asynchronous
> zero-data-touch IO fast path is -exactly the wrong direction to be
> moving-.
>
> This is simple math. The gap between IO latency and bandwidth and
> CPU addressable memory latency and bandwidth is closing all the
> time, and the closer that gap gets the less sense it makes to use
> CPU addressable memory for buffering syscall based read and write
> IO. We are not quite yet at the cross-over point, but we really
> aren't that far from it.
>
>

My use-case supports this. The application uses AIO+DIO, but backup may 
bring pages into page cache. For me, it is best to ignore page cache (as 
long as it's clean, which it is for backup) and serve from disk as usual.



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7E36B734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhDZQss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDZQsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:48:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47666C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 09:48:06 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b17so47152675ilh.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puGzBLwZv++5HHjd7fY19pEjsXMx9goCdL3lunTxYdQ=;
        b=J3hDuQRym59MuVErqE8iq0UtDP+T7SI07BCrWQ3p4KTcFE2Q29lkGYxa/J88Mu8034
         YgIZto9R9JjsVvzVbYma7W6GsD5vm7L4lZzmUi94q8y4d5jgVXGVtRr0Uo2itlDt7JrN
         gWDgQ5bUQwl5tPSCG2L2lY+85ia/nVgHRYK/M5SMoMEPLngjOzRWl4pa09GZk+QDgpBe
         i8cNUQ/4NVngRynvEnqgGPCaGI0CzNMoF0QTyQT8XJ1sxBEFSFOvuyk/FViLzXEpfH8V
         NBZpWe9YD+xElbx9cot5VbAuh83JCr3xV9okQpnHN5FLGA0voaSdWnSpqS/gEmBcytIf
         KstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puGzBLwZv++5HHjd7fY19pEjsXMx9goCdL3lunTxYdQ=;
        b=JlY2sXrhIsa0j4Eil6Vj8k6mlFXZAKNhMct3F8CLaLSl6vNIGRAiICwGvmoEuBVrjk
         yv1Nf/9oDteQYyMAwkhyzSrlH0KZqZP1Mc6kWpW6OV4WtcwvTYrq33Yymrs6mmEy6KgQ
         0nlqVRw3i6IseqhHCibVOT10hntYiP0nyPhtCv3k1nAjfk7yKqSNx4uO9e84ystx80M5
         hz1K3xsWBT9QvCKksw5kugNSm8421GyWeXnLvYeSP8fVFMGHfZyFqEJa5/jku8ob5Nwj
         V3PQrpUnmKsrhs8+IkWjRk0f8YMM6pXeQ+dQaT20Ld/fofW7kFPWyUA/4wyceWkht5lI
         A2TA==
X-Gm-Message-State: AOAM533GHbSLK7mGp8ldiGQKrVrcaTWIbkldM+wtJEH1f8S22rggB0W8
        jOGkR2T1KYpexHcWvNAPW7Ty6LXlkRYBPg==
X-Google-Smtp-Source: ABdhPJyz84UTTivuvf7p9WHBWJPdNtTnBqQ9MVSQ0iwDxMl87Xhp7DRqTHJVVCrqyJShe3XjXtWP/Q==
X-Received: by 2002:a92:d3c4:: with SMTP id c4mr13648591ilh.50.1619455685329;
        Mon, 26 Apr 2021 09:48:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m8sm182147ilc.13.2021.04.26.09.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:48:04 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210426134821.2191160-1-hch@lst.de>
 <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
 <20210426150638.GA24618@lst.de>
 <6b7e3ba0-aa09-b86d-8ea1-dc2e78c7529e@kernel.dk>
 <20210426161503.GA30994@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c77394a-c6fc-8f58-302e-8e997adc8620@kernel.dk>
Date:   Mon, 26 Apr 2021 10:48:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426161503.GA30994@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/21 10:15 AM, Christoph Hellwig wrote:
> On Mon, Apr 26, 2021 at 09:12:09AM -0600, Jens Axboe wrote:
>> Here's the series. It's not super clean (yet), but basically allows
>> users like io_uring to setup a bio cache, and pass that in through
>> iocb->ki_bi_cache. With that, we can recycle them instead of going
>> through free+alloc continually. If you look at profiles for high iops,
>> we're spending more time than desired doing just that.
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-bio-cache
> 
> So where do you spend the cycles?  The do not memset the whole bio
> optimization is pretty obvious and is someting we should do independent
> of the allocator.

memset is just a small optimization on top. If we look at current
profiles, the alloc+free looks something ala:

+    2.71%  io_uring  [kernel.vmlinux]  [k] bio_alloc_bioset
+    2.03%  io_uring  [kernel.vmlinux]  [k] kmem_cache_alloc

and

+    2.82%  io_uring  [kernel.vmlinux]  [k] __slab_free
+    1.73%  io_uring  [kernel.vmlinux]  [k] kmem_cache_free
     0.36%  io_uring  [kernel.vmlinux]  [k] mempool_free_slab
     0.27%  io_uring  [kernel.vmlinux]  [k] mempool_free

Which is a substantial amount of cycles that is needed just to
repeatedly use the same set of bios for doing IO. Using the caching
patchset, all of the above are completely eliminated, and the only thing
we dynamically allocate is a request which is a lot cheaper (ends up
being 1-2% for either kernel).

> The other thing that sucks is the mempool implementation, as it forces
> each allocation and free to do an indirect call.  I think it might be
> worth to try to frontend it with a normal slab cache and only fall back
> to the mempool if that fails.

Also minor I believe, but yes it'll eat cycles too. FWIW, the testing
above is done without RETPOLINE.

-- 
Jens Axboe


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB2866BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbfHHQMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 12:12:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34395 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404099AbfHHQMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:12:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so44362304pfo.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GbKZkWdFW3/LathJiTmUB/es7Gx9lbtHm6GJXlHv5+E=;
        b=aHd3BMPydi+5PV5TxAyyoXAB2//OlcpWaOb9Ulv9m4G+dGQDsVHyoJELks6vv29zZs
         +l9YLHqxG6PA7RsVkwpwZLjgZzwTnKooalsTD+ERQtN8bpHaq1JEAX79Q/0Q4JFzQWqX
         Zv7Za4X5k+/VUeEYrNZJJSLO7c+scqObfiMwnA2GipbI5hhnzUw2LCdhtgUFP2BnLpE2
         et7yYRwFoml44eQaKQF8+SGCmFWcKVzwtMQTEXAtjYSre8zV7f3nMDxyKkS/3fiM3pd8
         5g+VisQ2Yg7qdOQWYCT5hJZbqMllgcveePnnq+gYbnNhRPiHgqBwxulg0iqhWdshus0G
         /Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbKZkWdFW3/LathJiTmUB/es7Gx9lbtHm6GJXlHv5+E=;
        b=j/yaXp7Fq+DnHOjBZTxoADcoIYw2sVknXCX0oPCHsD1VjoHwXBIVJam8+1WTOhVAmu
         IvxTaym/mcJirTKhK5kvmrVHMpejgVfVp6lcPu/mr2lLl+quXSOaegwQahevuTk8Ylod
         0dUlIUnyV13r5LygK+82sgKAolqDtX06BZ08n4KvSrezHz+nFcaQVvWxmtsivLeRQUso
         As+4a6uwifdXNOupMv+L9EuDARPw2++L08yOPP4rH0fwBFToNkGuXS1dySj6cH5+ZWks
         SvWX/Pi7CFK56Ov4KdLZy3N8w/3EUpRu4ry7rM20G/FJ8D7fWiFdx7ZxkA2APrNazQmw
         2sYg==
X-Gm-Message-State: APjAAAXpwMMKeWjdCVT5AFDxOd1CS/TeRLKCcYaohYklho2xvn+gMFAo
        Co7R5lv14mw8yJR8oZPb8QBUWQ==
X-Google-Smtp-Source: APXvYqyiYb+knMp0JBJQrh+fcsfPoG9yFxitkP7TY7Atel9io4mNwiZe7WDGrcZe1yoOZtvrtpSkzA==
X-Received: by 2002:a65:690e:: with SMTP id s14mr13663644pgq.47.1565280759945;
        Thu, 08 Aug 2019 09:12:39 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4042:6c37:d29d:2320? ([2605:e000:100e:83a1:4042:6c37:d29d:2320])
        by smtp.gmail.com with ESMTPSA id 196sm103224711pfy.167.2019.08.08.09.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:12:38 -0700 (PDT)
Subject: Re: [PATCH] loop: set PF_MEMALLOC_NOIO for the worker thread
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>, junxiao.bi@oracle.com,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com>
 <20190808135329.GG5482@bombadil.infradead.org>
 <alpine.LRH.2.02.1908081113540.18950@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4625547c-f172-a0bf-720e-849fb7ff85a2@kernel.dk>
Date:   Thu, 8 Aug 2019 09:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1908081113540.18950@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 8:17 AM, Mikulas Patocka wrote:
> A deadlock with this stacktrace was observed.
> 
> The loop thread does a GFP_KERNEL allocation, it calls into dm-bufio
> shrinker and the shrinker depends on I/O completion in the dm-bufio
> subsystem.
> 
> In order to fix the deadlock (and other similar ones), we set the flag
> PF_MEMALLOC_NOIO at loop thread entry.
> 
> PID: 474    TASK: ffff8813e11f4600  CPU: 10  COMMAND: "kswapd0"
>     #0 [ffff8813dedfb938] __schedule at ffffffff8173f405
>     #1 [ffff8813dedfb990] schedule at ffffffff8173fa27
>     #2 [ffff8813dedfb9b0] schedule_timeout at ffffffff81742fec
>     #3 [ffff8813dedfba60] io_schedule_timeout at ffffffff8173f186
>     #4 [ffff8813dedfbaa0] bit_wait_io at ffffffff8174034f
>     #5 [ffff8813dedfbac0] __wait_on_bit at ffffffff8173fec8
>     #6 [ffff8813dedfbb10] out_of_line_wait_on_bit at ffffffff8173ff81
>     #7 [ffff8813dedfbb90] __make_buffer_clean at ffffffffa038736f [dm_bufio]
>     #8 [ffff8813dedfbbb0] __try_evict_buffer at ffffffffa0387bb8 [dm_bufio]
>     #9 [ffff8813dedfbbd0] dm_bufio_shrink_scan at ffffffffa0387cc3 [dm_bufio]
>    #10 [ffff8813dedfbc40] shrink_slab at ffffffff811a87ce
>    #11 [ffff8813dedfbd30] shrink_zone at ffffffff811ad778
>    #12 [ffff8813dedfbdc0] kswapd at ffffffff811ae92f
>    #13 [ffff8813dedfbec0] kthread at ffffffff810a8428
>    #14 [ffff8813dedfbf50] ret_from_fork at ffffffff81745242
> 
>    PID: 14127  TASK: ffff881455749c00  CPU: 11  COMMAND: "loop1"
>     #0 [ffff88272f5af228] __schedule at ffffffff8173f405
>     #1 [ffff88272f5af280] schedule at ffffffff8173fa27
>     #2 [ffff88272f5af2a0] schedule_preempt_disabled at ffffffff8173fd5e
>     #3 [ffff88272f5af2b0] __mutex_lock_slowpath at ffffffff81741fb5
>     #4 [ffff88272f5af330] mutex_lock at ffffffff81742133
>     #5 [ffff88272f5af350] dm_bufio_shrink_count at ffffffffa03865f9 [dm_bufio]
>     #6 [ffff88272f5af380] shrink_slab at ffffffff811a86bd
>     #7 [ffff88272f5af470] shrink_zone at ffffffff811ad778
>     #8 [ffff88272f5af500] do_try_to_free_pages at ffffffff811adb34
>     #9 [ffff88272f5af590] try_to_free_pages at ffffffff811adef8
>    #10 [ffff88272f5af610] __alloc_pages_nodemask at ffffffff811a09c3
>    #11 [ffff88272f5af710] alloc_pages_current at ffffffff811e8b71
>    #12 [ffff88272f5af760] new_slab at ffffffff811f4523
>    #13 [ffff88272f5af7b0] __slab_alloc at ffffffff8173a1b5
>    #14 [ffff88272f5af880] kmem_cache_alloc at ffffffff811f484b
>    #15 [ffff88272f5af8d0] do_blockdev_direct_IO at ffffffff812535b3
>    #16 [ffff88272f5afb00] __blockdev_direct_IO at ffffffff81255dc3
>    #17 [ffff88272f5afb30] xfs_vm_direct_IO at ffffffffa01fe3fc [xfs]
>    #18 [ffff88272f5afb90] generic_file_read_iter at ffffffff81198994
>    #19 [ffff88272f5afc50] __dta_xfs_file_read_iter_2398 at ffffffffa020c970 [xfs]
>    #20 [ffff88272f5afcc0] lo_rw_aio at ffffffffa0377042 [loop]
>    #21 [ffff88272f5afd70] loop_queue_work at ffffffffa0377c3b [loop]
>    #22 [ffff88272f5afe60] kthread_worker_fn at ffffffff810a8a0c
>    #23 [ffff88272f5afec0] kthread at ffffffff810a8428
>    #24 [ffff88272f5aff50] ret_from_fork at ffffffff81745242

Applied, thanks.

-- 
Jens Axboe


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968542A79C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhJLOth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbhJLOtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:49:33 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D40C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:47:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x1so8396829ilv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4MJaMMW8746DQT1wOfh06NFmp8vY5yRZAB/PDHHSeGY=;
        b=wOIbilVM5gc/k/LZ9/Ir1wHPCDEC+IR+oeQmi8pjQTvUyvfa2oZbSfQqPDImNMgtyQ
         DxhGgaz5+RPNRuFubDCiRCMnZceDLrc+C4OB89sWzEOWrTG+y91hDngiR3YIKZ+/aVH/
         9Bii7ghXtllIvrSjzGpTWpaI1pJURBqQbV6hd8+09Ufn95OxlNx5YjjsjiyT5oglv1Xe
         ToMkqjYZp0OudBD2QdC/8exoIwens1dkP4DGoLp6RebMGZTeOkDN3LAr6NIZDEU1VHWS
         PvyzkvQuSb/1CIei/9oaMldCHe344kFIwyg0rEFoGlgBAJfyJh0Q+Lx1Q2O/iSyAVSfO
         sxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4MJaMMW8746DQT1wOfh06NFmp8vY5yRZAB/PDHHSeGY=;
        b=TntydvXo79QGTtXwf7c5NmQx0INtRohQO6Tzf4b/2h+PlEmqXllq3/dvkGubrzk/ne
         +/zcQkCoRx3FVaNYT1fA2t+qjHE1a7yk/lNDMq/xqm0c5qknvRvtpqFypDIXJJHFx9YF
         Naz3/Gde8r7xIEz2UAecoUV7H004E8IXGzNIBpZBhyOxaZRRfre7u3Vl6G2JDFylhyHt
         XY9159Lh/vbkZvYJY9somvpeLooApooSbuXI/GLxz+fa2ZzlmsmfEaTZBNZAfhgL/nNj
         indIIZPXLgPsYbjAc4rPLvOCuyccBIr45D9WJ7xpbbhGp1u5aoJ7JeivOr9gzIQEiQah
         5/sQ==
X-Gm-Message-State: AOAM530OCZcBOamfp+/4nftaygH03LB70UTKe5ls4o1eTIx4MePZsArN
        JcsYlrSuAjcWORnkcdQYxRfFGg==
X-Google-Smtp-Source: ABdhPJxapnRy6JleZezPqu6pNBbq7PwR7Um8itvadPDoYS1xyG7UZ+W6d1/blh57xUyZyd+hWUDWDg==
X-Received: by 2002:a05:6e02:160a:: with SMTP id t10mr23554089ilu.207.1634050050606;
        Tue, 12 Oct 2021 07:47:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 2sm5337003iob.13.2021.10.12.07.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:47:30 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
Date:   Tue, 12 Oct 2021 08:47:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/21 5:12 AM, Christoph Hellwig wrote:
> Hi all,
> 
> This series clean up the block polling code a bit and changes the interface
> to poll for a specific bio instead of a request_queue and cookie pair.
> 
> Polling for the bio itself leads to a few advantages:
> 
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     removed entirely
> 
> The one major caveat is that this requires RCU freeing polled BIOs to make
> sure the bio that contains the polling information is still alive when
> io_uring tries to poll it through the iocb. For synchronous polling all the
> callers have a bio reference anyway, so this is not an issue.

I ran this through the usual peak testing, and it doesn't seem to regress
anything for me. We're still at around ~7.4M polled IOPS on a single CPU
core:

taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
Added file /dev/nvme1n1 (submitter 0)
Added file /dev/nvme2n1 (submitter 1)
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=256
submitter=0, tid=1199
submitter=1, tid=1200
IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)

with some of my pending changes and hacks. Using IRQ mode, we're at around 4.9M
and I don't see any particular impact of needing deferred RCU free of the bio
for that case.

-- 
Jens Axboe


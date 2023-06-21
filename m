Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340573937C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFVACe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFVACb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:02:31 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A76171C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 17:01:51 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-54fac329a71so3533193a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687391973; x=1689983973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OU/179/iXGq9NmmW8hnIXVlD1VRa6pe1WCR6A4omy38=;
        b=R2/kM7yBIoKcuCGTJ8iUWX+NGLJXYVfMBRd/TU4dFCAJOWayRZPh/qFpV3mc7tWw4J
         DTrLf9lPUC/Cxyh1HEz+9bGzO57/tzWPkeAvYV9sRS3HUvoGUiBNZ1/da5qCMkKah3CT
         Oqlxs9nqZx/JG9KxcX/Bz1ZHbTLHVMImadAqzLSWuidnqO0bSPk/xB/bIrNL6fORTB3r
         eAL2+F2NU1UNYjVjyC+m1yhMUsR9dE8E6YSTMcMY5PbHbcfVE+CfbdLPftg4MwUSPcmD
         KPl1uSJTj8RKtxQUI3ddVVBGhtkRrp3XUovNrCBdxZYYZ8d+I4IyDMcltlecMGXdfYda
         Hggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391973; x=1689983973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU/179/iXGq9NmmW8hnIXVlD1VRa6pe1WCR6A4omy38=;
        b=X6WJkDixPfIMBrz7CkqrfzupUHlFDMznkoKJs+8Dy/azO0nQ3RStQ/rlGoJX4jf7xJ
         hnU79wVGWulGmxmHX+WVkYuyUmaMd9+mMSsgb1Fms4DxVrwy2TgGs0fawTZwhhaycLZM
         g6Ry45basu+6m38YK4pQYMqiFY+5w8GLTHqNiE5IFe9bSKyK9wYj7omFdK8DOP+27BrV
         bIaJEV9QZQgIatmDUTlYRchfJ7hSdWiSrRpbBaLSZkuFXcHotgSYQ64j62+vd14Kt3JL
         a/1ixiOhVHVc0gVmK+OGP5bpHf8HqBVyHsBLjmQhdp2M8bF4tivkpITXBXSxb2Jq3L8A
         mNsQ==
X-Gm-Message-State: AC+VfDzs4d5er+9BCVe4hQxQlCGEldPL2KkZt+Y3K52xveZEo28QH9Dl
        6w2VE3BUnGArVkLM+aKUgHcIuw==
X-Google-Smtp-Source: ACHHUZ62jwCnhAIzgBYgwNp4Kl10YuDezm18pLAiA5wud0LAdl60j7do6H51Q9xhv853330itotYYA==
X-Received: by 2002:a05:6a20:54a6:b0:121:8b92:a20 with SMTP id i38-20020a056a2054a600b001218b920a20mr8871860pzk.46.1687391973065;
        Wed, 21 Jun 2023 16:59:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001b3c7e5ed8csm4019618plb.74.2023.06.21.16.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:59:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qC7jV-00Edjp-3D;
        Thu, 22 Jun 2023 09:59:30 +1000
Date:   Thu, 22 Jun 2023 09:59:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJOO4SobNFaQ+C5g@dread.disaster.area>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621174114.1320834-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:29:19AM -0700, Jeremy Bongio wrote:
> Hi Darrick and Allison,
> 
> There has been a standing performance regression involving AIO DIO
> 4k-aligned writes on ext4 backed by a fast local SSD since the switch
> to iomap. I think it was originally reported and investigated in this
> thread: https://lore.kernel.org/all/87lf7rkffv.fsf@collabora.com/
> 
> Short version:
> Pre-iomap, for ext4 async direct writes, after the bio is written to disk
> the completion function is called directly during the endio stage.
> 
> Post-iomap, for direct writes, after the bio is written to disk, the completion
> function is deferred to a work queue. This adds latency that impacts
> performance most noticeably in very fast SSDs.
> 
> Detailed version:
> A possible explanation is below, followed by a few questions to figure
> out the right way to fix it.
> 
> In 4.15, ext4 uses fs/direct-io.c. When an AIO DIO write has completed
> in the nvme driver, the interrupt handler for the write request ends
> in calling bio_endio() which ends up calling dio_bio_end_aio(). A
> different end_io function is used for async and sync io. If there are
> no pages mapped in memory for the write operation's inode, then the
> completion function for ext4 is called directly. If there are pages
> mapped, then they might be dirty and need to be updated and work
> is deferred to a work queue.
> 
> Here is the relevant 4.15 code:
> 
> fs/direct-io.c: dio_bio_end_aio()
> if (dio->result)
>         defer_completion = dio->defer_completion ||
>                            (dio_op == REQ_OP_WRITE &&
>                            dio->inode->i_mapping->nrpages);
> if (defer_completion) {
>         INIT_WORK(&dio->complete_work, dio_aio_complete_work);
>         queue_work(dio->inode->i_sb->s_dio_done_wq,
>                    &dio->complete_work);
> } else {
>         dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
> }
> 
> After ext4 switched to using iomap, the endio function became
> iomap_dio_bio_end_io() in fs/iomap/direct-io.c. In iomap the same end io
> function is used for both async and sync io.

Yes, because the IO completion processing is the same regardless of
whether the IO is submitted for sync or async completion.

> All write requests will
> defer io completion to a work queue even if there are no mapped pages
> for the inode.

Yup.

Consider O_DSYNC DIO writes: Where are the post-IO completion
integrity operations done?

Consider DIO write IO completion for different filesystems: how does
iomap_dio_complete() know whether dio->dops->end_io() needs to run
in task context or not.

e.g. DIO writes into unwritten extents: where are the written
conversion transactions run?

> With the attached patch, I see significantly better performance in 5.10 than 4.15. 5.10 is the latest kernel where I have driver support for an SSD that is fast enough to reproduce the regression. I verified that upstream iomap works the same.
> 
> Test results using the reproduction script from the original report
> and testing with 4k/8k/12k/16k blocksizes and write-only:
> https://people.collabora.com/~krisman/dio/week21/bench.sh
> 
> fio benchmark command:
> fio --ioengine libaio --size=2G --direct=1 --filename=${MNT}/file --iodepth=64 \
> --time_based=1 --thread=1 --overwrite=1 --bs=${BS} --rw=$RW \

Ah, you are testing pure overwrites, which means for ext4 the only
thing it needs to care about is cached mappings. What happens when
you add O_DSYNC here?

> --name "`uname -r`-${TYPE}-${RW}-${BS}-${FS}" \
> --runtime=100 --output-format=terse >> ${LOG}
> 
> For 4.15, with all write completions called in io handler:
> 4k:  bw=1056MiB/s
> 8k:  bw=2082MiB/s
> 12k: bw=2332MiB/s
> 16k: bw=2453MiB/s
> 
> For unmodified 5.10, with all write completions deferred:
> 4k:  bw=1004MiB/s
> 8k:  bw=2074MiB/s
> 12k: bw=2309MiB/s
> 16k: bw=2465MiB/s

I don't see a regression here - the differences are in the noise of
a typical fio overwrite test.

> For modified 5.10, with all write completions called in io handler:
> 4k:  bw=1193MiB/s
> 8k:  bw=2258MiB/s
> 12k: bw=2346MiB/s
> 16k: bw=2446MiB/s
>
> Questions:
> 
> Why did iomap from the beginning not make the async/sync io and
> mapped/unmapped distinction that fs/direct-io.c did?

Because the iomap code was designed from the ground up as an
extent-based concurrent async IO engine that supported concurrent
reads and writes to the same sparse file with full data integrity
handling guarantees.

The old dio code started off as "sync" DIO only, and it was for a
long time completely broken for async DIO. Correct support for that
was eventually tacked on via DIO_COMPLETE_ASYNC, but it was still
basically an awful, nasty, complex, "block at a time" synchronous
IO engine.

> Since no issues have been found for ext4 calling completion work
> directly in the io handler pre-iomap, it is unlikely that this is
> unsafe (sleeping within an io handler callback). However, this may not
> be true for all filesystems. Does XFS potentially sleep in its
> completion code?

Yes, and ext4 does too. e.g. O_DSYNC overwrites always need to be
deferred to task context to be able to take sleeping locks and
potentially block on journal and or device cache flushes.

i.e. Have you considered what context all of XFS, f2fs, btrfs,
zonefs and gfs2 need for pure DIO overwrite completion in all it's
different variants?

AFAIC, it's far simpler conceptually to defer all writes to
completion context than it is to try to work out what writes need to
be deferred and what doesn't, especially as the filesystem ->end_io
completion might need to sleep and the iomap code has no idea
whether that is possible.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

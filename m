Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D753CBFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbiFCPG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiFCPG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:06:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8489E01B
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 08:06:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h18so5720675qvj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jun 2022 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JYSh5kn5ThMI8CCaOPSJ53f4sBIED+WUhUG7FktR1dY=;
        b=siZl67/nQ8Im4grN9O1OmTzhS3rdMxs0Bq48muqZNNe5/kMScYOTWAg34Q2P5CPUR9
         H9wMUyjObyZlrxS9/BifA3LVTjcekusU8qt4jMRlpb+LGXEcnA1DVdo3JSiqMRomVZaw
         Zm7MIIujnZRxNpYqYWsTVaDfwte+vWvmZcSCVTlrx4a/Fo2ZVVUydCpQuLA7YpBVCyWm
         KKCKa2y5cyt1sxdcu3H5POuCIGXq0FtYDtNpHsoGwF/IJ6+l61esjOg3pu+39mPVAk3W
         n9DV4PFS6XX8kTP+SlqZOUFnyfK5+QUCxZ547WkydNEMrd1mFeTV4lS8mQwVS9P/XPVp
         LiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JYSh5kn5ThMI8CCaOPSJ53f4sBIED+WUhUG7FktR1dY=;
        b=fb0HWNH9rZSejcKJ07O4MHhwBFszWN2SJsY+JV+KR4lNoGK2/z0E0WK4Ss+xGTbthp
         Cp/sutXl2ZWP4t+eAzLuB5nWvvHjcNRf0JJrIUDKiwbogKEJ8D2sngev/dlCQ2PeaKbC
         5hIV7H++XiCxodjh9/df9g81qCzvSmGHP5VS/1FMX2ZjMKYPfI827w9qeclZMOqAg1fA
         KRS516RGwm8kBaemYmZdxvmkVtbJTlfFK06BzWz3hGLYpoMfPdINTso5bkuy2zzxzJGy
         kVveW14t3X9Fa/lWjwUj8/gK2/iBc5j7On4XP8lomlRBnmW0L7rDObsXvYvEutf/qJTa
         giqg==
X-Gm-Message-State: AOAM53270ZU5ANQmbsFEyurbV8X6RY8O7d+2R51xnXk23lNVQ7xuicKX
        d/pfE8mHLI2+GdrMLillDxaGyA==
X-Google-Smtp-Source: ABdhPJzNuFC4GmuFvrERREiLuT2vBmWyVZTMOB3y8uBoWR8lo3pSSZ4wrdBEYDTWNNb6mBUa7vtirg==
X-Received: by 2002:a05:6214:301b:b0:461:f5e9:5f9a with SMTP id ke27-20020a056214301b00b00461f5e95f9amr62557099qvb.2.1654268784051;
        Fri, 03 Jun 2022 08:06:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1d66])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a109b00b006a34bdb0c36sm5212260qkk.31.2022.06.03.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:06:23 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:06:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <YpojbvB/+wPqHT8y@cmpxchg.org>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
 <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
 <20220603052047.GJ1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603052047.GJ1098723@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dave,

On Fri, Jun 03, 2022 at 03:20:47PM +1000, Dave Chinner wrote:
> On Fri, Jun 03, 2022 at 01:29:40AM +0000, Chris Mason wrote:
> > As you describe above, the loops are definitely coming from higher
> > in the stack.  wb_writeback() will loop as long as
> > __writeback_inodes_wb() returns that it’s making progress and
> > we’re still globally over the bg threshold, so write_cache_pages()
> > is just being called over and over again.  We’re coming from
> > wb_check_background_flush(), so:
> > 
> >                 struct wb_writeback_work work = {
> >                         .nr_pages       = LONG_MAX,
> >                         .sync_mode      = WB_SYNC_NONE,
> >                         .for_background = 1,
> >                         .range_cyclic   = 1,
> >                         .reason         = WB_REASON_BACKGROUND,
> >                 };
> 
> Sure, but we end up in writeback_sb_inodes() which does this after
> the __writeback_single_inode()->do_writepages() call that iterates
> the dirty pages:
> 
>                if (need_resched()) {
>                         /*
>                          * We're trying to balance between building up a nice
>                          * long list of IOs to improve our merge rate, and
>                          * getting those IOs out quickly for anyone throttling
>                          * in balance_dirty_pages().  cond_resched() doesn't
>                          * unplug, so get our IOs out the door before we
>                          * give up the CPU.
>                          */
>                         blk_flush_plug(current->plug, false);
>                         cond_resched();
>                 }
> 
> So if there is a pending IO completion on this CPU on a work queue
> here, we'll reschedule to it because the work queue kworkers are
> bound to CPUs and they take priority over user threads.

The flusher thread is also a kworker, though. So it may hit this
cond_resched(), but it doesn't yield until the timeslice expires.

> Also, this then requeues the inode of the b_more_io queue, and
> wb_check_background_flush() won't come back to it until all other
> inodes on all other superblocks on the bdi have had writeback
> attempted. So if the system truly is over the background dirty
> threshold, why is writeback getting stuck on this one inode in this
> way?

The explanation for this part at least is that the bdi/flush domain is
split per cgroup. The cgroup in question is over its proportional bg
thresh. It has very few dirty pages, but it also has very few
*dirtyable* pages, which makes for a high dirty ratio. And those
handful of dirty pages are the unflushable ones past EOF.

There is no next inode to move onto on subsequent loops.

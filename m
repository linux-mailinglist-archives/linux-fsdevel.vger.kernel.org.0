Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827D505EA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbiDRTqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiDRTqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:46:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E6524BD8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 12:44:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so25709565lfu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0udl+Jg7/E8U2Q1uegxBt7sy07jVU2+ZH/a/jwjVSlM=;
        b=fuAdQ1PeOz6M/bcT6h/mwlA4eiXjsphDi2CiJsocjRzCVTIBMVrRxA72ZJrop1X1pf
         5lgluP1ppVjUATw3PG6Xz/dKfLcRrDgQrqrTXdNt3fupUSNMO1EkPPw5ZbWyY4VLQyqn
         8y2/mHZtse9xc/2my8Ws/HRORl366UPNTUvNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0udl+Jg7/E8U2Q1uegxBt7sy07jVU2+ZH/a/jwjVSlM=;
        b=QRBreUrc0UhaqOJL1rc3jro13P1DvSiuLn6k7rtdGQW22Wn+sHBNZj5pChtiBxyqGF
         VwX0v3rBlAQhzCxQMItUMTDa0tDFTwJ/hUxxc7nu6e2kQwl1yickQILKvB3eBjXEN4uO
         Nd2Oxc/RX4gvHeNbbRAU2KbWNIywZdYRln0Mx7e6b2j1s7XH3Sn0o4ie2lLy3kqPJcS3
         fRzz3v+5emqlepKB0rTVZZEhWq9rbQXJnR0e1yrWkI2I4qtdlb1zkGe+sDmhYxYEXEAZ
         VRQGGrWD5wY8HxGpRWxFCcuURs66AI+bXlDRemAcYCydsKYJMXoaK1ZRk2mmPTzFlQtj
         EvFw==
X-Gm-Message-State: AOAM531pAV6RvBi3UzSiAY6kDg0mqvWfhtdjcPx5OOXdcbyIrqWCsStW
        gg9tPUnqNNuDTtE4w4IYmjIfqljAQutiiIN5B2E=
X-Google-Smtp-Source: ABdhPJylh0VjhfY99cWYDujAsa6N28PpPg1QqbV1KUWgR3AANRMx0CBGQYsy5//UjZAKDRb4Fo5RrQ==
X-Received: by 2002:a05:6512:2252:b0:44a:3038:cbc with SMTP id i18-20020a056512225200b0044a30380cbcmr8833034lfu.252.1650311041429;
        Mon, 18 Apr 2022 12:44:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b00471988e79cdsm297520lfh.180.2022.04.18.12.43.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 12:44:00 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n17so13057992ljc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 12:43:59 -0700 (PDT)
X-Received: by 2002:a2e:b8d6:0:b0:24b:6b40:a96a with SMTP id
 s22-20020a2eb8d6000000b0024b6b40a96amr8231435ljp.176.1650311039589; Mon, 18
 Apr 2022 12:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
In-Reply-To: <20220418092824.3018714-1-chengzhihao1@huawei.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Apr 2022 12:43:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
Message-ID: <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fs=2Dwriteback=3A_writeback=5Fsb=5Finodes=EF=BC=9AR?=
        =?UTF-8?Q?ecalculate_=27wrote=27_according_skipped_pages?=
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Adding some scheduler people - the background here is a ABBA
deadlock because a plug never gets unplugged and the IO never starts
and the buffer lock thus never gets released. That's simplified, see
     https://lore.kernel.org/all/20220415013735.1610091-1-chengzhihao1@huawei.com/
  and
     https://bugzilla.kernel.org/show_bug.cgi?id=215837
   for details ]

On Mon, Apr 18, 2022 at 2:14 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> In my test, 'need_resched()' (which is imported by 590dca3a71 "fs-writeback:
> unplug before cond_resched in writeback_sb_inodes") in function
> 'writeback_sb_inodes()' seldom comes true, unless cond_resched() is deleted
> from write_cache_pages().

So I'm not reacting to the patch, but just to this part of the message...

I forget the exact history of plugging, but at some point (long long
ago - we're talking pre-git days) it was device-specific and always
released on a timeout (or, obviously, explicitly unplugged).

And then later it became per-process, and always released by task-work
on any schedule() call.

But over time, that "any schedule" has gone away. It did so gradually,
over time, and long ago:

  73c101011926 ("block: initial patch for on-stack per-task plugging")
  6631e635c65d ("block: don't flush plugged IO on forced preemtion scheduling")

And that's *mostly* perfectly fine, but the problem ends up being that
not everything necessarily triggers the flushing at all.

In fact, if you call "__schedule()" directly (rather than
"schedule()") I think you may end up avoiding flush entirely. I'm
looking at  do_task_dead() and schedule_idle() and the
preempt_schedule() cases.

Similarly, tsk_is_pi_blocked() will disable the plug flush.

Back when it was a timer, the flushing was eventually guaranteed.

And then we would flush on any re-schedule, even if it was about
preemption and the process might stay on the CPU.

But these days we can be in the situation where we really don't flush
at all - the process may be scheduled away, but if it's still
runnable, the blk plug won't be flushed.

To make things *really* confusing, doing an io_schedule() will force a
plug flush, even  if the process might stay runnable. So io_schedule()
has those old legacy "unconditional flush" guarantees that a normal
schedule does not any more.

Also note how the plug is per-process, so when another process *does*
block (because it's waiting for some resource), that doesn't end up
really unplugging the actual IO which was started by somebody else.
Even if that other process is using io_schedule().

Which all brings us back to how we have that hacky thing in
writeback_sb_inodes() that does

        if (need_resched()) {
                /*
                 * We're trying to balance between building up a nice
                 * long list of IOs to improve our merge rate, and
                 * getting those IOs out quickly for anyone throttling
                 * in balance_dirty_pages().  cond_resched() doesn't
                 * unplug, so get our IOs out the door before we
                 * give up the CPU.
                 */
                blk_flush_plug(current->plug, false);
                cond_resched();
        }

and that currently *mostly* ends up protecting us and flushing the
plug when doing big writebacks, but as you can see from the email I'm
quoting, it then doesn't always work very well, because
"need_resched()" may end up being cleared by some other scheduling
point, and is entirely meaningless when preemption is on anyway.

So I think that's basically just a random voodoo programming thing
that has protected us in the past in some situations.

Now, Zhihao has a patch that fixes the problem by limiting the
writeback by being better at accounting:

    https://lore.kernel.org/all/20220418092824.3018714-1-chengzhihao1@huawei.com/

which is the email I'm answering, but I did want to bring in the
scheduler people to the discussion to see if people have ideas.

I think the writeback accounting fix is the right thing to do
regardless, but that whole need_resched() dance in
writeback_sb_inodes() is, I think, a sign that we do have real issues
here. That whole "flush plug if we need to reschedule" is simply a
fundamentally broken concept, when there are other rescheduling
points.

Comments?

The answer may just be that "the code in writeback_sb_inodes() is
fundamentally broken and should be removed".

But the fact that we have that code at all makes me quite nervous
about this. And we clearly *do* have situations where the writeback
code seems to cause nasty unplugging delays.

So I'm not convinced that "fix up the writeback accounting" is the
real and final fix.

I don't really have answers or suggestions, I just wanted people to
look at this in case they have ideas.

                    Linus

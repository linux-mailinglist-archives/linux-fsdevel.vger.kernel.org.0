Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A67505F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiDRWEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiDRWEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:04:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA78720BFC
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:01:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so26347057lfb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoSSB6D4okQIzxYw590H8J+GvX7tUDqFDdL3NG2PVow=;
        b=Y0Azna+11Ygy4jE/LbD9k9ppPCkOldalF7CL1XSOIqHdcVg6oz83IRXODvqMA1a+NN
         tChz+i0D6XlNe64llHhy8KDYypWThZpTpcoIfiAWaSpjbUV4w2FPfoDJ3w1oXQCKwbuq
         pL6Tlwr0L738RSs3Y3jedLpure8WgxCDfUscs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoSSB6D4okQIzxYw590H8J+GvX7tUDqFDdL3NG2PVow=;
        b=POPNiVOa05y7JUGB187DEL+wlF3dd62Iq3goKnx4w9oCUwD0gNSbd6ULP21BHOrH2z
         Sb0ThzF+XeXk3ZOiPDzLw3+zb/KRB+USeltywRvM1oRQqg+CNnD/Slv3bFx0h+YxgCeb
         bzMBlTtPqEp7e+r2ULaxOfKi5iYXv9Tvt9KYTPosrgmUfzftMuOhkKFS7bhrcflnkWuj
         rJ1rM7vpzwZDAABSalAjpIYbhJDn2PZSo5spkz3/1qR5ipWUflf+iutkTvBP2Gw9+lXo
         XzZx1TxxtdD4QJ89ecOo+zPGPxpMFprmbs6h/cdg31H8eAJ058C2A112R8bf4nJ5SqqN
         9eqg==
X-Gm-Message-State: AOAM533j+1h4xbKmS7ASzChffY9AsKTGQ7618HpwxOJyBQGZB78DvTL0
        oyIZDFTXfJ/DXtLr8wKKrWCA06PYsc8JqOYJiyo=
X-Google-Smtp-Source: ABdhPJzvgbleLQXbKXfo8Np79DjFVuhIBKaUcFrRz7Wny3OUnMtF0kfVDzIrXWVbZrbjHJyb+QBbYA==
X-Received: by 2002:a05:6512:22cb:b0:471:a405:963d with SMTP id g11-20020a05651222cb00b00471a405963dmr1055117lfu.659.1650319311978;
        Mon, 18 Apr 2022 15:01:51 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e954c000000b0024b00cc7539sm1244721ljh.109.2022.04.18.15.01.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:01:50 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id o16so18341484ljp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:01:50 -0700 (PDT)
X-Received: by 2002:a2e:b8d6:0:b0:24b:6b40:a96a with SMTP id
 s22-20020a2eb8d6000000b0024b6b40a96amr8492009ljp.176.1650319309981; Mon, 18
 Apr 2022 15:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com> <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
In-Reply-To: <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Apr 2022 15:01:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
Message-ID: <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fs=2Dwriteback=3A_writeback=5Fsb=5Finodes=EF=BC=9AR?=
        =?UTF-8?Q?ecalculate_=27wrote=27_according_skipped_pages?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
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

On Mon, Apr 18, 2022 at 2:16 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> So as far as I can tell, we really have two options:
>
> 1) Don't preempt a task that has a plug active
> 2) Flush for any schedule out, not just going to sleep
>
> 1 may not be feasible if we're queueing lots of IO, which then leaves 2.
> Linus, do you remember what your original patch here was motivated by?
> I'm assuming it was an effiency thing, but do we really have a lot of
> cases of IO submissions being preempted a lot and hence making the plug
> less efficient than it should be at merging IO? Seems unlikely, but I
> could be wrong.

No, it goes all the way back to 2011, my memory for those kinds of
details doesn't go that far back.

That said, it clearly is about preemption, and I wonder if we had an
actual bug there.

IOW, it might well not just in the "gather up more IO for bigger
requests" thing, but about "the IO plug is per-thread and doesn't have
locking because of that".

So doing plug flushing from a preemptible kernel context might race
with it all being set up.

Explicit io_schedule() etc obviously doesn't have that issue.

                       Linus

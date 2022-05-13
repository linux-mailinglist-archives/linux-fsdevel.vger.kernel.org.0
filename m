Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05142526B9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384452AbiEMUdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384479AbiEMUdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 16:33:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D56D1AD;
        Fri, 13 May 2022 13:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 948C8B831C4;
        Fri, 13 May 2022 20:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1DAC34100;
        Fri, 13 May 2022 20:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652473931;
        bh=gmC5AwVMGEU2yYbKfPpZCKlEafrDstnH7NSBfxHTE8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnVFoZiTL3uqj38AiZl1Vz7AxQAjGSbWngWz20DyGxSP0DgtxFcsxMN9FvY1MqChm
         1P+o4f+nAG2ZqVKZEYsQSnUTWeH2EC3JvmBHa4LQ0TD4oxpD7+6Za6gESm2+KpQLN/
         MxbE+y77lmCFjQXNV3L9gXUYmz/10kBHSZ3Gd8d4=
Date:   Fri, 13 May 2022 13:32:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     cgel.zte@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
Message-Id: <20220513133210.9dd0a4216bd8baaa1047562c@linux-foundation.org>
In-Reply-To: <1835064.A2aMcgg3dW@natalenko.name>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
        <5820954.lOV4Wx5bFT@natalenko.name>
        <20220512153753.6f999fa8f5519753d43b8fd5@linux-foundation.org>
        <1835064.A2aMcgg3dW@natalenko.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 13 May 2022 11:51:53 +0200 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hello.
> 
> On pátek 13. května 2022 0:37:53 CEST Andrew Morton wrote:
> > On Tue, 10 May 2022 15:30:36 +0200 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> > 
> > > > If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> > > > of this mm to be involved in KSM scanning without explicitly calling
> > > > madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> > > > the klob of /sys/kernel/mm/ksm/run is set as 1.
> > > > 
> > > > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > > > process (fallback to the default state) and unmerge those merged pages
> > > > belonging to VMAs which is not madvised as MADV_MERGEABLE of this process,
> > > > but still leave MADV_MERGEABLE areas merged.
> > > 
> > > To my best knowledge, last time a forcible KSM was discussed (see threads [1], [2], [3] and probably others) it was concluded that a) procfs was a horrible interface for things like this one; and b) process_madvise() syscall was among the best suggested places to implement this (which would require a more tricky handling from userspace, but still).
> > > 
> > > So, what changed since that discussion?
> > > 
> > > P.S. For now I do it via dedicated syscall, but I'm not trying to upstream this approach.
> > 
> > Why are you patching the kernel with a new syscall rather than using
> > process_madvise()?
> 
> Because I'm not sure how to use `process_madvise()` to achieve $subj properly.
> 
> The objective is to mark all the eligible VMAs of the target task for KSM to consider them for merging.
> 
> For that, all the eligible VMAs have to be traversed.
> 
> Given `process_madvise()` has got an iovec API, this means the process that will call `process_madvise()` has to know the list of VMAs of the target process. In order to traverse them in a race-free manner the target task has to be SIGSTOP'ped or frozen, then the list of VMAs has to be obtained, then `process_madvise()` has to be called, and the the target task can continue. This is:
> 
> a) superfluous (the kernel already knows the list of VMAs of the target tasks, why proxy it through the userspace then?); and
> b) may induce more latency than needed because the target task has to be stopped to avoid races.

OK.  And what happens to new vmas that the target process creates after
the process_madvise()?

> OTOH, IIUC, even if `MADV_MERGEABLE` is allowed for `process_madvise()`,

Is it not?

> I cannot just call it like this:
> 
> ```
> iovec.iov_base = 0;
> iovec.iov_len = ~0ULL;
> process_madvise(pidfd, &iovec, 1, MADV_MERGEABLE, 0);
> ```
> 
> to cover the whole address space because iovec expects total size to be under ssize_t.
> 
> Or maybe there's no need to cover the whole address space, only the lower half of it?

Call process_madvise() twice, once for each half?

> Or maybe there's another way of doing things, and I just look stupid and do not understand how this is supposed to work?..
> 
> I'm more than happy to read your comments on this.
> 

I see the problem.  I do like the simplicity of the ksm_force concept. 
Are there alternative ideas?

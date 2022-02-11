Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35E4B2CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 19:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbiBKSX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 13:23:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiBKSXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:23:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F181D90;
        Fri, 11 Feb 2022 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6bmWKufOT+cLbyWHVaSZ2zq2oHZWdFCHw9OkfjHW2rU=; b=SNSwPES6EeX8W34sohTCTVYDrL
        nXPUi72glzyq8aWU3OZVSf6YTOR/OtmHpJxQ+wrYsm1xIIVHZONlWzVfUAXWMix60JdxG6fyNwRAl
        0DMnPoCJsjvfODRCnhXlwV2LUJ5hGpOS7599OUxNA4QXQqokT26ht65PhOApQCeGSlFotmQyq+7+3
        aMFw6CmJvtx3iLqPhjtYH6ks1hRI4VHbwQsEdmU7qBR1xYyTp76T84DX6WjoxiKSuZHVbbbkhCd52
        rU+40y/O+PEFZJqwyC4htFuIkrssfoqfVokEZ+VenCMic0ILf/rTvieSNgQK9g7WM6TPqI8tK5kSt
        FkjO68bA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIaa6-008QuB-6y; Fri, 11 Feb 2022 18:23:42 +0000
Date:   Fri, 11 Feb 2022 10:23:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhen Ni <nizhen@uniontech.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move rr_timeslice sysctls to rt.c
Message-ID: <YgaprpOvUYlrNvdH@bombadil.infradead.org>
References: <20220210060831.26689-1-nizhen@uniontech.com>
 <20220211115114.GU23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211115114.GU23216@worktop.programming.kicks-ass.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc'ing Andrew for coordination on merging these sorts of patches.

On Fri, Feb 11, 2022 at 12:51:14PM +0100, Peter Zijlstra wrote:
> So I've dropped the whole lot I had:
> 
> patches/zhen_ni-sched-move_energy_aware_sysctls_to_topology_c.patch
> patches/zhen_ni-sched-move_cfs_bandwidth_slice_sysctls_to_fair_c.patch
> patches/zhen_ni-sched-move_uclamp_util_sysctls_to_core_c.patch
> patches/zhen_ni-sched-move_schedstats_sysctls_to_core_c.patch
> patches/zhen_ni-sched-move_deadline_period_sysctls_to_deadline_c.patch
> patches/zhen_ni-sched-move_rt_period_runtime_sysctls_to_rt_c.patch
> patches/zhen_ni-sched-move_rr_timeslice_sysctls_to_rt_c.patch
> 
> And I expect a single coherent series or I'll forgo all this.

I suspect Zhen will follow up accordingly.

So Andrew had merged tons of initial cleanups for kernel/sysctl.c. Now
that some of the initial grunt work and sysctls for fs are out of
kernel/sysctl.c, I'm seeing the next target seems to be the scheduler. I
don't think these *need* to go through Andrew's tree since the fs
changes are already on Linus' tree. So figured I'd drop this note to
just remind ourselves that if accumulate a few of these patches for one
subsystem there is a greater risk of a conflict later with another
subsystem doing some similar cleanup. So for the next release I think it
makes sense to keep this localized somehow if we can. Maybe we just deal
with these on Peter's tree?

  Luis

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F21B17FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDTVGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbgDTVGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD879C061A0C;
        Mon, 20 Apr 2020 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bzkBd5/DmyxuIeGg8WVcx1ykVacx8pGIZb2Q1x9nRo4=; b=DNIGqrjjXa9rfJIlYQ6/w0oTOL
        Zc36hX2DDii8dVOYNhs5X+FwLalCu6gBAL25BNJGwZhQKZqCMvbBFtyXkAPb/GfMoyqArNR5ZEpXH
        ihxm8GqaAGtSGf31R3h7K53d0IRvylDPBQ71hVxr29VHXbklaCkr3QlZEAlF8Ukw7ToMw8PdeJQ+s
        kNW7oZ8wpyh5W7IvXdJ0hsLoPYItHUrRvSO41pj8WY0rMNQR/WNVm281PeZLAtkFfBaFPHfKjxcdV
        AKqz2sfrALlIpxh4RCun4nkGSnx3BdmcHk4n6IuVHQKiHNc2FdTU3duyKsZUR2skvT9bxd2rfIvye
        69f090gA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQdc5-0000US-Tt; Mon, 20 Apr 2020 21:05:57 +0000
Date:   Mon, 20 Apr 2020 14:05:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 01/15] sched: make nr_running() return "unsigned int"
Message-ID: <20200420210557.GG5820@bombadil.infradead.org>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:57:29PM +0300, Alexey Dobriyan wrote:
> I don't anyone have been crazy enough to spawn 2^32 threads.
> It'd require absurd amounts of physical memory,  and bump into futex pid
> limit anyway.
> 
> Meanwhile save few bits on REX prefixes and some stack space for upcoming
> print_integer() stuff.
> 
> And remove "extern" from prototypes while I'm at it.

It seems like there's a few more places to fix in this regard?

kernel/sched/fair.c:static u64 __sched_period(unsigned long nr_running)
kernel/sched/sched.h:   unsigned long           dl_nr_running;
kernel/sched/core.c:unsigned long nr_iowait_cpu(int cpu)
kernel/sched/core.c:unsigned long nr_iowait(void)
kernel/sched/loadavg.c: long nr_active, delta = 0;
kernel/sched/sched.h:   unsigned long           rt_nr_migratory;
kernel/sched/sched.h:   unsigned long           rt_nr_total;
kernel/sched/sched.h:   unsigned long           rt_nr_boosted;
kernel/sched/sched.h:   unsigned long           dl_nr_running;
kernel/sched/sched.h:   unsigned long           dl_nr_migratory;
kernel/sched/sched.h:   unsigned long           nr_uninterruptible;


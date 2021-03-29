Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD334CF65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhC2LvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhC2Luk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:50:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD719C061574;
        Mon, 29 Mar 2021 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7UpbfvkQlofjez1TPOd4UNQFXQ8qN4tvk7VAKOS6IdU=; b=d1jazCfp9GFupDWuBoEvDZbGQK
        UZh3r/Vp7n5hXFiWCRo215QQeab+C/jEbXVjcic5hvqv1r6g1ghqgrv2GxYXYmkSyn4iBwAS+LchH
        7gZ35kDMDQ9572RglcVE7MJEUXddNPs8Kd3T5ODSizVqeAKVKfP64BLPfF5dA2MQFFi+tCK3ySnj/
        k7bpEyUmvUYCGxB4sNNoCeCl561LuFtPXN/WCumUy0p2m5rBfOZEcaoXWn/52rEV5pZnqgiaHoApH
        4at1tHWSSFRxtOcbeUlp63TMCdcM7UVOQIapZPgpZ0v8tD3V5ZkJ2SrKZ+7iq52ZFro1OaDrYGS0z
        nQ1RJ6Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQqPU-000cyZ-G1; Mon, 29 Mar 2021 11:50:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D0E3305CC3;
        Mon, 29 Mar 2021 13:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EFE92071A3DD; Mon, 29 Mar 2021 13:50:19 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:50:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/11] perf: Rework perf_event_exit_event()
Message-ID: <YGG++nxhvVBSEphQ@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-2-elver@google.com>
 <YFxjJam0ErVmk99i@elver.google.com>
 <YFy3qI65dBfbsZ1z@elver.google.com>
 <YFzgO0AhGFODmgc1@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFzgO0AhGFODmgc1@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:10:51PM +0100, Marco Elver wrote:

> and therefore synthesized this fix on top:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 57de8d436efd..e77294c7e654 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12400,7 +12400,7 @@ static void sync_child_event(struct perf_event *child_event)
>  	if (child_event->attr.inherit_stat) {
>  		struct task_struct *task = child_event->ctx->task;
>  
> -		if (task)
> +		if (task && task != TASK_TOMBSTONE)
>  			perf_event_read_event(child_event, task);
>  	}
>  
> which fixes the problem. My guess is that the parent and child are both
> racing to exit?
> 
> Does that make any sense?

Yes, I think it does. ACK

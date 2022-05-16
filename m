Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3D528ACA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiEPQpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbiEPQpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:45:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936303C4BB;
        Mon, 16 May 2022 09:45:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12F2722023;
        Mon, 16 May 2022 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652719504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1cuhmg/5wnGfWVCfJ3OzVK0K9C2gJVK76XQYPz6KqI=;
        b=Llq6vrw2FLzDd7Ehr6QLl+N0BoHmma0XEANDL72UpqofMZMo5j2CDuWWJLYok6jijOAu+c
        aaQ7lVgOZe5+suqo7db8fp+u52SFsfKuJrznCh8rc45nwrXUcRol8JxokYILkGhRfWZ4ej
        u8Lqds9e+S0nLT6TtjeqOuuwKyZyRHM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 134102C141;
        Mon, 16 May 2022 16:45:01 +0000 (UTC)
Date:   Mon, 16 May 2022 18:44:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/5 v1] mm, oom: Introduce per numa node oom for
 CONSTRAINT_MEMORY_POLICY
Message-ID: <YoJ/ioXwGTdCywUE@dhcp22.suse.cz>
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-05-22 12:46:29, Gang Li wrote:
> TLDR:
> If a mempolicy is in effect(oc->constraint == CONSTRAINT_MEMORY_POLICY), out_of_memory() will
> select victim on specific node to kill. So that kernel can avoid accidental killing on NUMA system.
> 
> Problem:
> Before this patch series, oom will only kill the process with the highest memory usage.
> by selecting process with the highest oom_badness on the entire system to kill.
> 
> This works fine on UMA system, but may have some accidental killing on NUMA system.
> 
> As shown below, if process c.out is bind to Node1 and keep allocating pages from Node1,
> a.out will be killed first. But killing a.out did't free any mem on Node1, so c.out
> will be killed then.
> 
> A lot of our AMD machines have 8 numa nodes. In these systems, there is a greater chance
> of triggering this problem.

Sorry, I have only now found this email thread. The limitation of the
NUMA constrained oom is well known and long standing. Basically the
whole thing is a best effort as we are lacking per numa node memory
stats. I can see that you are trying to fill up that gap but this is
not really free. Have you measured the runtime overhead? Accounting is
done in a very performance sensitive paths and it would be rather
unfortunate to make everybody pay the overhead while binding to a
specific node or sets of nodes is not the most common usecase.

Also have you tried to have a look at cpusets? Those should be easier to
make a proper selection as it should be possible to iterate over tasks
belonging to a specific cpuset much more easier - essentialy something
similar to memcg oom killer. We do not do that right now and by a very
brief look at the CONSTRAINT_CPUSET it seems that this code is not
really doing much these days. Maybe that would be a more appropriate way
to deal with more precise node aware oom killing?

[...]
>  21 files changed, 317 insertions(+), 111 deletions(-)

The code footprint is not free either. And more importantnly does this
even work much more reliably? I can see quite some NUMA_NO_NODE
accounting (e.g. copy_pte_range!).Is this somehow fixable?

Also how do those numbers add up. Let's say you increase the counter as
NUMA_NO_NODE but later on during the clean up you decrease based on the
page node?

Last but not least I am really not following MM_NO_TYPE concept. I can
only see add_mm_counter users without any decrements. What is going on
there?
-- 
Michal Hocko
SUSE Labs

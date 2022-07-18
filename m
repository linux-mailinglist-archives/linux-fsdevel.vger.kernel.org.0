Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC25781C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiGRMLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 08:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiGRMLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:11:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AABF6F;
        Mon, 18 Jul 2022 05:11:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8AC71FB7D;
        Mon, 18 Jul 2022 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658146310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6D6pW7KOU2kPWCiZd07qffFGU6SpyCb2tbQHBnWrPk=;
        b=EXPnzUbilMMA5F7I79PNHtjTgfbMNI9Re7xNL324QWOc5NRzwccoapCXDua4tdUktLRmBD
        bqJJ6Pj+LoonmpjEJP9fMbxhYEWaV4vgH0QQoo2JU/UFNvQwduA0OeLIzlzuT7gU37fUAA
        HHZbVqI9QkVqm/m53IDyVIhn0W+WGW0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E612B2C141;
        Mon, 18 Jul 2022 12:11:45 +0000 (UTC)
Date:   Mon, 18 Jul 2022 14:11:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, akpm@linux-foundation.org,
        surenb@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, david@redhat.com,
        imbrenda@linux.ibm.com, adobriyan@gmail.com,
        yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        hezhongkun.hzk@bytedance.com
Subject: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Message-ID: <YtVOAGga+B3CmFKC@dhcp22.suse.cz>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
 <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
 <41ae31a7-6998-be88-858c-744e31a76b2a@bytedance.com>
 <Ys14oIHL85d/T7s+@dhcp22.suse.cz>
 <6f6a2257-3b60-e312-3ee3-fb08b972dbf2@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6a2257-3b60-e312-3ee3-fb08b972dbf2@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-07-22 23:00:55, Abel Wu wrote:
> 
> On 7/12/22 9:35 PM, Michal Hocko Wrote:
> > On Tue 12-07-22 19:12:18, Abel Wu wrote:
> > [...]
> > > I was just going through the mail list and happen to see this. There
> > > is another usecase for us about per-numa memory usage.
> > > 
> > > Say we have several important latency-critical services sitting inside
> > > different NUMA nodes without intersection. The need for memory of these
> > > LC services varies, so the free memory of each node is also different.
> > > Then we launch several background containers without cpuset constrains
> > > to eat the left resources. Now the problem is that there doesn't seem
> > > like a proper memory policy available to balance the usage between the
> > > nodes, which could lead to memory-heavy LC services suffer from high
> > > memory pressure and fails to meet the SLOs.
> > 
> > I do agree that cpusets would be rather clumsy if usable at all in a
> > scenario when you are trying to mix NUMA bound workloads with those
> > that do not have any NUMA proferences. Could you be more specific about
> > requirements here though?
> 
> Yes, these LC services are highly sensitive to memory access latency
> and bandwidth, so they are provisioned by NUMA node granule to meet
> their performance requirements. While on the other hand, they usually
> do not make full use of cpu/mem resources which increases the TCO of
> our IDCs, so we have to co-locate them with background tasks.
> 
> Some of these LC services are memory-bound but leave much of cpu's
> capacity unused. In this case we hope the co-located background tasks
> to consume some leftover without introducing obvious mm overhead to
> the LC services.

This are some tough requirements and I am afraid far from any typical
usage. So I believe that you need a careful tunning much more than a
policy which I really have hard time to imagine wrt semantic TBH.
 
> > Let's say you run those latency critical services with "simple" memory
> > policies and mix them with the other workload without any policies in
> > place so they compete over memory. It is not really clear to me how can
> > you achieve any reasonable QoS in such an environment. Your latency
> > critical servises will be more constrained than the non-critical ones
> > yet they are more demanding AFAIU.
> 
> Yes, the QoS over memory is the biggest block in the way (the other
> resources are relatively easier). For now, we hacked a new mpol to
> achieve weighted-interleave behavior to balance the memory usage across
> NUMA nodes, and only set memcg protections to the LC services. If the
> memory pressure is still high, the background tasks will be killed.
> Ideas? Thanks!

It is not really clear what the new memory policy does and what is the
semantic of it from your description. Memory protection (via memcg) of
your sensitive workload makes sense but it would require proper setting
of background jobs as well. As soon as you hit the global direct reclaim
then the memory protection won't safe your sensitve workload.

-- 
Michal Hocko
SUSE Labs

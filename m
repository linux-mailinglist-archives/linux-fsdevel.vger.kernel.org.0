Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE59856B4D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiGHIyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiGHIyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:54:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56761D47;
        Fri,  8 Jul 2022 01:54:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F019E1FEFE;
        Fri,  8 Jul 2022 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657270477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y09aHnftKgsb755aav+tcisMBqwaGQVPRoF6I/GeksQ=;
        b=pFEUnbCb+AjEBxNHzdq1IzRE0SheLCfh79/KP/G2SXw3v7NpmirYHy0MKyq6FafCpJoHdC
        Zbw81wF2FOf/Qk3Ph1hEgS9khYQ4lGrGD+cADZ22SMXc6uOyDMgwsrnnvaOpOJQRDLhzAb
        HRMxK0Ok91k7A5/A6xLynKW6jrv/yZ0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 04BBE2C141;
        Fri,  8 Jul 2022 08:54:33 +0000 (UTC)
Date:   Fri, 8 Jul 2022 10:54:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     akpm@linux-foundation.org, surenb@google.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
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
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Message-ID: <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-07-22 16:21:24, Gang Li wrote:
> TLDR
> ----
> If a mempolicy or cpuset is in effect, out_of_memory() will select victim
> on specific node to kill. So that kernel can avoid accidental killing on
> NUMA system.

We have discussed this in your previous posting and an alternative
proposal was to use cpusets to partition NUMA aware workloads and
enhance the oom killer to be cpuset aware instead which should be a much
easier solution.

> Problem
> -------
> Before this patch series, oom will only kill the process with the highest 
> memory usage by selecting process with the highest oom_badness on the
> entire system.
> 
> This works fine on UMA system, but may have some accidental killing on NUMA
> system.
> 
> As shown below, if process c.out is bind to Node1 and keep allocating pages
> from Node1, a.out will be killed first. But killing a.out did't free any
> mem on Node1, so c.out will be killed then.
> 
> A lot of AMD machines have 8 numa nodes. In these systems, there is a
> greater chance of triggering this problem.

Please be more specific about existing usecases which suffer from the
current OOM handling limitations. 
-- 
Michal Hocko
SUSE Labs

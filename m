Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260D56B5A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiGHJhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGHJhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:37:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2E5C9FB;
        Fri,  8 Jul 2022 02:37:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C22C21D17;
        Fri,  8 Jul 2022 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657273056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pF5t9woP5GK7nrYHCChHnPpig1ebKAkf9WM7m6BgpzY=;
        b=ShLUEdpxYc7XD3h7H3p2c0Ce+oEtfkQmGRD//brWuBbI5EHHFnb9Azy6FYZEEJjo6Fiybh
        YxEOE6VrCabpXmn/LDZkYUDcfTwLA+eFskdIIUXll3DbYZKMPq0mHpxf2NWQ3+GV++z9ow
        33bR6j+Um9l5Xkum6DMu4IYiFMF2J2Y=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B78522C141;
        Fri,  8 Jul 2022 09:37:34 +0000 (UTC)
Date:   Fri, 8 Jul 2022 11:37:31 +0200
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
Subject: Re: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Message-ID: <Ysf629IWfT5b58oD@dhcp22.suse.cz>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
 <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
 <be9303de-3800-c26f-4530-9a29fe044956@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9303de-3800-c26f-4530-9a29fe044956@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-07-22 17:25:31, Gang Li wrote:
> Oh apologize. I just realized what you mean.
> 
> I should try a "cpuset cgroup oom killer" selecting victim from a
> specific cpuset cgroup.

yes, that was the idea. Many workloads which really do care about
particioning the NUMA system tend to use cpusets. In those cases you
have reasonably defined boundaries and the current OOM killer
imeplementation is not really aware of that. The oom selection process
could be enhanced/fixed to select victims from those cpusets similar to
how memcg oom killer victim selection is done.

There is no additional accounting required for this approach because the
workload is partitioned on the cgroup level already. Maybe this is not
really the best fit for all workloads but it should be reasonably simple
to implement without intrusive or runtime visible changes.

I am not saying per-numa accounting is wrong or a bad idea. I would just
like to see a stronger justification for that and also some arguments
why a simpler approach via cpusets is not viable.

Does this make sense to you?

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020496471A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHOZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 09:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLHOYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:24:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50C45080;
        Thu,  8 Dec 2022 06:23:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F65B208CE;
        Thu,  8 Dec 2022 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670509437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX6YDzb8PyIKMrTf468EmhvBSzk6iJctUJatHJ6cuIA=;
        b=Qz7O1fJU8HHKKGBJmw8kfV/cErZ0iiN4f0bZfE5jsTRKpgLCCwWA2WlbQKYkLPlqYUsdIv
        QL4Tw0VatsYd6IlM50vHZ/Vh+5Gf/HUmlVUUZOZbte/Xefcdyd2eJjwb7GOYwzbCqbDOFp
        u3emrcIcxK2r4dEtCLvHkYxAVTnsGc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1574913416;
        Thu,  8 Dec 2022 14:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SgCvBH3zkWODbAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Dec 2022 14:23:57 +0000
Date:   Thu, 8 Dec 2022 15:23:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>
Cc:     chengkaitao <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Message-ID: <Y5HzfLB7lu4+BOu1@dhcp22.suse.cz>
References: <Y5Gc0jiDlWlRlMYH@dhcp22.suse.cz>
 <3E260DAC-2E2F-48B7-98BB-036EF0A423DC@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E260DAC-2E2F-48B7-98BB-036EF0A423DC@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-12-22 14:07:06, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-08 16:14:10, "Michal Hocko" <mhocko@suse.com> wrote:
> >On Thu 08-12-22 07:59:27, 程垲涛 Chengkaitao Cheng wrote:
> >> At 2022-12-08 15:33:07, "Michal Hocko" <mhocko@suse.com> wrote:
> >> >On Thu 08-12-22 11:46:44, chengkaitao wrote:
> >> >> From: chengkaitao <pilgrimtao@gmail.com>
> >> >> 
> >> >> We created a new interface <memory.oom.protect> for memory, If there is
> >> >> the OOM killer under parent memory cgroup, and the memory usage of a
> >> >> child cgroup is within its effective oom.protect boundary, the cgroup's
> >> >> tasks won't be OOM killed unless there is no unprotected tasks in other
> >> >> children cgroups. It draws on the logic of <memory.min/low> in the
> >> >> inheritance relationship.
> >> >> 
> >> >> It has the following advantages,
> >> >> 1. We have the ability to protect more important processes, when there
> >> >> is a memcg's OOM killer. The oom.protect only takes effect local memcg,
> >> >> and does not affect the OOM killer of the host.
> >> >> 2. Historically, we can often use oom_score_adj to control a group of
> >> >> processes, It requires that all processes in the cgroup must have a
> >> >> common parent processes, we have to set the common parent process's
> >> >> oom_score_adj, before it forks all children processes. So that it is
> >> >> very difficult to apply it in other situations. Now oom.protect has no
> >> >> such restrictions, we can protect a cgroup of processes more easily. The
> >> >> cgroup can keep some memory, even if the OOM killer has to be called.
> >> >> 
> >> >> Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
> >> >> ---
> >> >> v2: Modify the formula of the process request memcg protection quota.
> >> >
> >> >The new formula doesn't really address concerns expressed previously.
> >> >Please read my feedback carefully again and follow up with questions if
> >> >something is not clear.
> >> 
> >> The previous discussion was quite scattered. Can you help me summarize
> >> your concerns again?
> >
> >The most important part is http://lkml.kernel.org/r/Y4jFnY7kMdB8ReSW@dhcp22.suse.cz
> >: Let me just emphasise that we are talking about fundamental disconnect.
> >: Rss based accounting has been used for the OOM killer selection because
> >: the memory gets unmapped and _potentially_ freed when the process goes
> >: away. Memcg changes are bound to the object life time and as said in
> >: many cases there is no direct relation with any process life time.
> >
> We need to discuss the relationship between memcg's mem and process's mem, 
> 
> task_usage = task_anon(rss_anon) + task_mapped_file(rss_file) 
> 	 + task_mapped_share(rss_share) + task_pgtables + task_swapents
> 
> memcg_usage	= memcg_anon + memcg_file + memcg_pgtables + memcg_share
> 	= all_task_anon + all_task_mapped_file + all_task_mapped_share 
> 	 + all_task_pgtables + unmapped_file + unmapped_share
> 	= all_task_usage + unmapped_file + unmapped_share - all_task_swapents

You are missing all the kernel charged objects (aka __GFP_ACCOUNT
allocations resp. SLAB_ACCOUNT for slab caches). Depending on the
workload this can be really a very noticeable portion. So not this is
not just about unmapped cache or shm.

> >That is to the per-process discount based on rss or any per-process
> >memory metrics.
> >
> >Another really important question is the actual configurability. The
> >hierarchical protection has to be enforced and that means that same as
> >memory reclaim protection it has to be enforced top-to-bottom in the
> >cgroup hierarchy. That makes the oom protection rather non-trivial to
> >configure without having a good picture of a larger part of the cgroup
> >hierarchy as it cannot be tuned based on a reclaim feedback.
> 
> There is an essential difference between reclaim and oom killer.

oom killer is a memory reclaim of the last resort. So yes, there is some
difference but fundamentally it is about releasing some memory. And long
term we have learned that the more clever it tries to be the more likely
corner cases can happen. It is simply impossible to know the best
candidate so this is a just a best effort. We try to aim for
predictability at least.

> The reclaim 
> cannot be directly perceived by users,

I very strongly disagree with this statement. First the direct reclaim is a
direct source of latencies because the work is done on behalf of the
allocating process. There are side effect possible as well because
refaults have their cost as well.

> so memcg need to count indicators 
> similar to pgscan_(kswapd/direct). However, when the user process is killed 
> by oom killer, users can clearly perceive and count (such as the number of 
> restarts of a certain type of process). At the same time, the kernel also has 
> memory.events to count some information about the oom killer, which can 
> also be used for feedback adjustment.

Yes we have those metrics already. I suspect I haven't made myself
clear. I didn't say there are no measures to see how oom behaves. What
I've said that I _suspect_ that oom protection would be really hard to
configure correctly because unlike the memory reclaim which happens
during the normal operation, oom is a relatively rare event and it is
quite hard to use it for any feedback mechanisms. But I am really open
to be convinced otherwise and this is in fact what I have been asking
for since the beginning. I would love to see some examples on the
reasonable configuration for a practical usecase. It is one thing to say
that you can set the protection to a certain value and a different one
to have a way to determine that value. See my point?

-- 
Michal Hocko
SUSE Labs

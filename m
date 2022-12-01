Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7065C63F392
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiLAPRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiLAPRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:17:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A920364;
        Thu,  1 Dec 2022 07:17:51 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1336C21A99;
        Thu,  1 Dec 2022 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669907870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXlkWC2x3jCBLbFSc4SzlcbQGp8MHx6uDp5av6z1mNo=;
        b=k30ixjE6LqemmfsFV0Zse9FQiuesSQnFgGvweadjcr1aagroTOCG5WHwVwJFGEfGusCFCf
        KW2BoWfpyl09bC/FfJrhxJiI1euhcu0Y3ghwo3YfXLLX4Fou04MqnJwgyeq+bFLrnwfWaS
        682upUE6Tr9AOU9BINm3McZE+5sMDig=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EEA7713503;
        Thu,  1 Dec 2022 15:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id fy3bOZ3FiGMETgAAGKfGzw
        (envelope-from <mhocko@suse.com>); Thu, 01 Dec 2022 15:17:49 +0000
Date:   Thu, 1 Dec 2022 16:17:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>
Cc:     Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "ran.xiaokai@zte.com.cn" <ran.xiaokai@zte.com.cn>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Message-ID: <Y4jFnY7kMdB8ReSW@dhcp22.suse.cz>
References: <Y4inSsNpmomzRt8J@dhcp22.suse.cz>
 <C9FFF5A4-B883-4C0D-A802-D94080D6C3A4@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C9FFF5A4-B883-4C0D-A802-D94080D6C3A4@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-12-22 14:30:11, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-01 21:08:26, "Michal Hocko" <mhocko@suse.com> wrote:
> >On Thu 01-12-22 13:44:58, Michal Hocko wrote:
> >> On Thu 01-12-22 10:52:35, 程垲涛 Chengkaitao Cheng wrote:
> >> > At 2022-12-01 16:49:27, "Michal Hocko" <mhocko@suse.com> wrote:
> >[...]
> >> There is a misunderstanding, oom.protect does not replace the user's 
> >> tailed policies, Its purpose is to make it easier and more efficient for 
> >> users to customize policies, or try to avoid users completely abandoning 
> >> the oom score to formulate new policies.
> >
> > Then you should focus on explaining on how this makes those policies and
> > easier and moe efficient. I do not see it.
> 
> In fact, there are some relevant contents in the previous chat records. 
> If oom.protect is applied, it will have the following benefits
> 1. Users only need to focus on the management of the local cgroup, not the 
> impact on other users' cgroups.

Protection based balancing cannot really work in an isolation.

> 2. Users and system do not need to spend extra time on complicated and 
> repeated scanning and configuration. They just need to configure the 
> oom.protect of specific cgroups, which is a one-time task

This will not work same way as the memory reclaim protection cannot work
in an isolation on the memcg level.

> >> > >Why cannot you simply discount the protection from all processes
> >> > >equally? I do not follow why the task_usage has to play any role in
> >> > >that.
> >> > 
> >> > If all processes are protected equally, the oom protection of cgroup is 
> >> > meaningless. For example, if there are more processes in the cgroup, 
> >> > the cgroup can protect more mems, it is unfair to cgroups with fewer 
> >> > processes. So we need to keep the total amount of memory that all 
> >> > processes in the cgroup need to protect consistent with the value of 
> >> > eoom.protect.
> >> 
> >> You are mixing two different concepts together I am afraid. The per
> >> memcg protection should protect the cgroup (i.e. all processes in that
> >> cgroup) while you want it to be also process aware. This results in a
> >> very unclear runtime behavior when a process from a more protected memcg
> >> is selected based on its individual memory usage.
> >
> The correct statement here should be that each memcg protection should 
> protect the number of mems specified by the oom.protect. For example, 
> a cgroup's usage is 6G, and it's oom.protect is 2G, when an oom killer occurs, 
> In the worst case, we will only reduce the memory used by this cgroup to 2G 
> through the om killer.

I do not see how that could be guaranteed. Please keep in mind that a
non-trivial amount of memory resources could be completely independent
on any process life time (just consider tmpfs as a trivial example).

> >Let me be more specific here. Although it is primarily processes which
> >are the primary source of memcg charges the memory accounted for the oom
> >badness purposes is not really comparable to the overal memcg charged
> >memory. Kernel memory, non-mapped memory all that can generate rather
> >interesting cornercases.
> 
> Sorry, I'm thoughtless enough about some special memory statistics. I will fix 
> it in the next version

Let me just emphasise that we are talking about fundamental disconnect.
Rss based accounting has been used for the OOM killer selection because
the memory gets unmapped and _potentially_ freed when the process goes
away. Memcg changes are bound to the object life time and as said in
many cases there is no direct relation with any process life time.

Hope that clarifies.
-- 
Michal Hocko
SUSE Labs

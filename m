Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635FF63F0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLAMpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 07:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLAMpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:45:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E7C8C6AF;
        Thu,  1 Dec 2022 04:44:59 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E60621AC2;
        Thu,  1 Dec 2022 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669898698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2usVyVHvq6UpCYGTeYatlo+CIODmj9sJULa7nXifL7I=;
        b=hVlPQZhQULbKSaUOF1Ptr93R7UHM2CFgYMqevAQOi+JuvHhxUFBIvxcFSM2Vh7Djf7zhEL
        dlFAaCNFppiO/tq30A6MzlbBRIYJXya8GMZ+SOvkebJl/TRVMO1i2Tyy8KA1wVap+1o63F
        rrwgJlk321vFBTdqNpCzEqeY/yXhzEU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EB1CB13503;
        Thu,  1 Dec 2022 12:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mpA4OcmhiGM3eAAAGKfGzw
        (envelope-from <mhocko@suse.com>); Thu, 01 Dec 2022 12:44:57 +0000
Date:   Thu, 1 Dec 2022 13:44:57 +0100
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
Message-ID: <Y4ihyRqQzyFFLqh6@dhcp22.suse.cz>
References: <Y4hqlzNeZ6Osu0pI@dhcp22.suse.cz>
 <C2CC36C1-29AE-4B65-A18A-19A745652182@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2CC36C1-29AE-4B65-A18A-19A745652182@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-12-22 10:52:35, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-01 16:49:27, "Michal Hocko" <mhocko@suse.com> wrote:
> >On Thu 01-12-22 04:52:27, 程垲涛 Chengkaitao Cheng wrote:
> >> At 2022-12-01 00:27:54, "Michal Hocko" <mhocko@suse.com> wrote:
> >> >On Wed 30-11-22 15:46:19, 程垲涛 Chengkaitao Cheng wrote:
> >> >> On 2022-11-30 21:15:06, "Michal Hocko" <mhocko@suse.com> wrote:
> >> >> > On Wed 30-11-22 15:01:58, chengkaitao wrote:
> >> >> > > From: chengkaitao <pilgrimtao@gmail.com>
> >> >> > >
> >> >> > > We created a new interface <memory.oom.protect> for memory, If there is
> >> >> > > the OOM killer under parent memory cgroup, and the memory usage of a
> >> >> > > child cgroup is within its effective oom.protect boundary, the cgroup's
> >> >> > > tasks won't be OOM killed unless there is no unprotected tasks in other
> >> >> > > children cgroups. It draws on the logic of <memory.min/low> in the
> >> >> > > inheritance relationship.
> >> >> >
> >> >> > Could you be more specific about usecases?
> >> >
> >> >This is a very important question to answer.
> >> 
> >> usecases 1: users say that they want to protect an important process 
> >> with high memory consumption from being killed by the oom in case 
> >> of docker container failure, so as to retain more critical on-site 
> >> information or a self recovery mechanism. At this time, they suggest 
> >> setting the score_adj of this process to -1000, but I don't agree with 
> >> it, because the docker container is not important to other docker 
> >> containers of the same physical machine. If score_adj of the process 
> >> is set to -1000, the probability of oom in other container processes will 
> >> increase.
> >> 
> >> usecases 2: There are many business processes and agent processes 
> >> mixed together on a physical machine, and they need to be classified 
> >> and protected. However, some agents are the parents of business 
> >> processes, and some business processes are the parents of agent 
> >> processes, It will be troublesome to set different score_adj for them. 
> >> Business processes and agents cannot determine which level their 
> >> score_adj should be at, If we create another agent to set all processes's 
> >> score_adj, we have to cycle through all the processes on the physical 
> >> machine regularly, which looks stupid.
> >
> >I do agree that oom_score_adj is far from ideal tool for these usecases.
> >But I also agree with Roman that these could be addressed by an oom
> >killer implementation in the userspace which can have much better
> >tailored policies. OOM protection limits would require tuning and also
> >regular revisions (e.g. memory consumption by any workload might change
> >with different kernel versions) to provide what you are looking for.
> 
> There is a misunderstanding, oom.protect does not replace the user's 
> tailed policies, Its purpose is to make it easier and more efficient for 
> users to customize policies, or try to avoid users completely abandoning 
> the oom score to formulate new policies.

Then you should focus on explaining on how this makes those policies and
easier and moe efficient. I do not see it.

[...]

> >Why cannot you simply discount the protection from all processes
> >equally? I do not follow why the task_usage has to play any role in
> >that.
> 
> If all processes are protected equally, the oom protection of cgroup is 
> meaningless. For example, if there are more processes in the cgroup, 
> the cgroup can protect more mems, it is unfair to cgroups with fewer 
> processes. So we need to keep the total amount of memory that all 
> processes in the cgroup need to protect consistent with the value of 
> eoom.protect.

You are mixing two different concepts together I am afraid. The per
memcg protection should protect the cgroup (i.e. all processes in that
cgroup) while you want it to be also process aware. This results in a
very unclear runtime behavior when a process from a more protected memcg
is selected based on its individual memory usage.
-- 
Michal Hocko
SUSE Labs

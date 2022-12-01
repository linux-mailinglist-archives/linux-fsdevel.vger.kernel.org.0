Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C363EB94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 09:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLAItx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 03:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLAIte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:49:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157A11A1D;
        Thu,  1 Dec 2022 00:49:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D59C1FD68;
        Thu,  1 Dec 2022 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669884568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guIxpxNAKGFiX13aZHwKzc4sgDiWlaSOm8SorFitB8w=;
        b=N3ADfolne44ylq/Uj9XYi305h0aolKKN92dzo6nzondChOAnn42JLZGonKi8piI1EwfYrL
        5qhGgcY5pZR1iPH0r/oAwVw5Bk3BusbtMcafYF38Bf26AKI3S6FsOcdGIdLeNuc4XPcekJ
        rezD8+qtp+o1njMbFZ0/5oGMnYYS78Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4B813B4A;
        Thu,  1 Dec 2022 08:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHRmBphqiGM8GgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Dec 2022 08:49:28 +0000
Date:   Thu, 1 Dec 2022 09:49:27 +0100
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
Message-ID: <Y4hqlzNeZ6Osu0pI@dhcp22.suse.cz>
References: <Y4eEiqwMMkHv9ELM@dhcp22.suse.cz>
 <E5A5BCC3-460E-4E81-8DD3-88B4A2868285@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E5A5BCC3-460E-4E81-8DD3-88B4A2868285@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-12-22 04:52:27, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-01 00:27:54, "Michal Hocko" <mhocko@suse.com> wrote:
> >On Wed 30-11-22 15:46:19, 程垲涛 Chengkaitao Cheng wrote:
> >> On 2022-11-30 21:15:06, "Michal Hocko" <mhocko@suse.com> wrote:
> >> > On Wed 30-11-22 15:01:58, chengkaitao wrote:
> >> > > From: chengkaitao <pilgrimtao@gmail.com>
> >> > >
> >> > > We created a new interface <memory.oom.protect> for memory, If there is
> >> > > the OOM killer under parent memory cgroup, and the memory usage of a
> >> > > child cgroup is within its effective oom.protect boundary, the cgroup's
> >> > > tasks won't be OOM killed unless there is no unprotected tasks in other
> >> > > children cgroups. It draws on the logic of <memory.min/low> in the
> >> > > inheritance relationship.
> >> >
> >> > Could you be more specific about usecases?
> >
> >This is a very important question to answer.
> 
> usecases 1: users say that they want to protect an important process 
> with high memory consumption from being killed by the oom in case 
> of docker container failure, so as to retain more critical on-site 
> information or a self recovery mechanism. At this time, they suggest 
> setting the score_adj of this process to -1000, but I don't agree with 
> it, because the docker container is not important to other docker 
> containers of the same physical machine. If score_adj of the process 
> is set to -1000, the probability of oom in other container processes will 
> increase.
> 
> usecases 2: There are many business processes and agent processes 
> mixed together on a physical machine, and they need to be classified 
> and protected. However, some agents are the parents of business 
> processes, and some business processes are the parents of agent 
> processes, It will be troublesome to set different score_adj for them. 
> Business processes and agents cannot determine which level their 
> score_adj should be at, If we create another agent to set all processes's 
> score_adj, we have to cycle through all the processes on the physical 
> machine regularly, which looks stupid.

I do agree that oom_score_adj is far from ideal tool for these usecases.
But I also agree with Roman that these could be addressed by an oom
killer implementation in the userspace which can have much better
tailored policies. OOM protection limits would require tuning and also
regular revisions (e.g. memory consumption by any workload might change
with different kernel versions) to provide what you are looking for.
 
> >> > How do you tune oom.protect
> >> > wrt to other tunables? How does this interact with the oom_score_adj
> >> > tunining (e.g. a first hand oom victim with the score_adj 1000 sitting
> >> > in a oom protected memcg)?
> >> 
> >> We prefer users to use score_adj and oom.protect independently. Score_adj is 
> >> a parameter applicable to host, and oom.protect is a parameter applicable to cgroup. 
> >> When the physical machine's memory size is particularly large, the score_adj 
> >> granularity is also very large. However, oom.protect can achieve more fine-grained 
> >> adjustment.
> >
> >Let me clarify a bit. I am not trying to defend oom_score_adj. It has
> >it's well known limitations and it is is essentially unusable for many
> >situations other than - hide or auto-select potential oom victim.
> >
> >> When the score_adj of the processes are the same, I list the following cases 
> >> for explanation,
> >> 
> >>           root
> >>            |
> >>         cgroup A
> >>        /        \
> >>  cgroup B      cgroup C
> >> (task m,n)     (task x,y)
> >> 
> >> score_adj(all task) = 0;
> >> oom.protect(cgroup A) = 0;
> >> oom.protect(cgroup B) = 0;
> >> oom.protect(cgroup C) = 3G;
> >
> >How can you enforce protection at C level without any protection at A
> >level? 
> 
> The basic idea of this scheme is that all processes in the same cgroup are 
> equally important. If some processes need extra protection, a new cgroup 
> needs to be created for unified settings. I don't think it is necessary to 
> implement protection in cgroup C, because task x and task y are equally 
> important. Only the four processes (task m, n, x and y) in cgroup A, have 
> important and secondary differences.
> 
> > This would easily allow arbitrary cgroup to hide from the oom
> > killer and spill over to other cgroups.
> 
> I don't think this will happen, because eoom.protect only works on parent 
> cgroup. If "oom.protect(parent cgroup) = 0", from perspective of 
> grandpa cgroup, task x and y will not be specially protected.

Just to confirm I am on the same page. This means that there won't be
any protection in case of the global oom in the above example. So
effectively the same semantic as the low/min protection.

> >> usage(task m) = 1G
> >> usage(task n) = 2G
> >> usage(task x) = 1G
> >> usage(task y) = 2G
> >> 
> >> oom killer order of cgroup A: n > m > y > x
> >> oom killer order of host:     y = n > x = m
> >> 
> >> If cgroup A is a directory maintained by users, users can use oom.protect 
> >> to protect relatively important tasks x and y.
> >> 
> >> However, when score_adj and oom.protect are used at the same time, we 
> >> will also consider the impact of both, as expressed in the following formula. 
> >> but I have to admit that it is an unstable result.
> >> score = task_usage + score_adj * totalpage - eoom.protect * task_usage / local_memcg_usage
> >
> >I hope I am not misreading but this has some rather unexpected
> >properties. First off, bigger memory consumers in a protected memcg are
> >protected more. 
> 
> Since cgroup needs to reasonably distribute the protection quota to all 
> processes in the cgroup, I think that processes consuming more memory 
> should get more quota. It is fair to processes consuming less memory 
> too, even if processes consuming more memory get more quota, its 
> oom_score is still higher than the processes consuming less memory. 
> When the oom killer appears in local cgroup, the order of oom killer 
> remains unchanged

Why cannot you simply discount the protection from all processes
equally? I do not follow why the task_usage has to play any role in
that.

> 
> >Also I would expect the protection discount would
> >be capped by the actual usage otherwise excessive protection
> >configuration could skew the results considerably.
> 
> In the calculation, we will select the minimum value of memcg_usage and 
> oom.protect
> 
> >> > I haven't really read through the whole patch but this struck me odd.
> >> 
> >> > > @@ -552,8 +552,19 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> >> > > 	unsigned long totalpages = totalram_pages() + total_swap_pages;
> >> > > 	unsigned long points = 0;
> >> > > 	long badness;
> >> > > +#ifdef CONFIG_MEMCG
> >> > > +	struct mem_cgroup *memcg;
> >> > > 
> >> > > -	badness = oom_badness(task, totalpages);
> >> > > +	rcu_read_lock();
> >> > > +	memcg = mem_cgroup_from_task(task);
> >> > > +	if (memcg && !css_tryget(&memcg->css))
> >> > > +		memcg = NULL;
> >> > > +	rcu_read_unlock();
> >> > > +
> >> > > +	update_parent_oom_protection(root_mem_cgroup, memcg);
> >> > > +	css_put(&memcg->css);
> >> > > +#endif
> >> > > +	badness = oom_badness(task, totalpages, MEMCG_OOM_PROTECT);
> >> >
> >> > the badness means different thing depending on which memcg hierarchy
> >> > subtree you look at. Scaling based on the global oom could get really
> >> > misleading.
> >> 
> >> I also took it into consideration. I planned to change "/proc/pid/oom_score" 
> >> to a writable node. When writing to different cgroup paths, different values 
> >> will be output. The default output is root cgroup. Do you think this idea is 
> >> feasible?
> >
> >I do not follow. Care to elaborate?
> 
> Take two example，
> cmd: cat /proc/pid/oom_score
> output: Scaling based on the global oom
> 
> cmd: echo "/cgroupA/cgroupB" > /proc/pid/oom_score
> output: Scaling based on the cgroupB oom
> (If the task is not in the cgroupB's hierarchy subtree, output: invalid parameter)

This is a terrible interface. First of all it assumes a state for the
file without any way to guarantee atomicity. How do you deal with two
different callers accessing the file?

-- 
Michal Hocko
SUSE Labs

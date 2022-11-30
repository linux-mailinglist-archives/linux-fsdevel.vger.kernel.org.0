Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8963DA96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiK3Q17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 11:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiK3Q16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:27:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B08ADF85;
        Wed, 30 Nov 2022 08:27:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 014482129A;
        Wed, 30 Nov 2022 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669825675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXfNG6Sww8fGURySTb8eVABizwa45hjeSXnodgsxL7A=;
        b=K5AhfMD1mmeSLfJHmy5N+Z9Fp6PpPk7Tg6j3Gg7JBI1HUIpk9Q1kujuQk6AXGNNyV145KQ
        d9PwmobJ2stCSZPjUM0avskb5R4vue2G5ijhEc6FYiczmjflCS0mD9rGkb6uCxCJrsuy3j
        g3oV+3D2ydZVm0DCiTt0qtKaJSdI6oU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D03D313A70;
        Wed, 30 Nov 2022 16:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pufuMYqEh2NEPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 30 Nov 2022 16:27:54 +0000
Date:   Wed, 30 Nov 2022 17:27:54 +0100
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
Message-ID: <Y4eEiqwMMkHv9ELM@dhcp22.suse.cz>
References: <CAAWJmAYPUK+1GBS0R460pDvDKrLr9zs_X2LT2yQTP_85kND5Ew@mail.gmail.com>
 <7EF16CB9-C34A-410B-BEBE-0303C1BB7BA0@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7EF16CB9-C34A-410B-BEBE-0303C1BB7BA0@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-11-22 15:46:19, 程垲涛 Chengkaitao Cheng wrote:
> On 2022-11-30 21:15:06, "Michal Hocko" <mhocko@suse.com> wrote:
> > On Wed 30-11-22 15:01:58, chengkaitao wrote:
> > > From: chengkaitao <pilgrimtao@gmail.com>
> > >
> > > We created a new interface <memory.oom.protect> for memory, If there is
> > > the OOM killer under parent memory cgroup, and the memory usage of a
> > > child cgroup is within its effective oom.protect boundary, the cgroup's
> > > tasks won't be OOM killed unless there is no unprotected tasks in other
> > > children cgroups. It draws on the logic of <memory.min/low> in the
> > > inheritance relationship.
> >
> > Could you be more specific about usecases?

This is a very important question to answer.

> > How do you tune oom.protect
> > wrt to other tunables? How does this interact with the oom_score_adj
> > tunining (e.g. a first hand oom victim with the score_adj 1000 sitting
> > in a oom protected memcg)?
> 
> We prefer users to use score_adj and oom.protect independently. Score_adj is 
> a parameter applicable to host, and oom.protect is a parameter applicable to cgroup. 
> When the physical machine's memory size is particularly large, the score_adj 
> granularity is also very large. However, oom.protect can achieve more fine-grained 
> adjustment.

Let me clarify a bit. I am not trying to defend oom_score_adj. It has
it's well known limitations and it is is essentially unusable for many
situations other than - hide or auto-select potential oom victim.

> When the score_adj of the processes are the same, I list the following cases 
> for explanation,
> 
>           root
>            |
>         cgroup A
>        /        \
>  cgroup B      cgroup C
> (task m,n)     (task x,y)
> 
> score_adj(all task) = 0;
> oom.protect(cgroup A) = 0;
> oom.protect(cgroup B) = 0;
> oom.protect(cgroup C) = 3G;

How can you enforce protection at C level without any protection at A
level? This would easily allow arbitrary cgroup to hide from the oom
killer and spill over to other cgroups.

> usage(task m) = 1G
> usage(task n) = 2G
> usage(task x) = 1G
> usage(task y) = 2G
> 
> oom killer order of cgroup A: n > m > y > x
> oom killer order of host:     y = n > x = m
> 
> If cgroup A is a directory maintained by users, users can use oom.protect 
> to protect relatively important tasks x and y.
> 
> However, when score_adj and oom.protect are used at the same time, we 
> will also consider the impact of both, as expressed in the following formula. 
> but I have to admit that it is an unstable result.
> score = task_usage + score_adj * totalpage - eoom.protect * task_usage / local_memcg_usage

I hope I am not misreading but this has some rather unexpected
properties. First off, bigger memory consumers in a protected memcg are
protected more. Also I would expect the protection discount would
be capped by the actual usage otherwise excessive protection
configuration could skew the results considerably.
 
> > I haven't really read through the whole patch but this struck me odd.
> 
> > > @@ -552,8 +552,19 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> > > 	unsigned long totalpages = totalram_pages() + total_swap_pages;
> > > 	unsigned long points = 0;
> > > 	long badness;
> > > +#ifdef CONFIG_MEMCG
> > > +	struct mem_cgroup *memcg;
> > > 
> > > -	badness = oom_badness(task, totalpages);
> > > +	rcu_read_lock();
> > > +	memcg = mem_cgroup_from_task(task);
> > > +	if (memcg && !css_tryget(&memcg->css))
> > > +		memcg = NULL;
> > > +	rcu_read_unlock();
> > > +
> > > +	update_parent_oom_protection(root_mem_cgroup, memcg);
> > > +	css_put(&memcg->css);
> > > +#endif
> > > +	badness = oom_badness(task, totalpages, MEMCG_OOM_PROTECT);
> >
> > the badness means different thing depending on which memcg hierarchy
> > subtree you look at. Scaling based on the global oom could get really
> > misleading.
> 
> I also took it into consideration. I planned to change "/proc/pid/oom_score" 
> to a writable node. When writing to different cgroup paths, different values 
> will be output. The default output is root cgroup. Do you think this idea is 
> feasible?

I do not follow. Care to elaborate?
-- 
Michal Hocko
SUSE Labs

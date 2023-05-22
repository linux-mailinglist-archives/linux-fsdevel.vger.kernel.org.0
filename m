Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDE70BF16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjEVNDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEVNDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:03:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBE795;
        Mon, 22 May 2023 06:03:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE5231FEFD;
        Mon, 22 May 2023 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684760630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrtDbupRjXTYRj2tZ8j8I/X6g23GzYeO+ha6ND6W5ms=;
        b=suVckYdzUWeSehtbUYtrY8aIrry6qsyz9sDDBEHs1h3Eua4XcbY3irusmUqS2No/hcQeaS
        ek/Vzt88mLX32eaY6tLLxK52XXBMgBFktKrdb06SvcVK6PRDeIeb2Y7AB96DlM1FXN66jC
        hJivbKMhHDfz7qqloyaIPFKnuABQ2C0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE0E813776;
        Mon, 22 May 2023 13:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ci3tLTZoa2RRbQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 May 2023 13:03:50 +0000
Date:   Mon, 22 May 2023 15:03:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "pilgrimtao@gmail.com" <pilgrimtao@gmail.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Message-ID: <ZGtoNu7zIRRy7qK0@dhcp22.suse.cz>
References: <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
 <900EF82B-9899-46DD-9ACC-16D82D9B7A3F@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900EF82B-9899-46DD-9ACC-16D82D9B7A3F@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Sorry for a late reply but I was mostly offline last 2 weeks]

On Tue 09-05-23 06:50:59, 程垲涛 Chengkaitao Cheng wrote:
> At 2023-05-08 22:18:18, "Michal Hocko" <mhocko@suse.com> wrote:
[...]
> >Your cover letter mentions that then "all processes in the cgroup as a
> >whole". That to me reads as oom.group oom killer policy. But a brief
> >look into the patch suggests you are still looking at specific tasks and
> >this has been a concern in the previous version of the patch because
> >memcg accounting and per-process accounting are detached.
> 
> I think the memcg accounting may be more reasonable, as its memory 
> statistics are more comprehensive, similar to active page cache, which 
> also increases the probability of OOM-kill. In the new patch, all the 
> shared memory will also consume the oom_protect quota of the memcg, 
> and the process's oom_protect quota of the memcg will decrease.

I am sorry but I do not follow. Could you elaborate please? Are you
arguing for per memcg or per process metrics?

[...]

> >> In the final discussion of patch v2, we discussed that although the adjustment range 
> >> of oom_score_adj is [-1000,1000], but essentially it only allows two usecases
> >> (OOM_SCORE_ADJ_MIN, OOM_SCORE_ADJ_MAX) reliably. Everything in between is 
> >> clumsy at best. In order to solve this problem in the new patch, I introduced a new 
> >> indicator oom_kill_inherit, which counts the number of times the local and child 
> >> cgroups have been selected by the OOM killer of the ancestor cgroup. By observing 
> >> the proportion of oom_kill_inherit in the parent cgroup, I can effectively adjust the 
> >> value of oom_protect to achieve the best.
> >
> >What does the best mean in this context?
> 
> I have created a new indicator oom_kill_inherit that maintains a negative correlation 
> with memory.oom.protect, so we have a ruler to measure the optimal value of 
> memory.oom.protect.

An example might help here.

> >> about the semantics of non-leaf memcgs protection,
> >> If a non-leaf memcg's oom_protect quota is set, its leaf memcg will proportionally 
> >> calculate the new effective oom_protect quota based on non-leaf memcg's quota.
> >
> >So the non-leaf memcg is never used as a target? What if the workload is
> >distributed over several sub-groups? Our current oom.group
> >implementation traverses the tree to find a common ancestor in the oom
> >domain with the oom.group.
> 
> If the oom_protect quota of the parent non-leaf memcg is less than the sum of 
> sub-groups oom_protect quota, the oom_protect quota of each sub-group will 
> be proportionally reduced
> If the oom_protect quota of the parent non-leaf memcg is greater than the sum 
> of sub-groups oom_protect quota, the oom_protect quota of each sub-group 
> will be proportionally increased
> The purpose of doing so is that users can set oom_protect quota according to 
> their own needs, and the system management process can set appropriate 
> oom_protect quota on the parent non-leaf memcg as the final cover, so that 
> the system management process can indirectly manage all user processes.

I guess that you are trying to say that the oom protection has a
standard hierarchical behavior. And that is fine, well, in fact it is
mandatory for any control knob to have a sane hierarchical properties.
But that doesn't address my above question. Let me try again. When is a
non-leaf memcg potentially selected as the oom victim? It doesn't have
any tasks directly but it might be a suitable target to kill a multi
memcg based workload (e.g. a full container).

> >All that being said and with the usecase described more specifically. I
> >can see that memcg based oom victim selection makes some sense. That
> >menas that it is always a memcg selected and all tasks withing killed.
> >Memcg based protection can be used to evaluate which memcg to choose and
> >the overall scheme should be still manageable. It would indeed resemble
> >memory protection for the regular reclaim.
> >
> >One thing that is still not really clear to me is to how group vs.
> >non-group ooms could be handled gracefully. Right now we can handle that
> >because the oom selection is still process based but with the protection
> >this will become more problematic as explained previously. Essentially
> >we would need to enforce the oom selection to be memcg based for all
> >memcgs. Maybe a mount knob? What do you think?
> 
> There is a function in the patch to determine whether the oom_protect 
> mechanism is enabled. All memory.oom.protect nodes default to 0, so the function 
> <is_root_oom_protect> returns 0 by default.

How can an admin determine what is the current oom detection logic?

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A363E584
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiK3XdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 18:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiK3Xcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:32:46 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A969790E;
        Wed, 30 Nov 2022 15:29:32 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:29:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669850971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLdcW8YLuJNMoWtBITi5oNMUbS4UvnO6BlVvWMG2nYE=;
        b=oJT/fRlbxbmZrYuoQmUv92rI06HoeclkYkBmi6RfeHrRbgReK+CHE10c6xJ8goJ+2VOyWN
        h9wjleatctaHsOOBKTxLa1OitIsI7BCUNk3DDcto0/tSYqLUVefiRap60qItuf/b1XmpE8
        dJVgc1TkD0UwkYXK7a1IHJWdtcREVCk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        cgel.zte@gmail.com, ran.xiaokai@zte.com.cn,
        viro@zeniv.linux.org.uk, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, Liam.Howlett@Oracle.com,
        chengzhihao1@huawei.com, haolee.swjtu@gmail.com, yuzhao@google.com,
        willy@infradead.org, vasily.averin@linux.dev, vbabka@suse.cz,
        surenb@google.com, sfr@canb.auug.org.au, mcgrof@kernel.org,
        sujiaxun@uniontech.com, feng.tang@intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Message-ID: <Y4fnRyIp17NXpti9@P9FQF9L96D.corp.robot.car>
References: <20221130070158.44221-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130070158.44221-1-chengkaitao@didiglobal.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:01:58PM +0800, chengkaitao wrote:
> From: chengkaitao <pilgrimtao@gmail.com>
> 
> We created a new interface <memory.oom.protect> for memory, If there is
> the OOM killer under parent memory cgroup, and the memory usage of a
> child cgroup is within its effective oom.protect boundary, the cgroup's
> tasks won't be OOM killed unless there is no unprotected tasks in other
> children cgroups. It draws on the logic of <memory.min/low> in the
> inheritance relationship.
> 
> It has the following advantages,
> 1. We have the ability to protect more important processes, when there
> is a memcg's OOM killer. The oom.protect only takes effect local memcg,
> and does not affect the OOM killer of the host.
> 2. Historically, we can often use oom_score_adj to control a group of
> processes, It requires that all processes in the cgroup must have a
> common parent processes, we have to set the common parent process's
> oom_score_adj, before it forks all children processes. So that it is
> very difficult to apply it in other situations. Now oom.protect has no
> such restrictions, we can protect a cgroup of processes more easily. The
> cgroup can keep some memory, even if the OOM killer has to be called.

It reminds me our attempts to provide a more sophisticated cgroup-aware oom
killer. The problem is that the decision which process(es) to kill or preserve
is individual to a specific workload (and can be even time-dependent
for a given workload). So it's really hard to come up with an in-kernel
mechanism which is at the same time flexible enough to work for the majority
of users and reliable enough to serve as the last oom resort measure (which
is the basic goal of the kernel oom killer).

Previously the consensus was to keep the in-kernel oom killer dumb and reliable
and implement complex policies in userspace (e.g. systemd-oomd etc).

Is there a reason why such approach can't work in your case?

Thanks!

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695672DC6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbjFMI1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjFMI1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:27:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09BC9;
        Tue, 13 Jun 2023 01:27:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 923F31FD80;
        Tue, 13 Jun 2023 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686644852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6nUGC14+7CBrEZi0pZlxIb9RwE6G35ofltIgPALxQpU=;
        b=AvTOTVSVYVd8ee7Kx3UT6ua7VKmK3BO63CfBLXP9P/NNd2GCnkFP7DCouBzWUgF+Re9T5D
        L9ERmrpkcMrCveWeQFYtfZyWwGKRIjc/oS2aEt3SIBgfA2D/M/FXI8OD41n4eZXivEZ0R4
        VwVmBbZupyQ5A0phG1gvCTbkXDbPVkE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80C5E13483;
        Tue, 13 Jun 2023 08:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PuVeH3QoiGRqMwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Jun 2023 08:27:32 +0000
Date:   Tue, 13 Jun 2023 10:27:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>, "tj@kernel.org" <tj@kernel.org>,
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
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Message-ID: <ZIgodGWoC/R07eak@dhcp22.suse.cz>
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz>
 <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
 <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 04-06-23 01:25:42, Yosry Ahmed wrote:
[...]
> There has been a parallel discussion in the cover letter thread of v4
> [1]. To summarize, at Google, we have been using OOM scores to
> describe different job priorities in a more explicit way -- regardless
> of memory usage. It is strictly priority-based OOM killing. Ties are
> broken based on memory usage.
> 
> We understand that something like memory.oom.protect has an advantage
> in the sense that you can skip killing a process if you know that it
> won't free enough memory anyway, but for an environment where multiple
> jobs of different priorities are running, we find it crucial to be
> able to define strict ordering. Some jobs are simply more important
> than others, regardless of their memory usage.

I do remember that discussion. I am not a great fan of simple priority
based interfaces TBH. It sounds as an easy interface but it hits
complications as soon as you try to define a proper/sensible
hierarchical semantic. I can see how they might work on leaf memcgs with
statically assigned priorities but that sounds like a very narrow
usecase IMHO.

I do not think we can effort a plethora of different OOM selection
algorithms implemented in the kernel. Therefore we should really
consider a control interface to be as much extensible and in line
with the existing interfaces as much as possible. That is why I am
really open to the oom protection concept which fits reasonably well
to the reclaim protection scheme. After all oom killer is just a very
aggressive method of the memory reclaim.

On the other hand I can see a need to customizable OOM victim selection
functionality. We've been through that discussion on several other
occasions and the best thing we could come up with was to allow to plug
BPF into the victim selection process and allow to bypass the system
default method. No code has ever materialized from those discussions
though. Maybe this is the time to revive that idea again?
 
> It would be great if we can arrive at an interface that serves this
> use case as well.
> 
> Thanks!
> 
> [1]https://lore.kernel.org/linux-mm/CAJD7tkaQdSTDX0Q7zvvYrA3Y4TcvLdWKnN3yc8VpfWRpUjcYBw@mail.gmail.com/
-- 
Michal Hocko
SUSE Labs

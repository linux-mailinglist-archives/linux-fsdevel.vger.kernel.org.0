Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148B972DC24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjFMIQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbjFMIQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:16:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD81E4E;
        Tue, 13 Jun 2023 01:16:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 834BA2236B;
        Tue, 13 Jun 2023 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686644213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Oj/gcuuB44r6saYYM7CYnUwY1Lak3+wZfGJTIYPEpw=;
        b=MwwIhts8/ksGQ47ht4E2VgYu7vHERjHXPmrPc+xTUrNjOP//oJ4Jns6B18yOlVVdlrQNBV
        +c8ihibL2UT+8LsO50aFG22VHGRM8Xp8m4+cOfuTsegVVd7Neti6y6dYed0/EmcWKQAXCp
        AlUXHHS8sxcJ4Aw5OHi9PVaH072+ac8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C30813483;
        Tue, 13 Jun 2023 08:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G6RbGvUliGS3LQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Jun 2023 08:16:53 +0000
Date:   Tue, 13 Jun 2023 10:16:53 +0200
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
Message-ID: <ZIgl9Zl5D+Y1RGM0@dhcp22.suse.cz>
References: <ZHSwhyGnPteiLKs/@dhcp22.suse.cz>
 <C5E5137F-8754-40CC-9F0C-0EB3D8AC1EC2@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C5E5137F-8754-40CC-9F0C-0EB3D8AC1EC2@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 04-06-23 08:05:53, 程垲涛 Chengkaitao Cheng wrote:
> At 2023-05-29 22:02:47, "Michal Hocko" <mhocko@suse.com> wrote:
> >On Thu 25-05-23 07:35:41, 程垲涛 Chengkaitao Cheng wrote:
> >> At 2023-05-22 21:03:50, "Michal Hocko" <mhocko@suse.com> wrote:
> >[...]
> >> >> I have created a new indicator oom_kill_inherit that maintains a negative correlation 
> >> >> with memory.oom.protect, so we have a ruler to measure the optimal value of 
> >> >> memory.oom.protect.
> >> >
> >> >An example might help here.
> >> 
> >> In my testing case, by adjusting memory.oom.protect, I was able to significantly 
> >> reduce the oom_kill_inherit of the corresponding cgroup. In a physical machine 
> >> with severely oversold memory, I divided all cgroups into three categories and 
> >> controlled their probability of being selected by the oom-killer to 0%,% 20, 
> >> and 80%, respectively.
> >
> >I might be just dense but I am lost. Can we focus on the barebone
> >semantic of the group oom selection and killing first. No magic
> >auto-tuning at this stage please.
> >
> >> >> >> about the semantics of non-leaf memcgs protection,
> >> >> >> If a non-leaf memcg's oom_protect quota is set, its leaf memcg will proportionally 
> >> >> >> calculate the new effective oom_protect quota based on non-leaf memcg's quota.
> >> >> >
> >> >> >So the non-leaf memcg is never used as a target? What if the workload is
> >> >> >distributed over several sub-groups? Our current oom.group
> >> >> >implementation traverses the tree to find a common ancestor in the oom
> >> >> >domain with the oom.group.
> >> >> 
> >> >> If the oom_protect quota of the parent non-leaf memcg is less than the sum of 
> >> >> sub-groups oom_protect quota, the oom_protect quota of each sub-group will 
> >> >> be proportionally reduced
> >> >> If the oom_protect quota of the parent non-leaf memcg is greater than the sum 
> >> >> of sub-groups oom_protect quota, the oom_protect quota of each sub-group 
> >> >> will be proportionally increased
> >> >> The purpose of doing so is that users can set oom_protect quota according to 
> >> >> their own needs, and the system management process can set appropriate 
> >> >> oom_protect quota on the parent non-leaf memcg as the final cover, so that 
> >> >> the system management process can indirectly manage all user processes.
> >> >
> >> >I guess that you are trying to say that the oom protection has a
> >> >standard hierarchical behavior. And that is fine, well, in fact it is
> >> >mandatory for any control knob to have a sane hierarchical properties.
> >> >But that doesn't address my above question. Let me try again. When is a
> >> >non-leaf memcg potentially selected as the oom victim? It doesn't have
> >> >any tasks directly but it might be a suitable target to kill a multi
> >> >memcg based workload (e.g. a full container).
> >> 
> >> If nonleaf memcg have the higher memory usage and the smaller 
> >> memory.oom.protect, it will have the higher the probability being 
> >> selected by the killer. If the non-leaf memcg is selected as the oom 
> >> victim, OOM-killer will continue to select the appropriate child 
> >> memcg downwards until the leaf memcg is selected.
> >
> >Parent memcg has more or equal memory charged than its child(ren) by
> >definition. Let me try to ask differently. Say you have the following
> >hierarchy
> >
> >		  root
> >		/     \
> >       container_A     container_B
> >     (oom.prot=100M)   (oom.prot=200M)
> >     (usage=120M)      (usage=180M)
> >     /     |     \
> >    A      B      C
> >                 / \
> >		C1  C2
> >
> >
> >container_B is protected so it should be excluded. Correct? So we are at
> >container_A to chose from. There are multiple ways the system and
> >continer admin might want to achieve.
> >1) system admin might want to shut down the whole container.
> >2) continer admin might want to shut the whole container down
> >3) cont. admin might want to shut down a whole sub group (e.g. C as it
> >   is a self contained workload and killing portion of it will put it into
> >   inconsistent state).
> >4) cont. admin might want to kill the most excess cgroup with tasks (i.e. a
> >   leaf memcg).
> >5) admin might want to kill a process in the most excess memcg.
> >
> >Now we already have oom.group thingy that can drive the group killing
> >policy but it is not really clear how you want to incorporate that to
> >the protection.
> >
> >Again, I think that an oom.protection makes sense but the semantic has
> >to be very carefully thought through because it is quite easy to create
> >corner cases and weird behavior. I also think that oom.group has to be
> >consistent with the protection.
> 
> The barebone semantic of the function implemented by my patch are 
> summarized as follows:
> Memcg only allows processes in the memcg to be selected by their 
> ancestor's OOM killer when the memory usage exceeds "oom.protect"

I am sure you would need to break this expectation if there is no such
memcg with tasks available or do you panic the system in that case in
the global case and retry for ever for the memcg oom?

> It should be noted that "oom.protect" and "oom.group" are completely 
> different things, and kneading them together may make the explanation 
> more confusing.

I am not suggesting to tight those two together by any means. I am
merely saying that those two have to be mutually cooperative and still
represent a reasonable semantic. Please have a look at above example
usecases and try to explain how the memory protection fits in here as
you have defined and implemented it.

-- 
Michal Hocko
SUSE Labs

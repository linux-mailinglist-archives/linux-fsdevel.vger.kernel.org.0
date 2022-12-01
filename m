Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B895163EBDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLAJCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 04:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLAJCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:02:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29BD41999;
        Thu,  1 Dec 2022 01:02:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAD041FD63;
        Thu,  1 Dec 2022 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669885325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLNRgcULxl39VgjFJbWNAjDoQ3yDDlm/yFmMG9HhK6M=;
        b=Ave28KB7tNiE9ZkiI7R4ytVUUUAZgkBbdNR7IQHcXtu89ZpGOoODAgfa8xscLtJtg0hMJJ
        6gquAn4cxI2y631J5knFx5hUq5LZS8Udhl8vNAHpi6IWv8yq74McDglEEoEtre9bBwt6TB
        9OFPwbsrQMhymA6Fhqf+pMPYOfRnQhE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3D9E13B4A;
        Thu,  1 Dec 2022 09:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YsXwJ41tiGOJIQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Dec 2022 09:02:05 +0000
Date:   Thu, 1 Dec 2022 10:02:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>
Cc:     "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        Tao pilgrim <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Message-ID: <Y4htjRAX1v7ZzC/z@dhcp22.suse.cz>
References: <E5A5BCC3-460E-4E81-8DD3-88B4A2868285@didiglobal.com>
 <5019F6D4-D341-4A5E-BAA1-1359A090114A@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5019F6D4-D341-4A5E-BAA1-1359A090114A@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-12-22 07:49:04, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-01 07:29:11, "Roman Gushchin" <roman.gushchin@linux.dev> wrote:
[...]
> >The problem is that the decision which process(es) to kill or preserve
> >is individual to a specific workload (and can be even time-dependent
> >for a given workload). 
> 
> It is correct to kill a process with high workload, but it may not be the 
> most appropriate. I think the specific process to kill needs to be decided 
> by the user. I think it is the original intention of score_adj design.

I guess what Roman tries to say here is that there is no obviously _correct_
oom victim candidate. Well, except for a very narrow situation when
there is a memory leak that consumes most of the memory over time. But
that is really hard to identify by the oom selection algorithm in
general.
 
> >So it's really hard to come up with an in-kernel
> >mechanism which is at the same time flexible enough to work for the majority
> >of users and reliable enough to serve as the last oom resort measure (which
> >is the basic goal of the kernel oom killer).
> >
> Our goal is to find a method that is less intrusive to the existing 
> mechanisms of the kernel, and find a more reasonable supplement 
> or alternative to the limitations of score_adj.
> 
> >Previously the consensus was to keep the in-kernel oom killer dumb and reliable
> >and implement complex policies in userspace (e.g. systemd-oomd etc).
> >
> >Is there a reason why such approach can't work in your case?
> 
> I think that as kernel developers, we should try our best to provide 
> users with simpler and more powerful interfaces. It is clear that the 
> current oom score mechanism has many limitations. Users need to 
> do a lot of timed loop detection in order to complete work similar 
> to the oom score mechanism, or develop a new mechanism just to 
> skip the imperfect oom score mechanism. This is an inefficient and 
> forced behavior

You are right that it makes sense to address typical usecases in the
kernel if that is possible. But oom victim selection is really hard
without a deeper understanding of the actual workload. The more clever
we try to be the more corner cases we can produce. Please note that this
has proven to be the case in the long oom development history. We used
to sacrifice child processes over a large process to preserve work or
prefer younger processes. Both those strategies led to problems.

Memcg protection based mechanism sounds like an interesting idea because
it mimics a reclaim protection scheme but I am a bit sceptical it will
be practically useful. Most for 2 reasons. a) memory reclaim protection
can be dynamically tuned because on reclaim/refault/psi metrics. oom
events are rare and mostly a failure situation. This limits any feedback
based approach IMHO. b) Hierarchical nature of the protection will make
it quite hard to configure properly with predictable outcome.

-- 
Michal Hocko
SUSE Labs

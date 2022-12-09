Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE2647F32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 09:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIIZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 03:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIIZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:25:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253056D46;
        Fri,  9 Dec 2022 00:25:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 282851FE57;
        Fri,  9 Dec 2022 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670574338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yg8Dy91nslxvuXyFZO8v15npgrF13z71XGIrk7x/zmg=;
        b=Gnl1efSl8C1V561RAp72h3ej4lDX6Hv8yQ8w86HPJq65Ge6RaZnEvRYmYPoSJ9jiiv1NGv
        Fx9fSt/Cl1opw8apuCmh5dW02+cRgRM0sOsgUb5228e0NfEAvX3nWN0tgPL+Ob+UcDzKtb
        TWx/69xXPo0xOpP4HauT3GvHY0m9jyM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 024D2138E0;
        Fri,  9 Dec 2022 08:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M/+IAALxkmOgQgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 09 Dec 2022 08:25:38 +0000
Date:   Fri, 9 Dec 2022 09:25:37 +0100
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
Message-ID: <Y5LxAbOB2AYp42hi@dhcp22.suse.cz>
References: <Y5HzfLB7lu4+BOu1@dhcp22.suse.cz>
 <114DF8F0-3E68-4F2B-8E35-0943EC2F51AE@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <114DF8F0-3E68-4F2B-8E35-0943EC2F51AE@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-12-22 05:07:15, 程垲涛 Chengkaitao Cheng wrote:
> At 2022-12-08 22:23:56, "Michal Hocko" <mhocko@suse.com> wrote:
[...]
> >oom killer is a memory reclaim of the last resort. So yes, there is some
> >difference but fundamentally it is about releasing some memory. And long
> >term we have learned that the more clever it tries to be the more likely
> >corner cases can happen. It is simply impossible to know the best
> >candidate so this is a just a best effort. We try to aim for
> >predictability at least.
> 
> Is the current oom_score strategy predictable? I don't think so. The score_adj 
> has broken the predictability of oom_score (it is no longer simply killing the 
> process that uses the most mems).

oom_score as reported to the userspace already considers oom_score_adj
which means that you can compare processes and get a reasonable guess
what would be the current oom_victim. There is a certain fuzz level
because this is not atomic and also there is no clear candidate when
multiple processes have equal score. So yes, it is not 100% predictable.
memory.reclaim as you propose doesn't change that though.

Is oom_score_adj a good interface? No, not really. If I could go back in
time I would nack it but here we are. We have an interface that
promises quite much but essentially it only allows two usecases
(OOM_SCORE_ADJ_MIN, OOM_SCORE_ADJ_MAX) reliably. Everything in between
is clumsy at best because a real user space oom policy would require to
re-evaluate the whole oom domain (be it global or memcg oom) as the
memory consumption evolves over time. I am really worried that your
memory.oom.protection directs a very similar trajectory because
protection really needs to consider other memcgs to balance properly.

[...]

> > But I am really open
> >to be convinced otherwise and this is in fact what I have been asking
> >for since the beginning. I would love to see some examples on the
> >reasonable configuration for a practical usecase.
> 
> Here is a simple example. In a docker container, users can divide all processes 
> into two categories (important and normal), and put them in different cgroups. 
> One cgroup's oom.protect is set to "max", the other is set to "0". In this way, 
> important processes in the container can be protected.

That is effectivelly oom_score_adj = OOM_SCORE_ADJ_MIN - 1 to all
processes in the important group. I would argue you can achieve a very
similar result by the process launcher to set the oom_score_adj and
inherit it to all processes in that important container. You do not need
any memcg tunable for that. I am really much more interested in examples
when the protection is to be fine tuned.
-- 
Michal Hocko
SUSE Labs

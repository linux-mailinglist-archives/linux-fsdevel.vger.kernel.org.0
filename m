Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B472E277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjFMMGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbjFMMGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:06:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665AE57;
        Tue, 13 Jun 2023 05:06:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A1D2224C5;
        Tue, 13 Jun 2023 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686658004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYVUFO1wPWNonY/X8OsDNVi5gRCOnIF00hLJCgVVXL8=;
        b=E2hmup+R2QkYLjr7YF45V8o6ojzs8mRStZDGZ4gtvemfRUU6ZMdUti8UWYB14K4N087zID
        PCmHqx+U0pWm1b+NAhJZWgxdcsmQ+DfDoUQ1SrXhDczXVUyCIOGHqIdZ4Mqv9LGNpjulD7
        sr0aoAT7cMde28oU3y65lkUec6malk0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7511513345;
        Tue, 13 Jun 2023 12:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ab+LHNRbiGSNKAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Jun 2023 12:06:44 +0000
Date:   Tue, 13 Jun 2023 14:06:44 +0200
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Message-ID: <ZIhb1EwvrdKXpEMb@dhcp22.suse.cz>
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz>
 <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
 <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
 <ZIgodGWoC/R07eak@dhcp22.suse.cz>
 <CAJD7tkawYZAWKYgttgtPjscnZTARj+QaGZLGiMiSadwC3oCELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkawYZAWKYgttgtPjscnZTARj+QaGZLGiMiSadwC3oCELQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-06-23 01:36:51, Yosry Ahmed wrote:
> +David Rientjes
> 
> On Tue, Jun 13, 2023 at 1:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sun 04-06-23 01:25:42, Yosry Ahmed wrote:
> > [...]
> > > There has been a parallel discussion in the cover letter thread of v4
> > > [1]. To summarize, at Google, we have been using OOM scores to
> > > describe different job priorities in a more explicit way -- regardless
> > > of memory usage. It is strictly priority-based OOM killing. Ties are
> > > broken based on memory usage.
> > >
> > > We understand that something like memory.oom.protect has an advantage
> > > in the sense that you can skip killing a process if you know that it
> > > won't free enough memory anyway, but for an environment where multiple
> > > jobs of different priorities are running, we find it crucial to be
> > > able to define strict ordering. Some jobs are simply more important
> > > than others, regardless of their memory usage.
> >
> > I do remember that discussion. I am not a great fan of simple priority
> > based interfaces TBH. It sounds as an easy interface but it hits
> > complications as soon as you try to define a proper/sensible
> > hierarchical semantic. I can see how they might work on leaf memcgs with
> > statically assigned priorities but that sounds like a very narrow
> > usecase IMHO.
> 
> Do you mind elaborating the problem with the hierarchical semantics?

Well, let me be more specific. If you have a simple hierarchical numeric
enforcement (assume higher priority more likely to be chosen and the
effective priority to be max(self, max(parents)) then the semantic
itslef is straightforward.

I am not really sure about the practical manageability though. I have
hard time to imagine priority assignment on something like a shared
workload with a more complex hierarchy. For example:
	    root
	/    |    \
cont_A    cont_B  cont_C

each container running its workload with own hierarchy structures that
might be rather dynamic during the lifetime. In order to have a
predictable OOM behavior you need to watch and reassign priorities all
the time, no?

> The way it works with our internal implementation is (imo) sensible
> and straightforward from a hierarchy POV. Starting at the OOM memcg
> (which can be root), we recursively compare the OOM scores of the
> children memcgs and pick the one with the lowest score, until we
> arrive at a leaf memcg.

This approach has a strong requirement on the memcg hierarchy
organization. Siblings have to be directly comparable because you cut
off many potential sub-trees this way (e.g. is it easy to tell
whether you want to rule out all system or user slices?).

I can imagine usecases where this could work reasonably well e.g. a set
of workers of a different priority all of them running under a shared
memcg parent. But more more involved hierarchies seem more complex
because you always keep in mind how the hierarchy is organize to get to
your desired victim.

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEF56F5EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjECTJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECTJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:09:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2910EF;
        Wed,  3 May 2023 12:09:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaec9ad820so42315785ad.0;
        Wed, 03 May 2023 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140980; x=1685732980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2prCTdjzaiRiaqQtudLpWKutHCUVL/OSWsxsk3W0H0=;
        b=DgGf/RDPAqWGHut8/ffMPgzzhFJ9XYYSPgLBeni/aHHvM33hoTyZ2z1/iWZrJfEq83
         XC8cOYLwo2w4awuIxnl0cMADE/m0XmY+wPpkMbjZhRe/h0OTU4R7JHORw6cp3ebvPJPs
         fVMtj4scXOewOp4pOg6Y+bLDbTCONtNkC6uKe3XQm4/tjkELGZ7bx+BlGycvwgcMZTg3
         diw26d57mAXbzMIEL2R9owFYzXiYqv54fGxd86cbz1pWBKa8UI2AhEJ1f1/yiknBF/PK
         kJgW8kCwMV9OQVIdn/sPBvqc9vOmLsLdyI/c/vfOx43vpU0ufO13PA0zEYN9tJjBA8qt
         Rc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140980; x=1685732980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2prCTdjzaiRiaqQtudLpWKutHCUVL/OSWsxsk3W0H0=;
        b=E2YA0TqhzZp35FEAt4xVK4Kqbdw3NaRI99dGYNohYt7qO+yejCQW0e2X0spRqCJvc0
         VH4At6rGptt5fDObl112xgbM7WNKTvq7uoRuA0FcsuPpMbSycHNYkCBkr83GaPVD/pBD
         TOXgbzse8c3vYll3B6rK7ui3ca/vBvCNUenag2b4LwVegXhp+t+YKd7zBaC/JGv3lOt6
         ofBCXKKnVSgpcYwkpnzPxPq1Ag/CnKvHCwg34T9gpeYvSaiBD/VxXt/irM1qiNbzaM9l
         WLs6zZ3CbZiQlXSyBUz201Het2p44aadgwWCRALMp2VzWcN5j8XocyZj9E8+QzcxVwC/
         mKQw==
X-Gm-Message-State: AC+VfDzF6PYo+zuINTsLZ2sTYPKszLmc07XLqGQ2kUEWXhPvlzSeG137
        qWDwW6qUmIjzzjE3bxNSeNk=
X-Google-Smtp-Source: ACHHUZ6YDYrRsQdW8TjDTlSuUDEQ8ByWIKmmy8KfjMdCubXv22qMvWwsp2IFNMqrmPGjqUc8LtNL9Q==
X-Received: by 2002:a17:902:8d8a:b0:1ab:5b0:6f16 with SMTP id v10-20020a1709028d8a00b001ab05b06f16mr1059467plo.43.1683140979705;
        Wed, 03 May 2023 12:09:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001a69d1bc32csm21999335plg.238.2023.05.03.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:09:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 09:09:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
References: <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKu6zWA00AzArMF@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 08:58:51AM -1000, Tejun Heo wrote:
> On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> > On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > > Yeah, easy / default visibility argument does make sense to me.
> > > 
> > > So, a bit of addition here. If this is the thrust, the debugfs part seems
> > > rather redundant, right? That's trivially obtainable with tracing / bpf and
> > > in a more flexible and performant manner. Also, are we happy with recording
> > > just single depth for persistent tracking?
> > 
> > Not sure what you're envisioning?
> > 
> > I'd consider the debugfs interface pretty integral; it's much more
> > discoverable for users, and it's hardly any code out of the whole
> > patchset.
> 
> You can do the same thing with a bpftrace one liner tho. That's rather
> difficult to beat.

Ah, shit, I'm an idiot. Sorry. I thought allocations was under /proc and
allocations.ctx under debugfs. I meant allocations.ctx is redundant.

Thanks.

-- 
tejun

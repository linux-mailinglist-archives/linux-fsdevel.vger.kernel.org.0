Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAD6F5EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjECS64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECS6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:58:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271572A5;
        Wed,  3 May 2023 11:58:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64115eef620so7164053b3a.1;
        Wed, 03 May 2023 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140334; x=1685732334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMlAqtjRc2HuzX77sJKufpwTYm/Gq3h8+fD7OUvgqfE=;
        b=AAvxk54YlMnkI7FdWDgkmXppZ5N5YVAtZzB/uFzgetK350E1VsosLNsIn+t9yAmlyz
         Mpf/EdDThAl6AdsQ4NqZZ4WQmsihQ4PIOjP2ktSZnRqbu/hpU+fSBV+6Seq32dABAuoB
         fgBMvXiDGIWraIMuHQyLJ8k8C2Rfu3BrjRS/alNIzOPn/3Xdw2WUHmjkDBEutrfMrPpb
         QTijZH34gDsEJTP9EXOMMbAzxdlErf6OrxB7h8VV2kzs6tN2Aq3j/W560a3R8Pg4/lCz
         FYHP8xcU1EYp/9E+JwiaUk9zf6GvPs+LS2bU4OlgAsosubDIcUNZjh57x1aZiOnb8NOJ
         sALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140334; x=1685732334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMlAqtjRc2HuzX77sJKufpwTYm/Gq3h8+fD7OUvgqfE=;
        b=Pv7EcBcdiwLQETD5ny8wnpO75RrF7iKml8dFvGHoMoc7fyYCmFFFJPLnwbmEzfYmnT
         IwPj2rGw9c/rzp7iFyn9mgVoTwXqrzUKfvk9mLh6H5LYDTPqCYr5A16B2DtCEC5qTojp
         N53/0YK2GEDDsNCTX6Va2zc8WDyJmg8oa+FreOV4u8nT5CZKeA9DAYKW0nARkiVkDVLP
         LlHSzsrgbPZorIgX3q8Xsxu0BCfA8JjvIYlKxqhQFH5IhW/vq8+U+COsvayTQRxEc+Pi
         Oi/C3q1aFfydvTdD6SaYBll5q4cA+bY0WtT++2aUIK00dd1l6jHzlgGfwmED2w7rCutJ
         Z4MQ==
X-Gm-Message-State: AC+VfDz6fPloNlz9upWGBxDLYfF3h6ymmZ4QMvw6aLEXYuw75Sf3JnIZ
        JrPFUnvQ94GkZp9PBXvx54E=
X-Google-Smtp-Source: ACHHUZ5EimlJXBnB410AOZJFF9uhR8Bd9zCcSVKDkw9w+jAPlVTHtCrOZFWDZSswiUq3A461o3c8YA==
X-Received: by 2002:a17:903:2345:b0:1a9:6a10:70e9 with SMTP id c5-20020a170903234500b001a96a1070e9mr878641plh.33.1683140333441;
        Wed, 03 May 2023 11:58:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902e9cb00b001aaf92130afsm5726253plk.116.2023.05.03.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:58:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 08:58:51 -1000
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
Message-ID: <ZFKu6zWA00AzArMF@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKubD/lq7oB4svV@moria.home.lan>
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

On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > Yeah, easy / default visibility argument does make sense to me.
> > 
> > So, a bit of addition here. If this is the thrust, the debugfs part seems
> > rather redundant, right? That's trivially obtainable with tracing / bpf and
> > in a more flexible and performant manner. Also, are we happy with recording
> > just single depth for persistent tracking?
> 
> Not sure what you're envisioning?
> 
> I'd consider the debugfs interface pretty integral; it's much more
> discoverable for users, and it's hardly any code out of the whole
> patchset.

You can do the same thing with a bpftrace one liner tho. That's rather
difficult to beat.

Thanks.

-- 
tejun

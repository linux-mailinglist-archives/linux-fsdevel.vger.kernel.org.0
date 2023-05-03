Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86F6F5B56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjECPhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjECPhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:37:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942466EA0;
        Wed,  3 May 2023 08:37:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so53546585e9.3;
        Wed, 03 May 2023 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683128258; x=1685720258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JJFuEPTE4BVU5/m4SDNq/0rwYCFngwHyNb8+sMGpbk=;
        b=f1ldkmb3XFaeE9giB5HgYpoxWExCQUXmfJ4wPY5lgSi5xTmbfBbONoep0z2W98W7Wt
         /V12EC2x93BkTv2q6xbvQ5zU+Qj35ndmiPtJoysgGPxWqIFgPDklGDxZY0MFJXHqzU2U
         V2xuyKyNq4q4r33oeksriXiB9EltdqXuI7t6CBkmVMxFAVk+5DZUTgEeuHOF8vdiYANJ
         CRBTNnFN6Q7laO5i1m5aBAuVRqvOb9ukpBUnG9MLtiPrq5D66aiqS1DbvznoNo4BfjZg
         U4AWHBJkmfkvfjVN3kAvMFidmy7t8a1i7JhTxDZ6WGETZCPlC/7CYZHOWGJC4EFs80nc
         3NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128258; x=1685720258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JJFuEPTE4BVU5/m4SDNq/0rwYCFngwHyNb8+sMGpbk=;
        b=aHiZQyTb88QoLWc8N2lrmQyP2M5liTTbTnsJ8lG9qUxdpCV/YPQg0ZHAsh9fSeL2sa
         WNdqFEHdbeTaFHm6XM1t7wORXowEDtaSLzFIgIXb8PRVWcpkzFH7aHEMZXnBLhMRYIca
         yLUI2Jp05BqVayunz2fQZQ24bSH6BmIMOD+OjtKxSvM1xyjhqF7t91xG4atIVs8PJxJB
         iMRbyL2XP8ewOyiNJdcIde75G3FgcM1cwHnmKdfBjWdYEwSQvwPN+/AIblSod/A9Dp7Y
         MGrnpOJndGYPCbdnarISOaWoABPDEZliCXDhdQ3PoOataWTRJj5wvkvd0KriePraNr3X
         0+ZQ==
X-Gm-Message-State: AC+VfDyxatHmTE+ulrps1RroLjECR4/A31Eqnmpq7+0WV6YMlB86bCpc
        TH9QZ/TM9G2xvvYZ+ZGrezQ=
X-Google-Smtp-Source: ACHHUZ45eo37jRhdELP3diMtYKEIHQFfdiD2toTSX9stBBpCuutuuzk1Z4vng0abDtctAvKSjY/BNQ==
X-Received: by 2002:a1c:7710:0:b0:3f3:2b37:dd34 with SMTP id t16-20020a1c7710000000b003f32b37dd34mr11146391wmi.9.1683128257631;
        Wed, 03 May 2023 08:37:37 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id l2-20020a1ced02000000b003f19b3d89e9sm2234347wmh.33.2023.05.03.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:37:36 -0700 (PDT)
Date:   Wed, 3 May 2023 16:37:36 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <f57b77b0-74da-41a3-a3bc-969ded4e0410@lucifer.local>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <20230503115051.30b8a97f@meshulam.tesarici.cz>
 <ZFIv+30UH7+ySCZr@moria.home.lan>
 <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
 <ZFJ9hlQ3ZIU1XYCY@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFJ9hlQ3ZIU1XYCY@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 11:28:06AM -0400, Kent Overstreet wrote:
> On Wed, May 03, 2023 at 08:33:48AM -0400, James Bottomley wrote:
> > On Wed, 2023-05-03 at 05:57 -0400, Kent Overstreet wrote:
> > > On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesařík wrote:
> > > > If anyone ever wants to use this code tagging framework for
> > > > something
> > > > else, they will also have to convert relevant functions to macros,
> > > > slowly changing the kernel to a minefield where local identifiers,
> > > > struct, union and enum tags, field names and labels must avoid name
> > > > conflict with a tagged function. For now, I have to remember that
> > > > alloc_pages is forbidden, but the list may grow.
> > >
> > > Also, since you're not actually a kernel contributor yet...
> >
> > You have an amazing talent for being wrong.  But even if you were
> > actually right about this, it would be an ad hominem personal attack on
> > a new contributor which crosses the line into unacceptable behaviour on
> > the list and runs counter to our code of conduct.
>
> ...Err, what? That was intended _in no way_ as a personal attack.
>

As an outside observer, I can assure you that absolutely came across as a
personal attack, and the precise kind that puts people off from
contributing. I should know as a hobbyist contributor myself.

> If I was mistaken I do apologize, but lately I've run across quite a lot
> of people offering review feedback to patches I post that turn out to
> have 0 or 10 patches in the kernel, and - to be blunt - a pattern of
> offering feedback in strong language with a presumption of experience
> that takes a lot to respond to adequately on a technical basis.
>

I, who may very well not merit being considered a contributor of
significant merit in your view, have had such 'drive-by' commentary on some
of my patches by precisely this type of person, and at no time felt the
need to question whether they were a true Scotsman or not. It's simply not
productive.

> I don't think a suggestion to spend a bit more time reading code instead
> of speculating is out of order! We could all, put more effort into how
> we offer review feedback.

It's the means by which you say it that counts for everything. If you feel
the technical comments might not be merited on a deeper level, perhaps ask
a broader question, or even don't respond at all? There are other means
available.

It's remarkable the impact comments like the one you made can have on
contributors, certainly those of us who are not maintainers and are
naturally plagued with imposter syndrome, so I would ask you on a human
level to try to be a little more considerate.

By all means address technical issues as robustly as you feel appropriate,
that is after all the purpose of code review, but just take a step back and
perhaps find the 'cuddlier' side of yourself when not addressing technical
things :)

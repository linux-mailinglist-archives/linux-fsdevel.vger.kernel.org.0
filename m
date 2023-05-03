Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB616F5D80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjECSGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECSGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:06:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83CE4F;
        Wed,  3 May 2023 11:06:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24de2954bc5so3464447a91.1;
        Wed, 03 May 2023 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683137173; x=1685729173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cv7r3p/uGjVZzfVGJD3+oUJmj97nEyjDPWByIKN3z4=;
        b=kBIOUh53OZR1fn3Tl9vhMiJMS2FInFLP+lUhlPMor7jTDMLunrtCSmTdzMWMH2FwCJ
         YVGqfGBLCcFxyEZqWGvgdtkqh7q9mW9TITc2zQ1MEl9Z4dyRAIRBQgQ/GqXqe64yJJJD
         jtv1N2E+Q8wb/Xz4JW2RS+0z2DdUghhXRvmD4NcDBMi7YahwOEPgg0vNKS60VKG0vC0s
         rVXB8P21/jbXTCpjmQQRTHqlVfjdnNcak2Qa/aW6mlFKobaN4n+shXYE6Y3F+F5hgEAG
         f9bKyMjVy+ACvR4cf5kNhW2+TZwy4NkBNj9YXF9ja+6/87G38J+6YdFn2/3Ki55ZW1Z2
         6s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137173; x=1685729173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cv7r3p/uGjVZzfVGJD3+oUJmj97nEyjDPWByIKN3z4=;
        b=IdecMYrgn5HnKH2bBZyz7SItyN3h3g5UQgqubjJZW49ajMWU76Ru4Tzb7SJ+o63R+B
         g15R2C9jw9dojo+Naqx68ySzis4D0XJUsJq0Kt2Zvbe6RYepCLtJjnSVUiYaAxGxBROu
         1QjcuMy4OuEUAfCzxejxihfbR91lOr7/EO48X6aVl86XXexNeuTQuvJktrwa8IswxRr4
         rmvJ5vhZXHFXLLAKCdkXQ3pzT3INFzVFyoVb2hmS96mws7WixrQ1z9gwPGMFI/02izE7
         nH9JuwtoIoF7aBALNiG5uAiuDrhgesGjA8NyjDyz79CFtSxNP1I1K4Wsmnt0UFKpVt5h
         WZKg==
X-Gm-Message-State: AC+VfDyTTD/c7MDpASy356D/Nu8PUk6U6LdnDdmGoL6YfxJ2Xh/0CnpL
        cTVVLVSXje7ao4yw7PISbzg=
X-Google-Smtp-Source: ACHHUZ6Ys0BQM8tQyYEoKSFpV2WCvnyoLhkkNSy/RU10JosALh+3fJA0w6WaI2GGSjVNqyUuFYx0fQ==
X-Received: by 2002:a17:90a:850a:b0:24e:1f8:b786 with SMTP id l10-20020a17090a850a00b0024e01f8b786mr11008096pjn.19.1683137172717;
        Wed, 03 May 2023 11:06:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b001a183ade911sm21931204plt.56.2023.05.03.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:06:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 08:06:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKikp0Poqen1kNv@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <CAJuCfpEFV7ZB4pvnf6n0bVpTCDWCVQup9PtrHuAayrf3GrQskg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEFV7ZB4pvnf6n0bVpTCDWCVQup9PtrHuAayrf3GrQskg@mail.gmail.com>
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

Hello, Suren.

On Wed, May 03, 2023 at 10:42:11AM -0700, Suren Baghdasaryan wrote:
> > * The framework doesn't really have any runtime overhead, so we can have it
> >   deployed in the entire fleet and debug wherever problem is.
> 
> Do you mean it has no runtime overhead when disabled?

Yes, that's what I meant.

> If so, do you know what's the overhead when enabled? I want to
> understand if that's truly a viable solution to track all allocations
> (including slab) all the time.

(cc'ing Alexei and Andrii who know a lot better than me)

I don't have enough concrete benchmark data on the hand to answer
definitively but hopefully what my general impresison would help. We attach
BPF programs to both per-packet and per-IO paths. They obviously aren't free
but their overhead isn't signficantly higher than building in the same thing
in C code. Once loaded, BPF progs are jit compiled into native code. The
generated code will be a bit worse than regularly compiled C code but those
are really micro differences. There's some bridging code to jump into BPF
but again negligible / acceptable even in the hottest paths.

In terms of execution overhead, I don't think there is a signficant
disadvantage to doing these things in BPF. Bigger differences would likely
be in tracking data structures and locking around them. One can definitely
better integrate tracking into alloc / free paths piggybacking on existing
locking and whatnot. That said, BPF hashtable is pretty fast and BPF is
constantly improving in terms of data structure support.

It really depends on the workload and how much overhead one considers
acceptable and I'm sure persistent global tracking can be done more
efficiently with built-in C code. That said, done right, the overhead
difference most likely isn't gonna be orders of magnitude but more like in
the realm of tens of percents, if that.

So, it doesn't nullify the benefits a dedicated mechansim can bring but does
change the conversation quite a bit. Is the extra code justifiable given
that most of what it enables is already possible using a more generic
mechanism, albeit at a bit higher cost? That may well be the case but it
does raise the bar.

Thanks.

-- 
tejun

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79786F57FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjECMe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjECMeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 08:34:21 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CD10FF;
        Wed,  3 May 2023 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683117236;
        bh=ouniWm3kSvheJ5FVfsQv5nBr8bj1HWMP2KRRhetgh0w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tBkpGMeHZlzQT7xcRfhegUu+wRFRMNYKk6KHQH9rVVXBpIbjN/8+o1xoQ19Hqpohg
         OkNzp5X7Gz8O9ULzqmlhb2B/3qykYYJsyqEUw/puHJIAqQho1Um/vUhig69kw9pE34
         3VJbCcqjcs3yhCW9eIwUZKzOzdLAc5JMGM1fjNZI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 605131286185;
        Wed,  3 May 2023 08:33:56 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id m7TfR2wZ3ZyK; Wed,  3 May 2023 08:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683117236;
        bh=ouniWm3kSvheJ5FVfsQv5nBr8bj1HWMP2KRRhetgh0w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tBkpGMeHZlzQT7xcRfhegUu+wRFRMNYKk6KHQH9rVVXBpIbjN/8+o1xoQ19Hqpohg
         OkNzp5X7Gz8O9ULzqmlhb2B/3qykYYJsyqEUw/puHJIAqQho1Um/vUhig69kw9pE34
         3VJbCcqjcs3yhCW9eIwUZKzOzdLAc5JMGM1fjNZI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 87F771285CEE;
        Wed,  3 May 2023 08:33:50 -0400 (EDT)
Message-ID: <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Date:   Wed, 03 May 2023 08:33:48 -0400
In-Reply-To: <ZFIv+30UH7+ySCZr@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
         <ZFIMaflxeHS3uR/A@dhcp22.suse.cz> <ZFIOfb6/jHwLqg6M@moria.home.lan>
         <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
         <20230503115051.30b8a97f@meshulam.tesarici.cz>
         <ZFIv+30UH7+ySCZr@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-03 at 05:57 -0400, Kent Overstreet wrote:
> On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesařík wrote:
> > If anyone ever wants to use this code tagging framework for
> > something
> > else, they will also have to convert relevant functions to macros,
> > slowly changing the kernel to a minefield where local identifiers,
> > struct, union and enum tags, field names and labels must avoid name
> > conflict with a tagged function. For now, I have to remember that
> > alloc_pages is forbidden, but the list may grow.
> 
> Also, since you're not actually a kernel contributor yet...

You have an amazing talent for being wrong.  But even if you were
actually right about this, it would be an ad hominem personal attack on
a new contributor which crosses the line into unacceptable behaviour on
the list and runs counter to our code of conduct.

James


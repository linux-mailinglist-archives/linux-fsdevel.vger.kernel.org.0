Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B96F555D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjECJwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjECJwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:52:00 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D22D69;
        Wed,  3 May 2023 02:51:01 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 4172014F40A;
        Wed,  3 May 2023 11:50:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683107454; bh=euE9Fy72eTCTzlw5Sukf/PgjmxlM5KjXHgyH+Ju07I4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4mIxsTFDU/Asg743zP6TL7vY9VIicV7szjQy+QZSVfUh0ZN2pXcOmbsJkTrRQhEW
         V0lzfUZw62KHSzg9YBP14S4dhZVmXUCdkggUSAZ2UuV+SUUVfZF/CGUsCwWitZBD4z
         ysWGUtF+VV0GsSv+Ei3n5Pi0OS1j9ABWxozdTkHK0/uzoTxalYL1ZDmYfFb+XuYNfT
         HegYaGGzQ6f2kiymcfSDHOApWq2LmLt2PQ9UxD1K5WRUxyph/jb6V/3Kz6TgPvsafx
         MwLoNdNiSCn9iZOacUHABR4CbRTCORxZjyKDpv5cPN9R4G8md9WmrmQ50ZjClYN1Bi
         bP0Em3VIM6Z/w==
Date:   Wed, 3 May 2023 11:50:51 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
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
Message-ID: <20230503115051.30b8a97f@meshulam.tesarici.cz>
In-Reply-To: <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
References: <20230501165450.15352-1-surenb@google.com>
        <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
        <ZFIOfb6/jHwLqg6M@moria.home.lan>
        <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 May 2023 09:51:49 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Wed 03-05-23 03:34:21, Kent Overstreet wrote:
>[...]
> > We've made this as clean and simple as posssible: a single new macro
> > invocation per allocation function, no calling convention changes (that
> > would indeed have been a lot of churn!)  
> 
> That doesn't really make the concern any less relevant. I believe you
> and Suren have made a great effort to reduce the churn as much as
> possible but looking at the diffstat the code changes are clearly there
> and you have to convince the rest of the community that this maintenance
> overhead is really worth it.

I believe this is the crucial point.

I have my own concerns about the use of preprocessor macros, which goes
against the basic idea of a code tagging framework (patch 13/40).
AFAICS the CODE_TAG_INIT macro must be expanded on the same source code
line as the tagged code, which makes it hard to use without further
macros (unless you want to make the source code unreadable beyond
imagination). That's why all allocation functions must be converted to
macros.

If anyone ever wants to use this code tagging framework for something
else, they will also have to convert relevant functions to macros,
slowly changing the kernel to a minefield where local identifiers,
struct, union and enum tags, field names and labels must avoid name
conflict with a tagged function. For now, I have to remember that
alloc_pages is forbidden, but the list may grow.

FWIW I can see some occurences of "alloc_pages" under arch/ which are
not renamed by patch 19/40 of this series. For instance, does the
kernel build for s390x after applying the patch series?

New code may also work initially, but explode after adding an #include
later...

HOWEVER, if the rest of the community agrees that the added value of
code tagging is worth all these potential risks, I can live with it.

Petr T

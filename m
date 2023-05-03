Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AA6F5B15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjECP0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjECP0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:26:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999441730;
        Wed,  3 May 2023 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683127605; x=1714663605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JW32feYIw7XcNCp0X+HS3CFsBn68Px3L2hSYcXUbWmk=;
  b=PT6Tf3+ASWtq19/6hMEa+jPQ0ZVD0jARTYMjwUKenjA7A/kU7l6vFLZE
   9t53840o7oJXHlK4Ut64rUdq/LFDOaR1NG4yvaXryaV7MfnoUb7CkUbKp
   NCn6LNbt6HG3fR+Nt9YzZiNe4rwxx0KffSFgAwzgc4wshHmr0EDuuMNvI
   XM8jPeWbslJBLoHwPxmiV8sqV0CumCWvZCKV43eBEmaOy4f9vaVYSLGx1
   XuPtZf8AXWtK2Nb1+EqLqSbVcQfHtdh6rrGRHPHIg2lbvZlrgf1tWAW/O
   Mf/23L+lao3oyVGzsIwRiUOtCJpkpio9tUIp99X6lo8fJKwFhyX7dWPRb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="347502744"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="347502744"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 08:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="766174780"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="766174780"
Received: from hrizk-mobl.amr.corp.intel.com (HELO [10.212.127.167]) ([10.212.127.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 08:26:41 -0700
Message-ID: <b8ab89e6-0456-969d-ed31-fa64be0a0fd0@intel.com>
Date:   Wed, 3 May 2023 08:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-35-surenb@google.com> <ZFIO3tXCbmTn53uv@dhcp22.suse.cz>
 <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/23 08:18, Suren Baghdasaryan wrote:
>>> +static inline void rem_ctx(struct codetag_ctx *ctx,
>>> +                        void (*free_ctx)(struct kref *refcount))
>>> +{
>>> +     struct codetag_with_ctx *ctc = ctx->ctc;
>>> +
>>> +     spin_lock(&ctc->ctx_lock);
>> This could deadlock when allocator is called from the IRQ context.
> I see. spin_lock_irqsave() then?

Yes.  But, even better, please turn on lockdep when you are testing.  It
will find these for you.  If you're on x86, we have a set of handy-dandy
debug options that you can add to an existing config with:

	make x86_debug.config

That said, I'm as concerned as everyone else that this is all "new" code
and doesn't lean on existing tracing or things like PAGE_OWNER enough.

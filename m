Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927557697FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGaNrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGaNrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:47:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D500170C;
        Mon, 31 Jul 2023 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phaaJIZq1BLWmPqCytuBa+h2XJylFF98eK0c+HuebO4=; b=Fr1NrfcLzdpJVpmcOBL17zaxcV
        zEYs26Dbdcqza8yQ2T/gXt6eJXboPEJDuFGznraLpotq5X7rjBlo3FpAmzHfseZRvk68l8JasNeG0
        +WtScm3eUB5qzFnSVptSpdbfn3qDJe20ysVK0l4UYj/pksK8xkHmndNPZ00AHymM1PT3Pm8xhyoDY
        P+N/gRHEh7Tq3zv150c3HLMnk43p8seEmT9AypoQn+WvEN1JpoUi0OMnBGLkKxGj2S7ARg8vVk7DS
        ncdBCZlrKI1aVZGJJBi4u8phMp2+tpPtCrQZpp5BoEk7L6K4hd2fVmDuvQ7SjuHtMjV1S1M4MQvp1
        CtbLs/0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQTEs-001wMI-Lv; Mon, 31 Jul 2023 13:47:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F9B93001DD;
        Mon, 31 Jul 2023 15:47:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB506203EA053; Mon, 31 Jul 2023 15:47:09 +0200 (CEST)
Date:   Mon, 31 Jul 2023 15:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        David Hildenbrand <david@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        acme@kernel.org
Subject: Re: [PATCH v3 0/4] mm: convert to vma_is_initial_heap/stack()
Message-ID: <20230731134709.GJ29590@hirez.programming.kicks-ass.net>
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:00:39PM +0800, Kefeng Wang wrote:

> Kefeng Wang (4):
>   mm: factor out VMA stack and heap checks
>   drm/amdkfd: use vma_is_initial_stack() and vma_is_initial_heap()
>   selinux: use vma_is_initial_stack() and vma_is_initial_heap()
>   perf/core: use vma_is_initial_stack() and vma_is_initial_heap()
> 
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c |  5 +----
>  fs/proc/task_mmu.c                   | 24 ++++----------------
>  fs/proc/task_nommu.c                 | 15 +------------
>  include/linux/mm.h                   | 25 +++++++++++++++++++++
>  kernel/events/core.c                 | 33 ++++++++++------------------
>  security/selinux/hooks.c             |  7 ++----
>  6 files changed, 44 insertions(+), 65 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

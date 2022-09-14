Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606ED5B87B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiINL72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiINL7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:59:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02E7E80F;
        Wed, 14 Sep 2022 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DjJiHdzjzNHKplI5fdbiO1rulUEOZ5g8wf7cW4w6xns=; b=pOI4quzd9E4/kPUUfI/dY2QiAI
        88g+aQsVAM17kyo4k9uDDV7uSZAxl61BlEGufwXhb8yTdsHkGskNWxfKu2vUK1f6+N9ZSdEZcLfn1
        kGL/j+JFG6lyJ+bWYNcnnrGelXcjMhN7ZvQxxdy2YhOUOWJUZpbRO+KECytZQbWZf+HAwBhYj/HWr
        nOTICOzrZJYEg/bofQ2vPbbSeD5LH1dSLMkAU1qDu6TLr8EaZNlYR3s7PuSCAc725vahDNN2Smmc5
        9A9GNZ0HzG8Gkb4LiIl9w7+pRlcONoFLyo+L7TCaLcBMOnSOeGqKp9ZsH7osCIuikZchV5LUXU1eH
        XLHDF+NQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYR2E-00CLes-AZ; Wed, 14 Sep 2022 11:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E90630013F;
        Wed, 14 Sep 2022 13:58:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E50CE202706E5; Wed, 14 Sep 2022 13:58:27 +0200 (CEST)
Date:   Wed, 14 Sep 2022 13:58:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joe Damato <jdamato@fastly.com>, x86@kernel.org,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] mm: Add per-task struct tlb counters
Message-ID: <YyHB48HSs/1S6S08@hirez.programming.kicks-ass.net>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:40:55AM -0700, Dave Hansen wrote:
>  Why didn't the tracepoints work for you?

This; perf should be able to get you per-task slices of those events.

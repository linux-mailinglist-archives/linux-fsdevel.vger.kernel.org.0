Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8DA5B96A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIOIun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIOIuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:50:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29A58DD8;
        Thu, 15 Sep 2022 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KSEO7grr1p/8DaZzm61xRKuesIZdIt0bL/jRmRVRgkc=; b=eWfNCTgy4m5xfBnkmORobqoHKt
        sFJ6c69laoIcGWhFYCSHxNjZUb+0eC7j6x+mmTaJFyE+MKvFrR7QsQEVXAW4KyPQgXe+XXEQimLhU
        Y5Zwbogw7k9JbmeB/1mojdNG2sHLQ2wcu3JvJFCBfxhHMrKekY8CN9BIUmBd6PEvj5+bm0/2ocnBV
        Qenn+6RcPTKt0pLFW/RfTGbYLhecpztpv7IbWLR12+Dq7OfZaMdC7+Bh1oVwO7I+WN+958sg0EBJA
        rP/r//3zdykpw7yKoMve0utqkXgMBahbgyWfLj6vf3eyhOivM6bweBMIAmKNn0kCz1eKGlCsYTXrf
        awa3nFTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYkZb-000wGY-Qo; Thu, 15 Sep 2022 08:50:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69FC530029C;
        Thu, 15 Sep 2022 10:50:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EB85201ABB97; Thu, 15 Sep 2022 10:50:12 +0200 (CEST)
Date:   Thu, 15 Sep 2022 10:50:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Damato <jdamato@fastly.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
Message-ID: <YyLnRC/Bd2kzhJ/t@hirez.programming.kicks-ass.net>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
 <20220914141507.GA4422@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914141507.GA4422@fastly.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:15:08AM -0700, Joe Damato wrote:

> I could patch count_vm_tlb... to account on a per-task basis. That seems
> reasonable to me... assuming you and others are convinced that it's a
> better approach than tracepoints ;)

Well, we *could* do a lot of things, but we can all spend out cycles
only once. Doing endless variations of statistics contributes to
death-by-a-thoudsand-cuts.

If you really think you need this, write yourself an eBPF program and
attach it to these tracepoints. Then you get less cycles for useful
work, but the rest of us isn't bothered by that.

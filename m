Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041AF41D5A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348348AbhI3Irw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 04:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348126AbhI3Irv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:47:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817E8C06176A;
        Thu, 30 Sep 2021 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8d/h8nbryP0oox/DlztyppXYQ0VJiTBHMbHxYT4g2MA=; b=BsQNPW9QuCs+taahSJyEvp3Rn5
        Xb1xz8lAshcXFfFgb1EIrAvRKPwLrP7U/84MCzl60R9Rbi9wWd0eAefJiXxbDGve0K4XPGkRTzoHY
        2v0iJ1ZAGnkLb7uhiqDsOfE5jl4YVXWGMmMKRXSPR1iluINri5uET20DdA+KydQq01euzTjmuJord
        IAkDUm/o6MN+82D5XPfqz6mWcdZb/iXx8tf5scl1SY68IcCFzzMZjZYWwk3XxG/zbmacZmVF1oBNG
        T/lwVlLQoF4oAJR10a03+B3+Vb8VFeYA6KGMJPaYC/rHO7huAdkuJ+sEqg5QjhG21S62pE62A1MCZ
        phMzpMXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVrby-00CeuG-9b; Thu, 30 Sep 2021 08:40:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15836300252;
        Thu, 30 Sep 2021 10:40:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0C6620831B8A; Thu, 30 Sep 2021 10:40:11 +0200 (CEST)
Date:   Thu, 30 Sep 2021 10:40:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/6] wchan: Fix ORC support and leaky fallback
Message-ID: <YVV36z4UZaL/vOBI@hirez.programming.kicks-ass.net>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210930010157.mtn7pjyxkxokzmyh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930010157.mtn7pjyxkxokzmyh@treble>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 06:01:57PM -0700, Josh Poimboeuf wrote:

> - Should we use a similar sched wrapper for /proc/$pid/stack to make its
>   raciness go away?

Alternatively, can we make /stack go away? AFAICT the semantics of that
are far worse in that it wants the actual kernel stack of a task,
blocked or not, which is a total pain in the arse (not to mention a
giant infoleak and side-channel).

> - At the risk of triggering a much larger patch set, I suspect
>   get_wchan() can be made generic ;-)  It's just a glorified wrapper
>   around stack_trace_save_tsk().

Done that for you :-)

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1341E158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbhI3SmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbhI3SmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:42:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15191C06176A;
        Thu, 30 Sep 2021 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYToXOXJROfvHoWCT8VypqLNTBATdvE7yFf0BHLho5s=; b=EE+Rz2KJGHLpH9C85xR3w3X2En
        D8ukahSu3KLQTmDh30AxWU7CdmyTaJkHbNQIuu98j2gyqaMnSeMM7E6nO/511ND7kXgNvlWfxnwfG
        O7oImekvEPjDQQKc1J7VkbjrNEAxCb4sPCrsqotQweHuN20uink2b2KgfwfxAvXdkyWi/9yxH003E
        1qjAVlUCqUz/YPVHZuI7Qo/YKwhpyyBUGAh4fo/qHSZSCliEnEiG3Q8uB4G0Ksfd2Arwpy8H9Rsww
        JMAEmOSy6K0+WEQ/r/ldJG6Q3RnsrvSdwUUkbGv55EGpM72pivyPV6hv0OLMQ5/K4AixJ895fpzzv
        QpPXCixg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW0y0-0070FJ-Gn; Thu, 30 Sep 2021 18:39:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7194981431; Thu, 30 Sep 2021 20:39:36 +0200 (CEST)
Date:   Thu, 30 Sep 2021 20:39:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20210930183936.GE4323@worktop.programming.kicks-ass.net>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210930010157.mtn7pjyxkxokzmyh@treble>
 <YVV36z4UZaL/vOBI@hirez.programming.kicks-ass.net>
 <202109300817.36A8D1D0A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109300817.36A8D1D0A@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 08:18:34AM -0700, Kees Cook wrote:
> Do you want me to re-collect the resulting series, or do you have a tree
> already for -tip for this?

I stuck it here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/wchan

I'm waiting on the robots to tell I wrecked the world... :-)

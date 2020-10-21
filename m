Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B942948E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440941AbgJUH1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440932AbgJUH1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:27:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94413C0613CE;
        Wed, 21 Oct 2020 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LfLKDr228zeIZDnUVRJzSctBjN1bRXJI0iFBMRj3SFM=; b=O1vbu6Y8L2ik3RVQZ6Iwl/WUE+
        gTS6+IGAhOkPC0mBg9IJjOUCB9mt0HZSHNtmweq0DCSUiCWu+8G+7RZ/sW+tYYuidPQebo30jWcO3
        7drIqDR7L9R2JjSxYWRN/g3TwM5GtgaNL7kNz++9/wdG3UOWH5reuEXNfUU6MaGaNEqlnGuz4sGkW
        TcsnIlm4zFv1wX4Gjsbm1hQ/ZNpsJGqxXrrSsDHwhIEn9mkgT39ObZwPG0TNDMsf20qA2Be26gcZI
        LeIKg5j0J6Rmq28p/e82QgNjbGG0att1k9ZfnW4ujKVdV1/FzewpLyXJoUzQYuCrIEf/83j4UlvaS
        n9b6lJyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV8Vm-0000uV-0X; Wed, 21 Oct 2020 07:26:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40E39304D28;
        Wed, 21 Oct 2020 09:26:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 247B6203CC499; Wed, 21 Oct 2020 09:26:12 +0200 (CEST)
Date:   Wed, 21 Oct 2020 09:26:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Redha Gouicem <redha.gouicem@gmail.com>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Ignatov <rdna@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched: delayed thread migration
Message-ID: <20201021072612.GV2628@hirez.programming.kicks-ass.net>
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020154445.119701-1-redha.gouicem@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:44:38PM +0200, Redha Gouicem wrote:
> 
> The first patch of the series is not specific to scheduling. It allows us
> (or anyone else) to use the cpufreq infrastructure at a different sampling
> rate without compromising the cpufreq subsystem and applications that
> depend on it.

It's also completely redudant as the scheduler already reads aperf/mperf
on every tick. Clearly you didn't do your homework ;-)

> The main idea behind this patch series is to bring to light the frequency
> inversion problem that will become more and more prominent with new CPUs
> that feature per-core DVFS. The solution proposed is a first idea for
> solving this problem that still needs to be tested across more CPUs and
> with more applications.

Which is why schedutil (the only cpufreq gov anybody should be using) is
integrated with the scheduler and closes the loop and tells the CPU
about the expected load.


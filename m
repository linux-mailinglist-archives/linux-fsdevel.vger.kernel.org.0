Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038D53AD104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhFRRRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 13:17:06 -0400
Received: from foss.arm.com ([217.140.110.172]:44460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhFRRRF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:17:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA8541424;
        Fri, 18 Jun 2021 10:14:55 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7143F70D;
        Fri, 18 Jun 2021 10:14:52 -0700 (PDT)
Date:   Fri, 18 Jun 2021 18:14:50 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     YT Chang <yt.chang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Turner <pjt@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] sched: Add tunable capacity margin for fis_capacity
Message-ID: <20210618171450.c5tgggydukcmap5v@e107158-lin.cambridge.arm.com>
References: <1623855954-6970-1-git-send-email-yt.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1623855954-6970-1-git-send-email-yt.chang@mediatek.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi YT Chang

Thanks for the patch.

On 06/16/21 23:05, YT Chang wrote:
> Currently, the margin of cpu frequency raising and cpu overutilized are
> hard-coded as 25% (1280/1024). Make the margin tunable

The way I see cpu overutilized is that we check if we're above the 80% range.

> to control the aggressive for placement and frequency control. Such as
> for power tuning framework could adjust smaller margin to slow down
> frequency raising speed and let task stay in smaller cpu.
> 
> For light loading scenarios, like beach buggy blitz and messaging apps,
> the app threads are moved big core with 25% margin and causing
> unnecessary power.
> With 0% capacity margin (1024/1024), the app threads could be kept in
> little core and deliver better power results without any fps drop.
> 
> capacity margin        0%          10%          20%          30%
>                      current        current       current      current
>                   Fps  (mA)    Fps    (mA)   Fps   (mA)    Fps  (mA)
> Beach buggy blitz  60 198.164  60   203.211  60   209.984  60  213.374
> Yahoo browser      60 232.301 59.97 237.52  59.95 248.213  60  262.809
> 
> Change-Id: Iba48c556ed1b73c9a2699e9e809bc7d9333dc004
> Signed-off-by: YT Chang <yt.chang@mediatek.com>
> ---

We are aware of the cpu overutilized value not being adequate on some modern
platforms. But I haven't considered or seen any issues with the frequency one.
So the latter is an interesting one.

I like your patch, but sadly I can't agree with it too.

The dilemma is that there are several options forward based on what we've seen
vendors do/want:

	1. Modify the margin to be small for high end SoC and larger for lower
	   end ones. Which is what your patch allows.
	2. Some vendors have a per cluster (perf domain) value. So within the
	   same SoC different margins are used for each capacity level.
	3. Some vendors have asymmetric margin. A margin to move up and a
	   different margin to go down.

We're still not sure which approach is the best way forward.

Your patch allows 1, but if it turned out options 2 or 3 are better; the ABI
will make it hard to change.

Have you considered all these options? Do you have any data to help support
1 is enough for the range of platforms you work with at least?

We were considering also whether we can have a smarter logic to automagically
set a better value for the platform, but no concrete suggestions yet.

So while I agree the current margin value of one size fits all is no longer
suitable. But the variation of hardware and the possible approaches we could
take need more careful thinking and consideration before committing to an ABI.

This patch is a good start for this discussion :)


Thanks

--
Qais Yousef

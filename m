Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69F14B53F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1Nlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 08:41:52 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:54221 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgA1Nlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:41:52 -0500
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 8133D1C30BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 13:41:50 +0000 (GMT)
Received: (qmail 3614 invoked from network); 28 Jan 2020 13:41:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2020 13:41:50 -0000
Date:   Tue, 28 Jan 2020 13:41:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128134148.GB3466@techsingularity.net>
References: <20200128100643.3016-1-hdanton@sina.com>
 <20200128130837.11136-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200128130837.11136-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:08:37PM +0800, Hillf Danton wrote:
> > Functionally it works, it's just slow. There is a cost to migration and
> > a cost to exiting from idle state and ramping up the CPU frequency.
> > 
> Yeah we need to pay some costs but are not they compensated by the ping
> and pong that waker and wakee are happy to play for ten minutes on
> different cpus sharing cache if you have no way to migrate waker?
> 

I could get into it depth but the changelog already mentions the cpufreq
implications and the consequences of round-robining around the machine
as a side-effect of how select_idle_sibling works. The data indicates
that we are not compensated by the migrations.

> Or back to the kworker case, a tradeoff needs to make between making kworker
> able to run on cache-sharing cpus and adding scheduling heuristics. IOW
> is cache affinity the key to the problem?
> 

The kworker is already running on CPUs sharing cache. That is not the
central issue.

-- 
Mel Gorman
SUSE Labs

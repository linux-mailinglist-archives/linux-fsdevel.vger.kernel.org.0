Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31D136E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 14:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgAJNm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 08:42:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgAJNm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GYGF/a4qRWroP/Y/H4KPJyAQgKptGfA1ZmohXqWNKSA=; b=iQ+UspVXX1HEG+w2HZ5QjJauD
        MOgh04LefdeXka9JjPakR5ZwXGMxxwoMqVtzLmS+0IlQ+rxmVjXgituwUKia9I4yyLztfQa7I5JOi
        lOljcymFY6l8mT9sBFx5yocFX5VQRisY2pU7VmXAYjgabjBCHphK4LJU0p4pmDybipvCArejlAPYz
        O8IR7/chn/iknXFupNZzt0qtbVmdUMxc11plVOLGeTb6KperE2MryVCihcyFxtZDwGIpxwqpY+iDQ
        60wfxwfalJkdp4R80n8/ZaKISh99WqpkW5Oq/D0JeUG/XkPzeTUU/e+9wP5uW6s7QnK1gLW7moqWG
        aL8Jd+aUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipuYg-0003gY-P0; Fri, 10 Jan 2020 13:42:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D71E30025A;
        Fri, 10 Jan 2020 14:41:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F027C2B612615; Fri, 10 Jan 2020 14:42:36 +0100 (CET)
Date:   Fri, 10 Jan 2020 14:42:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200110134236.GM2844@hirez.programming.kicks-ass.net>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
 <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:00:58PM +0000, Qais Yousef wrote:
> On 01/08/20 14:44, Peter Zijlstra wrote:

> > Did cpu_uclamp_write() forget to check for input<0 ?
> 
> Hmm just tried that and it seems so
> 
> # echo -1 > cpu.uclamp.min
> # cat cpu.uclamp.min
> 42949671.96
> 
> capacity_from_percent(); we check for
> 
> 7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
> 7302                         req.ret = -ERANGE;
> 7303                         return req;
> 7304                 }
> 
> But req.percent is s64, maybe it should be u64?

		if ((u64)req.percent > UCLAMP_PERCENT_SCALE)

should do, I think.

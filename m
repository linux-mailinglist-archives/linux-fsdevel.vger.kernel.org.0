Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3992441CCD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbhI2Trp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbhI2Trm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:47:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366B1C06161C;
        Wed, 29 Sep 2021 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XUQjPlxUzyJJLOjoxDLHnmXHdd8MXOO/ojHcClak0TY=; b=iKBOQNL+2JpkvGVN0VgW2BBHLU
        BEfPRu4lE5rZV2fufxs3AYjjUyXhUaJMEEUUojipC9C2ZNEPpdTh8MyEo8rzPy+pcYvLeEukNtxId
        fWTwyQhGTNiLkT+y+sS2gl0AjjObLiRwAm85TW9JzcBE9cVXvWSkq9MXhDEoFCI+XnTwdIXt5Sw5e
        3wi4LuUpf2FFwgwPldghyfurXx1137/L2Z41DCEdHsXySFkF3REWo/iJVLK6uMYO76jusiAXr5kOY
        d1BvePeYCPk82dOKPqeZto265102twzRjbL/iFZmiErYkOVMSy8g0l3OvddOEYoCqYzN3F+1MKUvr
        8wR/RjiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVfRL-00CAit-HA; Wed, 29 Sep 2021 19:40:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5137981431; Wed, 29 Sep 2021 21:40:26 +0200 (CEST)
Date:   Wed, 29 Sep 2021 21:40:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210929194026.GA4323@worktop.programming.kicks-ass.net>
References: <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
 <202109291152.681444A135@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109291152.681444A135@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:54:55AM -0700, Kees Cook wrote:

> > > > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > > > channel".

> Since I think we're considering get_wchan() to be slow-path, can we just
> lock the runqueue and use arch_stack_walk_reliable()?

Funny thing, when a task is blocked it isn't on the runqueue :-)

So if all we want to do is capture a blocked task and fail otherwise we
don't need the rq->lock at all.

Something like:

	unsigned long ip = 0;

	raw_spin_lock_irq(&p->pi_lock);
	state = READ_ONCE(p->__state);
	smp_rmb(); /* see try_to_wake_up() */
	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
		goto unlock;

	ip = /* do actual stack walk on a blocked task */
unlock:
	raw_spin_unlock_irq(&p->pi_lock);

	return ip;


Should get us there.


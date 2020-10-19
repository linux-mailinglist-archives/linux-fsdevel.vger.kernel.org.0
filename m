Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4F29304D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbgJSVMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 17:12:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbgJSVMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:12:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603141964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDvrn3khPRCsQ3kInC9PrrCmCeDblVbtH3pwV9O3vYI=;
        b=n9YVFtdwNtjSN+/ua96l0MsskldSlV9SMYPXxeyfZVkSroaPpJvfdUVPxpnadtpw8deZUb
        1WHNTN+KDfNjTi5UZ+5JOsQnj3hKLVpZBmM3AvPzZbyN5ABYaSPpbmydgqCm1PW2xBsZgF
        Q+nm3lSRfwtU5hQYk2LEyrERhPTG5W7qQM+OHhPMeEsTb8WmZ33Sr7pfpqqDyEnw+2bwPZ
        mhZeW6+h9IbsAcKPvE8+85NjwtEUamW1g9p+fRj5XzKvrT8+oyOpngKl2sl4fiIQ1cKXKF
        HyeHOPQrhTNVU1BJ7gA8h0b9FzwHiJulPZYt8a+b4KPuO/6HVkXyaHmcT6NS/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603141964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDvrn3khPRCsQ3kInC9PrrCmCeDblVbtH3pwV9O3vYI=;
        b=9pvYjSU9yrEDoXWUmWAb3RLmG8qQCf74kogPetVI1dOtIQWI6qjPgTtxmM6U2rfV5AqgLV
        KTo8wQwFYiESmpBw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com> <20201009194258.3207172-7-ira.weiny@intel.com> <20201016114510.GO2611@hirez.programming.kicks-ass.net> <87lfg6tjnq.fsf@nanos.tec.linutronix.de> <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com> <87k0vma7ct.fsf@nanos.tec.linutronix.de> <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
Date:   Mon, 19 Oct 2020 23:12:44 +0200
Message-ID: <871rhtapir.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19 2020 at 13:26, Ira Weiny wrote:
> On Mon, Oct 19, 2020 at 11:32:50AM +0200, Thomas Gleixner wrote:
> Sorry, let me clarify.  After this patch we have.
>
> typedef union irqentry_state {
> 	bool	exit_rcu;
> 	bool	lockdep;
> } irqentry_state_t;
>
> Which reflects the mutual exclusion of the 2 variables.

Huch? From the patch I gave you:

 #ifndef irqentry_state
 typedef struct irqentry_state {
 	bool    exit_rcu;
+       bool    lockdep;
 } irqentry_state_t;
 #endif

How is that a union?

> But then when the pkrs stuff is added the union changes back to a structure and
> looks like this.

So you want:

  1) Move stuff to struct irqentry_state (my patch)

  2) Change it to a union and pass it as pointer at the same time

  3) Change it back to struct to add PKRS

> Is that clear?

What's clear is that the above is nonsense. We can just do

 #ifndef irqentry_state
 typedef struct irqentry_state {
 	union {
         	bool    exit_rcu;
                bool    lockdep;
        };        
 } irqentry_state_t;
 #endif

right in the patch which I gave you. Because that actually makes sense.

Thanks,

        tglx

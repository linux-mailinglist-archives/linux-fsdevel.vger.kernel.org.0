Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BE2924A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgJSJcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 05:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJSJcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:32:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C52C0613CE;
        Mon, 19 Oct 2020 02:32:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603099971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fyNCJtixmMQLpdN/DZHToMwce+xzNTC2SZe9HVysp4=;
        b=Us4WBN074EyLmI/JAtZBFMM/L+H+96RGsyD0V7+tfhvUas/oAmUlLH+yR30O2esPxSv9mr
        jMuqsa8LFt5XnodL9ZmM56R9euqMVoibL41CNwTA8c6mx3GPKXbVQfFWTxqJ+b4UnuXY8E
        3utbQZBo3wsSF5dUhNB521STjUF+aQk4nCm2rc5zMx9ws1/VsSWCH8K3W8Z+Ki9mI3VTM1
        zgz2hY/F8S5aKztuXoA1alyNzBPmneHbpfLGVXOv5e+uYT7HstuVl3ve68rHneBaoLLIlo
        /uQTRkrtHYbo4SfLwJBoGcv2JSbkkxgqfPkEWJxvHC9c0q4FfHzQ8PoSQyC7tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603099971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fyNCJtixmMQLpdN/DZHToMwce+xzNTC2SZe9HVysp4=;
        b=n5qkv4DinDVT1DFRGYUsWn49/iHAKpipcTZl3lLbCBeUXx8M0W6uKRs9bA2WqnEiErHMR4
        hejKs03ygBJ/CRAQ==
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
In-Reply-To: <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com> <20201009194258.3207172-7-ira.weiny@intel.com> <20201016114510.GO2611@hirez.programming.kicks-ass.net> <87lfg6tjnq.fsf@nanos.tec.linutronix.de> <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
Date:   Mon, 19 Oct 2020 11:32:50 +0200
Message-ID: <87k0vma7ct.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 18 2020 at 22:37, Ira Weiny wrote:
> On Fri, Oct 16, 2020 at 02:55:21PM +0200, Thomas Gleixner wrote:
>> Subject: x86/entry: Move nmi entry/exit into common code
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Fri, 11 Sep 2020 10:09:56 +0200
>> 
>> Add blurb here.
>
> How about:
>
> To prepare for saving PKRS values across NMI's we lift the
> idtentry_[enter|exit]_nmi() to the common code.  Rename them to
> irqentry_nmi_[enter|exit]() to reflect the new generic nature and store the
> state in the same irqentry_state_t structure as the other irqentry_*()
> functions.  Finally, differentiate the state being stored between the NMI and
> IRQ path by adding 'lockdep' to irqentry_state_t.

No. This has absolutely nothing to do with PKRS. It's a cleanup valuable
by itself and that's how it should have been done right away.

So the proper changelog is:

  Lockdep state handling on NMI enter and exit is nothing specific to
  X86. It's not any different on other architectures. Also the extra
  state type is not necessary, irqentry_state_t can carry the necessary
  information as well.

  Move it to common code and extend irqentry_state_t to carry lockdep
  state.

>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -343,6 +343,7 @@ void irqentry_exit_to_user_mode(struct p
>>  #ifndef irqentry_state
>>  typedef struct irqentry_state {
>>  	bool	exit_rcu;
>> +	bool	lockdep;
>>  } irqentry_state_t;
>
> Building on what Peter said do you agree this should be made into a union?
>
> It may not be strictly necessary in this patch but I think it would reflect the
> mutual exclusivity better and could be changed easy enough in the follow on
> patch which adds the pkrs state.

Why the heck should it be changed in a patch which adds something
completely different?

Either it's mutually exclusive or not and if so it want's to be done in
this patch and not in a change which extends the struct for other
reasons.

Thanks,

        tglx



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6522D078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXVZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXVZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:25:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B58C0619D3;
        Fri, 24 Jul 2020 14:25:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595625899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvMyNHsN0q61AeYEdZRSIrvuxMsl65bOxTzAFe7Crcg=;
        b=mcpxjpBay3zaosMLUpZIESiZjX70tWRDRrx62Lm4RZUZc66n2tEF+jIigzon1ulXqPAERq
        ZJBeRZcLuvLk3InOnvs226uLjvp9EwdGzfEf4sHXWe38EjioooEeyVEX2Kksr7QK6jVkr+
        gApsCDCed1fI1bDW7RK9ps9yfftC50U2AXId0QshkdkkGOfTL5UPVuBaBWUBWhbMGefq0a
        MAKXzZK9hoR8BnVhzGZPhLTTEPNpSkPkqD7AcTV1UJTp0GZt3J4BCnJi/biHikXZ5HE40c
        xE35FKIFCpdNFLF7Crv+6ifPiyZlxBEA9V8tCb6fCPFnzN/br8LG0AYI/g9MTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595625899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvMyNHsN0q61AeYEdZRSIrvuxMsl65bOxTzAFe7Crcg=;
        b=BRWV0W9529yicWf3VvB2bX366+Nsr1sxb73tdd6g/5PhodE1uYx58ywUoVNKdnXJW4fZmr
        4hAZGvRtWU1J8ICw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <87mu3pvly7.fsf@nanos.tec.linutronix.de>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com> <87mu3pvly7.fsf@nanos.tec.linutronix.de>
Date:   Fri, 24 Jul 2020 23:24:58 +0200
Message-ID: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira,

Thomas Gleixner <tglx@linutronix.de> writes:
> Ira Weiny <ira.weiny@intel.com> writes:
>> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
>> I think, after fixing my code (see below), using idtentry_state could still
>> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
>> should carry the state to the new cpu, correct?
>
> I'm way too tired to think about that now. Will have a look tomorrow
> with brain awake.

Not that I'm way more awake now, but at least I have the feeling that my
brain is not completely useless.

Let me summarize what I understood:

  1) A per CPU cache which shadows the current state of the MSR, i.e. the
     current valid key. You use that to avoid costly MSR writes if the
     key does not change.

  2) On idtentry you store the key on entry in idtentry_state, clear it
     in the MSR and shadow state if necessary and restore it on exit.

  3) On context switch out you save the per CPU cache value in the task
     and on context switch in you restore it from there.

Yes, that works (see below for #2) and sorry for my confusion yesterday
about storing this in task state.

#2 requires to handle the exceptions which do not go through
idtentry_enter/exit() seperately, but that's a manageable amount. It's
the ones which use IDTENTRY_RAW or a variant of it.

#BP, #MC, #NMI, #DB, #DF need extra local storage as all the kernel
entries for those use nmi_enter()/exit(). So you just can create
wrappers around those. Somehting like this

static __always_inline idtentry_state_t idtentry_nmi_enter(void)
{
     	idtentry_state_t state = {};

        nmi_enter();
        instrumentation_begin();
        state.key = save_and_clear_key();
        instrumentation_end();
}

static __always_inline void idtentry_nmi_exit(idtentry_state_t state)
{
        instrumentation_begin();
        restore_key(state.key);
        instrumentation_end();
        nmi_exit();
}

#UD and #PF are using the raw entry variant as well but still invoke
idtentry_enter()/exit(). #PF does not need any work. #UD handles
WARN/BUG without going through idtentry_enter() first, but I don't think
that's an issue unless a not 0 key would prevent writing to the console
device. You surely can figure that out.

Hope that helps.

Thanks,

        tglx

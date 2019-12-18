Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81BA12519A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfLRTPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:15:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLRTPG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:15:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5471AC3E;
        Wed, 18 Dec 2019 19:15:04 +0000 (UTC)
Date:   Wed, 18 Dec 2019 11:08:33 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
Message-ID: <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
References: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
 <20191218135047.GS2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191218135047.GS2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Dec 2019, Peter Zijlstra wrote:

>On Tue, Dec 17, 2019 at 03:32:00PM +0000, David Howells wrote:
>> Standard kernel mutexes cannot be used in any way from interrupt or softirq
>> context, so the user_mutex which manages access to a call cannot be a mutex
>> since on a new call the mutex must start off locked and be unlocked within
>> the softirq handler to prevent userspace interfering with a call we're
>> setting up.
>>
>> Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
>> upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
>> in dmesg for each a new call that comes in from the server.
>
>FYI that patch has currently been reverted.
>
>commit c571b72e2b845ca0519670cb7c4b5fe5f56498a5 (tip/locking/urgent, tip/locking-urgent-for-linus)

Will we ever want to re-add this warning (along with writer rwsems) at some point?

It seems that having it actually prompts things getting fixed, as opposed to
just sitting there forever borken (at least in -rt).

Thanks,
Davidlohr

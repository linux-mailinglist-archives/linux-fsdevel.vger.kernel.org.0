Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E329711F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374349AbgJWOO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 10:14:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374293AbgJWOO1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:14:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D31D2B2A6;
        Fri, 23 Oct 2020 14:14:25 +0000 (UTC)
Subject: Re: [PATCH 04/65] mm: Extract might_alloc() debug check
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d4d7ecb9-1147-2965-a551-7647e755387d@suse.cz>
Date:   Fri, 23 Oct 2020 16:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/20 2:21 PM, Daniel Vetter wrote:
> Extracted from slab.h, which seems to have the most complete version
> including the correct might_sleep() check. Roll it out to slob.c.
> 
> Motivated by a discussion with Paul about possibly changing call_rcu
> behaviour to allocate memory, but only roughly every 500th call.
> 
> There are a lot fewer places in the kernel that care about whether
> allocating memory is allowed or not (due to deadlocks with reclaim
> code) than places that care whether sleeping is allowed. But debugging
> these also tends to be a lot harder, so nice descriptive checks could
> come in handy. I might have some use eventually for annotations in
> drivers/gpu.
> 
> Note that unlike fs_reclaim_acquire/release gfpflags_allow_blocking
> does not consult the PF_MEMALLOC flags. But there is no flag
> equivalent for GFP_NOWAIT, hence this check can't go wrong due to
> memalloc_no*_save/restore contexts.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Looks useful.
Acked-by: Vlastimil Babka <vbabka@suse.cz>

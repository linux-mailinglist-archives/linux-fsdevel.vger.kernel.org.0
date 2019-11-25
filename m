Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851401092C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 18:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfKYRZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 12:25:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfKYRZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:25:21 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZI6q-0003I3-RK; Mon, 25 Nov 2019 18:25:12 +0100
Date:   Mon, 25 Nov 2019 18:25:12 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH RT 1/2 v2] dm-snapshot: fix crash with the realtime kernel
Message-ID: <20191125172512.q65pmda66un3cm2e@linutronix.de>
References: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-12 11:09:51 [-0500], Mikulas Patocka wrote:
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-snap.c	2019-11-12 16:44:36.000000000 +0100
> +++ linux-2.6/drivers/md/dm-snap.c	2019-11-12 17:01:46.000000000 +0100
…
>  static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
>  {
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	hlist_bl_lock(lock->complete_slot);
>  	hlist_bl_lock(lock->pending_slot);
> +#else
> +	spin_lock(lock->lock);

if you also set the lowest bit for complete_slot + pending_slot then
patch 2 of this mini series wouldn't be required. That means we could
keep the debug code on -RT. Or am I missing something?

> +#endif
>  }

Sebastian

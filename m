Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574C77D124
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 00:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfGaW1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 18:27:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaW1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:27:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsx3t-00009A-6X; Thu, 01 Aug 2019 00:27:09 +0200
Date:   Thu, 1 Aug 2019 00:27:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kara <jack@suse.cz>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Theodore Tso <tytso@mit.edu>, Julia Cartwright <julia@ni.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 2/4] fs/buffer: Move BH_Uptodate_Lock locking into wrapper
 functions
In-Reply-To: <20190731144639.GG15806@quack2.suse.cz>
Message-ID: <alpine.DEB.2.21.1908010022180.1788@nanos.tec.linutronix.de>
References: <20190730112452.871257694@linutronix.de> <20190730120321.285095769@linutronix.de> <20190731144639.GG15806@quack2.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Jul 2019, Jan Kara wrote:
> On Tue 30-07-19 13:24:54, Thomas Gleixner wrote:
> > Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> > disable preemption, which is undesired for latency reasons and breaks when
> > regular spinlocks are taken within the bit_spinlock locked region because
> > regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> > replaces the bit spinlocks with regular spinlocks to avoid this problem.
> > 
> > To avoid ifdeffery at the source level, wrap all BH_Uptodate_Lock bitlock
> > operations with inline functions, so the spinlock substitution can be done
> > at one place.
> > 
> > Using regular spinlocks can also be enabled for lock debugging purposes so
> > the lock operations become visible to lockdep.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-fsdevel@vger.kernel.org
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> BTW, it should be possible to get rid of BH_Uptodate_Lock altogether using
> bio chaining (which was non-existent when this bh code was written) to make
> sure IO completion function gets called only once all bios used to fill in
> / write out the page are done. It would be also more efficient. But I guess
> that's an interesting cleanup project for some other time...

While 'possible cleanup' is something which triggers a certain nerve, that
particular project certainly goes beyond my basic understanding of that
whole fs/block conglomerate. I rather leave that to people who actually
have a clue. :)

Thanks,

	tglx



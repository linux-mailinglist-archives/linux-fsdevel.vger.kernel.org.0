Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12CF9683D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfHTSBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 14:01:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTSBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:01:22 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i08RX-0004FB-JJ; Tue, 20 Aug 2019 20:01:15 +0200
Date:   Tue, 20 Aug 2019 20:01:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular
 spinlock_t
In-Reply-To: <20190820171721.GA4949@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de> <20190820171721.GA4949@bombadil.infradead.org>
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

On Tue, 20 Aug 2019, Matthew Wilcox wrote:
> On Tue, Aug 20, 2019 at 07:08:18PM +0200, Sebastian Siewior wrote:
> > Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> > disable preemption, which is undesired for latency reasons and breaks when
> > regular spinlocks are taken within the bit_spinlock locked region because
> > regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> > replaces the bit spinlocks with regular spinlocks to avoid this problem.
> > Bit spinlocks are also not covered by lock debugging, e.g. lockdep.
> > 
> > Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > [bigeasy: remove the wrapper and use always spinlock_t]
> 
> Uhh ... always grow the buffer_head, even for non-PREEMPT_RT?  Why?

Christoph requested that:

  https://lkml.kernel.org/r/20190802075612.GA20962@infradead.org

Thanks,

	tglx

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF27EFE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfHBJJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 05:09:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHBJJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:09:01 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htTXb-0008Bx-4U; Fri, 02 Aug 2019 11:07:59 +0200
Date:   Fri, 2 Aug 2019 11:07:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
In-Reply-To: <20190802075612.GA20962@infradead.org>
Message-ID: <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
References: <20190801010126.245731659@linutronix.de> <20190802075612.GA20962@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-738874475-1564736879=:2285"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-738874475-1564736879=:2285
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Christoph,

On Fri, 2 Aug 2019, Christoph Hellwig wrote:

> did you look into killing bіt spinlocks as a public API instead?

Last time I did, there was resistance :)

But I'm happy to try again.

> The main users seems to be buffer heads, which are so bloated that
> an extra spinlock doesn't really matter anyway.
>
> The list_bl and rhashtable uses kinda make sense to be, but they are
> pretty nicely abstracted away anyway.  The remaining users look
> pretty questionable to start with.

What about the page lock?

  mm/slub.c:      bit_spin_lock(PG_locked, &page->flags);

Thanks,

	tglx
--8323329-738874475-1564736879=:2285--

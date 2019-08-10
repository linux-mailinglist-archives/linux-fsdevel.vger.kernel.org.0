Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937A7889E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJISm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 04:18:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJISm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GMe3cJeR3x4cOsIIHg7bFNCkA/K5StIKgfeCxVBHL3I=; b=EijfoWzQchoSmnjIXxQUy7X3a
        BdO3QDy1XsyViRMM4c2khWGMKE/iLJZLsdE2toRCuwOD14l+4wkdfv82GPPv/EX+WVAkJ2o7d43XC
        ZCVDF95BVDhTh3UBqZMjoVTGRX0XXxobgArCuiFLtwTF4BUiMynE8g95tP3lQyGDwtOceVsIifpKk
        vPMHAllgYPyg3grsQEBVtM7Rzox2zstTOhVdS6x43TvBWhz0fnq5YBIN96i0Rv18HVa0uOxVUxk7G
        DGzeOmIfXXRQKRBWpJPBVv/vql8f3/6dquFBusP2aZ4I1IUmQv1AHiE/cCvNPYZDUnkDEirqBtk+I
        UPXrS0oXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwMaA-0001Ok-V2; Sat, 10 Aug 2019 08:18:34 +0000
Date:   Sat, 10 Aug 2019 01:18:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190810081834.GB30426@infradead.org>
References: <20190801010126.245731659@linutronix.de>
 <20190802075612.GA20962@infradead.org>
 <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
 <20190806061119.GA17492@infradead.org>
 <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
 <20190808072807.GA25259@infradead.org>
 <alpine.DEB.2.21.1908080953170.2882@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908080953170.2882@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:54:03AM +0200, Thomas Gleixner wrote:
> > I know.  But the problem here is that normally PG_locked is used together 
> > with wait_on_page_bit_*, but this one instances uses the bit spinlock
> > helpers.  This is the equivalent of calling spin_lock on a struct mutex
> > rather than having a mutex_lock_spin helper for this case.
> 
> Yes, I know :(

But this means we should exclude slub from the bit_spin_lock removal.
It really should use it's own version of it anyhow insted of pretending
that the page lock is a bit spinlock.

> 
> > Does SLUB work on -rt at all?
> 
> It's the only allocator we support with a few tweaks :)

What do you do about this particular piece of code there?

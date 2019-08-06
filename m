Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8C82B80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 08:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfHFGL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 02:11:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbfHFGL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aB60sYFkleC6hpDylnEldYGmLHnG+9pRYw06I4nxy6M=; b=ia9qAdq6lNwFYo7OVTZPsfhxv
        vfOjSEbe9ZkOiaAOKXdKACSVtb7rMX+i3fcKh0974MqVDFqWUVvEtfnry2a+ezfxHcDX+r+jgSl50
        4z8jVldTjbUVRJWVBZXrw753MjgEsLKG3pAdolC1PYVTAIiRMZaCUjvDi4ZbEkre5vaoTQXo1KETI
        OlBxF2ExoFKfBRpc+TrCOYdxFhwlgpmKi5cuPacGG26m5p0pT+N+pjxlSVyd3pSxk1WRTuDcWdOw8
        nXuhTXz7wF2qZXGAy1lH72pgTQdZ+NgIHLkPSCgb3p7NxvwYBxpElWC7GCA+TdWg9Dr2qPPVGqCcv
        JHcSj4RBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1husgp-0005nR-Nj; Tue, 06 Aug 2019 06:11:19 +0000
Date:   Mon, 5 Aug 2019 23:11:19 -0700
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
Message-ID: <20190806061119.GA17492@infradead.org>
References: <20190801010126.245731659@linutronix.de>
 <20190802075612.GA20962@infradead.org>
 <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:07:53AM +0200, Thomas Gleixner wrote:
> Last time I did, there was resistance :)

Do you have a pointer?  Note that in the buffer head case maybe
a hash lock based on the page address is even better, as we only
ever use the lock in the first buffer head of a page anyway..

> What about the page lock?
> 
>   mm/slub.c:      bit_spin_lock(PG_locked, &page->flags);

One caller ouf of a gazillion that spins on the page lock instead of
sleepign on it like everyone else.  That should not have passed your
smell test to start with :)

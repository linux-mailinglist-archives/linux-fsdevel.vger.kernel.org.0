Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5727A11909A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfLJTaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 14:30:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJTaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tw2JPIMYDsfgukvM8WXHM1nu5JQP5vubIup8mX2xa3Y=; b=OHQtieOKJ3KsSxH0XLa2EtTsh
        XAnLaFDGOgNiQCq63QIcZzsCqoyHH0w0ataQ3lJhpbatDvRxXkLrFwL/6ycEWDG1V5dUNk1p+rbBx
        RsHnzwKVc/XXESf1jD+CW2exZ3u5t3U5A/mxjfmN+ZM/GMa8zYBIN1oLTXlW+pHEY2ykRHxACV1G+
        bfpGOMKesC5bHP/dr8uU4QVWUPHfvlSja7190Ge7YmC/iJJNGu3mM7KMSLwIe4Ezpz8mU8kvPgaFf
        X/YQHWctWfaPlrTclyGn4vRJTXPbKpNacgsXe7mGLBIn5pyzi368hMnchEhtTcf+Qq4DZZFKsuE3e
        Ud3Unr15g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ielD3-0002k5-Kt; Tue, 10 Dec 2019 19:30:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC80F980D21; Tue, 10 Dec 2019 20:30:11 +0100 (CET)
Date:   Tue, 10 Dec 2019 20:30:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] rxrpc: Mutexes are unusable from softirq context, so use
 rwsem instead
Message-ID: <20191210193011.GA11802@worktop.programming.kicks-ass.net>
References: <157599917879.6327.69195741890962065.stgit@warthog.procyon.org.uk>
 <20191210191009.GA11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210191009.GA11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 08:10:09PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 10, 2019 at 05:32:58PM +0000, David Howells wrote:
> > rxrpc_call::user_mutex is of type struct mutex, but it's required to start
> > off locked on an incoming call as it is being set up in softirq context to
> > prevent sendmsg and recvmsg interfering with it until it is ready.  It is
> > then unlocked in rxrpc_input_packet() to make the call live.
> > 
> > Unfortunately, commit a0855d24fc22d49cdc25664fb224caee16998683
> > ("locking/mutex: Complain upon mutex API misuse in IRQ contexts") causes
> > big warnings to be splashed in dmesg for each a new call that comes in from
> > the server.
> > 
> > It *seems* like it should be okay, since the accept path trylocks the mutex
> > when no one else can see it and drops the mutex before it leaves softirq
> > context.
> > 
> > Fix this by switching to using an rw_semaphore instead as that is permitted
> > to be used in softirq context.
> 
> This really has the very same problem. It just avoids the WARN. We do PI
> boosting for rwsem write side identical to what we do for mutexes.
> 
> I would rather we revert David's patch for now and more carefully
> consider what to do about this.

To clarify (I only just reliazed David is a bit ambiguous here), take
this patch out for now:

  a0855d24fc22 ("locking/mutex: Complain upon mutex API misuse in IRQ contexts")

The RXRPC code has been there for a while... and like I wrote, both
mutex and rwsem have the exact same issue, the rwsem code just doesn't
have a WARN on it.

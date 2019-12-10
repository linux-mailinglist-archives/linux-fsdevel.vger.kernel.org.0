Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B62119059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLJTKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 14:10:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfLJTKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a35QQIVRZAfUwW6/AE1+O5h1J9PVr+kiDXT0hU/xuAk=; b=u5Y4Sp2rJd5Pz1+Bj6lrdl5xF
        PQ06SchtmJ7RQjs3rGJMHTxj9dXHoD/8ZRpyGq4dGZgtyY5TueTqrttP69kNFYkpWKPINZpfYufrY
        YZ8f/h7dRzikcn1LFfFXkmn7zUWjbkAs0HhNRJmV2zDndEmqItPhGAEwAXoZm/6+wwTFHTEBHLKiG
        97wqZtBKAhLKnXngCYvueNY6Nv6WFBa07xKvXoNyfstlzJCbD5Ejgmxdf7IQWayLj8jzgmBW7/6tN
        MdTBGGWBZwgViaJgaZFJc3+PSN45AWuZs7q3WmyCn9yrr9dtxWSNYjLBw0qerEDjx4Iu8LeIUg6iZ
        9uc8hrtQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iektm-0002Sn-3z; Tue, 10 Dec 2019 19:10:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C1F3980D21; Tue, 10 Dec 2019 20:10:09 +0100 (CET)
Date:   Tue, 10 Dec 2019 20:10:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: Mutexes are unusable from softirq context, so use
 rwsem instead
Message-ID: <20191210191009.GA11457@worktop.programming.kicks-ass.net>
References: <157599917879.6327.69195741890962065.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157599917879.6327.69195741890962065.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:32:58PM +0000, David Howells wrote:
> rxrpc_call::user_mutex is of type struct mutex, but it's required to start
> off locked on an incoming call as it is being set up in softirq context to
> prevent sendmsg and recvmsg interfering with it until it is ready.  It is
> then unlocked in rxrpc_input_packet() to make the call live.
> 
> Unfortunately, commit a0855d24fc22d49cdc25664fb224caee16998683
> ("locking/mutex: Complain upon mutex API misuse in IRQ contexts") causes
> big warnings to be splashed in dmesg for each a new call that comes in from
> the server.
> 
> It *seems* like it should be okay, since the accept path trylocks the mutex
> when no one else can see it and drops the mutex before it leaves softirq
> context.
> 
> Fix this by switching to using an rw_semaphore instead as that is permitted
> to be used in softirq context.

This really has the very same problem. It just avoids the WARN. We do PI
boosting for rwsem write side identical to what we do for mutexes.

I would rather we revert David's patch for now and more carefully
consider what to do about this.


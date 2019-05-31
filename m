Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5830DB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaMCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 08:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaMCa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 08:02:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD5363001789;
        Fri, 31 May 2019 12:02:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F522176B4;
        Fri, 31 May 2019 12:02:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190531111445.GO2677@hirez.programming.kicks-ass.net>
References: <20190531111445.GO2677@hirez.programming.kicks-ass.net> <CAG48ez0R-R3Xs+3Xg9T9qcV3Xv6r4pnx1Z2y=Ltx7RGOayte_w@mail.gmail.com> <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk> <4031.1559064620@warthog.procyon.org.uk> <20190528231218.GA28384@kroah.com> <31936.1559146000@warthog.procyon.org.uk> <16193.1559163763@warthog.procyon.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21941.1559304135.1@warthog.procyon.org.uk>
Date:   Fri, 31 May 2019 13:02:15 +0100
Message-ID: <21942.1559304135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 31 May 2019 12:02:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> Can you re-iterate the exact problem? I konw we talked about this in the
> past, but I seem to have misplaced those memories :/

Take this for example:

	void afs_put_call(struct afs_call *call)
	{
		struct afs_net *net = call->net;
		int n = atomic_dec_return(&call->usage);
		int o = atomic_read(&net->nr_outstanding_calls);

		trace_afs_call(call, afs_call_trace_put, n + 1, o,
			       __builtin_return_address(0));

		ASSERTCMP(n, >=, 0);
		if (n == 0) {
			...
		}
	}

I am printing the usage count in the afs_call tracepoint so that I can use it
to debug refcount bugs.  If I do it like this:

	void afs_put_call(struct afs_call *call)
	{
		int n = refcount_read(&call->usage);
		int o = atomic_read(&net->nr_outstanding_calls);

		trace_afs_call(call, afs_call_trace_put, n, o,
			       __builtin_return_address(0));

		if (refcount_dec_and_test(&call->usage)) {
			...
		}
	}

then there's a temporal gap between the usage count being read and the actual
atomic decrement in which another CPU can alter the count.  This can be
exacerbated by an interrupt occurring, a softirq occurring or someone enabling
the tracepoint.

I can't do the tracepoint after the decrement if refcount_dec_and_test()
returns false unless I save all the values from the object that I might need
as the object could be destroyed any time from that point on.  In this
particular case, that's just call->debug_id, but it could be other things in
other cases.

Note that I also can't touch the afs_net object in that situation either, and
the outstanding calls count that I record will potentially be out of date -
but there's not a lot I can do about that.

David

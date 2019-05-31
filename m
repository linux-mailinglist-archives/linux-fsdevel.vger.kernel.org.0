Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6131004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEaOUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 10:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaOUT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 10:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD64BB5C01;
        Fri, 31 May 2019 14:20:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2128E7C5AD;
        Fri, 31 May 2019 14:20:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190531132620.GC2606@hirez.programming.kicks-ass.net>
References: <20190531132620.GC2606@hirez.programming.kicks-ass.net> <20190531111445.GO2677@hirez.programming.kicks-ass.net> <CAG48ez0R-R3Xs+3Xg9T9qcV3Xv6r4pnx1Z2y=Ltx7RGOayte_w@mail.gmail.com> <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk> <4031.1559064620@warthog.procyon.org.uk> <20190528231218.GA28384@kroah.com> <31936.1559146000@warthog.procyon.org.uk> <16193.1559163763@warthog.procyon.org.uk> <21942.1559304135@warthog.procyon.org.uk>
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
Content-ID: <605.1559312411.1@warthog.procyon.org.uk>
Date:   Fri, 31 May 2019 15:20:12 +0100
Message-ID: <606.1559312412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 31 May 2019 14:20:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> Is it not the responsibility of the task that affects the 1->0
> transition to actually free the memory?
> 
> That is, I'm expecting the '...' in both cases above the include the
> actual freeing of the object. If this is not the case, then @usage is
> not a reference count.

Yes.  The '...' does the freeing.  It seemed unnecessary to include the code
ellipsised there since it's not the point of the discussion, but if you want
the full function:

	void afs_put_call(struct afs_call *call)
	{
		struct afs_net *net = call->net;
		int n = atomic_dec_return(&call->usage);
		int o = atomic_read(&net->nr_outstanding_calls);

		trace_afs_call(call, afs_call_trace_put, n + 1, o,
			       __builtin_return_address(0));

		ASSERTCMP(n, >=, 0);
		if (n == 0) {
			ASSERT(!work_pending(&call->async_work));
			ASSERT(call->type->name != NULL);

			if (call->rxcall) {
				rxrpc_kernel_end_call(net->socket, call->rxcall);
				call->rxcall = NULL;
			}
			if (call->type->destructor)
				call->type->destructor(call);

			afs_put_server(call->net, call->server);
			afs_put_cb_interest(call->net, call->cbi);
			afs_put_addrlist(call->alist);
			kfree(call->request);

			trace_afs_call(call, afs_call_trace_free, 0, o,
				       __builtin_return_address(0));
			kfree(call);

			o = atomic_dec_return(&net->nr_outstanding_calls);
			if (o == 0)
				wake_up_var(&net->nr_outstanding_calls);
		}
	}

You can see the kfree(call) in there.
Peter Zijlstra <peterz@infradead.org> wrote:

> (and it has already been established that refcount_t doesn't work for
> usage count scenarios)

?

Does that mean struct kref doesn't either?

> Aside from that, is the problem that refcount_dec_and_test() returns a
> boolean (true - last put, false - not last) instead of the refcount
> value? This does indeed make it hard to print the exact count value for
> the event.

That is the problem, yes - well, one of them: refcount_inc() doesn't either.

David

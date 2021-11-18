Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8290456391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 20:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKRTji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 14:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhKRTji (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:39:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1EC61507;
        Thu, 18 Nov 2021 19:36:36 +0000 (UTC)
Date:   Thu, 18 Nov 2021 14:36:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     "Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211118143634.3f7d43e9@gandalf.local.home>
In-Reply-To: <87pmqxuv4n.fsf@email.froward.int.ebiederm.org>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
        <20211118140211.7d7673fb@gandalf.local.home>
        <87pmqxuv4n.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 13:22:16 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:

> > 
> I am refreshing my nack on the concept.  My nack has been in place for
> good technical reasons since about 2006.

I'll admit, we are new to this, as we are now trying to add more visibility
into the workings of things like kubernetes. And having a way of knowing
what containers are running and how to monitor them is needed, and we need
to do this for all container infrastructures.

> 
> I see no way forward.  I do not see a compelling use case.

What do you use to debug issues in a kubernetes cluster of hundreds of
machines running thousands of containers? Currently, if something is amiss,
a node is restarted in the hopes that the issue does not appear again. But
we would like to add infrastructure that takes advantage of tracing and
profiling to be able to narrow that down. But to do so, we need to
understand what tasks belong to what containers.

> 
> There have been many conversations in the past attempt to implement
> something that requires a namespace of namespaces and they have never
> gotten anywhere.

We are not asking about a "namespace" of namespaces, but a filesystem (one,
not a namespace of one), that holds the information at the system scale,
not a container view.

I would be happy to implement something that makes a container having this
file system available "special" as most containers do not need this.

> 
> I see no attempt a due diligence or of actually understanding what
> hierarchy already exists in namespaces.

This is not trivial. What did we miss?

> 
> I don't mean to be nasty but I do mean to be clear.  Without a
> compelling new idea in this space I see no hope of an implementation.
> 
> What they are attempting to do makes it impossible to migrate a set of
> process that uses this feature from one machine to another.  AKA this
> would be a breaking change and a regression if merged.

The point of this is not to allow that migration. I'd be happy to add that
if a container has access to this file system, it is pinned to the system
and can not be migrated. The whole point of this file system is to monitor
all containers no the system, and it makes no sense in migrating it.

We would duplicate it over several systems, but there's no reason to move
it once it is running.

> 
> The breaking and regression are caused by assigning names to namespaces
> without putting those names into a namespace of their own.   That
> appears fundamental to the concept not to the implementation.

If you think this should be migrated then yes, it is broken. But we don't
want this to work across migrations. That defeats the purpose of this work.

> 
> Since the concept if merged would cause a regression it qualifies for
> a nack.
> 
> We can explore what problems they are trying to solve with this and
> explore other ways to solve those problems.  All I saw was a comment
> about monitoring tools and wanting a global view.  I did not see
> any comments about dealing with all of the reasons why a global view
> tends to be a bad idea.

If you only care about a working environment of the system that runs a set
of containers, how is that a bad idea. Again, I'm happy with implementing
something that makes having this file system prevent it from being
migrated. A pinned privileged container.

> 
> I should have added that we have to some extent a way to walk through
> namespaces using ioctls on nsfs inodes.

How robust is this? And is there a library or tooling around it?

-- Steve

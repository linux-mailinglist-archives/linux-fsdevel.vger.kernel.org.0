Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3441D310A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEaOzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 10:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaOzM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 10:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47CAFC0AD2B7;
        Fri, 31 May 2019 14:55:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44FF41001E6F;
        Fri, 31 May 2019 14:55:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190529231112.GB3164@kroah.com>
References: <20190529231112.GB3164@kroah.com> <20190528231218.GA28384@kroah.com> <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk> <4031.1559064620@warthog.procyon.org.uk> <31936.1559146000@warthog.procyon.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3762.1559314508.1@warthog.procyon.org.uk>
Date:   Fri, 31 May 2019 15:55:08 +0100
Message-ID: <3763.1559314508@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 31 May 2019 14:55:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> wrote:

> So, if that's all that needs to be fixed, can you use the same
> buffer/code if that patch is merged?

I really don't know.  The perf code is complex, partially in hardware drivers
and is tricky to understand - though a chunk of that is the "aux" buffer part;
PeterZ used words like "special" and "magic" and the comments in the code talk
about the hardware writing into the buffer.

__perf_output_begin() does not appear to be SMP safe.  It uses local_cmpxchg()
and local_add() which on x86 lack the LOCK prefix.

stracing the perf command on my test machine, it calls perf_event_open(2) four
times and mmap's each fd it gets back.  I'm guessing that each one maps a
separate buffer for each CPU.

So to use watch_queue based on perf's buffering, you would have to have a
(2^N)+1 pages-sized buffer for each CPU.  So that would be a minimum of 64K of
unswappable memory for my desktop machine, say).  Multiply that by each
process that wants to listen for events...

What I'm aiming for is something that has a single buffer used by all CPUs for
each instance of /dev/watch_queue opened and I'd also like to avoid having to
allocate the metadata page and the aux buffer to save space.  This is locked
memory and cannot be swapped.

Also, perf has to leave a gap in the ring because it uses CIRC_SPACE(), though
that's a minor detail that I guess can't be fixed now.

I'm also slightly concerned that __perf_output_begin() doesn't check if
rb->user->tail has got ahead of rb->user->head or that it's lagging too far
behind.  I doubt it's a serious problem for the kernel since it won't write
outside of the buffer, but userspace might screw up.  I think the worst that
will happen is that userspace will get confused.

One thing I would like is to waive the 2^N size requirement.  I understand
*why* we do that, but I wonder how expensive DIV instructions are for
relatively small divisors.

David

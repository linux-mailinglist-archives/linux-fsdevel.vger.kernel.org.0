Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5261223BF5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHDS1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDS1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:27:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AA0C06174A;
        Tue,  4 Aug 2020 11:27:41 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k31em-009HhW-2E; Tue, 04 Aug 2020 18:27:24 +0000
Date:   Tue, 4 Aug 2020 19:27:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
Message-ID: <20200804182724.GK1236603@ZenIV.linux.org.uk>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
 <20200803154125.GA23808@casper.infradead.org>
 <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com>
 <20200803161230.GB23808@casper.infradead.org>
 <CAJuCfpGot1Lr+eS_AU30gqrrjc0aFWikxySe0667_GTJNsGTMw@mail.gmail.com>
 <20200803222831.GI1236603@ZenIV.linux.org.uk>
 <20200804010913.GA2096725@ZenIV.linux.org.uk>
 <20200804154451.GA948167@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804154451.GA948167@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 03:44:51PM +0000, Kalesh Singh wrote:

> Hi Al. Thank you for the comments. Ultimately what we need is to identify processes
> that hold a file reference to the dma-buf. Unfortunately we can't use only
> explicit dma_buf_get/dma_buf_put to track them because when an FD is being shared
> between processes the file references are taken implicitly.
> 
> For example, on the sender side:
>    unix_dgram_sendmsg -> send_scm -> __send_scm -> scm_fp_copy -> fget_raw
> and on the receiver side:
>    unix_dgram_recvmsg -> scm_recv -> scm_detach_fds -> __scm_install_fd -> get_file
> 
> I understand now that fd_install is not an appropriate abstraction level to track these.
> Is there a more appropriate alternative where we could use to track these implicit file
> references?

There is no single lock that would stabilize the descriptor tables of all
processes.  And there's not going to be one, ever - it would be a contention
point from hell, since that would've been a system-wide lock that would have
to be taken by *ALL* syscalls modifying any descriptor table.  Not going to
happen, for obvious reasons.  Moreover, you would have to have fork(2) take
the same lock, since it does copy descriptor table.  And clone(2) either does
the same, or has the child share the descriptor table of parent.

What's more, a reference to struct file can bloody well survive without
a single descriptor refering to that file.  In the example you've mentioned
above, sender has ever right to close all descriptors it has sent.   Files
will stay opened as long as the references are held in the datagram; when
that datagram is received, the references will be inserted into recepient's
descriptor table.  At that point you again have descriptors refering to
that file, can do any IO on it, etc.

So "the set of processes that hold a file reference to the dma-buf" is
	* inherently unstable, unless you are willing to freeze every
process in the system except for the one trying to find that set.
	* can remain empty for any amount of time (hours, weeks, whatever),
only to get non-empty later, with syscalls affecting the object in question
done afterwards.

So... what were you going to do with that set if you could calculate it?
If it's really "how do we debug a leak?", it's one thing; in that case
I would suggest keeping track of creation/destruction of objects (not
gaining/dropping references - actual constructors and destructors) to
see what gets stuck around for too long and use fuser(1) to try and locate
the culprits if you see that something *was* living for too long.  "Try"
since the only reference might indeed have been stashed into an SCM_RIGHTS
datagram sitting in a queue of some AF_UNIX socket.  Note that "fuser
needs elevated priveleges" is not a strong argument - the ability to
do that sort of tracking does imply elevated priveleges anyway, and
having a root process taking requests along the lines of "gimme the
list of PIDs that have such-and-such dma_buf in their descriptor table"
is not much of an attack surface.

If you want to use it for something else, you'll need to describe that
intended use; there might be sane ways to do that, but it's hard to
come up with one without knowing what's being attempted...

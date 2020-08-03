Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7B23B02F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHCW2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCW2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:28:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98278C06174A;
        Mon,  3 Aug 2020 15:28:44 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2iwZ-008hXp-IY; Mon, 03 Aug 2020 22:28:31 +0000
Date:   Mon, 3 Aug 2020 23:28:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
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
Message-ID: <20200803222831.GI1236603@ZenIV.linux.org.uk>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
 <20200803154125.GA23808@casper.infradead.org>
 <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com>
 <20200803161230.GB23808@casper.infradead.org>
 <CAJuCfpGot1Lr+eS_AU30gqrrjc0aFWikxySe0667_GTJNsGTMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGot1Lr+eS_AU30gqrrjc0aFWikxySe0667_GTJNsGTMw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 09:22:53AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2020 at 9:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Aug 03, 2020 at 09:00:00AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Aug 3, 2020 at 8:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Aug 03, 2020 at 02:47:19PM +0000, Kalesh Singh wrote:
> > > > > +static void dma_buf_fd_install(int fd, struct file *filp)
> > > > > +{
> > > > > +     trace_dma_buf_fd_ref_inc(current, filp);
> > > > > +}
> > > >
> > > > You're adding a new file_operation in order to just add a new tracepoint?
> > > > NACK.
> > >
> > > Hi Matthew,
> > > The plan is to attach a BPF to this tracepoint in order to track
> > > dma-buf users. If you feel this is an overkill, what would you suggest
> > > as an alternative?
> >
> > I'm sure BPF can attach to fd_install and filter on file->f_ops belonging
> > to dma_buf, for example.
> 
> Sounds like a workable solution. Will explore that direction. Thanks Matthew!

No, it is not a solution at all.

What kind of locking would you use?  With _any_ of those approaches.

How would you use the information that is hopelessly out of date/incoherent/whatnot
at the very moment you obtain it?

IOW, what the hell is that horror for?  You do realize, for example, that there's
such thing as dup(), right?  And dup2() as well.  And while we are at it, how
do you keep track of removals, considering the fact that you can stick a file
reference into SCM_RIGHTS datagram sent to yourself, close descriptors and an hour
later pick that datagram, suddenly getting descriptor back?

Besides, "I have no descriptors left" != "I can't be currently sitting in the middle
of syscall on that sucker"; close() does *NOT* terminate ongoing operations.

You are looking at the drastically wrong abstraction level.  Please, describe what
it is that you are trying to achieve.

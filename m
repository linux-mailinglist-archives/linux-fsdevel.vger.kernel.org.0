Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A491F342719
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 21:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCSUoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 16:44:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59394 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSUn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:43:58 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNLyN-0000Ed-Qu; Fri, 19 Mar 2021 20:43:55 +0000
Date:   Fri, 19 Mar 2021 21:43:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <20210319204354.yucbbh5fyn2ekqtx@wittgenstein>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFUJLUnXnsv9X/vN@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 01:27:25PM -0700, Omar Sandoval wrote:
> On Fri, Mar 19, 2021 at 01:08:05PM -0700, Linus Torvalds wrote:
> > On Fri, Mar 19, 2021 at 11:21 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > Can we get some movement on this?  Omar is sort of spinning his wheels here
> > > trying to get this stuff merged, no major changes have been done in a few
> > > postings.
> > 
> > I'm not Al, and I absolutely detest the IOCB_ENCODED thing, and want
> > more explanations of why this should be done that way, and pollute our
> > iov_iter handling EVEN MORE.
> > 
> > Our iov_iter stuff isn't the most legible, and I don't understand why
> > anybody would ever think it's a good idea to spread what is clearly a
> > "struct" inside multiple different iov extents.
> > 
> > Honestly, this sounds way more like an ioctl interface than
> > read/write. We've done that before.
> 
> As Josef just mentioned, I started with an ioctl, and Dave Chinner
> suggested doing it this way:
> https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
> 
> The nice thing about it is that it sidesteps all of the issues we had
> with the dedupe/reflink ioctls over the years where permissions checks
> and the like were slightly different from read/write.
> 
> > But if it has to be done with an iov_iter, is there *any* reason to
> > not make it be a hard rule that iov[0] should not be the entirely of
> > the struct, and the code shouldn't ever need to iterate?
> 
> For RWF_ENCODED, iov[0] is always used as the entirety of the struct. I
> made the helper more generic to support other use cases, but if that's
> the main objection I can easily make it specifically use iov[0].
> 
> > Also I see references to the man-page, but honestly, that's not how
> > the kernel UAPI should be defined ("just read the man-page"), plus I
> > refuse to live in the 70's, and consider troff to be an atrocious
> > format.
> 
> No disagreement here, troff is horrible to read.

Not a fan of troff either: One thing that might help you a little bit is
to use pandoc to convert to troff. You can write your manpage in
markdown or rst and then convert it into troff via pandoc. Still might
require some massaging but it makes it considerably more pleasant to
write a manpage.

Christian

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE053B2164
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWTsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:48:30 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30026C061574;
        Wed, 23 Jun 2021 12:46:13 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw8ox-00BcP3-G0; Wed, 23 Jun 2021 19:45:59 +0000
Date:   Wed, 23 Jun 2021 19:45:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
References: <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:49:51AM -0700, Omar Sandoval wrote:

> > Fair summary. The only other thing that I'd add is this is an IO
> > interface that requires issuing physical IO. So if someone wants
> > high throughput for encoded IO, we really need AIO and/or io_uring
> > support, and we get that for free if we use readv2/writev2
> > interfaces.
> > 
> > Yes, it could be an ioctl() interface, but I think that this sort of
> > functionality is exactly what extensible syscalls like
> > preadv2/pwritev2 should be used for. It's a slight variant on normal
> > IO, and that's exactly what the RWF_* flags are intended to be used
> > for - allowing interesting per-IO variant behaviour without having
> > to completely re-implemnt the IO path via custom ioctls every time
> > we want slightly different functionality...
> 
> Al, Linus, what do you think? Is there a path forward for this series as
> is? I'd be happy to have this functionality merged in any form, but I do
> think that this approach with preadv2/pwritev2 using iov_len is decent
> relative to the alternatives.

IMO we might be better off with explicit ioctl - this magical mystery shite
with special meaning of the first iovec length is, IMO, more than enough
to make it a bad fit for read/write family.

It's *not* just a "slightly different functionality" - it's very different
calling conventions.  And the deeper one needs to dig into the interface
details to parse what's going on, the less it differs from ioctl() mess.

Said that, why do you need a variable-length header on the read side,
in the first place?

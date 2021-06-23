Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1950C3B2201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFWUtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWUtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:49:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FDC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 13:46:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w71so3307532pfd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=35fX3b/9KipFW6E3fYUr5lcYBNTVVlADu03Gtygr2Nk=;
        b=Hk+dH/qK+72QM33k5wW4gKCoofvBG35fBFE/5NSN9cuhFQ+yHUtHo14gwPuBvB5kLS
         E6q16f1m17kqPZWIR5Z6unziZ6jNGg0lecaDbu/EOB01AT4yko4updWTWuzu3/j8Cp0K
         YAFsNG5PL9jNw4QzSuNhiJLFiNHr9gXPNlJOJFVchKP7QBJrSVQFsIUSPF+FeTb7AtEa
         F76qW3ZgBP/1e7hFW/auvpk9BMkPCXa5wT8JCEK2eWcXwJ2JRhyCm0QgqUMcmwgdVVOI
         PQUwMPVkPN4hgOGpQ3sFI0P/fJEMAK2kqXaTj4te5hrUFsfFOqp3bsBD9XezvotPsgK6
         CmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=35fX3b/9KipFW6E3fYUr5lcYBNTVVlADu03Gtygr2Nk=;
        b=VqZKNw0xYx/yOxmiTTA6yQac2loHoXLvNbnPiQtemTrv8tN5pI/2AIZb8SeY2DdGQX
         ZaNStOTbB1bxebSbKsyO0QeOxFY6qd3Fe3YwoIh5C2A7jSKPqzSSEdHuxZUGznFaBQ6u
         REfNQ73ylCD1d7KHjRadrCGYobVsqPv6XuY/sv9XS5iHoA9MwQ/YYO7aMXaynekgG7E6
         M/27x9E3RFc0YRY7ShN4QdqZP23Liu9cxUuXyj3XlWinpf/l6Ivo9AfDnafmCBOjgj2n
         b7VU4MRdju8YPINmETqYOpipC/cMDBmt8a2UUO2ETuks8z1dralcPprJfHIJ8oVFXpGf
         JumQ==
X-Gm-Message-State: AOAM5322+ekfxKrGnIGXkwOWeOU8+anCpAPpEqkthsgTg9YAauB+1WrT
        w3lPj6jb1a8YpDa5nXB380vjgA==
X-Google-Smtp-Source: ABdhPJxc5l5DI/3/a0Vr5/trltrw8Ct1u+bkj2q4aYmLeaoJdbHwBVB2e0UdzNnQEvcMXtZUvOQ8aQ==
X-Received: by 2002:a65:6644:: with SMTP id z4mr1258936pgv.101.1624481212718;
        Wed, 23 Jun 2021 13:46:52 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e167])
        by smtp.gmail.com with ESMTPSA id p45sm702640pfw.19.2021.06.23.13.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:46:52 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:46:50 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNOdunP+Fvhbsixb@relinquished.localdomain>
References: <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 07:45:59PM +0000, Al Viro wrote:
> On Wed, Jun 23, 2021 at 10:49:51AM -0700, Omar Sandoval wrote:
> 
> > > Fair summary. The only other thing that I'd add is this is an IO
> > > interface that requires issuing physical IO. So if someone wants
> > > high throughput for encoded IO, we really need AIO and/or io_uring
> > > support, and we get that for free if we use readv2/writev2
> > > interfaces.
> > > 
> > > Yes, it could be an ioctl() interface, but I think that this sort of
> > > functionality is exactly what extensible syscalls like
> > > preadv2/pwritev2 should be used for. It's a slight variant on normal
> > > IO, and that's exactly what the RWF_* flags are intended to be used
> > > for - allowing interesting per-IO variant behaviour without having
> > > to completely re-implemnt the IO path via custom ioctls every time
> > > we want slightly different functionality...
> > 
> > Al, Linus, what do you think? Is there a path forward for this series as
> > is? I'd be happy to have this functionality merged in any form, but I do
> > think that this approach with preadv2/pwritev2 using iov_len is decent
> > relative to the alternatives.
> 
> IMO we might be better off with explicit ioctl - this magical mystery shite
> with special meaning of the first iovec length is, IMO, more than enough
> to make it a bad fit for read/write family.
> 
> It's *not* just a "slightly different functionality" - it's very different
> calling conventions.  And the deeper one needs to dig into the interface
> details to parse what's going on, the less it differs from ioctl() mess.
> 
> Said that, why do you need a variable-length header on the read side,
> in the first place?

Suppose we add a new field representing a new type of encoding to the
end of encoded_iov. On the write side, the caller might want to specify
that the data is encoded in that new way, of course. But on the read
side, if the data is encoded in that new way, then the kernel will want
to return that. The kernel needs to know if the user's structure
includes the new field (otherwise when it copies the full struct out, it
will write into what the user thinks is the data instead).

As I mentioned in my reply to Linus, maybe we can stick with
preadv2/pwritev2, but make the struct encoded_iov structure a fixed size
with some reserved space for future expansion. That makes this a lot
less special: just copy a fixed size structure, then read/write the
rest. And then we don't need to reinvent the rest of the
preadv2/pwritev2 path for an ioctl.

Between a fixed size structure and an ioctl, what would you prefer?

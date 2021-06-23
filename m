Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5671F3B1FDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFWRwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFWRwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:52:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84EC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 10:49:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s14so1649606pfg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jM0/fuoJEp0WkWTBlwHRuxABxUrsbCLb+UOcPsZzDds=;
        b=EaFaRZeD7LoVMH2RK8LnQujTeHrf3HShJG6nud7YS9AFM2LyWRu9nlRhgySleurNFJ
         89k2FjZZ+1tLjbMsXkS/ooPf6M9HQvKXIL+Mkw3KYj6p6qrdud1zgNCANmADJKYVwdRV
         1OUG3SLqBe3Agx0wbc1+xvpqElw5lbCme44rHa5Vp/0td7HOlaNOnMZlfTmpPbMnnckE
         rJMImg/0nTszugtZPNlBOgC8iGfy2ZPaOsgYUUha/fmZIWVsk47abfZLOiXwPYnxraNd
         689WqI6VbSTO2sMCq5cKJTIzkbW7Bj4cH2TBDNRp/EHuwq2GgDsv0Dk8s9Y16l4wKB3Q
         dMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jM0/fuoJEp0WkWTBlwHRuxABxUrsbCLb+UOcPsZzDds=;
        b=oGUpC5uOh5MVJJzSNej2/iO9a5xPNFpXCsv4EbZrJsvtsTkuJQYT/rQOK+dGuHqZ66
         7XNx6zo6O8ckdY3r6Weg9OWijihkU3oNTM1v/BrAjVl/brWKRXzlikvwOWdozYYRLe/b
         z8blU/ol+t5gIYW4NWXqVDNot68j8UcpEOk7uECKRMDd/K5L1u3hrZvG8hE5nmsDp4rT
         iLs/fvh3A8akbE3bc2/Qm30RtclH5qOAo2NMhVVUL3Y3JwWw1KM7LsSnaQjokP0Hz1zN
         gYb6JegDAB59Zuy0q8i2m7xD3h/xyrrxtIjejAHTFjflvEC/2dmTjBWVMMFoxY8Tcht/
         9m9Q==
X-Gm-Message-State: AOAM5300nhL4aVLTq3f1Sjj5Q72VpCackqagu6Xc8YJ0gxa+Kbtt2XvO
        +GJlPeI1fZ5RnPeuRVo3ecKcRg==
X-Google-Smtp-Source: ABdhPJwY3Rc0RaMhy2jttOviNOFzcgRD+TDNWD7DvxxKGlK9I4v47H14tspEa5h2Y2zaozqhlxe6Cw==
X-Received: by 2002:a63:f13:: with SMTP id e19mr626162pgl.112.1624470593763;
        Wed, 23 Jun 2021 10:49:53 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e167])
        by smtp.gmail.com with ESMTPSA id kk4sm4385903pjb.50.2021.06.23.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:49:53 -0700 (PDT)
Date:   Wed, 23 Jun 2021 10:49:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
References: <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622220639.GH2419729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 08:06:39AM +1000, Dave Chinner wrote:
> On Mon, Jun 21, 2021 at 01:55:03PM -0700, Omar Sandoval wrote:
> > On Mon, Jun 21, 2021 at 01:46:04PM -0700, Omar Sandoval wrote:
> > > On Mon, Jun 21, 2021 at 12:33:17PM -0700, Linus Torvalds wrote:
> > > > On Mon, Jun 21, 2021 at 11:46 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > > >
> > > > > How do we get the userspace size with the encoded_iov.size approach?
> > > > > We'd have to read the size from the iov_iter before writing to the rest
> > > > > of the iov_iter. Is it okay to mix the iov_iter as a source and
> > > > > destination like this? From what I can tell, it's not intended to be
> > > > > used like this.
> > > > 
> > > > I guess it could work that way, but yes, it's ugly as hell. And I
> > > > really don't want a readv() system call - that should write to the
> > > > result buffer - to first have to read from it.
> > > > 
> > > > So I think the original "just make it be the first iov entry" is the
> > > > better approach, even if Al hates it.
> > > > 
> > > > Although I still get the feeling that using an ioctl is the *really*
> > > > correct way to go. That was my first reaction to the series
> > > > originally, and I still don't see why we'd have encoded data in a
> > > > regular read/write path.
> > > > 
> > > > What was the argument against ioctl's, again?
> > > 
> > > The suggestion came from Dave Chinner here:
> > > https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
> > > 
> > > His objection to an ioctl was two-fold:
> > > 
> > > 1. This interfaces looks really similar to normal read/write, so we
> > >    should try to use the normal read/write interface for it. Perhaps
> > >    this trouble with iov_iter has refuted that.
> > > 2. The last time we had Btrfs-specific ioctls that eventually became
> > >    generic (FIDEDUPERANGE and FICLONE{,RANGE}), the generalization was
> > >    painful. Part of the problem with clone/dedupe was that the Btrfs
> > >    ioctls were underspecified. I think I've done a better job of
> > >    documenting all of the semantics and corner cases for the encoded I/O
> > >    interface (and if not, I can address this). The other part of the
> > >    problem is that there were various sanity checks in the normal
> > >    read/write paths that were missed or drifted out of sync in the
> > >    ioctls. That requires some vigilance going forward. Maybe starting
> > >    this off as a generic (not Btrfs-specific) ioctl right off the bat
> > >    will help.
> > > 
> > > If we do go the ioctl route, then we also have to decide how much of
> > > preadv2/pwritev2 it should emulate. Should it use the fd offset, or
> > > should that be an ioctl argument? Some of the RWF_ flags would be useful
> > > for encoded I/O, too (RWF_DSYNC, RWF_SYNC, RWF_APPEND), should it
> > > support those? These bring us back to Dave's first point.
> > 
> > Oops, I dropped Dave from the Cc list at some point. Adding him back
> > now.
> 
> Fair summary. The only other thing that I'd add is this is an IO
> interface that requires issuing physical IO. So if someone wants
> high throughput for encoded IO, we really need AIO and/or io_uring
> support, and we get that for free if we use readv2/writev2
> interfaces.
> 
> Yes, it could be an ioctl() interface, but I think that this sort of
> functionality is exactly what extensible syscalls like
> preadv2/pwritev2 should be used for. It's a slight variant on normal
> IO, and that's exactly what the RWF_* flags are intended to be used
> for - allowing interesting per-IO variant behaviour without having
> to completely re-implemnt the IO path via custom ioctls every time
> we want slightly different functionality...

Al, Linus, what do you think? Is there a path forward for this series as
is? I'd be happy to have this functionality merged in any form, but I do
think that this approach with preadv2/pwritev2 using iov_len is decent
relative to the alternatives.

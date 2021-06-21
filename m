Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7163AF709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUU5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhFUU5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:57:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146FCC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 13:55:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d12so589840pgd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EO/Cg881E4iR5hE8GRk/YyeQH3UG7S/UbMqMJ0fur8M=;
        b=lkHLTaLpDyjPrk3QQVWBO9CcyBzPHXjrx9TueMmy+m/owtjQ6+GZOsg/8x3a8uPW9z
         2+exZ9hs2iSUAYqX/D1XbjYW85bnBBOKxGZJiTPljjO98A7bVvrZZpBEwXNEzdAArTzg
         Sd9zOGh+PMw8yY1rMLUZP8SZ2NnTgOiKVQgGwrz8iRQey/9SZ4EJS2aolT3Jmr42hdJt
         GNKdI5q3XXitSyed3Nkd7UK94UjTImmBKhS4+PYSA5IEA68Py5qZzzICMmUQ+G17gHxe
         4g/5d71GDWgvlWF1vrURd1Ad6k+hSkMK/P8PpSS9AAzOLT5O/GhXowWPu58fzzD0MvLQ
         TMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EO/Cg881E4iR5hE8GRk/YyeQH3UG7S/UbMqMJ0fur8M=;
        b=jWnuwWhzs50FhmcHmVm+SsXdHTunW+GVVBPDFEJPEt59ikN6hUEQtAmtlpvuiFqHjO
         jaYymRbt3vHw4PxxpmpKANy0hwErvEHJ6uMf/HyI8zMCFPT18xrLT50FJo/xHenx6/8z
         z2yDt+OJm5dQpr/Ru266Uy9s/nJYbp2JYKtQt0Y8tA4EPuNcrWlF+7nMQPYPvxj1zoDi
         HI8nIQ5VuVyerHIgy7z03PMpYw7avoq7Yc+A5Ma1XOADB5Y+lsjuKfbO2cxvfqChmXUE
         BkkVlVQCD1B1YEmUqZHADjdozyBZSp/9repbH+tjcA/4gPhCVDglnpraFZG/EiH9LJNo
         Yv5g==
X-Gm-Message-State: AOAM532kq4SiU1DD9clC1dGphh3ApOnzMrjH+KMtwefSyQxqYR+t8RY8
        yvD+bCSBCY4XfonETxhTK5UQPg==
X-Google-Smtp-Source: ABdhPJyKb8WfwKdvePyi0WHvYma5ixOJ2P9VN2ywqCwlxu6wmVOzb2rnQKDqp+xGoIdwuG8O9lHxPw==
X-Received: by 2002:a63:308:: with SMTP id 8mr400220pgd.194.1624308905601;
        Mon, 21 Jun 2021 13:55:05 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:96f])
        by smtp.gmail.com with ESMTPSA id z16sm4928003pff.9.2021.06.21.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:55:05 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:55:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YND8p7ioQRfoWTOU@relinquished.localdomain>
References: <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YND6jOrku2JDgqjt@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 01:46:04PM -0700, Omar Sandoval wrote:
> On Mon, Jun 21, 2021 at 12:33:17PM -0700, Linus Torvalds wrote:
> > On Mon, Jun 21, 2021 at 11:46 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > How do we get the userspace size with the encoded_iov.size approach?
> > > We'd have to read the size from the iov_iter before writing to the rest
> > > of the iov_iter. Is it okay to mix the iov_iter as a source and
> > > destination like this? From what I can tell, it's not intended to be
> > > used like this.
> > 
> > I guess it could work that way, but yes, it's ugly as hell. And I
> > really don't want a readv() system call - that should write to the
> > result buffer - to first have to read from it.
> > 
> > So I think the original "just make it be the first iov entry" is the
> > better approach, even if Al hates it.
> > 
> > Although I still get the feeling that using an ioctl is the *really*
> > correct way to go. That was my first reaction to the series
> > originally, and I still don't see why we'd have encoded data in a
> > regular read/write path.
> > 
> > What was the argument against ioctl's, again?
> 
> The suggestion came from Dave Chinner here:
> https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
> 
> His objection to an ioctl was two-fold:
> 
> 1. This interfaces looks really similar to normal read/write, so we
>    should try to use the normal read/write interface for it. Perhaps
>    this trouble with iov_iter has refuted that.
> 2. The last time we had Btrfs-specific ioctls that eventually became
>    generic (FIDEDUPERANGE and FICLONE{,RANGE}), the generalization was
>    painful. Part of the problem with clone/dedupe was that the Btrfs
>    ioctls were underspecified. I think I've done a better job of
>    documenting all of the semantics and corner cases for the encoded I/O
>    interface (and if not, I can address this). The other part of the
>    problem is that there were various sanity checks in the normal
>    read/write paths that were missed or drifted out of sync in the
>    ioctls. That requires some vigilance going forward. Maybe starting
>    this off as a generic (not Btrfs-specific) ioctl right off the bat
>    will help.
> 
> If we do go the ioctl route, then we also have to decide how much of
> preadv2/pwritev2 it should emulate. Should it use the fd offset, or
> should that be an ioctl argument? Some of the RWF_ flags would be useful
> for encoded I/O, too (RWF_DSYNC, RWF_SYNC, RWF_APPEND), should it
> support those? These bring us back to Dave's first point.

Oops, I dropped Dave from the Cc list at some point. Adding him back
now.

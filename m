Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5B7F541
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfHBKj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 06:39:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39911 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfHBKj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:39:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so73300248qtu.6;
        Fri, 02 Aug 2019 03:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rlJwQwKozaN0IUoAzhdQgNUAloq8MbsoeODQ5XHIhJY=;
        b=smTgesqlEhm59X+NJGhyYz6n7wKcJv9UxN3KLCmauIYr1XwW+sqMBDZ2bmSMqJjT1F
         IlyXl/6NV/KePa4flHdcX8Pl+CrZG70wG9TX9biGHtiDjB5Tf1Rxx7hT7X1g6Gqfp2Br
         PdGYnL7108bhvqBS9Hc4E0Q/TvdETZ2JlSQDtKiS3SPKwt33L8+ZdxAu4yLcew9Xnxfw
         Fi6cFyaEegGKajE8TOyAdbZGFPy3RMMbfEwTQGmL/+lwQqdgZDoQogsMxcshMG4Ptg1W
         WnC1zs2DJ73zKG3flHxQFJZ59x4S7jMo2KEgVGSaZgAfoqbEEKfQmDsIXtUcbgFeUFDD
         R6Qw==
X-Gm-Message-State: APjAAAWgGek8WZ9jaMdupvLvPOw+COtDHwvKjvR5o56fok8gR3GgUmHf
        pVo03OQhdmk5fwfcaey5WgivnkBblwcPdUUVD/KLZTC4WdE=
X-Google-Smtp-Source: APXvYqxjI2APY3XKV/roWB/IOZhK6Qh9LDCyhPcXTsJGr54ySUA2d5+lcfIDZDxkRrdXwBZu1D17z1dmyaU77yOWmQs=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr86917918qtk.142.1564742398001;
 Fri, 02 Aug 2019 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia> <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu>
In-Reply-To: <20190801224344.GC17372@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Aug 2019 12:39:41 +0200
Message-ID: <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 12:43 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Aug 01, 2019 at 12:18:28PM -0700, Deepa Dinamani wrote:
> > > Say you have a filesystem with s_inode_size > 128 where not all of the
> > > ondisk inodes have been upgraded to i_extra_isize > 0 and therefore
> > > don't support nanoseconds or times beyond 2038.  I think this happens on
> > > ext3 filesystems that reserved extra space for inode attrs that are
> > > subsequently converted to ext4?
> >
> > I'm confused about ext3 being converted to ext4. If the converted
> > inodes have extra space, then ext4_iget() will start using the extra
> > space when it modifies the on disk inode, won't it?i
>
> It is possible that you can have an ext3 file system with (for
> example) 256 byte inodes, and all of the extra space was used for
> extended attributes, then ext4 won't have the extra space available.
> This is going toh be on an inode-by-inode basis, and if an extended
> attribute is motdified or deleted, the space would become available,t
> and then inode would start getting a higher resolution timestamp.

Is it correct to assume that this kind of file would have to be
created using the ext3.ko file system implementation that was
removed in linux-4.3, but not using ext2.ko or ext4.ko (which
would always set the extended timestamps even in "-t ext2" or
"-t ext3" mode)?

I tried to reproduce this on a modern kernel and with and
moderately old debugfs (1.42.13) but failed.

> I really don't think it's worth worrying about that, though.  It's
> highly unlikely ext3 file systems will be still be in service by the
> time it's needed in 2038.  And if so, it's highly unlikely they would
> be converted to ext4.

As the difference is easily visible even before y2038 by using
utimensat(old_inode, future_date) on a file, we should at least
decide what the sanest behavior is that we can easily implement,
and then document what is expected to happen here.

If we check for s_min_extra_isize instead of s_inode_size
to determine s_time_gran/s_time_max, we would warn
at mount time as well as and consistently truncate all
timestamps to full 32-bit seconds, regardless of whether
there is actually space or not.

Alternatively, we could warn if s_min_extra_isize is
too small, but use i_inode_size to determine
s_time_gran/s_time_max anyway.

From looking at e2fsprogs git history, I see that
s_min_extra_isize has always been set by mkfs since
2008, but I'm not sure if there would have been a
case in which it remains set but the ext3.ko would
ignore it and use that space anyway.

       Arnd

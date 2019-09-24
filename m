Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E64BD064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437174AbfIXRPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 13:15:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40231 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437098AbfIXRPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:15:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so1262802pll.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jOVfFic0aC/sB5K6AnmSRgDO07i2M/QIEQDEL1PuVhk=;
        b=x26N3942+DmdIQ1sRCqJ5F/bC1YLtOK5gp0j4tDmpD+uDTrXssvHxQG2YVcjD6HfhK
         yGEn0BAnN0cthtBy8XQxssnVwU0+80GxpDUVBft0NWqtm/3SvG9yQ/0R8otMOW1ebbPo
         KgbvajiW6NpTG/Ke9C6fDCw4dx7XBFd551aG9Nr+cFx75/J6LD9udfgGgAhG93OIQRBT
         Wvs1Y+gFMgIc+36WAO8VIxAGGxBd5RhKysLpKsKjKIxSw85jDw12ySAAfi6q7Z2Oe7Ss
         AdnWoT0zf6xW24PSiVracGyY6tJD2skJVr/01ls8Osjo2M2B7NpL6R2OIJdlvueiBe1J
         duvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOVfFic0aC/sB5K6AnmSRgDO07i2M/QIEQDEL1PuVhk=;
        b=nZc9/Xpeeexzu9fIE4mroXpy/svM56Tz56wQZ+R2bL4TBUXZVPlCk0H9vKt1ma37C5
         vm34ixA+d8hkddXMQNXpVuNoPUQ3StW73nLDel2DLWds9+KU7obocY0i/8EzYWEmnKZi
         +3a8pddw23zxAUovJ/dfTZ3/tb5SWRP2sWhyYG/CnMXaRlSoGA6fSLYsczBkD83DZmNs
         i4UEuEYSwwHNIAZQm1lwBV53JGc/Dv/8xrpQEWe08KlQb5r58uGcK4Lz0BJuFrUWmRUr
         j7D3S6XqgjSrceZSjpNpwzGjWvThfszxDbpEieeh6pENjcTo0780EdAAPNV+LEtuDfoq
         ZJEQ==
X-Gm-Message-State: APjAAAXkEEvMC1dQP/tGNJDejOrKgpnvDRScDvwe22zRzffiK53NHMkN
        6ilB97/9i4/Iz6J3EsigL/s9Cw==
X-Google-Smtp-Source: APXvYqzhc8tgADrAilSYxLfDN1ihN4fhwbQt1mfpzzPgaSyk/mADAci8CMyfKd00aTDwYc7EgZq7tg==
X-Received: by 2002:a17:902:7002:: with SMTP id y2mr4112884plk.303.1569345315655;
        Tue, 24 Sep 2019 10:15:15 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:f972])
        by smtp.gmail.com with ESMTPSA id l7sm491697pjy.12.2019.09.24.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 10:15:15 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:15:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190924171513.GA39872@vader>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > Btrfs can transparently compress data written by the user. However, we'd
> > like to add an interface to write pre-compressed data directly to the
> > filesystem. This adds support for so-called "encoded writes" via
> > pwritev2().
> >
> > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > contains metadata about the write: namely, the compression algorithm and
> > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > must be set to sizeof(struct encoded_iov), which can be used to extend
> > the interface in the future. The remaining iovecs contain the encoded
> > extent.
> >
> > A similar interface for reading encoded data can be added to preadv2()
> > in the future.
> >
> > Filesystems must indicate that they support encoded writes by setting
> > FMODE_ENCODED_IO in ->file_open().
> [...]
> > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > +                        struct iov_iter *from)
> > +{
> > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > +               return -EINVAL;
> > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > +               return -EFAULT;
> > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > +               return 0;
> > +       }
> > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > +               return -EINVAL;
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> 
> How does this capable() check interact with io_uring? Without having
> looked at this in detail, I suspect that when an encoded write is
> requested through io_uring, the capable() check might be executed on
> something like a workqueue worker thread, which is probably running
> with a full capability set.

I discussed this more with Jens. You're right, per-IO permission checks
aren't going to work. In fully-polled mode, we never get an opportunity
to check capabilities in right context. So, this will probably require a
new open flag.

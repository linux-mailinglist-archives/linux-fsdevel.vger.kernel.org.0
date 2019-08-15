Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ECE8E5CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfHOH5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:57:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39870 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOH5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:57:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so1507220qtu.6;
        Thu, 15 Aug 2019 00:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og1blWTjQbHD8z+Aa6GJsSM0EvDf+W5fF8nT8B5d5bg=;
        b=CGvye5CU7blgQva+6GTdYRDGWKAygsJVKVOPKGyXYhjPvsEkJncwtCzCAGHgFZNZqI
         seZpwaZT/GmvP75b+V9BUuz7suFpvoozamD4Focu6os8ICZKfsodyP4KIDor+piykMAY
         W4VzDkADsoWtvwprZ15853+SEpzfNKS6zhURj3Wzt6X+nx/OvKAJFdeQ8Od3ammWxiaV
         cURkXC4STeXXv5Jhs54MwUBwrivm2X8waGYN2x/lIk9095kFa96+jffYEfkUQkgBozC5
         4a9555TowHsSgma5kHtQgEAQBCKrzfSHLFQzi6qxzrqek42Rn5aiq4bVDVxpULKKGMjP
         ANBA==
X-Gm-Message-State: APjAAAVW4YasHezuoaI8DdgjSDAGKc+1C5IFdpI/OzKQWMJJmo/Q7DPk
        f/mDpkZutWY9gLVWYp+ruP8dLu52mS2y6LF6z2s=
X-Google-Smtp-Source: APXvYqwd8Z0CEHj5l9dzXypLlvuaYz5uk3nK3xCoedz6ioYtSMQQriLYP3kyev1HsvcasLudoxA0iEzxmBatKCCLNxk=
X-Received: by 2002:ac8:239d:: with SMTP id q29mr2844105qtq.304.1565855830956;
 Thu, 15 Aug 2019 00:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area> <20190815071314.GA6960@infradead.org>
In-Reply-To: <20190815071314.GA6960@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 09:56:54 +0200
Message-ID: <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:13 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 15, 2019 at 07:37:53AM +1000, Dave Chinner wrote:
> > > @@ -576,7 +576,7 @@ xfs_file_compat_ioctl(
> > >     case XFS_IOC_SCRUB_METADATA:
> > >     case XFS_IOC_BULKSTAT:
> > >     case XFS_IOC_INUMBERS:
> > > -           return xfs_file_ioctl(filp, cmd, p);
> > > +           return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
> >
> > I don't really like having to sprinkle special casts through the
> > code because of this.
>
> True.  But the proper fix is to not do the indirection through
> xfs_file_ioctl but instead to call xfs_ioc_scrub_metadata,
> xfs_ioc_bulkstat, etc directly which all take a void __user
> arguments already.

I'm not sure that's better: This would end up duplicating all
of xfs_file_ioctl(), which is already a fairly long function, compared
to the current way of having a large set of commands all handled
with a single line.

From looking at other subsystems, what I find to work best is to
move the compat handler into the same file as the native code
and then structure the files so that shared handlers get
put into one place, something like

/* these are the ones that have the same ABI for 32-bit and 64-bit tasks */
static int xfs_compatible_file_ioctl(struct file *filp, unsigned cmd,
void __user *p)
{
      int ret = -ENOIOCTLCMD;

       switch (cmd) {
       case XFS_IOC_DIOINFO:
            ...
        case ...
     }

     return ret;
}

long
xfs_file_compat_ioctl(
        struct file             *filp,
        unsigned                cmd,
        unsigned long           p)
{
       ret = xfs_compatible_file_ioctl(filp, cmd, compat_ptr(p));
       if (ret != -ENOIOCTLCMD)
              return ret;

      /* all incompatible ones below */
      switch (cmd) {
         ...
      }
}
Having them in one place makes it more obvious to readers how the
native and compat handlers fit together, and makes it easier to keep
the two in sync.

That would of course be a much larger change to how it's done today,
and it's way out of scope of what I want to achieve in my (already
too long) series.

     Arnd

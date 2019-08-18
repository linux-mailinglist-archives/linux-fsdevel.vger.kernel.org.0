Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4B91948
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRTbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 15:31:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41106 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRTbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:31:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id i4so11816098qtj.8;
        Sun, 18 Aug 2019 12:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh5jr1rScriFxNzOWMaKI7sY0Xc2P0AIAoBRXShh9Rg=;
        b=Gj6jWv4fzuKKYl1FkSbcQyrPfBe7yY1EnI0xOGXESL4nod3/DCcYFZpNwJFc0j/yh5
         s7rHOmztnhMvg4xDroVqCC1oT3nQPOLC3m7SJRwxrmusnJH3WcI90w86CX1I01yl8vCr
         HYXuXwCHn8BQY8pDGM/BSygpRPZNV7LWiQmfnuaGUj962uYOMyb/Ep7vbRvivyk6w0PO
         qTJ76w3Hd/e5VaBg0NQwDBOQ5UaMlAFDP6/hZptOgkwghDi2BfXrIVcKXkax69GJxNOj
         jz99DFjMC7NMXtA13RFk2bXoxpLjC6M6hAmZwHDIjuy5dBEdegyhwBmtIlE+ZdZTbLq2
         O7ag==
X-Gm-Message-State: APjAAAVX2cYNILOclIHD611uSNd/owHVPU7eUiBqYziQ014HKVdOt71d
        hZCAUjB1I2/mwM7N57++B/dxUyZgl9StTbMbBXk=
X-Google-Smtp-Source: APXvYqzz3AewI020l+nDXpUq+OQWStAhNnUt/bcyf6+mtzqDW/h8VdaaJlYz7EUAiQl8ug0PnJYJPjQg2gEgg+FtrXk=
X-Received: by 2002:ad4:4b0c:: with SMTP id r12mr7996213qvw.45.1566156707449;
 Sun, 18 Aug 2019 12:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
 <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 18 Aug 2019 21:31:31 +0200
Message-ID: <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 7:32 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > +       /* These are just misnamed, they actually get/put from/to user an int */
> > +       switch(cmd) {
> > +       case FS_IOC32_GETFLAGS:
> > +               cmd = FS_IOC_GETFLAGS;
> > +               break;
> > +       case FS_IOC32_SETFLAGS:
> > +               cmd = FS_IOC_SETFLAGS;
> > +               break;
>
> I'd like the code to be more explicit here:
>
>         case FITRIM:
>         case FS_IOC_GETFSLABEL:
>               break;
>         default:
>               return -ENOIOCTLCMD;

I've looked at it again: if we do this, the function actually becomes
longer than
the native gfs2_ioctl(). Should we just make a full copy then?

static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd,
unsigned long arg)
{
        switch(cmd) {
        case FS_IOC32_GETFLAGS:
                return gfs2_get_flags(filp, (u32 __user *)arg);
        case FS_IOC32_SETFLAGS:
                return gfs2_set_flags(filp, (u32 __user *)arg);
        case FITRIM:
                return gfs2_fitrim(filp, (void __user *)arg);
        case FS_IOC_GETFSLABEL:
                return gfs2_getlabel(filp, (char __user *)arg);
        }

        return -ENOTTY;
}

> Should we feed this through the gfs2 tree?

A later patch that removes the FITRIM handling from fs/compat_ioctl.c
depends on it, so I'd like to keep everything together.

         Arnd

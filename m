Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEEE8E4F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfHOGnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 02:43:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33776 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHOGnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:43:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so1419531qtb.0;
        Wed, 14 Aug 2019 23:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moCscXF3FHERLCOXUMQFLafbhkiilN7j/QojfjTcev0=;
        b=Mpg/nw09+iiBoGaVQHuX/TH+bsh9jMNc3TrlZtAK/A3ldZkMlxFOfcZ7MuF9EHfqsn
         ybtKSCxvGQaghw1Za4GFMSVIwvTFBeC7fkWExage8MdbEQMaoJBfGWC9xcluMSomJo4a
         hNFgmq3VIWTu7RDPJD4ZUF6TzjMEZ7PsKR7GeEi1GU0RX7AGOH9Uk3gMlM7J783oHqAn
         EJruYEn6D6IlQVSoaOmwYwmdeawzq5igRyDbuDfXiC5p0ZbLKFqoep3+5FSdSNBf0YZk
         2x4S4vmDtrlSA7yZvyXDFazIxWkpPdfwNFiQuZWUVcfSUnQrA7JCmBjMkWy9rvotQpL0
         /tuA==
X-Gm-Message-State: APjAAAX2wWCRBrOJ5zvKWTnxOC9Q+xAAABg7xL1yqpEXgcWLjnWo2rfi
        nU+Bbywk+UKB5B95rAl8Ppl/PG6dRSRY1QTLtNHwXq63wlQ=
X-Google-Smtp-Source: APXvYqyxkg6GiBut6x07Qhx3vf49GcGn8k9G4seM+8Ayfv3Fo29FzJIUow0/Va2HT9tK164KhkeoqRKDVSGuM24oHVs=
X-Received: by 2002:ac8:239d:: with SMTP id q29mr2675174qtq.304.1565851419870;
 Wed, 14 Aug 2019 23:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
In-Reply-To: <20190814213753.GP6129@dread.disaster.area>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 08:43:24 +0200
Message-ID: <CAK8P3a0CAAtxXcfYt8NwmNSmF5tWhSSihLBkOtuQ62onjst4sA@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Wed, Aug 14, 2019 at 11:39 PM Dave Chinner <david@fromorbit.com> wrote:
> >       case XFS_IOC_BULKSTAT:
> >       case XFS_IOC_INUMBERS:
> > -             return xfs_file_ioctl(filp, cmd, p);
> > +             return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
>
> I don't really like having to sprinkle special casts through the
> code because of this.
>
> Perhaps do something like:
>
> static inline unsigned long compat_ptr_mask(unsigned long p)
> {
>         return (unsigned long)compat_ptr(p);
> }
>
> and then up front you can do:
>
>         void    __user *arg;
>
>         p = compat_ptr_mask(p);
>         arg = (void __user *)p;
>
>
> and then the rest of the code remains unchanged by now uses p
> correctly instead of having to change all the code to cast arg back
> to an unsigned long...
>

In part 1 of the series, I define this function as a global:

long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
        if (!file->f_op->unlocked_ioctl)
                return -ENOIOCTLCMD;

        return file->f_op->unlocked_ioctl(file, cmd, (unsigned
long)compat_ptr(arg));
}

How about using that to replace the individual casts:

-       return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
+      return compat_ptr_ioctl(filp, cmd, arg);

It adds another indirection, but it avoids all the casts and
uses existing mechanism.

     Arnd

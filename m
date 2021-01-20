Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D92FD3F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 16:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbhATP1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 10:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhATP1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:27:14 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 07:24:51 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a31so7975678uae.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9AhbQndRfZbf8+inSjYiPzYEQG5Tzotcb5GyJPqrsQ=;
        b=a1IJRpLPFEAaL/36w5k+jDqO0JMDyVXka/swD+xJTRD1vSGoLJXBTPELwSMNS8S5/R
         mjzyWgFHubPlIrTDmjrYGDNw3BWd18MI4YUSADxq1B2cP15skdKodsSP5rIBN16W9sfI
         j/l/Qja3RuLJ2PbJO5XyhqLyDPZam005oDtyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9AhbQndRfZbf8+inSjYiPzYEQG5Tzotcb5GyJPqrsQ=;
        b=LmeeJoqIp5qsZlN6/QlSIanS8MyTirZ7kOUFN7wzKEDwW2krPjNOfZ90kaw9Vx37dr
         iSZHRFnPUAwLOAL5zsUFv33t+IxGFOFjFLzOZAm/E9FBg2uRurzEiWbECZRM5OH+ms/J
         QpTXkyoC5I8O+e+9OboPyejcJgMzwIYDkxyMmjdlsQ4IzXqMk7Pcsv5+ANEY4rWB0TeE
         wJ89iwWpJ3ktFTIGmaMAVVPOPRnFL8tSaQzPZSj3nvNHEfmc3W++WLnG/KWpscpPTER6
         JwKwVCLvKi5kDy2Lwa6bLZ5d/cV/tQr1tEI7s8gVlYGcg/HcUBJruXNGjld9KHN0ccu2
         qefg==
X-Gm-Message-State: AOAM532YHeoYmEWZ4mBlqydmXwmfjteK3G1uy8/381Ehf8yH9ddhwo3h
        DxssziYzDaxNCjCRUeNkYkIb+Vnn4+7vIiqMtfAeDo67ejs=
X-Google-Smtp-Source: ABdhPJz+0N8vxcgUurzvtB8gMxTtpNBmZYEUEOt2+mIekPODulMfmcGS4IQcK2LX/IujOoEuAzvanPDS7TzolF9GHdo=
X-Received: by 2002:ab0:7296:: with SMTP id w22mr6591371uao.13.1611156290980;
 Wed, 20 Jan 2021 07:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20201130030039.596801-1-sargun@sargun.me> <CAMp4zn-c6gOPTPBqqkPoQi3NVeZ0yW-WfVPFzpDiazj8PeUgBw@mail.gmail.com>
 <CAOQ4uxhU=eWAfTn8DJ7x4NZ2PO9Q9V7Ohpj9aTasXg3KcfFpMA@mail.gmail.com> <CAMp4zn9sdpk1A1hYpDjS_774UscYZ1sztCsLdfshs=pXEYf0NQ@mail.gmail.com>
In-Reply-To: <CAMp4zn9sdpk1A1hYpDjS_774UscYZ1sztCsLdfshs=pXEYf0NQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 16:24:40 +0100
Message-ID: <CAJfpeguLFoLD8BYuNAAwV+F0583aujNBqto3QnFjeV+z4LszDA@mail.gmail.com>
Subject: Re: [PATCH] overlay: Plumb through flush method
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 7:32 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Thu, Dec 3, 2020 at 2:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 12:16 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > >
> > > On Sun, Nov 29, 2020 at 7:00 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > > >
> > > > Filesystems can implement their own flush method that release
> > > > resources, or manipulate caches. Currently if one of these
> > > > filesystems is used with overlayfs, the flush method is not called.
> > > >
> > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Cc: linux-unionfs@vger.kernel.org
> > > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/overlayfs/file.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > index efccb7c1f9bc..802259f33c28 100644
> > > > --- a/fs/overlayfs/file.c
> > > > +++ b/fs/overlayfs/file.c
> > > > @@ -787,6 +787,16 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
> > > >                             remap_flags, op);
> > > >  }
> > > >
> > > > +static int ovl_flush(struct file *file, fl_owner_t id)
> > > > +{
> > > > +       struct file *realfile = file->private_data;
> > > > +
> > > > +       if (realfile->f_op->flush)
> > > > +               return realfile->f_op->flush(realfile, id);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  const struct file_operations ovl_file_operations = {
> > > >         .open           = ovl_open,
> > > >         .release        = ovl_release,
> > > > @@ -798,6 +808,7 @@ const struct file_operations ovl_file_operations = {
> > > >         .fallocate      = ovl_fallocate,
> > > >         .fadvise        = ovl_fadvise,
> > > >         .unlocked_ioctl = ovl_ioctl,
> > > > +       .flush          = ovl_flush,
> > > >  #ifdef CONFIG_COMPAT
> > > >         .compat_ioctl   = ovl_compat_ioctl,
> > > >  #endif
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Amir, Miklos,
> > > Is this acceptable? I discovered this being a problem when we had the discussion
> > > of whether the volatile fs should return an error on close on dirty files.
> >
> > Yes, looks ok.
> > Maybe we want to check if the realfile is upper although
> > maybe flush can release resources also on read only fs?
> >
> > >
> > > It seems like it would be useful if anyone uses NFS, or CIFS as an upperdir.
> >
> > They are not supported as upperdir. only FUSE is.
> >
> > Thanks,
> > Amir.
>
> VFS does it on read-only files / mounts, so we should probably do the
> same thing.

Right, but it should handle files copied up after the oipen (i.e. call
ovl_real_fdget() to get the real file).

Thanks,
Miklos

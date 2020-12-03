Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F32CD3B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgLCKd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgLCKd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:33:26 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C90EC061A4E;
        Thu,  3 Dec 2020 02:32:40 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id k8so1425955ilr.4;
        Thu, 03 Dec 2020 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYI2zoFscPNYwdqUfecEz5f5sOyCvl9o34HEnn5Rf3U=;
        b=oIwv4QD3yJHW8TdAZWpaMLDQkb94MnldcdckScrBqq3cgjfpeU9a4ZmDPHJTWTc0ug
         Vfj6L3TW/YUjaoXM70iehV91V3Gc+Si6bxvcJ6g3iJreIdhcD2EorvW9CK2woMJ/yOTl
         cbETGZBA4hWITaSOdu+6u5IKHCsfDEXiXoRxcNyIJ3pWdMxAs9krD4Yr0nKEmSHoSAYH
         HVblu6tp/ODkjxBYBn9bS0nPiNz+1Slh2p8o9YhivgXzp4MIkBU4cUiiRp3x4cdk+s77
         88VNUA6TLx35F76P10LFTBLvcZsK3lr+jHNzTEYK4AlgJnwAVjPuqcKWLAl+vvugkRO7
         Zhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYI2zoFscPNYwdqUfecEz5f5sOyCvl9o34HEnn5Rf3U=;
        b=UStLFOYoMrsNu49e1zuB5vsBFcT9dqklR+pq4B8879THjNy/8qUDZQVVOZZ30m2XCi
         2tO1xzv9kAvrWA9rgIVN0wpntoIJCQry94bB4Wy+zUI/RMP/MUxEfzE7knUSCWsJz1nc
         pY+R6mxi9W1/VKo/EP6pjyYUZ9nQxED3gMQ+9EFvVSCRe2o0uH0TmzAXOEBsI9newzQD
         5dos/q9QXxAn9lC4RaUHycTtd+q1FJoYRppwfejj49Yygeu95xWQVSNIUYVROxUgyfd+
         9m+dPaiJ5XgCeYSrwOxHvApTeUd36pwNKffIgKYDPMmwmiGN7OVHeSMyYnsxngJSE7EX
         yOZw==
X-Gm-Message-State: AOAM530UJPls1B/4fyvq/7fjYu+9Xk6ydTHHXp8Ib380/xF/ojRTsjkY
        /qC2waSF6pumcJ0bnsXm5hc+20WwRJ487ZJR9tA4pUjk
X-Google-Smtp-Source: ABdhPJyAdaiH1Sx9X1F/C3Zvd+PIkMNUCIgc1JeAi/+00tBLfkkYWAKtp91FibKYaChn81+Jae1UKQxJfSF+u01+W1U=
X-Received: by 2002:a92:da82:: with SMTP id u2mr2379761iln.137.1606991559719;
 Thu, 03 Dec 2020 02:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20201130030039.596801-1-sargun@sargun.me> <CAMp4zn-c6gOPTPBqqkPoQi3NVeZ0yW-WfVPFzpDiazj8PeUgBw@mail.gmail.com>
In-Reply-To: <CAMp4zn-c6gOPTPBqqkPoQi3NVeZ0yW-WfVPFzpDiazj8PeUgBw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 12:32:28 +0200
Message-ID: <CAOQ4uxhU=eWAfTn8DJ7x4NZ2PO9Q9V7Ohpj9aTasXg3KcfFpMA@mail.gmail.com>
Subject: Re: [PATCH] overlay: Plumb through flush method
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 12:16 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Sun, Nov 29, 2020 at 7:00 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > Filesystems can implement their own flush method that release
> > resources, or manipulate caches. Currently if one of these
> > filesystems is used with overlayfs, the flush method is not called.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/overlayfs/file.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index efccb7c1f9bc..802259f33c28 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -787,6 +787,16 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
> >                             remap_flags, op);
> >  }
> >
> > +static int ovl_flush(struct file *file, fl_owner_t id)
> > +{
> > +       struct file *realfile = file->private_data;
> > +
> > +       if (realfile->f_op->flush)
> > +               return realfile->f_op->flush(realfile, id);
> > +
> > +       return 0;
> > +}
> > +
> >  const struct file_operations ovl_file_operations = {
> >         .open           = ovl_open,
> >         .release        = ovl_release,
> > @@ -798,6 +808,7 @@ const struct file_operations ovl_file_operations = {
> >         .fallocate      = ovl_fallocate,
> >         .fadvise        = ovl_fadvise,
> >         .unlocked_ioctl = ovl_ioctl,
> > +       .flush          = ovl_flush,
> >  #ifdef CONFIG_COMPAT
> >         .compat_ioctl   = ovl_compat_ioctl,
> >  #endif
> > --
> > 2.25.1
> >
>
> Amir, Miklos,
> Is this acceptable? I discovered this being a problem when we had the discussion
> of whether the volatile fs should return an error on close on dirty files.

Yes, looks ok.
Maybe we want to check if the realfile is upper although
maybe flush can release resources also on read only fs?

>
> It seems like it would be useful if anyone uses NFS, or CIFS as an upperdir.

They are not supported as upperdir. only FUSE is.

Thanks,
Amir.

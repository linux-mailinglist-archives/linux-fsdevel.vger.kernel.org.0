Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2340329D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 04:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbhIHC0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347285AbhIHC0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:26:45 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496AC061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 19:25:38 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id t26so464800uao.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 19:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEy5nO6osutxEv/TrODavbWwjCHA2MvpQP/DDDhYQVw=;
        b=hFKJwwawmYO2uEAQXafr9BxOCZsN1F92guZEBXscXHfqz36zw3dv9IPlyq13dIr2FR
         89Gd76MZwPMCqToeu13OYApauUeNR4rIZcP820DxbdEMDUtKQPteBEvuDbnDXL0LpYl6
         u319/3WhQ0BLaxDuoH6GwcECnbM3v0i1ECSnezzW79/ntwgugjRFz+IFgMBhetHZrQpi
         tt55ACpZSMcuFKknDzn42iDrSaKFQVRWLe11rQJimV50AfY8ygGzAVIQdp9WmsHxWrQl
         5IK97HnlnArFuVtejsR6U4Bkd0isUchEpt4VdjzXiPkf7H9RZgpmnY1I3PWQbN3fLHO1
         oYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEy5nO6osutxEv/TrODavbWwjCHA2MvpQP/DDDhYQVw=;
        b=FbXBGKLt3/ANu6bZMswYcCv9nqIoD1KGSoKJffBceo9+wNh5cFcvZPQ7cKwPvTLcWB
         VlpdN8A5cIjcMYnOETEOUOPywnTpgsX8oNeomPXqAVVZEOgythVJVNiWYjYoHtr6VQEi
         UUWdlVx9fR19ofKR8ahiczO4bIcL3z1jyDadTtqARqsdQPuqt6WAQht6GGZQCNVZ1vS2
         CuaT1ykgUBabJ6E+r/TbLh3Y5Q6eod8iW+OFm/deanCtF2YGhcRmCxLaxFnBwPSOxU8Q
         gZyEAlXipWQNelcWT72I0IbU0kSB97Q5xqy/W/Hq9USNU6q0RD/uv6sTH8HpqPx0W56K
         LyLw==
X-Gm-Message-State: AOAM532/kY7GGXknJtHnsWu2HClz2dgG5UwoCJZxvum32HnhbQ+4otTa
        aINXCoexJfCTaO6fUxlE7tG6JJnXyrHkERCViioVaX1mPzrelA==
X-Google-Smtp-Source: ABdhPJyRdKmTMqSLvN3NMnJTaEgE2lHWBVCiZH3Fb+waXzhkpVcCBqIND+z9es+rwUipUz10k5VItnXOaXtS7xHfHQ4=
X-Received: by 2002:ab0:2755:: with SMTP id c21mr886577uap.68.1631067937831;
 Tue, 07 Sep 2021 19:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
In-Reply-To: <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 8 Sep 2021 10:25:10 +0800
Message-ID: <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > For a simple read-only file system, as long as the connection
> > is not broken, the recovery of the user-mode read-only file
> > system can be realized by putting the request of the processing
> > list back into the pending list.
>
> Thanks for the patch.
>
> Do you have example userspace code for this?
>
Under development. When the fuse user-mode file system process is abnormal,
the process does not terminate (/dev/fuse will not be closed), enter
the reset procedure,
and will not open /dev/fuse again during the reinitialization.
Of course, this can only solve part of the abnormal problem.

> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  fs/fuse/dev.c             | 38 +++++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/fuse.h |  1 +
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 491c092d427b..8e1b69a5b503 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2239,7 +2239,7 @@ static int fuse_device_clone(struct fuse_conn
> > *fc, struct file *new)
> >  static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
> >                            unsigned long arg)
> >  {
> > -       int res;
> > +       int res = 0;
> >         int oldfd;
> >         struct fuse_dev *fud = NULL;
> >
> > @@ -2268,6 +2268,42 @@ static long fuse_dev_ioctl(struct file *file,
> > unsigned int cmd,
> >                         }
> >                 }
> >                 break;
> > +
> > +       case FUSE_DEV_IOC_RECOVERY:
> > +       {
> > +               struct fuse_iqueue *fiq;
> > +               struct fuse_pqueue *fpq;
> > +               struct fuse_req *req, *next;
> > +               LIST_HEAD(recovery);
> > +               unsigned int i;
> > +
> > +               fud = fuse_get_dev(file);
> > +               fiq = &fud->fc->iq;
> > +               fpq = &fud->pq;
> > +
> > +               spin_lock(&fpq->lock);
> > +               list_for_each_entry_safe(req, next, &fpq->io, list) {
> > +                       spin_lock(&req->waitq.lock);
> > +                       clear_bit(FR_LOCKED, &req->flags);
> > +                       list_move(&req->list, &recovery);
> > +                       spin_unlock(&req->waitq.lock);
> > +               }
>
> I don't get it.  Recovery means the previous server process is dead.
> If there are requests on the fpq->io queue, than that's obviously not
> true and having two processes messing with the same requests isn't
> going to do any good.
>
> So I suggest just erroring out if fpq->io is not empty.
I will modify it in the next version.
>
>
> > +               for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> > +                       list_splice_tail_init(&fpq->processing[i],
> > +                                             &recovery);
> > +               list_for_each_entry_safe(req, next, &recovery, list) {
> > +                       clear_bit(FR_SENT, &req->flags);
> > +               }
> > +               spin_unlock(&fpq->lock);
> > +
> > +               spin_lock(&fiq->lock);
> > +               list_for_each_entry_safe(req, next, &recovery, list) {
> > +                       set_bit(FR_PENDING, &req->flags);
> > +               }
> > +               list_splice(&recovery, &fiq->pending);
> > +               spin_unlock(&fiq->lock);
> > +               break;
> > +       }
> >         default:
> >                 res = -ENOTTY;
> >                 break;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 36ed092227fa..fc07324efa9d 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -923,6 +923,7 @@ struct fuse_notify_retrieve_in {
> >  /* Device ioctls: */
> >  #define FUSE_DEV_IOC_MAGIC             229
> >  #define FUSE_DEV_IOC_CLONE             _IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
> > +#define FUSE_DEV_IOC_RECOVERY          _IOR(FUSE_DEV_IOC_MAGIC+1, 0, uint32_t)
> >
> >  struct fuse_lseek_in {
> >         uint64_t        fh;
> > --
> > 2.27.0

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4742340263D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhIGJfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIGJft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:35:49 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C433C061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 02:34:43 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id j31so5221281uad.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm0clPQJxrIuFgWEy9b8Jwx5gtGqw6MqiZjgE10G3pw=;
        b=WtPFd/vxAsJU5yAcSlwfvM99LL2RqTBjBBjVJ0RJXhKD1Yk0G7t6zsJd55wHEcFmhv
         8hyG0NSCAtVEns7NscdyVDyHHO8h4DF9mLc9VUjjJGX+OdthhNpDM49hj883ejxIfGjJ
         LzPw5V86DukYD1UMa91TtxyW8ycnQ+/G3lnIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm0clPQJxrIuFgWEy9b8Jwx5gtGqw6MqiZjgE10G3pw=;
        b=t2cOPoE9gShUyfcA1Rh3qihFMyLN8dQsAgkaN7GIzZy8GsxN5aNR00OcsbLTQEhhlQ
         lIm5wnN2N0aiHbdr8fzrjuq1mAJJG2D2zlV6tqxTZPSDJCklPULSK+GiBDwpftbYDzoG
         VS4tabRytcfppCJX+vsMjtXhMJiU8tvohCNY6ODzpxoYiTkXlnGVSFlw20h68q93udgR
         3xcNnRk+I2dl8WEdhdnoHqjZm47tt5Z1B5G0kc74XWnL/dNeb2tpf6Eq59+vgkKcbvH4
         RoQX/SM5FQ+7SEOwix9NI55+wl0vAK21DySE9QNw0hdbX0XlG+tsiCwN2Z2yTc0QjFoT
         Gn9w==
X-Gm-Message-State: AOAM533XxfH8W68aXS8pTA9lSR28ZDMS/vf0KPbn4jIMrNrr/FE5C/a8
        r69+btNr80KD0vJMktnKcZn0UBkNoQSZhOHH1cY1dA==
X-Google-Smtp-Source: ABdhPJxXNr8F9bGKhAXlDx7Z9qTRdOGjJBioZo7phbXJOtSbp/HepfrFmrOhcvYDY0ZPDasvG2wfDcXeInm5CdORHa4=
X-Received: by 2002:a05:6130:30a:: with SMTP id ay10mr7990835uab.8.1631007282385;
 Tue, 07 Sep 2021 02:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
In-Reply-To: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 11:34:31 +0200
Message-ID: <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> For a simple read-only file system, as long as the connection
> is not broken, the recovery of the user-mode read-only file
> system can be realized by putting the request of the processing
> list back into the pending list.

Thanks for the patch.

Do you have example userspace code for this?

>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  fs/fuse/dev.c             | 38 +++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fuse.h |  1 +
>  2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 491c092d427b..8e1b69a5b503 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2239,7 +2239,7 @@ static int fuse_device_clone(struct fuse_conn
> *fc, struct file *new)
>  static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>                            unsigned long arg)
>  {
> -       int res;
> +       int res = 0;
>         int oldfd;
>         struct fuse_dev *fud = NULL;
>
> @@ -2268,6 +2268,42 @@ static long fuse_dev_ioctl(struct file *file,
> unsigned int cmd,
>                         }
>                 }
>                 break;
> +
> +       case FUSE_DEV_IOC_RECOVERY:
> +       {
> +               struct fuse_iqueue *fiq;
> +               struct fuse_pqueue *fpq;
> +               struct fuse_req *req, *next;
> +               LIST_HEAD(recovery);
> +               unsigned int i;
> +
> +               fud = fuse_get_dev(file);
> +               fiq = &fud->fc->iq;
> +               fpq = &fud->pq;
> +
> +               spin_lock(&fpq->lock);
> +               list_for_each_entry_safe(req, next, &fpq->io, list) {
> +                       spin_lock(&req->waitq.lock);
> +                       clear_bit(FR_LOCKED, &req->flags);
> +                       list_move(&req->list, &recovery);
> +                       spin_unlock(&req->waitq.lock);
> +               }

I don't get it.  Recovery means the previous server process is dead.
If there are requests on the fpq->io queue, than that's obviously not
true and having two processes messing with the same requests isn't
going to do any good.

So I suggest just erroring out if fpq->io is not empty.


> +               for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> +                       list_splice_tail_init(&fpq->processing[i],
> +                                             &recovery);
> +               list_for_each_entry_safe(req, next, &recovery, list) {
> +                       clear_bit(FR_SENT, &req->flags);
> +               }
> +               spin_unlock(&fpq->lock);
> +
> +               spin_lock(&fiq->lock);
> +               list_for_each_entry_safe(req, next, &recovery, list) {
> +                       set_bit(FR_PENDING, &req->flags);
> +               }
> +               list_splice(&recovery, &fiq->pending);
> +               spin_unlock(&fiq->lock);
> +               break;
> +       }
>         default:
>                 res = -ENOTTY;
>                 break;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..fc07324efa9d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -923,6 +923,7 @@ struct fuse_notify_retrieve_in {
>  /* Device ioctls: */
>  #define FUSE_DEV_IOC_MAGIC             229
>  #define FUSE_DEV_IOC_CLONE             _IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
> +#define FUSE_DEV_IOC_RECOVERY          _IOR(FUSE_DEV_IOC_MAGIC+1, 0, uint32_t)
>
>  struct fuse_lseek_in {
>         uint64_t        fh;
> --
> 2.27.0

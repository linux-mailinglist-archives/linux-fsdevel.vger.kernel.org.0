Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF57AD646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjIYKnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjIYKnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:43:39 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE2E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 03:43:32 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ab8265b797so1262094241.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695638611; x=1696243411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5a51Iajf1wruN3JYLPZKeAIvbjFdiPifrK7dTJkZKE=;
        b=BeutJjfAeNd6l+LNExuPb3Din70PJFPU/6BJl3s8YJUn9KZoVKPFbMZPQ2zFbHOals
         nQEUMshbvtM8/oaA3GMZa5SMJInGxY3CPD4L+eTL5n/5V6VLK1kWA3N4YdmT1/kbKDrJ
         d+7wmS/p73FakT/tYFlepHViN3LsYzXBxR0BzzRW2/+rBDPKrgo7nY/Qjz2ireaY7d6s
         XMqFc089/Zyc9gxn2kdArsRO2lQmJb9WWGDKOeQScO+NmQ1v9bm/82ti2aYepFDKfR4N
         +MvcayQxK9G65DsoXVpBfhU7ZkCf7hK9pXppXUQShfsbCQbgfs+W87z1OVh7Eb8AoCRb
         GwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638611; x=1696243411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5a51Iajf1wruN3JYLPZKeAIvbjFdiPifrK7dTJkZKE=;
        b=Dk+wkXEVbiji4a25GXUM+urLxGsJAaclm61ISYfnNeJmyB+oSnvOFx5e+gqTx10BKK
         LTPDhkSpkzB8tG1Drzt/hMcHfND8+D76MhVebvD/cSC9Km8N4PiXLgsS/ehRJwvvi79q
         d4g3F7s3QVXNHEu06VgN3q6eQgv/xYWTTf7bMU5eUhdRgyXnCAFpfDnzI5HgRruFbK9S
         8MozB7CY8Pamy0Sf3aikxItOFj2r3IpUpJvRu0BelqTuMm27zolp2Yj+R8NjqT2/wyNe
         Za3sSPOzKRg85J61C7v4wE4YXTOs1zqkAyHnWcDuDDey9OEbwMLmTxJaPnQD4H+YCx3d
         6ryw==
X-Gm-Message-State: AOJu0YxfoC8jf5hpTnbtSD8vu0yGSqa6F1e9dlqPvaRczBF8a1/OQaCB
        3HZLV3oZ20sf5laK0ZZcCHtwES4bozaFbhJUcSk=
X-Google-Smtp-Source: AGHT+IHbjFIjy/yjSlLsDJ+AWfe1c6zVExPd8oD5PHnB/6U6D8fnVYgQQbAYIA/xOQ/mRAoxohwc0nAVvAzg8DkVxzk=
X-Received: by 2002:a05:6102:3c3:b0:44e:a216:59a6 with SMTP id
 n3-20020a05610203c300b0044ea21659a6mr2930152vsq.4.1695638611387; Mon, 25 Sep
 2023 03:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-9-amir73il@gmail.com>
 <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
In-Reply-To: <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Sep 2023 13:43:20 +0300
Message-ID: <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com>
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
To:     Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:41=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> On Fri, May 19, 2023 at 8:59=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Similar to update size/mtime at the end of fuse_perform_write(),
> > we need to bump the attr version when we update the inode size.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fuse/passthrough.c | 53 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 42 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index 10b370bcc423..8352d6b91e0e 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -14,15 +14,42 @@ struct fuse_aio_req {
> >         struct kiocb *iocb_fuse;
> >  };
> >
> > -static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
> > +static void fuse_file_start_write(struct file *fuse_file,
> > +                                 struct file *backing_file,
> > +                                 loff_t pos, size_t count)
> > +{
> > +       struct inode *inode =3D file_inode(fuse_file);
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +
> > +       if (inode->i_size < pos + count)
> > +               set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> > +
> > +       file_start_write(backing_file);
> > +}
> > +
> > +static void fuse_file_end_write(struct file *fuse_file,
> > +                               struct file *backing_file,
> > +                               loff_t pos, ssize_t res)
> > +{
> > +       struct inode *inode =3D file_inode(fuse_file);
> > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > +
> > +       file_end_write(backing_file);
> > +
> > +       fuse_write_update_attr(inode, pos, res);
>
> Hi Amir,
> This function(fuse_file_end_write) will execute in interrupt context, but
> fuse_write_update_attr() uses fuse_inode->lock, this will cause soft lock=
up.
>
> So we may have to change all the fuse_inode->lock usage to fixup this bug=
, but
> I think this is one ugly resolution.
>
> Or why should we do aio_clearup_handler()? What is the difference between
> fuse_passthrough_write_iter() with ovl_write_iter()?
>

[CC Jens and Christian]

Heh, very good question.
Does this answer your question:

https://lore.kernel.org/linux-unionfs/20230912173653.3317828-2-amir73il@gma=
il.com/

I queued this patch to overlayfs for 6.7, because I think overlayfs
has a bug that can manifest with concurrent aio completions.

For people who just joined, this is a patch review of the
FUSE passthrough feature, which is expected to share the
common "kiocb_clone" io passthrough helpers with overlayfs.

Jens,

Are there any IOCB flags that overlayfs (or backing_aio) need
to set or clear, besides IOCB_DIO_CALLER_COMP, that
would prevent calling completion from interrupt context?

Or is the proper way to deal with this is to defer completion
to workqueue in the common backing_aio helpers that
I am re-factoring from overlayfs?

IIUC, that could also help overlayfs support
IOCB_DIO_CALLER_COMP?

Is my understanding correct?

Thanks,
Amir.

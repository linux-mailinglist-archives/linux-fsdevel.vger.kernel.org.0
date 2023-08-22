Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23827845A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 17:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjHVPdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHVPdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:33:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2127C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:33:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-997c4107d62so614840966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692718395; x=1693323195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AV/DzGzP7RnVI7ppwQ8956Y2hhXavtARX08mNEPb7wI=;
        b=WrPHQbzsZ7msGmO1hMMLGf87ACdGZnT8qRMal4ioRCBR2QPgVk/uiOO9uTk3S040oG
         bR2leLLUbYq50b1GbrfObI1p2fd/q64om59Uoc1JAXPqv76eRmY3IJbUcIX2JEhggGrE
         OePCtGzFgyGcdOVMDVl5eBqe9vrGlPI1ZOg1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718395; x=1693323195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV/DzGzP7RnVI7ppwQ8956Y2hhXavtARX08mNEPb7wI=;
        b=GAnRHcTp6XFohF4gw/JOaxTdmPpOkVf/UKRjOGKqOsMQNkjbYI3W08YdFVR8x1cJWf
         EMslXklWH1+PrCLyRGLqZGLt4Y6rue1wMtTyub69s+zEKuAS0XO2hQb5GPWn1IsM3X+p
         aZ/NTpzPoEafHXx6D7K7t13iVp10TtiKNxz+hqXOi/QfLsZtBESTOw0JlNhSvYBfzE/Y
         67rvgZXF7bp/6MkUU1ak7X6B1k4Su8GXLkgkgB6QKIxCyn9QlrKqdHahTzdLpLX4Wlnv
         Tau/FW2OP3HkzH/pZsenDca/k2/irt3svYgvvZaoWDqHEp11+UUUVktqfqMmFJ5rK4C5
         36EQ==
X-Gm-Message-State: AOJu0Yx0HoTYKX891tKZ/W4uemrbgzxXzjTkweQWQDlb+U4gLjMB2TmQ
        wUHTIH8/uJRHh5BmPQLMkwm+uflxluRG2qzzTFbM9w==
X-Google-Smtp-Source: AGHT+IFsyOoXVf38AR9cN1aOND0r13XBs+C16VAXVJP0H/KovomiTeEVbA0Q4PVmh7Pch2rQ9VUmeqk0L+Q2giEZ5SY=
X-Received: by 2002:a17:906:10d6:b0:99b:cf0c:2cb1 with SMTP id
 v22-20020a17090610d600b0099bcf0c2cb1mr8242815ejv.66.1692718395158; Tue, 22
 Aug 2023 08:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230810105501.1418427-1-mszeredi@redhat.com> <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
In-Reply-To: <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Aug 2023 17:33:03 +0200
Message-ID: <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: implement statx
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> Hi Miklos,
>
> sorry for late review.
>
> On 8/10/23 12:55, Miklos Szeredi wrote:
> [...]
> > +static int fuse_do_statx(struct inode *inode, struct file *file,
> > +                      struct kstat *stat)
> > +{
> > +     int err;
> > +     struct fuse_attr attr;
> > +     struct fuse_statx *sx;
> > +     struct fuse_statx_in inarg;
> > +     struct fuse_statx_out outarg;
> > +     struct fuse_mount *fm = get_fuse_mount(inode);
> > +     u64 attr_version = fuse_get_attr_version(fm->fc);
> > +     FUSE_ARGS(args);
> > +
> > +     memset(&inarg, 0, sizeof(inarg));
> > +     memset(&outarg, 0, sizeof(outarg));
> > +     /* Directories have separate file-handle space */
> > +     if (file && S_ISREG(inode->i_mode)) {
> > +             struct fuse_file *ff = file->private_data;
> > +
> > +             inarg.getattr_flags |= FUSE_GETATTR_FH;
> > +             inarg.fh = ff->fh;
> > +     }
> > +     /* For now leave sync hints as the default, request all stats. */
> > +     inarg.sx_flags = 0;
> > +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
>
>
>
> What is actually the reason not to pass through flags from
> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
> required mask and then server side can decide if it wants to fill in more?

This and following commit is about btime and btime only.  It's about
adding just this single attribute, otherwise the logic is unchanged.

But the flexibility is there in the interface definition, and
functionality can be added later.

Thanks,
Miklos

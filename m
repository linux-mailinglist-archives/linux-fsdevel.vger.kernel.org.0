Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91C785B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjHWO60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbjHWO6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:58:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9D10C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 07:58:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so1170695866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692802696; x=1693407496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4oSIBed+jjCNrQbmU/CpFlKKIRE7wrO9F7MxuI+xRM=;
        b=h6EOAV+JmytBWNbV7Idq7zpmh+kJj8t74RbzfZPWSd+1mPdwNBmaE1IuJZCb4Ld/rQ
         8tOjZ/5G+EBPgpx3iiwa825JuGweP8353JEzhu/ZjPXE+soTf08+FY5gj/eC8AKCwXaP
         S0rbay+MpffAJLgUjCDdwF8tFyseTaIpe5R+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802696; x=1693407496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4oSIBed+jjCNrQbmU/CpFlKKIRE7wrO9F7MxuI+xRM=;
        b=MmY1jYFvkl1iPdStPOffcWJ5IsnnzcIxY/9YWwyKpSP56MtNnBP6GCnuU9ImIYxHZK
         APVcICaAttSkl7ViQwL7iAIUFZhP7fndVGeptXtoqBCabx5rJKWPcGOVentWR4rVhiRe
         JFzg3x0qfI/0KisYn43BOH73C9vwM9lqTW519i0rKf3K1iaKjKgS9ZKjIiCfCRNXNb6C
         ldqeKkt/Bipz8sNRl2ZX5aV60lnVSu4gFXOT3WSEeJ5vQVsyllskvWx0Dvrp1TV7Mq6G
         r9uJGxkfjIXBBtRdGPA8Z3aqnWQekVavcCT373IeP3hgVHBOJQn6b44cQGmb7rdbvy1M
         WiMQ==
X-Gm-Message-State: AOJu0Yx2BJ3SAHBAb92xfzbnDyNuzh78w+eUQwoFxCUC7Ob4wMs0Z/1e
        qE4Y9XDLr7/fbLxPfMLLIP8I9EuaNgekw3jX4IlXXQ==
X-Google-Smtp-Source: AGHT+IHUoFaurk3Q19zOW9oIf15Xd3O9v8+HhlUQYFeEfLj7GXcnM8Vzo7p5cTZ6iolhhAJ2pdR2hJmEl6ia23+n/Rc=
X-Received: by 2002:a17:907:2ccd:b0:9a1:be5b:f49d with SMTP id
 hg13-20020a1709072ccd00b009a1be5bf49dmr4985396ejc.7.1692802696228; Wed, 23
 Aug 2023 07:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230810105501.1418427-1-mszeredi@redhat.com> <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm> <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
 <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm> <CAJfpegvqdAa+XjHA2VefEu=QZNQHyYnXC988UxPfPMisCj93jA@mail.gmail.com>
 <410b7d7d-b930-4580-3342-c66b3985555d@fastmail.fm>
In-Reply-To: <410b7d7d-b930-4580-3342-c66b3985555d@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 16:58:04 +0200
Message-ID: <CAJfpeguFuXPPB-SqNizDEoiemqCZGKm_zHYvYfOMGqGM66viSw@mail.gmail.com>
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

On Wed, 23 Aug 2023 at 16:51, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/23/23 08:18, Miklos Szeredi wrote:
> > On Tue, 22 Aug 2023 at 18:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 8/22/23 17:33, Miklos Szeredi wrote:
> >>> On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> Hi Miklos,
> >>>>
> >>>> sorry for late review.
> >>>>
> >>>> On 8/10/23 12:55, Miklos Szeredi wrote:
> >>>> [...]
> >>>>> +static int fuse_do_statx(struct inode *inode, struct file *file,
> >>>>> +                      struct kstat *stat)
> >>>>> +{
> >>>>> +     int err;
> >>>>> +     struct fuse_attr attr;
> >>>>> +     struct fuse_statx *sx;
> >>>>> +     struct fuse_statx_in inarg;
> >>>>> +     struct fuse_statx_out outarg;
> >>>>> +     struct fuse_mount *fm = get_fuse_mount(inode);
> >>>>> +     u64 attr_version = fuse_get_attr_version(fm->fc);
> >>>>> +     FUSE_ARGS(args);
> >>>>> +
> >>>>> +     memset(&inarg, 0, sizeof(inarg));
> >>>>> +     memset(&outarg, 0, sizeof(outarg));
> >>>>> +     /* Directories have separate file-handle space */
> >>>>> +     if (file && S_ISREG(inode->i_mode)) {
> >>>>> +             struct fuse_file *ff = file->private_data;
> >>>>> +
> >>>>> +             inarg.getattr_flags |= FUSE_GETATTR_FH;
> >>>>> +             inarg.fh = ff->fh;
> >>>>> +     }
> >>>>> +     /* For now leave sync hints as the default, request all stats. */
> >>>>> +     inarg.sx_flags = 0;
> >>>>> +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
> >>>>
> >>>>
> >>>>
> >>>> What is actually the reason not to pass through flags from
> >>>> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
> >>>> required mask and then server side can decide if it wants to fill in more?
> >>>
> >>> This and following commit is about btime and btime only.  It's about
> >>> adding just this single attribute, otherwise the logic is unchanged.
> >>>
> >>> But the flexibility is there in the interface definition, and
> >>> functionality can be added later.
> >>
> >> Sure, though what speaks against setting (limiting the mask) right away?
> >
> > But then the result is basically uncacheable, until we have separate
> > validity timeouts for each attribute.  Maybe we need that, maybe not,
> > but it does definitely have side effects.
>
> Ah right, updating the cache timeout shouldn't be done unless the reply
> contains all attributes. Although you already handle that in fuse_do_statx

Yes, correctness is guaranteed.

However not setting the full mask might easily result in a performance
regression. At this point just avoid such issues by not allowing
partial masks to reach the server.

Thanks,
Miklos


>
>
>         if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
>                 fuse_change_attributes(inode, &attr, &outarg.stat,
>                                        ATTR_TIMEOUT(&outarg), attr_version);
>         }
>
>
>
> Thanks,
> Bernd

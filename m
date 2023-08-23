Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24269785082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 08:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjHWGSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 02:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHWGSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:18:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7910C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:18:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so702365866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692771508; x=1693376308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgYiPB6w71zDBfhr0hMWj12wR0suoRM9Hm3n9xpPb3o=;
        b=djLqFmn6l9wyrgnB4XBV0MmxUkHv/Oz96IukS5/XbRBHfmE/UuEfq69YmCa0SZqfxa
         kOgu2f+xLqOnUaJhZOdJY8DzvtqJ5FKFQcMN8jBmHNCvAT4IWCaf38pPomekoDHdw+GT
         HwdySS4r+oSbYtEbaTA9Ic4SqwAXamkF21YEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692771508; x=1693376308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgYiPB6w71zDBfhr0hMWj12wR0suoRM9Hm3n9xpPb3o=;
        b=L5ytgXd3bEihFPmk8dpCtFSzUvo/IPYvL5pFuJA7SsdPKMOjgcz3/+m97xp/wPLxeI
         fkJe+kTcNY9jurkysC9JP7ipwKbzhBd6wevnOk/e9vcPsUXbuss6j6pMxc3nG45e5f8z
         SnhcPZa5S2iUin/E6/9jwaXnmGnSKP/W3RfUC+YqRFxh6UIOotF8KnAEVucMwSnPyNCO
         rbeccMhrLRTwyfVGL0GBb4qflijoQ8/uy0IZqoDnPBk2NYhiEZes3+lufwNGN+JWfC5q
         7D1Q45Ja1u/Vu2xN4yqLBHDpzvvzWEeZUT93aXGeb0IzVF5H8k+oropsJOy1ZmpsKRmq
         B3Yw==
X-Gm-Message-State: AOJu0YyUBMltxMRHbSL6C1aIgO5Ox2Hr5kVePoP/z7AphJTJ0lx1YCSX
        KU7J3vgmlxoOkV0yqoOK4WRCydnOAgxf5pzz/Ki9Sw==
X-Google-Smtp-Source: AGHT+IGlUVFUdjKWtrk/103p347b+3vEDuwtcRbncpbYCqrbaZKNJPGLXKafOGhh9f2LZFDPajOPEqknofbzM70vcYM=
X-Received: by 2002:a17:906:2250:b0:99b:bdff:b0ac with SMTP id
 16-20020a170906225000b0099bbdffb0acmr9315076ejr.16.1692771508599; Tue, 22 Aug
 2023 23:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230810105501.1418427-1-mszeredi@redhat.com> <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm> <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
 <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm>
In-Reply-To: <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 08:18:17 +0200
Message-ID: <CAJfpegvqdAa+XjHA2VefEu=QZNQHyYnXC988UxPfPMisCj93jA@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: implement statx
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 at 18:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/22/23 17:33, Miklos Szeredi wrote:
> > On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Miklos,
> >>
> >> sorry for late review.
> >>
> >> On 8/10/23 12:55, Miklos Szeredi wrote:
> >> [...]
> >>> +static int fuse_do_statx(struct inode *inode, struct file *file,
> >>> +                      struct kstat *stat)
> >>> +{
> >>> +     int err;
> >>> +     struct fuse_attr attr;
> >>> +     struct fuse_statx *sx;
> >>> +     struct fuse_statx_in inarg;
> >>> +     struct fuse_statx_out outarg;
> >>> +     struct fuse_mount *fm = get_fuse_mount(inode);
> >>> +     u64 attr_version = fuse_get_attr_version(fm->fc);
> >>> +     FUSE_ARGS(args);
> >>> +
> >>> +     memset(&inarg, 0, sizeof(inarg));
> >>> +     memset(&outarg, 0, sizeof(outarg));
> >>> +     /* Directories have separate file-handle space */
> >>> +     if (file && S_ISREG(inode->i_mode)) {
> >>> +             struct fuse_file *ff = file->private_data;
> >>> +
> >>> +             inarg.getattr_flags |= FUSE_GETATTR_FH;
> >>> +             inarg.fh = ff->fh;
> >>> +     }
> >>> +     /* For now leave sync hints as the default, request all stats. */
> >>> +     inarg.sx_flags = 0;
> >>> +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
> >>
> >>
> >>
> >> What is actually the reason not to pass through flags from
> >> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
> >> required mask and then server side can decide if it wants to fill in more?
> >
> > This and following commit is about btime and btime only.  It's about
> > adding just this single attribute, otherwise the logic is unchanged.
> >
> > But the flexibility is there in the interface definition, and
> > functionality can be added later.
>
> Sure, though what speaks against setting (limiting the mask) right away?

But then the result is basically uncacheable, until we have separate
validity timeouts for each attribute.  Maybe we need that, maybe not,
but it does definitely have side effects.

Thanks,
Miklos

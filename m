Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5E7242F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjFFMsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbjFFMsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:48:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759410E4
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 05:47:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9768fd99c0cso780659466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686055586; x=1688647586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLqeJy5xV/mK81iVeK2GFXGqqQgcNBBXHz9GqpmpQso=;
        b=XVNwi5H56mRlkak5dkWSxfTJEr/Jii/7GZonZyZdaWY9/2VsQR/SmuA24N2YsI29tX
         Yu+WyQi2yBdkbFHu54gFdUd+6E+bz8SxHbela8sjMaJFgUUWW461YHu0WCRst5Pldld3
         jHDqnHiILnoheJHom63yyE7uCSYhLJb/Yc+6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055586; x=1688647586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLqeJy5xV/mK81iVeK2GFXGqqQgcNBBXHz9GqpmpQso=;
        b=JEgX8nJXNIyRG+VvPnyHae+f1qbFQkpZ2fxquLohmX/y4zbgO18NjCyCvTZ2a9snCr
         CTHzJ6DtcZvsmKTNeqCUxaPEF7ZVbrfmZ7aQxi2s3TXfLSNQQEp5q4gNcbHNZTcg+JIu
         DU5pXtZWVReIDb++x7nplGZ8u8tt2ZvTBpZZb5k/tA9g0Lni6YzUrx2UMNaX4dwYltrW
         +AfgZq/haTcylmbeLntpG+w5P30ZTbOSuF6BMQcM/0uAY0wkr2m+M66vRvHW1R7Xgeup
         6OnC2in6BZ0ZHFpXGl1YjZHF5V6/GWyuLpHr9rlTwCMxlqqj2N0JnPJX7/eV5lXuUlWa
         0JQA==
X-Gm-Message-State: AC+VfDwpsVqPs/bm2rQzQlriip1j2LiP/5KJbNp+86bmkQMOM51uCiNB
        LZznfxLmLQgw3hSkfKiMLPr2LmR3USYZ44aKVnbalg==
X-Google-Smtp-Source: ACHHUZ71EOi1g3T84a1S5C0jrTTX5oIAMDqTuBb1LxwGB9LTzBx7Ff4b+OrmKxY6g6Xk7lbRsqAeKFimBP4dGTKmyyY=
X-Received: by 2002:a17:907:7f1f:b0:977:d660:c5aa with SMTP id
 qf31-20020a1709077f1f00b00977d660c5aamr2467146ejc.31.1686055586395; Tue, 06
 Jun 2023 05:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-11-amir73il@gmail.com>
 <CAJfpegv3sBfw2OKWaxDe+zEEbq5Q6vBDixLd6OYzeguZgGZ_fA@mail.gmail.com> <CAOQ4uxhLFRHAfXs5ZZLf5yakYMVD9edMMofSzwC12MXGvMsnXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhLFRHAfXs5ZZLf5yakYMVD9edMMofSzwC12MXGvMsnXg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 14:46:14 +0200
Message-ID: <CAJfpeguDbDr9f0J47-U7+DFh2bgArYtDKohYDthxiak5FyOENQ@mail.gmail.com>
Subject: Re: [fuse-devel] Fwd: [PATCH v13 10/10] fuse: setup a passthrough fd
 without a permanent backing id
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 6 Jun 2023 at 13:00, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jun 6, 2023 at 1:23=E2=80=AFPM Miklos Szeredi via fuse-devel
> <fuse-devel@lists.sourceforge.net> wrote:
> >
> > On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > WIP
> > >
> > > Add an ioctl to associate a FUSE server open fd with a request.
> > > A later response to this request get use the FOPEN_PASSTHROUGH flag
> > > to request passthrough to the associated backing file.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Miklos,
> > >
> > > After implementing refcounted backing files, I started to think how
> > > to limit the server from mapping too many files.
> > >
> > > I wanted to limit the backing files mappings to the number of open fu=
se
> > > files to simplify backing files accounting (i.e. open files are
> > > effectively accounted to clients).
> > >
> > > It occured to me that creatig a 1-to-1 mapping between fuse files and
> > > backing file ids is quite futile if there is no need to manage 1-to-m=
any
> > > backing file mappings.
> > >
> > > If only 1-to-1 mapping is desired, the proposed ioctl associates a
> > > backing file with a pending request.  The backing file will be kept
> > > open for as long the request lives, or until its refcount is handed
> > > over to the client, which can then use it to setup passthough to the
> > > backing file without the intermediate idr array.
> >
> > I think I understand what the patch does, but what I don't understand
> > is how this is going to solve the resource accounting problem.
> >
> > Can you elaborate?
> >
>
> It does not solve the resource accounting in the traditional way
> of limiting the number of open files to the resource limit of the
> server process.
>
> Instead, it has the similar effect of overlayfs pseudo files
> non accounting.
>
> A FUSE passthrough filesystem can contribute the same number
> of non accounted open fds as the number of FUSE fds accounted
> to different processes.
>
> A non privileged user can indirectly cause unaccounted open fds
> with a FUSE passthough fs in the exact same way that the same
> user can cause unaccounted open fds with an overlayfs mount
> if it can convince other users to open files on the FUSE/ovl that it
> has mounted.
>
> Am I making sense?

So this allows double the number of open files as normally would be
allowed, same as overlayfs.

Makes sense.

Thanks,
Miklos

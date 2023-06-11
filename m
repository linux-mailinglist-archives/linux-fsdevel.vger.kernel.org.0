Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D172B358
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFKRwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKRwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 13:52:13 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64F187;
        Sun, 11 Jun 2023 10:52:12 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43b54597d3cso799544137.2;
        Sun, 11 Jun 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686505931; x=1689097931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRPK/N4/eyGyDEywfjw/kzE9gHBPfmfh+IeuWCKpiZk=;
        b=lzL5srMOzjDJJhz9j6Fzs15INuIhysEWCvQPKmlDXqh1yL6yRvL50L+mRJQQg1oibz
         g92hmCNBAPxlAmn1ZcM5AGua7LR8B5vA0Yc1bckCLdKFXkRhAFedcp5RYeaDljgwTDYH
         I0Aeir3osl9iWtUDDr5P1fRYl/z64//MPkLZO640CAuWsEgoDpV5z8/wXuTvetDiQeZt
         Bo17KlCIJnw4L1BW/qd8hMTFtQNZQ89lOmpMFL98Vrul341EOaCxlsSM/pDcNMTC3w+P
         moHyR0rSzK5uC+T+3xWnXfOvqOzVKVC1FLBfvuQEnNsoSm7bd/lZeN8Ze9Sq1qbgsZuM
         +rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686505931; x=1689097931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRPK/N4/eyGyDEywfjw/kzE9gHBPfmfh+IeuWCKpiZk=;
        b=VaGQN2je7I5YR5GXruNtmGFqebbCnrBmnGtyE/OGhyfBSYvNoQkYR9L7d5Vb2widib
         zEXtny2dP7A4TA6RBt0GV5lSlVze4cI3fnSjAV3chmYjrOhBcCrTTXD1HzTZ1VxRpjaO
         +FBudCoIXvHQDShe0gDGp+THuJ+BvSb5ra4sd5Gs52CIQxKr1QbEtRBW+/HZ198QgObj
         t9ekb9Eami2+GJocR0Q1ArxaC+4lepSDAOms+3ZwYpxIN+q6HpDfJ3eeZglPo1YL2UOr
         RV2tp6yEh3hUZ6uAyXOTQkS2FdMRRg3ARj7eIwuEMClCjapOtom5i/qOiaRgaa1rqzed
         iq8g==
X-Gm-Message-State: AC+VfDyRc8dYbc2Oi08bRg/ukaKNiHtbhgtp27Fd9/NliGG8T70gzjEv
        a1DAOdw07gLbHo+NvNSWeUTdqhoFkiaA+Rh9k8g=
X-Google-Smtp-Source: ACHHUZ5GCtk6a86PDMGn4R7AHynZR/flCKaTXbEHLN6UeBWjW2I6aV7SdP3e7itKb3T2airX5k0R7d/mmIEv3GRwBHQ=
X-Received: by 2002:a67:ef9a:0:b0:43d:c133:c631 with SMTP id
 r26-20020a67ef9a000000b0043dc133c631mr2274766vsp.13.1686505931368; Sun, 11
 Jun 2023 10:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
 <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Jun 2023 20:52:00 +0300
Message-ID: <CAOQ4uxiDL+u3SS-=HsNaHwPLz2CAV=8oDCED5RtzPhmFwQmkZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 7:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sun, Jun 11, 2023 at 5:23=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Sun, 11 Jun 2023 at 15:27, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > Miklos,
> > >
> > > The first solution that we discussed for removing FMODE_NONOTIFY
> > > from overlayfs real files using file_fake container got complicated.
> > >
> > > This alternative solution is less intrusive to vfs and all the vfs
> > > code should remian unaffected expect for the special fsnotify case
> > > that we want to fix.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > Changes since v1:
> > > - Drop the file_fake container
> >
> > Why?
>
> See my question on v1.
> The fake file objects are used both as vm_file and in read/write iter
> how do we know which path to use in low level functions?
>
> If we allocate file_fake container and still store the fake path
> in f_path, then we have no need to store also the real path
> because ovl knows how to get from fake path to real path.
>
> This is what v2 does.
>
> What am I missing?
>

Is it because getting f_real_path() and file_dentry() via d_real()
is more expensive?
and caching this information in file_fake container would be
more efficient?

I will restore the file_fake container and post v3.

Thanks,
Amir.

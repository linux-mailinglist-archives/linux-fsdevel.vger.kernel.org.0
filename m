Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6026D9904
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbjDFOGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbjDFOGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:06:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F2A255
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 07:06:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54bfa5e698eso75091547b3.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680789970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZEFn8PqM4Q3KLpypvlzmI9JPAeXdYTlS1j5GPFBpkw=;
        b=CO0rDtMBX7GxOqle4zRutsOkQkDOUCYVLrL8Wfl77EmWXDuiIvcV+YrqMQOLYbhGJ+
         aNyRDlyf8vIHKDRfku61g+CnhNo4prUodDSPYHEdO6Rqb+euL64lB2w74SASMMbOXbEI
         7b9EPPSj4LGkaUX0dAKzifQXQuTiLmDuMSnPBSk5sx3St2174+72Cx9KmolQmKVe/lHz
         iQYoYFMAEMlsQXzq/B4lhEHatZGMDV5tyVdaEiCwHpukGcNB+XBivt6hrR/2HTVTCm9K
         NyZOrZIioxAPuyfwe9MAFM89k657qhB1ihrrd4GG4ywF8jQ2YhOXnz1uGhiDkjQuMPhw
         StEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZEFn8PqM4Q3KLpypvlzmI9JPAeXdYTlS1j5GPFBpkw=;
        b=zmnK9vtN8+bxHIrDNeACl+uBN7357l1Jg3LaFy8VnMZC5e+RdE2KzCupgVnCfnylrJ
         hddb9XUonAcoyzW9t5LoawSNJhb1gZP8JU/RpRuzUtZiO0+qVnH0/sIs43LC3BTPc5KE
         sKyYLfDMA/jZbpWfIgBoyVtj69QzVCh+9EbX9n4lMwLHpCCgrmWHfVfb9cRNbff/vllu
         5w5YHQtFHnuD3sSxgDJGI4qMJEmtAaIpuoXi/9pLpu4kX096yig/z8J7dPYKAmU8OJ/q
         JfrbsoAMZiQb1O3a+G4vAY2dpOUv85s55BqHrfkIqGy5Iq4SfHkhtwcyXuXJ0V47neGW
         +qEQ==
X-Gm-Message-State: AAQBX9cAXuoNu+eCzHvZyZmNeLMWHDd6sPtnygtviXkLlIK/PdUwWXsf
        +YH3obEbyCYSZrwl86175QFqEKqUBRBCh6f/USI7
X-Google-Smtp-Source: AKy350bzGQHURm8e9J4sIKMy2Czta+iiQu318TrftTUElrzWTqrzipRouhTXLQPqTfHnlillmkHSo2LmVb+JMnxN18c=
X-Received: by 2002:a81:4513:0:b0:544:d5ce:eb33 with SMTP id
 s19-20020a814513000000b00544d5ceeb33mr5955389ywa.8.1680789970528; Thu, 06 Apr
 2023 07:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230405171449.4064321-1-stefanb@linux.ibm.com> <20230406-diffamieren-langhaarig-87511897e77d@brauner>
In-Reply-To: <20230406-diffamieren-langhaarig-87511897e77d@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Apr 2023 10:05:59 -0400
Message-ID: <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 6:26=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
> > Overlayfs fails to notify IMA / EVM about file content modifications
> > and therefore IMA-appraised files may execute even though their file
> > signature does not validate against the changed hash of the file
> > anymore. To resolve this issue, add a call to integrity_notify_change()
> > to the ovl_release() function to notify the integrity subsystem about
> > file changes. The set flag triggers the re-evaluation of the file by
> > IMA / EVM once the file is accessed again.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  fs/overlayfs/file.c       |  4 ++++
> >  include/linux/integrity.h |  6 ++++++
> >  security/integrity/iint.c | 13 +++++++++++++
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 6011f955436b..19b8f4bcc18c 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/security.h>
> >  #include <linux/mm.h>
> >  #include <linux/fs.h>
> > +#include <linux/integrity.h>
> >  #include "overlayfs.h"
> >
> >  struct ovl_aio_req {
> > @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct fil=
e *file)
> >
> >  static int ovl_release(struct inode *inode, struct file *file)
> >  {
> > +     if (file->f_flags & O_ACCMODE)
> > +             integrity_notify_change(inode);
> > +
> >       fput(file->private_data);
> >
> >       return 0;
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index 2ea0f2f65ab6..cefdeccc1619 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -23,6 +23,7 @@ enum integrity_status {
> >  #ifdef CONFIG_INTEGRITY
> >  extern struct integrity_iint_cache *integrity_inode_get(struct inode *=
inode);
> >  extern void integrity_inode_free(struct inode *inode);
> > +extern void integrity_notify_change(struct inode *inode);
>
> I thought we concluded that ima is going to move into the security hook
> infrastructure so it seems this should be a proper LSM hook?

We are working towards migrating IMA/EVM to the LSM layer, but there
are a few things we need to fix/update/remove first; if anyone is
curious, you can join the LSM list as we've been discussing some of
these changes this week.  Bug fixes like this should probably remain
as IMA/EVM calls for the time being, with the understanding that they
will migrate over with the rest of IMA/EVM.

That said, we should give Mimi a chance to review this patch as it is
possible there is a different/better approach.  A bit of patience may
be required as I know Mimi is very busy at the moment.

--=20
paul-moore.com

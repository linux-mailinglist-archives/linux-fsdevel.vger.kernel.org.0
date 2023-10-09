Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD657BD4A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJIHvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjJIHvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:51:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426FD6;
        Mon,  9 Oct 2023 00:51:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65b05a45046so25115896d6.2;
        Mon, 09 Oct 2023 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696837872; x=1697442672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7zJv/BEFC+e8jZD+yuEwqsaiTBQGGGm2OB9yNeSuYU=;
        b=l+GSY3WKm++FyIMmW320ZiyaM40KeJ2H1CZemhauVmjRLS0RfaIiFJkzFiiLSNQ49R
         2sYez4K+GZjOnwRHOs9hGG4Heg4zcCIKCjiQhZcRSR15XjchwzUBDsdeSS17OGvq5U6p
         pzyP8dhvArjaOT60jX/YofUdd3E/IUoo2Zka4gVS6uJ4LdxLRmBLLBUl6DIyeI0/HffQ
         wOrkAqabJwTiI1QInalDm8RBrsqljNR8YI24qZx5knFeFkKkFRAIjF6V4kvRenzZLBZa
         HheymCteKqkvxi9cvd4xjXflqnOjngi0Qln6sBlkIyI7ascvJcp6JAFDhYDbOhBMqUoa
         RiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696837872; x=1697442672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7zJv/BEFC+e8jZD+yuEwqsaiTBQGGGm2OB9yNeSuYU=;
        b=MbF5ZFWyIuiRjkaK64JjnrYUlEUoQSpLu3TByhLiKie8g/Gi7RcODCu3jBknKeo8zr
         q8Vvu8jvAFpy/BT+lhznyUQotcdphcJTxKT6RAR3vBNGRbZbjArkh5udRfjbgE2n7dyE
         PifzH8bNntr9pDbc4S4PVPZZaLi+vN2zjo53mecvXya+PwiNdRsUotbn1Q07RpkV7Lo8
         k3IjHauXvya3uvH+kZd8rke3YQLhhiPfWLolTLxDeWhXZb1EKmPfOVRAI+VHQ+P1Nnr4
         ghh86wSDfYDirINbPWwgEZ6oI7+M6LBV/anqTu+1qgDy+MHMZI5ZmisTpTBfY+kWJpQM
         UaMQ==
X-Gm-Message-State: AOJu0Yzwn+URzMxaD1pUobU7gk6bpoet5kDiQnjXugqH7XPltaSw6/01
        GFLZOaY5+Z+2jyNPpzfgi7YGGyIJ+iAHyAqleaE=
X-Google-Smtp-Source: AGHT+IFm3JzvfB9hHmsAij/umx2g4WMnSiFVcmISTkq8udq5/T9G+ZGu6TkMd2EqYgPPtAzagdtAUIGubIW82lus0Oc=
X-Received: by 2002:ad4:4531:0:b0:656:5467:4d52 with SMTP id
 l17-20020ad44531000000b0065654674d52mr14992057qvu.56.1696837872309; Mon, 09
 Oct 2023 00:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231007084433.1417887-1-amir73il@gmail.com> <20231007084433.1417887-3-amir73il@gmail.com>
 <20231009070048.GG800259@ZenIV>
In-Reply-To: <20231009070048.GG800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Oct 2023 10:51:00 +0300
Message-ID: <CAOQ4uxiCkNodH71x+z_Ukj2mgzPrx9YWguvgWDnKpHj-7yNZxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: create helper file_user_path() for user
 displayed mapped file path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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

On Mon, Oct 9, 2023 at 10:00=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Oct 07, 2023 at 11:44:32AM +0300, Amir Goldstein wrote:
>
> > @@ -93,7 +93,8 @@ static void show_faulting_vma(unsigned long address)
> >               char *nm =3D "?";
> >
> >               if (vma->vm_file) {
> > -                     nm =3D file_path(vma->vm_file, buf, ARC_PATH_MAX-=
1);
> > +                     nm =3D d_path(file_user_path(vma->vm_file), buf,
> > +                                 ARC_PATH_MAX-1);
> >                       if (IS_ERR(nm))
> >                               nm =3D "?";
>
> Umm...  At one point I considered this:
>         if (vma->vm_file)
>                 pr_info("  @off 0x%lx in [%pD]  VMA: 0x%08lx to 0x%08lx\n=
",
>                         vma->vm_start < TASK_UNMAPPED_BASE ?
>                                 address : address - vma->vm_start,
>                         vma->vm_file, vma->vm_start, vma->vm_end);
>         else
>                 pr_info("  @off 0x%lx in [anon]  VMA: 0x%08lx to 0x%08lx\=
n",
>                         vma->vm_start < TASK_UNMAPPED_BASE ?
>                                 address : address - vma->vm_start,
>                         vma->vm_start, vma->vm_end);
> and to hell with that 'buf' thing...

It's fine by me.
That would be consistent with print_bad_pte().
I've never had to debug vma/pte faults, so I don't know
how much of the path is really valuable for debugging.

Thanks,
Amir.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5B70A6A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjETJPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETJPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:15:48 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53FD1;
        Sat, 20 May 2023 02:15:47 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-45702d3d92cso1096805e0c.1;
        Sat, 20 May 2023 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684574146; x=1687166146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV9yWfObuGSHQhWaTGLjjFXmUxZwoyjiWs/RVOlCuDM=;
        b=d6JXE8byoV/ctjNyc18kOYeOxyFA6BiZO9YZBbwXRuzCw4d0nK94uUkp9irX+ulNXJ
         2QAzSwGms0PhPIabaDkOghie0ey1fXPUdqTNcYi63mEM4NsyNAbBsDhj5sSk591nEctH
         dI6nbYuDoWBbxXTqTD0k+qNzb1mcLtZoYLqkIvjd+ZvFum07uH57Pflfnn6y9JscaQAq
         6vF3uqK5Yk/2vFrW/oHOaT9zlwibNHqs8e/4krDHrKKb9MAINJs5IxOb/nx/1wJSR3oV
         SrTbIl7Tq9TjZUUwbsoPQ4IWNUB4H7F8Ard0gpKPNqAH1z0KxKaeQLn/vxnzcYxRvaGO
         wvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684574146; x=1687166146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV9yWfObuGSHQhWaTGLjjFXmUxZwoyjiWs/RVOlCuDM=;
        b=JT2c2v2tFZYtXEFgA260iWwjXwPNCbEXEILbBljIs/kWYrTrvdgjMxESE1vVLQlCqj
         o5ErbxaD142rA1f7QOhaZ45X04hg2FoV9Pp/tmq+hL7AdMCR7AVRv4EnSlo7UbZMDT2Z
         e9bgrQVQmHV7sAAFdxDosk3pkis1NruAcVwoi7w1STWZ9dO2fsPrk1IqIQX9G2exyAsz
         PQ8uRas6J5agNWKkBx4nCboomSZISMjt6K8xkggP+max5vJgXQAqLtqT39W9gT6jET+Z
         laTq1dV+f06NvHp4BHzimSa37EFh+UA6OycvLUMB3q0hsCHfo5K/I8kmHI5gyxKu+13a
         WNHg==
X-Gm-Message-State: AC+VfDx+VJFQ6MV/5w9km/3b5FHn9lkfqJot7Tr0uIGi1ICHx7rd98xK
        JtegV2+JVVDz33TwigjxVtL9AooGcVeUwR4/YbTM2WTG
X-Google-Smtp-Source: ACHHUZ7GpknK4R92DTbs5EeLc1EKcqsKoOxoIIVWwApmErvfgrUPqW8Xe3N7zUcDaoilpRzZ7CDFnYOHLewzsnuvIYM=
X-Received: by 2002:a05:6102:cd:b0:42c:543a:ab2a with SMTP id
 u13-20020a05610200cd00b0042c543aab2amr598510vsp.35.1684574146149; Sat, 20 May
 2023 02:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner> <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
In-Reply-To: <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 May 2023 12:15:34 +0300
Message-ID: <CAOQ4uxi7PFPPUuW9CZAZB9tvU2GWVpmpdBt=EUYyw60K=WX-Yg@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
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

On Fri, May 19, 2023 at 10:42=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > So, I think we want both; we want the ovl_copyattr() and the
> > vfs_getattr_nosec() change:
> >
> > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> >     is in line what we do with all other inode attributes. IOW, the
> >     overlayfs inode's i_version counter should aim to mirror the
> >     relevant layer's i_version counter. I wouldn't know why that
> >     shouldn't be the case. Asking the other way around there doesn't
> >     seem to be any use for overlayfs inodes to have an i_version that
> >     isn't just mirroring the relevant layer's i_version.
> > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> >     Currently, ima assumes that it will get the correct i_version from
> >     an inode but that just doesn't hold for stacking filesystem.
> >
> > While (1) would likely just fix the immediate bug (2) is correct and
> > _robust_. If we change how attributes are handled vfs_*() helpers will
> > get updated and ima with it. Poking at raw inodes without using
> > appropriate helpers is much more likely to get ima into trouble.
>
> In addition to properly setting the i_version for IMA, EVM has a
> similar issue with i_generation and s_uuid. Adding them to
> ovl_copyattr() seems to resolve it.   Does that make sense?
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 923d66d131c1..cd0aeb828868 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
>         inode->i_atime =3D realinode->i_atime;
>         inode->i_mtime =3D realinode->i_mtime;
>         inode->i_ctime =3D realinode->i_ctime;
> +       inode->i_generation =3D realinode->i_generation;
> +       if (inode->i_sb)
> +               uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> >s_uuid);

That is not a possible solution Mimi.

The i_gneration copy *may* be acceptable in "all layers on same fs"
setup, but changing overlayfs s_uuid over and over is a non-starter.

If you explain the problem, I may be able to help you find a better solutio=
n.

Thanks,
Amir.

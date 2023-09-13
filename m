Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C479F075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIMRhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIMRhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:37:02 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D0A8;
        Wed, 13 Sep 2023 10:36:58 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a505727e7eso59670241.0;
        Wed, 13 Sep 2023 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694626617; x=1695231417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUBTHLHMdVrFtqCVTI9npNAUNxOv53pR5xqiTxGy/z4=;
        b=ltuvVGdONvIKlvwk2W8dWK0O7Bz8lZG3Q0Fo9ie3+DF0onqsskDOI5hFVoqDhDdkSh
         SA67qvyX0epiZI76QFWKGHXbyvRNft9s3ZNg9OQITwvlORj/rMsEuVIGkap1Jo4Gjau1
         TOwwVFNwskW3YId4fFrQYJg+w5yMB93eqiVsbyPSwDhYkeGIkR1Dr+GnQoOSnkgpDhuJ
         rJy+MOXakH8vJ4/OWGTe0Z0q+2qCDwIBleV6uEbUo/3RiVvutIMYn9y+LNvWZUEwu49k
         BLWfrI3lLRnNHOyn6fSP2FvHpecboq5apMOdB3PPkopIQcBHrWrA3zI88l522THoK4/v
         LLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626617; x=1695231417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUBTHLHMdVrFtqCVTI9npNAUNxOv53pR5xqiTxGy/z4=;
        b=DOcJvirKFSlhlFP8aj8i+kymldOpDUN3yo+10A78n+3uMvQh445IKOL5teV7z5ON5U
         DuMWZXIUa5wS8h8HpQrBrGRENOAB0BB2jEQROU2RSZTnpzSyWCgtMmiHzNDB6/10Eehu
         0FNo+GtoZxLJd1oLL/U3YjYXXcoPNsto4MqTZwvqJx8ls/19dEE6XZfck2Ue3k48J6yZ
         4JwAUAPR0o7XdJyAYWwpBykA9lc5q3bQNnezIB3Gn3AE0opixIP1vQ2h76ayXD7UydK5
         Rf+xdFsWMOGXuK9PezKPZ+IEeGKRZLWod0vTb5FIhrWZuw36YrTpzf36Kvcl6naNDpMG
         k1Kw==
X-Gm-Message-State: AOJu0Yz0oFh8kUgMV+AOJy5weXpzOibxsBPol9UZqc+htyP/9mZ/1wIz
        LTPBlNQ+iRiut68awOw1tfeBpKvQyqBHxfL0+Ck=
X-Google-Smtp-Source: AGHT+IHnZ5RMnSyqYQIJ0YQlL3YDIavATqGNsUT6AgecvkVsZb9etm/KfUc34JO5eovfCyjImlWLzbmGQ7ux4RqYSY4=
X-Received: by 2002:a1f:4b85:0:b0:495:bc26:d110 with SMTP id
 y127-20020a1f4b85000000b00495bc26d110mr3150824vka.12.1694626616904; Wed, 13
 Sep 2023 10:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
In-Reply-To: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 20:36:45 +0300
Message-ID: <CAOQ4uxhYRnX0NChCU2tsEi7eUPqbqQDeOwQT4ubWUgtCN0OVfA@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 4:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Nathan reported that he was seeing the new warning in
> setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> trying to set the atime and mtime via notify_change without also
> setting the ctime.
>
> POSIX states that when the atime and mtime are updated via utimes() that
> we must also update the ctime to the current time. The situation with
> overlayfs copy-up is analogous, so add ATTR_CTIME to the bitmask.
> notify_change will fill in the value.
>

IDGI, if ctime always needs to be set along with ATIME / MTIME, why not
let notify_change() set the bit instead of assert and fix all the callers?
But maybe I am missing something.

Anyway, I have no objection to the ovl patch.
It's fine by me if Christian applies it to the vfs.ctime branch with my ACK=
.

Thanks,
Amir.

> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> The new WARN_ON_ONCE in setattr_copy_mgtime caught a bug! Fix up
> overlayfs to ensure that the ctime on the upper inode is also updated
> when copying up the atime and mtime.
> ---
>  fs/overlayfs/copy_up.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d1761ec5866a..ada3fcc9c6d5 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, str=
uct dentry *upperdentry,
>  {
>         struct iattr attr =3D {
>                 .ia_valid =3D
> -                    ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIM=
E_SET,
> +                    ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIM=
E_SET | ATTR_CTIME,
>                 .ia_atime =3D stat->atime,
>                 .ia_mtime =3D stat->mtime,
>         };
>
> ---
> base-commit: 9cb8e7c86ac793862e7bea7904b3426942bbd7ef
> change-id: 20230913-ctime-299173760dd9
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

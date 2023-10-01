Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19697B4983
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjJAT7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAT7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:59:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102A1C6;
        Sun,  1 Oct 2023 12:59:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50437c618b4so21997095e87.2;
        Sun, 01 Oct 2023 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696190353; x=1696795153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6wnHTgTcw37XCFqdNoUwceIprHkHSWJNKSBsu0v9k0=;
        b=b2AEyb7Djs2XMEk+JHtlUbo1horar/QONrxDjtDnk1u9DLZStteMueb+jehXQ4tzCv
         u/TT/E9B+SKGVVB9yZe10ba5ZLUynWE7igNL/5PicEs+hfaYf40YJkBYcZ6a5xsA2QT3
         2ydNf1Aqi9x7rIj5NGpV5dhU5D1iKGTfAdI4U8CuwUffd28W4Au2MbsAKlgFw1JBAGSG
         xFVKm9l4w9u9TQR1aQpr/amhO2DB0i9oHFoLhwCIKHl5LK3w08+BBAPwH606+En6J4Mc
         mt8U2jQZpR3wy13/CUP/ovU0Pv6f7EDfQ2Dru55giuCAucaKIRf7Ya0kop0kW/3b0acH
         xCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696190353; x=1696795153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6wnHTgTcw37XCFqdNoUwceIprHkHSWJNKSBsu0v9k0=;
        b=pDlfZ5ZNniBheiNG+f7//LQt8xFM1Ky1CoaHoU4vPBp+ri5FVY6ipYLi356JA+UPQH
         Zt1fp0GW8zhS8xmJsEVOk4tzV1kjLvPSe+Tdcy+PFjh/52gB4bnEPLNfhgR44KeLcD/d
         o1t/zkA2Awd3dU1qYYG2jOq7XatQNl6wfbibnDx8R3lPwFccjuV0Smb2RaZ09moLJ3rZ
         aQHc2BSDFejMZI5ks/CyWy8h0oHioC/P5Z/VGge8FSTZcmj9wQsDbb3cC0owJnswqiMo
         nj2W/ZyP2vZkA04fOjVdKwah51vN5TuaaFuznSJqsNQlhS+2L17cF+Sil7O2yqhnhLSa
         a54w==
X-Gm-Message-State: AOJu0Yy/oPTkgTgGU+s7Lx7ut55kJsD8v4HrC5DHk5K+gvmHKsGhNASy
        2wZtincn9qUOkmk492y0NKIV7qvjmymEex6NN+Q=
X-Google-Smtp-Source: AGHT+IFoIIwxaA7g5WAF7STEjI04HAo61gFoGEBM2TseweuiTvit/2GlFb8eZm9jmmI/b6cQqQd1t2uXsm39ei/59lU=
X-Received: by 2002:ac2:58db:0:b0:505:6fed:33a0 with SMTP id
 u27-20020ac258db000000b005056fed33a0mr5768211lfo.34.1696190353001; Sun, 01
 Oct 2023 12:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-24-wedsonaf@gmail.com>
In-Reply-To: <20230930050033.41174-24-wedsonaf@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 1 Oct 2023 14:59:01 -0500
Message-ID: <CAH2r5mt_u0SDLpFzZ43n0F2-ZQ8xF8KJ4qTvvDKxe116Doa1Qw@mail.gmail.com>
Subject: Re: [PATCH 23/29] smb: move cifs_xattr_handlers to .rodata
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
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

Reviewed-by: Steve French <stfrench@microsoft.com>

On Sat, Sep 30, 2023 at 6:27=E2=80=AFAM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This makes it harder for accidental or malicious changes to
> cifs_xattr_handlers at runtime.
>
> Cc: Steve French <sfrench@samba.org>
> Cc: Paulo Alcantara <pc@manguebit.com>
> Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  fs/smb/client/cifsfs.h | 2 +-
>  fs/smb/client/xattr.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index 15c8cc4b6680..a0472b539567 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -134,7 +134,7 @@ extern int cifs_symlink(struct mnt_idmap *idmap, stru=
ct inode *inode,
>                         struct dentry *direntry, const char *symname);
>
>  #ifdef CONFIG_CIFS_XATTR
> -extern const struct xattr_handler *cifs_xattr_handlers[];
> +extern const struct xattr_handler * const cifs_xattr_handlers[];
>  extern ssize_t cifs_listxattr(struct dentry *, char *, size_t);
>  #else
>  # define cifs_xattr_handlers NULL
> diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
> index 4ad5531686d8..ac199160bce6 100644
> --- a/fs/smb/client/xattr.c
> +++ b/fs/smb/client/xattr.c
> @@ -478,7 +478,7 @@ static const struct xattr_handler smb3_ntsd_full_xatt=
r_handler =3D {
>         .set =3D cifs_xattr_set,
>  };
>
> -const struct xattr_handler *cifs_xattr_handlers[] =3D {
> +const struct xattr_handler * const cifs_xattr_handlers[] =3D {
>         &cifs_user_xattr_handler,
>         &cifs_os2_xattr_handler,
>         &cifs_cifs_acl_xattr_handler,
> --
> 2.34.1
>


--=20
Thanks,

Steve

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7D777FB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjHJR63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHJR62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:58:28 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4CED;
        Thu, 10 Aug 2023 10:58:28 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4872c3dff53so331580e0c.1;
        Thu, 10 Aug 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690307; x=1692295107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiORD/kwp8ZCOVHFvTu8hUSLSgnUCKWjtsN+Cf0UQ8M=;
        b=TtnCfLTLSVsD/8mjJL/uLjovm8JaiHo4b/mdbCmmW0taf99at9JYttFr/1Hu0stXaV
         QQl2us1k6/9eXNUFDtwJb/oSuQXngYpRZyyf0G9fxzspyXjrJ08NiAKA7m7tceYtevTM
         SReJ4OltoiPmzNpA2eGc+eP1wKX5raWlRyrAvhi8nsbCv0x7tNoXClfdZzAHbT4uN2/F
         833eH1GXj8mx9+xOrghJw7iLqZw2NgupKsylHF/WEShyB8+GcMTeB7oaQnkqdW6diB8R
         cZennwKesLSivITSEzqKKThB1XmJW193+8NPxsGt2vfR35g3PWm0PdRrvL09OKlJk8AL
         rk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690307; x=1692295107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiORD/kwp8ZCOVHFvTu8hUSLSgnUCKWjtsN+Cf0UQ8M=;
        b=ZFnT6z4stSsMI0SlnBC8hCPOqTD+HtR7UJribqHd1tNbo4sRqigDRqCoUbnq5h6h+P
         DCcMpdXgnnFI6EmpyevHvtFwIjvQ+4dCgVsc23AKwzM8xDHDH4/ouxzUz59zOBpeo3Up
         2oL0Jz628o/PSewfbpLfb9Jlnbgp22pKvX3s0+QqMYo1pKDG99Z8IpUiK8YhckvaGO5R
         u7Y4iW7hCEWH4gobt02j1NCpcs1OC/1aykds/9/zXtYNNLxhpJ+7GTcduRAN6sh8QRu3
         ZOmaT7BXhGmIMVCnmhiL7SoloNR/AqVHznjNtbZA3gmrlXbW1hAim+ATcHza6tu+Rqet
         Nrkw==
X-Gm-Message-State: AOJu0YzpZp+2u2DwoQXsm5/m6fRwgabORNuffJG1x9MBvtVP2Ld6VDmx
        IioZOUmi+K7G06CKgKLfA7vz3rhoI/NTv9wv/8g=
X-Google-Smtp-Source: AGHT+IGDjuq+B+GVfzoZTy2uejYFgq74ja6JTdwGiEo0ZXML7lE1kjUGv4Wrybm5T8bBc8rvSZq8nEyKiMdB+Vd+2EQ=
X-Received: by 2002:a1f:6011:0:b0:45e:892b:d436 with SMTP id
 u17-20020a1f6011000000b0045e892bd436mr2213267vkb.12.1691690307097; Thu, 10
 Aug 2023 10:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230808091849.505809-1-suhui@nfschina.com>
In-Reply-To: <20230808091849.505809-1-suhui@nfschina.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Aug 2023 20:58:16 +0300
Message-ID: <CAOQ4uxhtZSr-kq3G1vmm4=GyBO3E5RdSbGSp108moRiRBx4vvg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: avoid possible NULL dereference
To:     Su Hui <suhui@nfschina.com>
Cc:     jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Tue, Aug 8, 2023 at 12:19=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> smatch error:
> fs/notify/fanotify/fanotify_user.c:462 copy_fid_info_to_user():
> we previously assumed 'fh' could be null (see line 421)
>
> Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
> Signed-off-by: Su Hui <suhui@nfschina.com>'

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index f69c451018e3..5a5487ae2460 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -459,12 +459,13 @@ static int copy_fid_info_to_user(__kernel_fsid_t *f=
sid, struct fanotify_fh *fh,
>         if (WARN_ON_ONCE(len < sizeof(handle)))
>                 return -EFAULT;
>
> -       handle.handle_type =3D fh->type;
>         handle.handle_bytes =3D fh_len;
>
>         /* Mangle handle_type for bad file_handle */
>         if (!fh_len)
>                 handle.handle_type =3D FILEID_INVALID;
> +       else
> +               handle.handle_type =3D fh->type;
>
>         if (copy_to_user(buf, &handle, sizeof(handle)))
>                 return -EFAULT;
> --
> 2.30.2
>

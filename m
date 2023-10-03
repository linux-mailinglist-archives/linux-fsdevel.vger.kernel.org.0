Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E987B6EBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbjJCQld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbjJCQlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:41:32 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB59A1;
        Tue,  3 Oct 2023 09:41:29 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4526a936dcaso623407137.2;
        Tue, 03 Oct 2023 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696351288; x=1696956088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzpsBd0hl8g05el1vI3tJ2EKjd4P5v9MJSsEQR5HPI0=;
        b=ZPTDfGfI6wp8YH/kDLeyRQ+9AmgpfBqWXwPLm7paKNl+LHRVhyZH04iXubqFmCL1Ng
         3Vs9oJdggg3r1zp5Dt4/OeA8uwcGdd8kpN4lET5nhRR1sHBhaodEXO0U1rv4SiGwlTLz
         6/T/dfMuUyXb81WVVSxHzKPfmARTotoCm2BYaQCUVGD+rcbWl9Oi6yhhLULKC+gopg0c
         iuFdSEcKMbzoH7eEzB8SrFpYRBOJR1hW6u2ZLwGdaXbopK8uXg4HRvkuKfCQYr7I/A5l
         TZVwR72IXXaJrdACbekGaKSZCTpvV2K4ImsQ1pqrZWhClsC05ulImdv1xp+XLA45M+Dl
         CSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351288; x=1696956088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzpsBd0hl8g05el1vI3tJ2EKjd4P5v9MJSsEQR5HPI0=;
        b=TQ4thC7Ssq7eyDhFj2h+/gZadAyU48ayDpV7GrbXTLCtn4Ptyxcvop1wXOaHfxhdfA
         /fm5pQWEZ5t3UXVFx09T6e/xh/MwU1N6CqK8ySwdKCeQrG3LFCIqkSymw5vwApkTDnNJ
         RqCC83nTPGEnyeFioeQ+pXB7/t3zpPgxPqU/JPl1gMY6fIBGQnaXdeN568xW51pCOA9+
         PKp+HM7uZ0qWvZa8SQ/1BLCpRjF2BGR6I0DrXPan8VCfS6m7BHv3/QBbhIWYACoZ7fWD
         C4EQxZklOuWJvCUaBd3GUk3kW2dCWbLUqQXsY8rcEuuoff2H0KnYsvngHBxph/XNdGDH
         iwzg==
X-Gm-Message-State: AOJu0Ywa7CwF4o0+rx8j8SKPKU0ttD38519O2F/t9eDGwGbejitkK995
        r6JxPpMJNJQLhijnUFKsIJDs0Aa03JmYgC3AY3E=
X-Google-Smtp-Source: AGHT+IHJdozEu/KZhJZn/lHmEhyPBoWl+ajpKEcSc2n07vKAw/SLSfqjBQngm5hKKn0EtBsgprFbBZ5Usg3N4HtzGG0=
X-Received: by 2002:a05:6102:7a4:b0:452:9988:5cbd with SMTP id
 x4-20020a05610207a400b0045299885cbdmr13007992vsg.5.1696351288603; Tue, 03 Oct
 2023 09:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-28-wedsonaf@gmail.com>
In-Reply-To: <20230930050033.41174-28-wedsonaf@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Oct 2023 19:41:17 +0300
Message-ID: <CAOQ4uxiTZNLD5cbYWqdWe0djTSEmq+32XsU5i39Y=WAZ791oxQ@mail.gmail.com>
Subject: Re: [PATCH 27/29] overlayfs: move xattr tables to .rodata
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 8:02=E2=80=AFAM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This makes it harder for accidental or malicious changes to
> ovl_trusted_xattr_handlers or ovl_user_xattr_handlers at runtime.
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index cc8977498c48..fe7af47be621 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -477,13 +477,13 @@ static const struct xattr_handler ovl_other_xattr_h=
andler =3D {
>         .set =3D ovl_other_xattr_set,
>  };
>
> -static const struct xattr_handler *ovl_trusted_xattr_handlers[] =3D {
> +static const struct xattr_handler * const ovl_trusted_xattr_handlers[] =
=3D {
>         &ovl_own_trusted_xattr_handler,
>         &ovl_other_xattr_handler,
>         NULL
>  };
>
> -static const struct xattr_handler *ovl_user_xattr_handlers[] =3D {
> +static const struct xattr_handler * const ovl_user_xattr_handlers[] =3D =
{
>         &ovl_own_user_xattr_handler,
>         &ovl_other_xattr_handler,
>         NULL
> --
> 2.34.1
>

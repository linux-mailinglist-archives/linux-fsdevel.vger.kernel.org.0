Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B37642C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0AC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 20:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjG0ACZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:02:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4354187
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 17:02:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so3446355e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 17:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1690416142; x=1691020942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY3QJeaMISaIKdDxKtJKohJ2GJoWkJJcs9mJ7frhIvA=;
        b=JMeYciZ6extbWy42C5yfWoIXWWCjILjf+vkioU3vFAhPr3DXf5HAt8QftPHoxB9O8e
         rM7uQXiGVx/Tl7WL29bpf3iyd1apIRCrbcfoXONu/DnbRkY9L8QYnxl6eK2oADbVEBmQ
         071Ebtfv3y7ucNEMI8yKpXwMvapTrFBTWmmto1Atz0SWlrzFdueDMJyHzjCFUqu+gYzb
         s+ADi7TBqxb830QY+YhLKTIbTAwv0O3lsy9bG8h2IppqoeQ/2/23RuZO1rplTAfPCKdL
         1kznMyoVGksodV9iTmWhsXZp/8SSXt+Vku0f7/KCkQO46qwONmSCLpav5StP6gxBYelG
         9ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416142; x=1691020942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY3QJeaMISaIKdDxKtJKohJ2GJoWkJJcs9mJ7frhIvA=;
        b=bAuT8pC7CTva+d37qCzYEn0wewfDf82C+Q1eKDAXSmayZbbVMn/okYLk2BNkcvMSF1
         HcfLOjY0uY4dEsf9xdxynd7tcKjVXKoDwDa/rgPLBY54b8E0zElLU38zfjzKzTMprX06
         nxV35pc/aEWpxabvlNxCfHp+Acc4AYhne3KVe4z4rat5OTaks0exj54KHudiPpwFZ5Ij
         qJc1MAf+XXNyO+P/1u/auZ7Imb8RBc9eXqFVoTEic16dFLNGCRLxiU0kngEmCL5q0LCB
         NKmy4faLUCC5dtWOIvQa9JfnMm3R5QTPn4sejx0MdUENymRKKhktZ5xPdxEz79WOTmPX
         bhGg==
X-Gm-Message-State: ABy/qLYPiDO/IqIb/8cXUlAvcbbuuT90DqlST4KCZv94DTaukxwxSmQ4
        45RreLRIt9b4M44kV0WZG5HwZV8zYi7oyikY4ixFHQ==
X-Google-Smtp-Source: APBJJlHXG8MNDeIKShy9xDvHXtfx9gRvwJvCEX2mLcwSYS3qbHbn1nBhhAONPEPTijBgStQmhz/+PlyPRAUGpob8HfU=
X-Received: by 2002:a05:6000:1146:b0:314:2d71:1f7a with SMTP id
 d6-20020a056000114600b003142d711f7amr408985wrx.32.1690416142177; Wed, 26 Jul
 2023 17:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-11-amiculas@cisco.com>
 <CALNs47ss3kV3mTx4ksYTWaHWdRG48=97DTi3OEnPom2nFcYhHw@mail.gmail.com> <CANeycqqTdL9vr=JF+Fij5EY0TW_+_FY1p2qGdvGhYcyH9=9J9w@mail.gmail.com>
In-Reply-To: <CANeycqqTdL9vr=JF+Fij5EY0TW_+_FY1p2qGdvGhYcyH9=9J9w@mail.gmail.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Wed, 26 Jul 2023 20:02:10 -0400
Message-ID: <CALNs47s=eXJ-=s7WiVSBoqgcKSqkuZemm_Lx_Ts7yoaOp_e13A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] rust: puzzlefs: add oci_root_dir and
 image_manifest filesystem parameters
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 7:48=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> On Wed, 26 Jul 2023 at 18:08, Trevor Gross <tmgross@umich.edu> wrote:
> >
> [...]
> > The guard syntax (available since 1.65) can make these kinds of match s=
tatements
> > cleaner:
>
> This is unstable though.
>
> We try to stay away from unstable features unless we really need them,
> which I feel is not the case here.
>

Let/else has been stable since 1.65 and is in pretty heavy use, the
kernel is on 1.68.2 correct? Could you be thinking of let chains
(multiple matches joined with `&&`/`||`)?

>     let Some(oci_root_dir) =3D data.oci_root_dir else {
>         pr_err!("missing oci_root_dir parameter!\n");
>         return Err(ENOTSUPP);
>     }
> [...]

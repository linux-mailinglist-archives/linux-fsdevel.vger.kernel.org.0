Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1DB747510
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGDPOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGDPOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:14:06 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C710D5;
        Tue,  4 Jul 2023 08:14:05 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-791b8525b59so2175760241.1;
        Tue, 04 Jul 2023 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688483644; x=1691075644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18US8w0C3qU4DiEkJ9jXYu7TawUKRfr7sw1OsNONIqI=;
        b=AuTMDE0JpsWVSaY/Xb8ckUoOyH9PKudki3prIAQpOv/2YZ3iQwCJhapLPBD8kV6eha
         s5FRu1FTHY69rDwqHzb7dqRWMMTMvt/nJrffomH/6XE/hPhMiITudicc2lDcKVyjBa2V
         tXAS4Cbci5SGTBWGjGI/xcrQm3IQ7PYHTJPiVg6CUCkJhPIbmGct7DDICOQc2zHzNRTA
         nwlStfUCuy9n+ueggtaH2E+9Qa6ySS3KObQlDBww1ClZnAHgXwNB/Ib46d/S+GikptzS
         LCTAfeVnkqUrmGkALtXaymsNY5BkWt8UU6HLzPd7fNUlh04kfZB1iZEg4PwGQdkhO3RH
         8E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483644; x=1691075644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18US8w0C3qU4DiEkJ9jXYu7TawUKRfr7sw1OsNONIqI=;
        b=j4BU83vtgukS3d2vqoy7AI1MQv2r1TU4VDewNg4Y9HqEiWiruWCcqSrbAUHAT4rosC
         jHe6ah9Q038MhtLGJKS02wCZ5pSf9U1L1BEiOtm6FAkAn/nMcRpym/H5sef0jGIwkrUV
         tLwolxxlY2XsPKCaF0xbymfeCaY1Hq907coV8Zw6hxw6wNXfYr+nCLLPk802VL6TABR1
         /AsvnTwig1HpADoh7G5FgZXLKdb21qGtFg8IZlz278T3+olPwVMLfgNcIELbi7EHQ4vC
         7GZrgr+RAaWiPwJExR75DR3ii1+aoyX+IwH4hix33v79fnoUDre8FPgL3smYBJwkKbz1
         9mSQ==
X-Gm-Message-State: ABy/qLYYaEqttETdmdbFQB2UPWz44M2996XrXTgyWfN8F7EcifQNLmWD
        izqIJKvoYu/BgJc4KxPT1fp2TRbEq1OOi0Fczsg=
X-Google-Smtp-Source: APBJJlEf//tr/JzH2tEXtaLjx28hEl4Xu/NsRumDDcx/vKSvONN5yyLt61d78dw5Ndg+lpCdMt8+vcQ0I4Ae05d/Hno=
X-Received: by 2002:a67:e8cc:0:b0:443:5981:72ad with SMTP id
 y12-20020a67e8cc000000b00443598172admr6919656vsn.24.1688483644488; Tue, 04
 Jul 2023 08:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-fs-overlayfs-mount-api-param-v1-1-29afb997a19f@kernel.org>
 <CAOQ4uxiOsHEx30ERLYeLdnOdFG1rw_OnXo+rBbKCY-ZzNxV_uQ@mail.gmail.com> <CAL7ro1GgW-2gUhB=TBxwDAiybbQBbFabkU2tBNbBH85Q_KZWew@mail.gmail.com>
In-Reply-To: <CAL7ro1GgW-2gUhB=TBxwDAiybbQBbFabkU2tBNbBH85Q_KZWew@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Jul 2023 18:13:53 +0300
Message-ID: <CAOQ4uxhkMYMnPL81RoWdnxCsiNtf-AbBVPcRj=hbo4vd8yp=QA@mail.gmail.com>
Subject: Re: [PATCH] ovl: move all parameter handling into params.{c,h}
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
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

On Mon, Jul 3, 2023 at 12:16=E2=80=AFPM Alexander Larsson <alexl@redhat.com=
> wrote:
>
> On Mon, Jun 26, 2023 at 4:40=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Mon, Jun 26, 2023 at 1:23=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > While initially I thought that we couldn't move all new mount api
> > > handling into params.{c,h} it turns out it is possible. So this just
> > > moves a good chunk of code out of super.c and into params.{c,h}.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >
> >
> > Thank you for this cleanup!
> >
> > Alex,
> >
> > I took the liberty to resolve the conflicts with your branch, see:
> >
> > https://github.com/amir73il/linux/commits/overlay-verity
>
> Thanks, I took a look at this and it seems good. Updated my branch to thi=
s too.
>

FYI, I pushed this cleanup commit to overlayfs-next, so
you can rebase overlay-verity v5 on top of that.

I will send this cleanup to Linus, so we have a clean slate for
the 6.6 cycle.

Thanks,
Amir.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76705E5532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIUVa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIUVa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:30:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BC85A8F
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 14:30:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dv25so16545223ejb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stonybrook.edu; s=sbu-gmail;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=S6OlODLlRXmKNL50YCQqt5lgeaLHQuWL/ZJMAREBJ0A=;
        b=Caf11FqlvGUab3Tifw+V44ztFnLp5/fDqGIpoMIQIDrWIIV7LaoLOZ9oRm1su2M8Lf
         I5Vt6IVH8xprpDrg12FVR8ObSewEwJI4qB01meW6l8CbPHshVLZtUGqggLApgIx19rUT
         GIAlPzpHLqHtP0KrHSv+EDv5Br/G+5nbjinIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S6OlODLlRXmKNL50YCQqt5lgeaLHQuWL/ZJMAREBJ0A=;
        b=RUixMrGxY1Syx2+3lsxqSRRp+W6uW97+OdPuRm8znlS1XSTU/IQ8uKEN1IXK1d2ImY
         RujXlAtOgJ2vuvqCeaXcvXTt7U4fyr9PWQbS9hKrjGc1mv7mxKUlpP17osOLgUYoue5P
         Xm4eQSVJo4V5+pDhQWz3uq/qMNJxSHK3Eb8Pi6RCb/3XtyagJz84gBTk0VkqrecLp0nF
         AdWsPlmBIdhrntl1xj/3PEWZqBfGJx2kp7eemResBLynUpJ/b92UMSG/hCLoGjVQvQEL
         Zjw2dUS9UjZIutEYt7wbBGcR7+V0tOx+PNcst/DhaWbwBTc280yjI++MflPZOdsAZBQ0
         VSOw==
X-Gm-Message-State: ACrzQf1cXZU2pvTdL6NZbyi9cOK0T0vfpQtGSbn/9oxqDDd6kLJ+I83E
        1hMXXoPqfY+6JmHwApx9QTNW6UKGUQLTP6bJweg89A==
X-Google-Smtp-Source: AMsMyM78m/PWvYaqpBf48Y65NI+GdYJh6wJVzsI5jPhdy/wHwbA88IRaEy9tHXwgYnxZybuGcbowj1RObia+ntX3VuE=
X-Received: by 2002:a17:907:270b:b0:77b:17b3:f446 with SMTP id
 w11-20020a170907270b00b0077b17b3f446mr189422ejk.415.1663795822597; Wed, 21
 Sep 2022 14:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu>
 <PH0PR10MB46153A784F27AE96DA69120DF46E9@PH0PR10MB4615.namprd10.prod.outlook.com>
 <513220739.132330.1661149559308.JavaMail.zimbra@nod.at> <CABHrer3ho5aAWN4KNSwF3iP=+4uLA1y9-=oF9-GzOwFewzK9Qw@mail.gmail.com>
In-Reply-To: <CABHrer3ho5aAWN4KNSwF3iP=+4uLA1y9-=oF9-GzOwFewzK9Qw@mail.gmail.com>
From:   Yifei Liu <yifeliu@cs.stonybrook.edu>
Date:   Wed, 21 Sep 2022 17:30:11 -0400
Message-ID: <CABHrer2ATkdEy-rb9H=qWeZ+r9C7sZ_Euxa=fOrHzi_97t2awg@mail.gmail.com>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_begin
To:     Richard Weinberger <richard@nod.at>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        ezk@cs.stonybrook.edu, madkar@cs.stonybrook.edu,
        David Woodhouse <dwmw2@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A reminder about a JFFS2 patch submitted months ago.

Best Regards,
Yifei


On Sun, Sep 4, 2022 at 3:39 PM Yifei Liu <yifeliu@cs.stonybrook.edu> wrote:
>
> A gentle reminder.
>
> Best Regards,
> Yifei
>
> Best Regards,
> Yifei
>
>
> On Mon, Aug 22, 2022 at 2:26 AM Richard Weinberger <richard@nod.at> wrote=
:
> >
> > ----- Urspr=C3=BCngliche Mail -----
> > > Von: "Joakim Tjernlund" <Joakim.Tjernlund@infinera.com>
> > > An: "Yifei Liu" <yifeliu@cs.stonybrook.edu>
> > > CC: ezk@cs.stonybrook.edu, madkar@cs.stonybrook.edu, "David Woodhouse=
" <dwmw2@infradead.org>, "richard"
> > > <richard@nod.at>, "Matthew Wilcox" <willy@infradead.org>, "Kyeong Yoo=
" <kyeong.yoo@alliedtelesis.co.nz>, "linux-mtd"
> > > <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.ke=
rnel.org>
> > > Gesendet: Sonntag, 21. August 2022 20:21:04
> > > Betreff: Re: [PATCH] jffs2: correct logic when creating a hole in jff=
s2_write_begin
> >
> > > What happened with this patch? Looks like a important fix but I don't=
 see it
> > > applied ?
> >
> > It will be part of the next fixes PR after I had a chance to review it.
> >
> > Thanks,
> > //richard

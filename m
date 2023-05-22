Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFA70C451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEVRdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjEVRdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 13:33:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50DFF
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:33:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso9109523a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684776829; x=1687368829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slu3gux4GuUHwh68X0h4hh6LgeEzWMQzZomXLQPnCh0=;
        b=Ljg4LOy0fHrVHwQrC6CFPRl2RBlB71H4nfxmtrAN37UAHfFvzivakgEuSCbqDA1N+4
         i9+SneFGnaWeVgwnYb9dbnOzwq8hgg370KB87G8X/9Pg+cm8yutJsa3CPJ4QGUp1mYpD
         A3AKz+Vz4rkoke6nYDDwagdl3BNnF6xBH56y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776829; x=1687368829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slu3gux4GuUHwh68X0h4hh6LgeEzWMQzZomXLQPnCh0=;
        b=TC+HFUIsNSXDbVHGweuvy1444lm3FP6Ulr3T6Wg7XSKvj1LJHT8StOgoOLwwBL/OZE
         CzKDpr9jJLyXu5I3Bol9+81fg4QTXxnP0ryWS6GzdJIL5RnQgdjfTRpmhHeMoZ7DuRxQ
         4ZWWsjYjK7gwhN8DbY1OILjhVDNmuCGvb6gnaxy0V3V93AXK96FrNt8+srDsg4MVJf9V
         B9sLVg8Cc6tF6Gof4WbYeEcbt1CLwl6l1Wd5JH+Xblgf55z1jLXFRt14r7uqmHAptm5d
         wTvoNpOqWebTmosBwIhPu02r3xcIwxcH467stsKWSr79I4T9JLrT3RVn2JWTV91PFmdE
         VaaQ==
X-Gm-Message-State: AC+VfDxsiCayu0wnMKg67HqJbaMJ4azCgX9pMdIsTZSueJZJ9Nhjd4yb
        mqLlCxdokVQnUbhbjihh19S59Z+NZDvTrEUvpxyWiw==
X-Google-Smtp-Source: ACHHUZ7K6LCbuTKFb/M3lcXkFyzScJeyNRF66il+9nGFXdiJBelS2OvJZDFtaBBo28ny9gAF0eyG5g==
X-Received: by 2002:a50:fc17:0:b0:504:9393:18b1 with SMTP id i23-20020a50fc17000000b00504939318b1mr9994561edr.9.1684776829132;
        Mon, 22 May 2023 10:33:49 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id n2-20020a50c202000000b005067d6b06efsm3310998edf.17.2023.05.22.10.33.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:33:48 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-97000a039b2so184348666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 10:33:48 -0700 (PDT)
X-Received: by 2002:a17:907:2d23:b0:96a:928c:d382 with SMTP id
 gs35-20020a1709072d2300b0096a928cd382mr11676946ejc.48.1684776828268; Mon, 22
 May 2023 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
In-Reply-To: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com>
Message-ID: <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com>
Subject: Re: patches to move ksmbd and cifs under new subdirectory
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 9:33=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> Following up on the email thread suggestion to move fs/ksmbd and
> fs/cifs and fs/smbfs_common all under a common directory fs/smb, here
> is an updated patchset for that (added one small patch).

Looks fine to me.

I wouldn't have noticed the typo that Tom Talpey mentioned (misspelled
"common" in the commit message of the first patch), and that
SMB_CLIENT config variable is odd.

I'm actually surprised that Kconfig didn't complain about the

        select SMB_CLIENT

when there is no actual declaration of that Kconfig variable, just a random=
 use.

That thing seems confusing and confused, and isn't related to the
renaming, so please drop the new random SMB_CLIENT config variable. If
you want to introduce a new Kconfig variable later for some reason,
that's fine, but please don't mix those kinds of changes up with pure
renames..

                Linus

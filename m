Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D984FE5E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357709AbiDLQdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357699AbiDLQdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:33:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04E5E765
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b21so33138073lfb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIrthwm6tdm2aQE/w3RNrvd+PErUsx9KWtS5YZPvaAw=;
        b=QGf3FpzYei83T8HcSKJorhnUgZvI/5VvV6a5G+/cctmgZ7rbbAyy8V4DbgESDpmRSm
         5IhZjCeNh0R39MUfLo4qjqE9YtmPT9mUmXL/HkUI+lrl1aydFAm9T+bk+e5KxKCcsLk2
         MHB4LP2yINUa4X8UmpyEErsSopyrheuUpxe/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIrthwm6tdm2aQE/w3RNrvd+PErUsx9KWtS5YZPvaAw=;
        b=VVeoBBCmDUJis7wN5ZkV7Sx2KBPkkUIP9+rHMECRMEUkvhDVFMdqOZ1z6ES3i6Sjxd
         ewaLWS8lSoKG0c6h7uRSk1CY6/fCMqWLn9aXo3Sztzto40k6JA3DqpFHcZaS7v5cspJ5
         t52SdgGk1GHCB0UE4o8ddM/Gq8amkIfT4uC1LBRj26DE4rXG0LkupnXhicVu03z7iPVr
         QGMojXdDxJxxpEZyNGN2jN6VsRPuQxRRWW3Hl15M2Mml1yKOaKh+q5jeTnSEMFqUg2by
         6Ly17UGZ7yvr6crkgjpMy5xfHPjGlZuw9GeNOxcuC/2/iYQ3um8j4nLKRVPa7ng5xXmN
         E2Fg==
X-Gm-Message-State: AOAM530QaqHSD51Sr65+wqtYfOQKCKgToAV9uYms94ATNRBisXu+aVjE
        htFwFu/7Rh4vZM+cKpqH9cDoRFLYlohh800I
X-Google-Smtp-Source: ABdhPJy8FzjDCNNaJAtn+H2RkGKSFPRKg7cMqT39A2N+0YGdZ3CVGx0LjkQgRcGWmd+HYZdelCFtmQ==
X-Received: by 2002:a05:6512:2601:b0:464:f8ca:979a with SMTP id bt1-20020a056512260100b00464f8ca979amr18105976lfb.84.1649781067921;
        Tue, 12 Apr 2022 09:31:07 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q21-20020a05651232b500b0046bacf73c9fsm41391lfe.151.2022.04.12.09.31.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 09:31:06 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t25so33112097lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:05 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr26536279lfu.449.1649781065537; Tue, 12
 Apr 2022 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com> <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Apr 2022 06:30:49 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com>
Message-ID: <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com>
Subject: Re: [PATCH] stat: fix inconsistency between struct stat and struct compat_stat
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:41 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Also, if the st_dev and st_rdev values are 32-bit, we don't have to use
> old_valid_dev to test if the value fits into them. This fixes -EOVERFLOW
> on filesystems that are on NVMe because NVMe uses the major number 259.

The problem with this part of the patch is that this:

> @@ -353,7 +352,7 @@ static int cp_new_stat(struct kstat *sta
>  #endif
>
>         INIT_STRUCT_STAT_PADDING(tmp);
> -       tmp.st_dev = encode_dev(stat->dev);
> +       tmp.st_dev = new_encode_dev(stat->dev);

completely changes the format of that st_dev field.

For completely insane historical reasons, we have had the rule that

 - 32-bit architectures encode the device into a 16 bit value

 - 64-bit architectures encode the device number into a 32 bit value

and that has been true *despite* the fact that the actual "st_dev"
field has been 32-bit and 64-bit respectively since 2003!

And it doesn't help that to confuse things even more, the _naming_ of
those "encode_dev" functions is "old and new", so that logically you'd
think that "cp_new_stat()" would use "new_encode_dev()". Nope.

So on 32-bit architectures, cp_new_stat() uses "old_encode_dev()",
which historically put the minor number in bits 0..7, and the major
number in bits 8..15.

End result: on a 32-bit system (or in the compat syscall mode),
changing to new_encode_dev() would confuse anybody (like just "ls -l
/dev") that uses that old stat call and tries to print out major/minor
numbers.

Now,. the good news is that

 (a) nobody should use that old stat call, since the new world order
is called "stat64" and has been for a loooong time - also since at
least 2003)

 (b) we could just hide the bits in upper bits instead.

So what I suggest we do is to make old_encode_dev() put the minor bits
in bits 0..7 _and_ 16..23, and the major bits in 8..15 _and_ 24..32.

And then the -EOVERFLOW should be something like

        unsigned int st_dev = encode_dev(stat->dev);
        tmp.st_dev = st_dev;
        if (st_dev != tmp.st_dev)
                return -EOVERFLOW;

for the lcase that tmp.st_dev is actually 16-bit (ie the compat case
for some architecture where the padding wasn't there?)

NOTE: That will still screw up 'ls -l' output, but only for the
devices that previously would have returned -EOVERFLOW.

And it will make anybopdy who does that "stat1->st_dev ==
stat2->st_dev && ino == ino2" thing for testing "same inode" work just
fine.

              Linus

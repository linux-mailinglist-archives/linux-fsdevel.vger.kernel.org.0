Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48C4D1F15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbiCHR2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349300AbiCHR2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:28:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2F5574F
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 09:27:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r20so26017958ljj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBQK4ptu5eu2CzXY/y3b95Ceol5gDBseg1AS4dXHJSU=;
        b=QU6dkM5L6DYfyvH3o0dpNFOmDFylySug8m5L3qgKK6V5c8lg8QrTruPxg85qI+5sPk
         LkI5S5XEiNwiuN1kP91fSxyfy5flySXCqOk3vBfhsp6fjOxF8K8sHKh8L3to/d668dCH
         7E+gqw0RScaNfcrTSTDNHD/elU9jbJacJnGLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBQK4ptu5eu2CzXY/y3b95Ceol5gDBseg1AS4dXHJSU=;
        b=UdXy+3z6UncUxAdneAFlOK1A7m+a5yGlTZUX5WBnE1/A5LkwYQn3dv0Fm2bWKBOdls
         uetK4odHzPxcoUaAdAVL25vIxfAsbrmx5+SBLMcy19Tl4ZVO2eJFhxcR4ow16QhFqPxK
         7uxcV9Ao/B8D9iR4WrpjDuV8tYa8LAk680nEKcoKoCO80hIZZltb3lnA+HSFXHP3PvRk
         P1wRIE7EKwaJS3VY19fEfCAmhytvhY73F/JrtbGuI4cRdPAxokoWAUaxDgG5IoQEOrp2
         1n3LEv7l3uyTSEH73hw5BM5z9c/AyJaZKf22MQQAVqxxym41s6qPk8YgQkS37NQS6RtK
         Nxag==
X-Gm-Message-State: AOAM532bP/NQvvLJenSsqWO7lpqJ0yVCOA5R25kT6qgL+pJO0c3XKXHt
        YijZGpb6Mgk7VMZ7hbaIX5LavCi7p2J1jBj1VtU=
X-Google-Smtp-Source: ABdhPJzLOKF97rfVn+U7dk9cx7qelorw4sfFN7EPvYyZ4rsWT193Fs8YFBxhmMItEtsBhjbMBGjk8w==
X-Received: by 2002:a2e:9d88:0:b0:247:fd40:a321 with SMTP id c8-20020a2e9d88000000b00247fd40a321mr1098986ljj.62.1646760430933;
        Tue, 08 Mar 2022 09:27:10 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x33-20020a0565123fa100b00443d3cffd89sm3577474lfa.210.2022.03.08.09.27.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:27:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id bu29so33602372lfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:27:09 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr11552290lfb.687.1646760428865; Tue, 08
 Mar 2022 09:27:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com> <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
In-Reply-To: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 09:26:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
Message-ID: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
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

On Tue, Mar 8, 2022 at 12:21 AM David Hildenbrand <david@redhat.com> wrote:
>
> As raised offline already, I suspect
>
> shrink_active_list()
> ->page_referenced()
>  ->page_referenced_one()
>   ->ptep_clear_flush_young_notify()
>    ->ptep_clear_flush_young()
>
> which results on s390x in:
>
> static inline pte_t pte_mkold(pte_t pte)
> {
>         pte_val(pte) &= ~_PAGE_YOUNG;
>         pte_val(pte) |= _PAGE_INVALID;
>         return pte;
> }

Yeah, that looks likely.

It looks to me like GUP just doesn't care about _PAGE_INVALID on s390,
and happily looks up that page despite it not being "present" as far
as hardware is concerned.

Your actual patch looks pretty nasty, though. We avoid marking it
accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
but still, that patch makes me go "there has to be a better way".

                              Linus

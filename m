Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE504EBAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiC3Gp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiC3GpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:45:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61C6C909
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e16so34043987lfc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhApYI2LhMGRpUg9dbvqs6hE/OBEtlG9wuXkddgwS8s=;
        b=ENqimhI30I1agwzDUDYPRCDpYl5zc0ePCljA3xasBaqRjZvYwvemAE+pwSf26IyNBv
         r0cr09lcgPFqgoYQUgAHxi55Wvl8uj7N0yl8LZ/1gsfWMOgPVKr9SvSiz61x3x5impXj
         R3ffuT0McnEAalObMBRL3KHFYIauMEFYx2Sr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhApYI2LhMGRpUg9dbvqs6hE/OBEtlG9wuXkddgwS8s=;
        b=0LYbwuA8T1NpPtJrp0NdsMgtAWVTr/v/BSFti9mTn0JDJ+zVqbVLYZ25FhG8qUFmWy
         3DmTCHwODt0FFMGSZ0qiAQmqsC8z4V/TO08lAIFFKxuHjpxTggZK/ox3URz4ZAstoMq9
         ILtAhhaJF9vIqE1sYMsFVkC5V1XCMEqmVU8H7bDuxKw7OBoGKEzW9rcYEx2dgYzYhYyU
         CVRtSyhMqpREWeJMJXPCAGI80I0zLXePiFsVvBBsPEr3tTjvJLWg+l3QkgmtPxpcgwfe
         y85UZKO2wDBTdNDR7cogsmCVfXROI9qCmD/9aFfXmHRWSE8YVgq1wALdgmJmYPuLUFI+
         unow==
X-Gm-Message-State: AOAM531y2GQWlILSFbyPOLmI59rfLS9q/o4F7ZJ/1Fh0fOZMwnkR10tv
        OJWhoMKY0AHPqNRRM65cNXUo4Xzsezkb7Tk5
X-Google-Smtp-Source: ABdhPJwW5vPw1Lo5CLTBWn1pg6ie8h3MTIzrh9dtXAsDOS2iwB3q1UXwK8RQ1yAZ1ZnVPqxH8htXbg==
X-Received: by 2002:a19:4351:0:b0:44a:2190:3d0e with SMTP id m17-20020a194351000000b0044a21903d0emr5687299lfj.169.1648622614235;
        Tue, 29 Mar 2022 23:43:34 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h14-20020a0565123c8e00b0044a2ddb6694sm2231212lfv.124.2022.03.29.23.43.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:43:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id bt26so34080450lfb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr5682187lfb.435.1648622612260; Tue, 29
 Mar 2022 23:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <YkPo0N/CVHFDlB6v@zx2c4.com> <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
 <YkP2hKKeMeFrdpBW@zx2c4.com> <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
In-Reply-To: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 23:43:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDKYj6VrRyzMDPB593o3oLf2GE9sMDuxMFB3smakbEHQ@mail.gmail.com>
Message-ID: <CAHk-=wjDKYj6VrRyzMDPB593o3oLf2GE9sMDuxMFB3smakbEHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 11:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I'll apply that asap.

Ok, pushed out. This time with no last-minute patch cleanup.

              Linus

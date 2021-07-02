Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098C63BA412
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhGBSwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhGBSwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:52:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CEAC061764
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jul 2021 11:50:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so19746750lfr.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=M7diCQUwMpzKQ1GXJoVPs9ZHH6w/FGKZMDIDOCrHx9bDTbOzzu8tbcnHNGtiUjvfRe
         7nD4xqc8ZKvmjMItQppsaUWB7+CxM4/HXNOlQPoFXIptkAOTbwmoM8RuNSbTOSK9Qk6c
         MNnPD0+78LLKPaN9r+5vwqH2uhsVbhc4Az2RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=n8bL/3hyGfs3ZCU1o+q5OL8IB6g9tEZFZH7FDAmS2GQ5we+VJ9dhuWoHzwbTVs305Y
         XVnj5FADimCNSDtPRGfJmfJQTarr+Fgs88PYH+v23/zpCOpYp6tMZu1pHYILbZBFitfa
         axYJQl+bd3MpYPJ1YFeUufP9IVwb/SFfp0FK5Uvei4AuJdy+pRwAAXDVkE1+skU03pRq
         EWfoQ64G/tlF/PfxCLtNwd+EJQRKR278DSHDX8AYYOkYGpOCTRXQLzaTQv9etwB5zRgX
         jnv8Y9akQOSmIuSl830/1ccvKHDd9kZtAJ7cD9V97R2XdIfbIpAgvrJOHmKCEBvdh877
         ZxNA==
X-Gm-Message-State: AOAM533N21+ystD9Zc/660i3qskK9VTKXjvMDrAgus8m1WWJ9tIr8MRA
        G9uCGbzszxZix0byc8e6wuZUmhSC5NMVDkm/
X-Google-Smtp-Source: ABdhPJzAdcO2PCmzgzgpDSvTV7UikJgZXkpBNQpresVbMchuFzfwXGGjKpPgwZpOggPbtgyPwtoNBg==
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr758208lfi.174.1625251801479;
        Fri, 02 Jul 2021 11:50:01 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q24sm372995lfj.200.2021.07.02.11.49.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 11:50:00 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id bq39so7163853lfb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr716901lfa.421.1625251799639;
 Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 11:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Subject: Re: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:24 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The git log short summary between good and bad.

Ity would have been really good to have a full bisect.

But from another report:

    https://lore.kernel.org/lkml/87ade24e-08f2-5fb1-7616-e6032af399a3@nvidia.com/

 it seems to be commit 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to
release checkpointed buffers"):

Ted, when there is a fix for this, it would be interesting to see what
made this all work fine on x86-64 but fail elsewhere...

         Linus

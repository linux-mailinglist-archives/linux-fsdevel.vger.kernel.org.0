Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B7215439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGFIy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGFIy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:54:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792BC061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 01:54:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so31087878ljm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
        b=GwK48GhmFmirpg3fdswa9lBUePOmYDIUGRR8hdVDdkSej4xaxCeCZAFSNgxfHMX6Yy
         w9Kla9Zz94g96jzu2SdkDHlz3/g7x+cSsfL0CLrYgCZP6J19zRAdLsZs87JfMO7sIJE6
         hD8DhDJnDAm0DcZzdnRoijixEc6U2wSUxDKr/PyrnIZ6sDA3NJltPdTHsLduPer5Awad
         NUwH5K/XHmbz5gpeAqR5kYWsh2PSuS+J5l9UTHxPSnjzSl1GyAg/pMTCqSfzmJ/+quNd
         zVd7EeWl6Jy5ia0GEmuuMG516H4zo1kh4cHrXJacH0rZz+cmV3uWqvNIF5fVl3UCZoOV
         qcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
        b=ggc2sSlfdoPddHYNOLsT2MMs9URSIU8rz+PbiGO1TX8UuLsDr1b1UmnvylFmuxkh4n
         yqQL7D3apdshptCJ24kj94WSBCVWzcslAHdF5ySHaTRg573+VkcSZZDqX6FM3D68j1mr
         2SfpNFXnjtLWqYh5v4mNFsBsLt2IWIQqwEvBrz8h07QUCH8/D+rBDmfu9yw+FhoO656b
         jTJYbst84So+QyHDrH2kwmTUA2yf6hq2ANiPaJ/abIphLg4MPQeI2o7rDx6JsPZMWLON
         2SAYyq9nczVK2iRA8lj8JKqny6SmQUKSwkfnOxqWNHJ7RK9wVbziKxzxXNjBar5Mvtad
         nxGw==
X-Gm-Message-State: AOAM533yBmt8vJmSPh+dQt5j/SGG/HdWm1oX06R/9q8li/PPSL158lZD
        HNvOL7o3IHxMsOARpMZMnnsanXDW5F7ugfwSyD7wyw==
X-Google-Smtp-Source: ABdhPJylBq/GlipYoQiOaeWdyv7Nd1mhikRAHRzoHcrBYF2Tgt2xn3B345Rezd2yDNMo2CkzdbSQ8juxx+Oe1fm99VA=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr10720535ljc.104.1594025696518;
 Mon, 06 Jul 2020 01:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org> <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
In-Reply-To: <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Jul 2020 10:54:45 +0200
Message-ID: <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 29 May 2020 at 08:22, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
> >
> > This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> > to set the underlying filesystem into 32bit mode even if the
> > file handle was opened using 64bit mode without the compat
> > syscalls.
>
> I somewhat belatedly got round to updating my QEMU patch
> that uses this new fcntl() flag to fix the bug. Sorry for
> the delay getting round to this. You can find the QEMU patch here:
> https://patchew.org/QEMU/20200623100101.6041-1-peter.maydell@linaro.org/
> (it's an RFC because obviously we won't put it into QEMU until
> the kernel side has gone upstream and the API is final.)
>
> What's the next step for moving this forward?

Ted, can you merge this patch?

It seems QEMU is happy and AFICT it uses the approach you want :)

Yours,
Linus Walleij

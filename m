Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2A2EB846
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAFC6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 21:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFC6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:58:51 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D066C06134D;
        Tue,  5 Jan 2021 18:58:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f6so1477371ybq.13;
        Tue, 05 Jan 2021 18:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXNN314Ke16i8waxDdpAwNKO1Slgul44h60adPucfvM=;
        b=FWbO71su7AGP3jCSwoHF9Ad9eOQ0W49rjRbTJ9Dln4nezajQIVMflxewsq2o4csbdG
         FD2VJK0MLugciYNLBFGQHEjwYExF1x56/J9BFQb+Eg15JazOSrVWuBT2T1izWAMeeQcI
         9n7lNYF9a30jQSaGqK2IuApXqbgEX0qSa13KjJBVNLlJle6bEwiYIv69YUrGK4Sme4CF
         KDl+Do1YaPAK7UJTFOxmY/SVPd4CcC9jzNgLunEk/ldke2Gs2xUf2JWJpW2VlSj0M0Ge
         ikS2TjnkIL7rRzG5K1n/MItMUUimH2FVrkfdW7z7HOFqvVMAS9U9isSFd2PTckHv2n/n
         dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXNN314Ke16i8waxDdpAwNKO1Slgul44h60adPucfvM=;
        b=WoDzgkNvOZs6OjLxIsrdH+ltwLCwnvXqnw6d4EvdSfuY6SDtYMMjQJueiJ93Bsmvlb
         s5WetYnKvU3JFAyOlCLlS0Y4XIWLiY5ASlAOQ+a0G4suxbBEybiKRFilnYA5y5tsoGHe
         jSDeqTJBBdmldvo5lK1IejaA+MpGbCaFe6jveIjKtYZrUNHlxm9NGpFsfa0ty1bpZAYs
         9TCj08Wdg5aWP+MqTAo7jlWbedNfg5d7NlAAaaU41vWgebZ3Y421XVys1vrKhMcEP6EL
         AdTIIqS/REv9mKDaRXyVcLy0rFqP47MAUdpIN6OOdvMTEIOUsrijXcN7Z+p+Z149Q+Yx
         R9+w==
X-Gm-Message-State: AOAM531j1HQkgkRXlV7u5c+cmX+z45afp/vou6zQj8BizhDsTpOgH/mZ
        8TJ8yRdxvCgJtKv7BfQyqe19eNWP8/dRceHm1wg=
X-Google-Smtp-Source: ABdhPJz5Mi3VKFUp+su2qq+CfwGFcjkrNb/ZWEwdVEs1xlhm7ATYLb1y6lZ1o2f/AR3j7aY/4cpUyE1Ji+muhMvmeyE=
X-Received: by 2002:a25:40d:: with SMTP id 13mr3520172ybe.422.1609901890523;
 Tue, 05 Jan 2021 18:58:10 -0800 (PST)
MIME-Version: 1.0
References: <55261f67-deb5-4089-5548-62bc091016ec@roeck-us.net> <20201222210345.2275038-1-ndesaulniers@google.com>
In-Reply-To: <20201222210345.2275038-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 03:57:59 +0100
Message-ID: <CANiq72=4Ym1JR-PJDTgAgYe2mKFy1_LEkhNbxvThz-6JcShdnQ@mail.gmail.com>
Subject: Re: [PATCH] fs: binfmt_em86: check return code of remove_arg_zero
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 10:03 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> remove_arg_zero is declared as __must_check. Looks like it can return
> -EFAULT on failure.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Cc'ing Alpha list too.

Alexander, fs-devel: pinging about this... We removed
ENABLE_MUST_CHECK in 196793946264 ("Compiler Attributes: remove
CONFIG_ENABLE_MUST_CHECK"), so this should be giving a warning now
unconditionally. In 5.12 it will likely become a build error.

Nick: thanks for the patch! (I missed it in December, sorry)

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

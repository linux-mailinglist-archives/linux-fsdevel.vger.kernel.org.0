Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4509E3247D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 01:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhBYARX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 19:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhBYARV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:17:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D2C061574;
        Wed, 24 Feb 2021 16:16:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h19so4726485edb.9;
        Wed, 24 Feb 2021 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dMyBH8rlEjqz4SpSQi70uv2VmD1HrNQDiHNj1GOL5L0=;
        b=TwdyVUZlKez3JqD7Hd5bEFvh3QfmIMhHOSji7kAPwJCQX+Mf818+C169DpCoaZ91ar
         aaqi9+n/lPZ7zBxVtSshlN9dgTtk9lSNZP9WAb6z52brFh4x65afBkINHioG55jnuEY2
         Umtl0LgNrNY8TTzZGL8YxsyyhTwUhVe8CR/IAmXy/ue/YXM9piPCi8n/Aom7FZ4SJpdi
         cOwbrRCLtJSanSY6AcCUAMEYgckNuvy1J9Vi64hsW2+r6rk6GN2kSxksxwEVVfUC1pm1
         i24ruebjNy5ORSEK/rslS2aw/NT39bVTQkzDp1McCckF21oCdvb1+50Ies9cJbiCtokV
         2ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dMyBH8rlEjqz4SpSQi70uv2VmD1HrNQDiHNj1GOL5L0=;
        b=Cn1tic7F3k7nBudWFJw80BthhxN+jN2S0HzeyavGC0+J7VNdoXXXcE1Gyb9B0ubjak
         0FvasR4edRrWkNygbuxhHqcMeFykSMnpEuCaC2jwUnZ2g6TH8Q9k8va2jb+/S66xg2dJ
         EZ9MnvjuzAxGs9xPo4P06EGZS7iandxoC3b0Bkj95WPkYdJRYIRDu1uMLTcqH06mqeXb
         bLULrukTQnEDs8RNTmjdK4hx4k2cIO3ZgxkgQa0YgZ2O+3fqXWF/e9F1l8y2w0GDzmCA
         A/FBpA7L32Gbij/MMpoSy+nlBK4IBdRjLzkBk6R5WGzPeyMLXkkEnbB1WDXpoL4xmz/p
         oZ0g==
X-Gm-Message-State: AOAM53082EmLTnQu3pra6LWqR5/MvPU1JEbJVsVh3r2xYTsYTywrp/sC
        GRPp/itiZ7s0crGbgj14KzFVJZraXcYB8PchA3CjFN8=
X-Google-Smtp-Source: ABdhPJyRzNcBX08vuJKuUxot/oPyEFoGQr2mMx7+Fh7Uf2znCB566Sc49XJu+X67Ker+Jewvv6d0gfyX6U0s/urSXMA=
X-Received: by 2002:a05:6402:1283:: with SMTP id w3mr377477edv.340.1614212199483;
 Wed, 24 Feb 2021 16:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223182726.31763-1-aaptel@suse.com> <CAKywueSCbANjCzPMnWJx7CXQM4kWO4pHtAhgpwwchMqCOcV0Lg@mail.gmail.com>
 <87tuq1zpo8.fsf@suse.com>
In-Reply-To: <87tuq1zpo8.fsf@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Wed, 24 Feb 2021 16:16:28 -0800
Message-ID: <CAKywueSz=zMd2+BHnSd8Qt+t6jtqAYjCAR3N2yu5QJt9ZSD4-Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: ignore FL_FLOCK locks in read/write
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Agree - given the differences between semantics with and without POSIX
extensions we should document limitations that the CIFS client has in
respect to locking including flock, posix locks and ofd locks.
--
Best regards,
Pavel Shilovsky

=D1=81=D1=80, 24 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3. =D0=B2 03:11, Aur=
=C3=A9lien Aptel <aaptel@suse.com>:
>
> Pavel Shilovsky <piastryyy@gmail.com> writes:
> > If a flock is emulated on the server side with mandatory locks (which
> > is what we only have for SMB2 without POSIX extensions) then we should
> > maintain the same logic on the client. Otherwise you get different
> > behavior depending on the caching policies currently in effect on the
> > client side. You may consider testing with both modes when
> > leases/oplocks are on and off.
>
> Hm.. you're right, the write will fail on the server side without
> cache.
>
> I guess we should document current cifs behaviour in the flock man page.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>

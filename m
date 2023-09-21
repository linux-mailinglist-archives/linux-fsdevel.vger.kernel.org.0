Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FFB7AA129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjIUU6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjIUU6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58930AE5F9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:05:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so21639741fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695319533; x=1695924333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gG7qoYapCoCxR2tv8KlJJWnTME84A3UgPPc6D1ZRfI=;
        b=jiyZk043VxEStcWtqseC0WMaDQd4EMYv322Gd10ItlmlSZNbV9ec4qUi8WR0uE3tBh
         LWvvJc44+UbrTKYScZj02Ut6GxgoPVadkH88kdytsLpkGu0kHwfOY1UYC6PM+2T1m/JR
         edkIzQMaYHBtOkSyCBgtAKa29OC3NNJTrEcaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319533; x=1695924333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gG7qoYapCoCxR2tv8KlJJWnTME84A3UgPPc6D1ZRfI=;
        b=rPsU4JgZorWKhE7ZePEJl8nUP0HPbUwvydNXT6zihgWDB91bBF7r7Om6Ep+SV5pYk/
         W0PYdMzawY8EnolRromX/0GpzO1L/QppQxc/AxnH2yH/Zd3ZxXJDfxIHX2J7MgDEVO1m
         GR4CIv4xHhhdasi1cRsUoPYaDb8D1/KUd45/bVNwDSezD4h5uTm2eZvFzYkJ/GdmvdPQ
         9tgNXdgOmGX3RIA8VSEaTy57pkEpKq47Hf+sSoZFe69Hg16uxSaRs01cIMn8dSfcl2gQ
         m7JM/gTOVqAlp9kpKfeahee9RZ3ru4Wgn3idAr3Tgvrzx5gxfTk5YmzkdPs1HkfeOOlE
         2/dg==
X-Gm-Message-State: AOJu0YxlNEM5e48V/bF+xDmcL7J0TZuFTi/9Nurl00fWaKr2anFhH+cD
        RY1l50+Wq9vWNtZG3D4VKey9ryeXvbLvKe9c+1qB85+LJeG4zpNJsxU=
X-Google-Smtp-Source: AGHT+IGsdKFPbsxNlJGeh++dlmQkw05L3zFOAYhD98y1hIgsceTBri/g0lpQaOwwuUec0Xx4Y3doIMPw2AujLWoEYeY=
X-Received: by 2002:a17:907:1de4:b0:9ae:52af:1128 with SMTP id
 og36-20020a1709071de400b009ae52af1128mr2809376ejc.70.1695284480739; Thu, 21
 Sep 2023 01:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com> <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Sep 2023 10:21:09 +0200
Message-ID: <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 09:33, Amir Goldstein <amir73il@gmail.com> wrote:

> In my example, the server happens to setup the mapping
> of the backing file to inode
> *before the first open for read on the inode*
> and to teardown the mapping
> *after the last close on the inode* (not even last rdonly file close)
> but this is an arbitrary implementation choice of the server.

Okay.

So my question becomes: is this flexibility really needed?

I understand the need to set up the mapping on open.   I think it also
makes sense to set up the mapping on lookup, since then OPEN/RELEASE
can be omitted.

Removing the mapping at a random point int time might also make sense,
because of limitation on the number of open files, but that's
debatable.

What I'm getting at is that I'd prefer the ioctl to just work one way:
register a file and return a ID. Then there would be ways to associate
that ID with an inode (in LOOKUP or OPEN) or with an open file (in
OPEN).

Can you please also remind me why we need the per-open-file mapping
mode?  I'm sure that we've discussed this, but my brain is like a
sieve...

Thanks,
Miklos

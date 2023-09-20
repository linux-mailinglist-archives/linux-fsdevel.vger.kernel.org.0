Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526027A8B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjITSPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjITSPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:15:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A34D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:15:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c008042211so1211071fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695233712; x=1695838512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXVio9tohshy862s8EiV/jvdkaq8/KEsoyWzPpoZOoI=;
        b=WmykMvYSEgv6iWEzek07aypLNfsybQh2afY6+ZB3YXCdN2njUyDrzXPrZY1CW+GyCB
         nKgQfhwXQLf7Mfz4UshMo+ITdGjYmA1VLUAjF5rfNph6iUqe2FXOfCCnclfAJe4ZsgGy
         3Mws6cb3SB8lVvM1+WLACfTmZZc1YN6/pv2YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233712; x=1695838512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXVio9tohshy862s8EiV/jvdkaq8/KEsoyWzPpoZOoI=;
        b=DX/ymO7JgD8MRz7DW7gg1xcLYsngzd/EZxzEUl80k+6Dz2IgLTCiauCwbKktNNowO+
         LZ+g6Xx97OH4QfGzwLfrtMs+NiPRI9hbuzam4FLyhqWmqtRJj7f22bMcAV6aCcrGp5p3
         486iS3gB4VPw9zeDX0PoJm33RojnDiaGqMqED9PvUg8ZBIpPHA+SLA/GFq03f2vtsv9Y
         9MG36VGDduomOzr3roJPXqbbLkEu9+WuN6iRl3qEfLMISDR/QTL5NIN538voj3+cB1FN
         NS3jDg1dQ1H33/xR6ExMox+u8nAPSB5OnZXmu6jm9tLpSg0CPAN2WtvmG2SLcZ/Se7UB
         pbjw==
X-Gm-Message-State: AOJu0YyoRUR3o+195mCliQijFDMSc/y5rxFQwGgYKA+OtUsM/1wUCOiq
        L6e9danFQOrK6NV1OVtfagxTrEXnAD7o11vMQ7fRCw==
X-Google-Smtp-Source: AGHT+IFQHPYMBQNN4sgmA4V0kanWryXgjdlNqiNGy4+cNY8cDRlIWVgbRfAFdRqYzMemgCJbMQe3i0I2qeY55HGJt3I=
X-Received: by 2002:a2e:9295:0:b0:2bd:bc9:30aa with SMTP id
 d21-20020a2e9295000000b002bd0bc930aamr2602954ljh.23.1695233711791; Wed, 20
 Sep 2023 11:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com> <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Sep 2023 20:15:00 +0200
Message-ID: <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Sept 2023 at 15:57, Amir Goldstein <amir73il@gmail.com> wrote:

> Unlike Alession's version, this implementation uses the explicit ioctl
> flag FUSE_BACKING_MAP_ID to setup an "inode unbound" backing file
> and the explicit open flag FOPEN_PASSTHROUGH_AUTO_CLOSE
> to unmap the backing id, when the backing file is assigned to the fuse file.

That sounds about right.  I'm not sure the flexibility provided by the
auto/noauto mode is really needed, but taking this out later in the
development process shouldn't be a problem.

>
> FOPEN_PASSTHROUGH (without AUTO_CLOSE) would let the server
> manage the backing ids, but that mode is not implemented in the example.
>
> The seconds passthrough_hp commit:
> - Enable passthrough of multiple fuse files to the same backing file
>
> Maps all the rdonly FUSE files to the same "inode bound" backing
> file that is setup on the first rdonly open of an inode.
> The implementation uses the ioctl flag FUSE_BACKING_MAP_INODE
> and the open flag FOPEN_PASSTHROUGH (AUTO_CLOSE not
> supported in this mode).

I think the natural interface would be to setup the inode mapping in
the lookup reply (using the normal backing ID).

With your current method, what's the good time for establishing the
mapping?  After the lookup succeeded, obviously.  But then it might
already have raced with open...

>
> The "inode bound" shared backing file is released of inode evict
> of course, but the example explicitly unmaps the inode bound
> backing file on close of the last open file of an inode.
>
> Writable files still use the per-open unmap-on-release mode.

What's the reason for using different modes on different types of opens?

Thanks,
Miklos

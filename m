Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677B5F99FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiJJHbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiJJHas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800B2037F;
        Mon, 10 Oct 2022 00:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1079060E15;
        Mon, 10 Oct 2022 07:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665E2C4347C;
        Mon, 10 Oct 2022 07:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665386659;
        bh=doWHn3YXVgjgCuArkfQPGiV4kODoLQkQt8cleW14+ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DVqZTbjxXlTHKDXkMZReegJsAhe5028y79vzP00pLl+JRtBH6HR4KZZ4ymti9ECfi
         sO0wvgOdfitSdX+tSUP7AfL7nE2qvTrLXYpajnGHVxgrUgksGRFhMdTMJGdDn7PEbu
         gPXrM+PWVDTpnOisOJt779iVB9P4a1sav1YZJUW0G84cm1KJYvz++83ST2NVhyKCU5
         KK6Pm90eecH3YbAslB6rYhy2Nt1pC5ClZLjb6dcZWjfdFbRh81TfLOUuCtlATaMORE
         ve9AAPM5PwVKiA9OMS8PGutlej7asU2PUh0szL/wPs2bHGAeXl6nxNy/fXHnqDa/1E
         ya+oebhl2HI3w==
Received: by mail-lf1-f43.google.com with SMTP id r14so15349756lfm.2;
        Mon, 10 Oct 2022 00:24:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Rc4uChfoBinBdl6Tp1Kdd++mWPoaIZcUGeoTN5+a51ILp2J+n
        0jIGw+mZQmAl8zSXjvl0sGFMH3lLLBHO/iqQSJo=
X-Google-Smtp-Source: AMsMyM7yd2tkbcyx7SY4api888o2ZGJu0D6juTOx2jXmntxmjEtrLVh8I99B3d4tEeMQBa6zM6Mfhbr1WjNEAQM0SEM=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr2537450lfb.637.1665386657320; Mon, 10
 Oct 2022 00:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook> <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook> <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
 <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
 <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com> <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
 <202210081242.0B0F8B7@keescook>
In-Reply-To: <202210081242.0B0F8B7@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 09:24:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF+oWGF7pe8kdwp-rmz3+VWsgqR4K3SHdSyLwoO2VQq4g@mail.gmail.com>
Message-ID: <CAMj1kXF+oWGF7pe8kdwp-rmz3+VWsgqR4K3SHdSyLwoO2VQq4g@mail.gmail.com>
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Oct 2022 at 21:44, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Oct 08, 2022 at 07:52:48PM +0200, Ard Biesheuvel wrote:
> > Again, please correct me if I am missing something here (Kees?). Are
> > there cases where we compress data that may be compressed already?
>
> Nope, for dmesg, it should all only be text. I'd agree -- the worst case
> seems a weird thing to need.
>

I've spent a bit more time looking into this, and it seems the pstore
code already deals with the compression failure gracefully, so we
should be able to just use the uncompressed size as an upper bound for
the compressed size without the need for elaborate support in the
crypto API.

Then I wondered if we still need the big_oops_buf, or whether we could
just compress in place. So after a bit more digging, I found out that
we can, but only because the scompress backend of the acompress API we
intend to use allocates 256 KiB of scratch buffers *per CPU* (which
amounts to 32 MB of DRAM permanently tied up in the kernel on my 32x4
ThunderX2 box).

So then I wondered why we are using this terrible API in the first
place, and what the added value is of having 6 different algorithms
available to compress a small amount of ASCII text, which only occurs
on an ice cold code path to begin with.

So can we rip out this layer and just use GZIP directly (or just use
LZMA if we are obsessed with compression ratio)? I am aware that we
will need some kind of transition period where we need to support
existing records compressed with other compression types, but I don't
think that is something we'd need to sustain for more than a year,
right?

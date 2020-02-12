Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE015A360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgBLIec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:34:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35182 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLIec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:34:32 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so1036317ild.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j/svfKaOLhoaBXf9xolfDPb9BbUNyifdFqflAWmeNnU=;
        b=N4szO5XUPRjGCoUDsNAd9a++zJ/nXsIdAJ5sFtmc2IRUF3NJlEdhuHi3PHX00g/LPC
         d67VX+gCs+1vWyj2SwCGzhnRKyzp4CQrRz2TbO6csDRhf5FR5Tc+/ZUDiyp4uJYAU7YV
         kedtxWfeVeCJAqm4hNAxWRwmVc1wi8bKYL6Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j/svfKaOLhoaBXf9xolfDPb9BbUNyifdFqflAWmeNnU=;
        b=HW4hKVktG6CnAI7yvxPtbEAru/iN54OHgB+r9hF9pauxxoWIDGoMEGmF0Wgk3K1/St
         VOgIYjIS8x/gpsasq9kTruS6qnOgY/NoxAITGAUBoK5udZ1sa4Nl6JtmuNj098gc+Ro/
         m49MGJIs7HSXIfuxz0sFn42t6y/QC+90ca+NoKh4tv23cWyneSDjuu5aYSXvcLmFSpqx
         t8hCjThYFnBIcsXubYPCKB9CjUBwNlcNNzMpVrDOIbnXUFvEs9SAxLMiZZW8niRqBtG8
         H/pujvtQNg0idEp4bKyamfvcn18SX2bgricSZzQAobnSHdAdNUWsOSNtdMVWnPmS94s7
         TKvw==
X-Gm-Message-State: APjAAAWQPNZTJkaCndVo0OSlWjNFtCZwXsGaYyso5vXHkPVWhl4zDtXA
        zlU3Yyfyo9wW/rDAyF35/ODQ48VVhN73H1e198cgoA==
X-Google-Smtp-Source: APXvYqy8h2tyK3hSrA4TOOjqLJYAt5Ufcai/fgsNx+gKoX1dBxHTfHaxCX+V1aWTbwdMgXP0dbZWRfbELgMhToQguG8=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr9956076ilk.252.1581496471825;
 Wed, 12 Feb 2020 00:34:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch> <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
 <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
In-Reply-To: <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Feb 2020 09:34:20 +0100
Message-ID: <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 8:58 AM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:

> (gdb) p *req->args
> $5 =3D {
>   nodeid =3D 18446683600620026424,
>   opcode =3D 2167928246,
>   in_numargs =3D 65535,
>   out_numargs =3D 65535,
>   force =3D false,
>   noreply =3D false,
>   nocreds =3D false,
>   in_pages =3D false,
>   out_pages =3D false,
>   out_argvar =3D true,
>   page_zeroing =3D true,
>   page_replace =3D false,
>   in_args =3D {{
>       size =3D 978828800,
>       value =3D 0x2fafce0
>     }, {
>       size =3D 978992728,
>       value =3D 0xffffffff8138efaa <fuse_alloc_forget+26>
>     }, {
>       size =3D 50002688,
>       value =3D 0xffffffff8138635f <fuse_lookup_name+255>
>     }},
>   out_args =3D {{
>       size =3D 570,
>       value =3D 0xffffc90002fafb10
>     }, {
>       size =3D 6876,
>       value =3D 0x3000000001adc
>     }},
>   end =3D 0x1000100000001
> }

Okay, that looks like rubbish, the request was possibly freed and overwritt=
en.

> Independently, as a separate test, I have also modified the source like t=
his:
>
> bool async;
> bool async_early =3D req->args->end;
>
> if (test_and_set_bit(FR_FINISHED, &req->flags))
> goto put_request;
>
> async =3D req->args->end;
>
> =E2=80=A6and printed the value of async and async_early. async is true,
> async_early is false.

Can you save and print out the value of req->opcode before the
test_and_set_bit()?

Thanks,
Miklos

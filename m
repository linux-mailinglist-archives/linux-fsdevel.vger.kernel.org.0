Return-Path: <linux-fsdevel+bounces-74247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BFD3894A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28ADD3049E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFEF311C32;
	Fri, 16 Jan 2026 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQW6Sx4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF0288530
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602856; cv=pass; b=ecYzkw5L59YwHRDQYEw2Fu+4F2Bz1OUKbRjTjbLHHkqgel19jAtJQlfcJZOJmZ8on9xZB8eI6rU+hSuF9TrAUGHrssB2Ivt+BeGmsD2nYz95amE4uoczaeR7VRyj3KBMnF0Jm8+SZbUS/osPtwE6V5Pv8fR7X5NxJ1VECjBwhVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602856; c=relaxed/simple;
	bh=ngnRdojsz7sahJ6vKMtNpNK25ocBKdo7RbojSLoUvsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOxqaxWErTTOcNGmr8kytcABIoBqsJtDkrfGTw/+EwcZ9TS4solrFqvgdv2Oh3rcwi5+fGJZqBUaxaeZAR1FEGNXW1DexTp5bAo9gssvwPESTGpKcOxulXZHudrYl4VzIxY8KcWuELK+JhZ4Vgdnkq+UAXdp0Xc/8/OoNz5SPzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQW6Sx4h; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014db8e268so37535341cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 14:34:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602854; cv=none;
        d=google.com; s=arc-20240605;
        b=SpVUb5qTpRtdAP2BR1jbjP93VvYHsXUbzJNMRFjzURhxoX37PY/8X31KuFEY1RjrJP
         GAmMfGoMop425IyS6l0DmRM0Mqpn3ieNprwZ9HbDTMyuQw3mgYAWcWYfj2eiDTTX3Flh
         WE/rMiy7V+saRVNZ/hqJ4gZlUAk6DctZiXbYr8jW0OWDwuHxVe3hNGaU1pJzNzu8yFTw
         0nAd9W8RFxdY4VdG9GdRu1ALcIPnY1ssCyUNjsK9YDIK7M7AAfwaFJs0sbTm/hkoR9ho
         2k76f5Oxb8ijnAV19O1XaEJDobs5V6eUPaEG0ItRdbp8I2AI2C0wHRChU55x9rXbw7lg
         hLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75/NrbCEScTtCn7V32nBbQG9kbGh2kWAqzhzkaDKKF4=;
        fh=UwXMCHRrAA/z6dFIW+XywrVCsPopB86YfA7/K8HkuNM=;
        b=c30RKNdCSufg4rAISdS974b6BDcYaXws2MhO8C8tcmr69iuxhlDzYxPPUF2mxizqrd
         DavmGlReqKLVQuOTF5b3Ib594I/kqq82DyST6KBsYwZ5hpBWPjyKBSUm0NIQjHOZWVlF
         WmaViR0OlC8E22lzV8AV7QLJOwsiEvDKS2S1Xs4HwvEwBvN+iW9ynbCz6/2ZhgqV4QRP
         PqGQQzHgrujSlyAGbgeB62j44Yu2YE9qs8hRh/sJnAxZIHcqtnHYr8D43SFU+Cd8d/wr
         pJ5Ps7Nbh2QgqBaQiQ0zTkfqU2OeLbzJOaJz9R8dUA95uZdZntHr5yTJ4rRXN/hB5n+7
         3/ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602854; x=1769207654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75/NrbCEScTtCn7V32nBbQG9kbGh2kWAqzhzkaDKKF4=;
        b=ZQW6Sx4hJi7YyXLKKbqcYFT2GEf+mZUqan1rBgsNb9vnLhttkg2xBl6fN2+IFqmqNi
         WrowI/IMIe3OK1Un5YM/Gg6Ky8fl9XLUWU7BZMnvuP8Wm0LVpbjxXJiuzF6euG0IUi+1
         depKzLsTcjYmyxA+wMltD1HiNEeSDFF3p2RpQa75w8+8zVi8hObDJy7n5U/4fAw+fHYI
         iEOn1wUYvnJpSXIGNswHDcy1Bk/XX3a/ULOjj9n1igiZNI437rSJZcHEYGHA1cuZAd7f
         TdlUdgDIYqdQJAesgRAguZj404Y8UFs98kG61h+xvImIdJM8KYDUpMnWO1WTh8uwRMVJ
         h33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602854; x=1769207654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75/NrbCEScTtCn7V32nBbQG9kbGh2kWAqzhzkaDKKF4=;
        b=MIsbQjg5y0rGl+HnqGIp2GBQuobBPBUy8GG2bmr81jx3AlGzG7KbTisWTAXaU32tLR
         LIZF4blsbBBgJwJob/FBETKzi1o1JmBIzZIbBIRr4KOU+BUVLBwCA9btf70XccryH7TL
         aPhU/GZEogbla9/wsI/2MykeTbcCMbiLc9nEskUIqsqp6s+uVLPJUb3MgUuSfRRv0qMX
         XqOqRTgYUWu0OrUExgxJCSpg01VBh3kLWbCENaBKraKfLIKXgXb6WPI3a5nMZOTHvqUf
         +iWntEuuupmaYjQjxHsv+OmWZDdeCRfYTClOthhXjbVaCZGw5kgU9BY6/3g9EfgJJyct
         wF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJaESxIUPPQLuQGH/2/03fc+Gn4KFgotfD3lVMKJcRr2KACyf/mmu7feijxHoDAvrWPWYsNZu+tCnea3cT@vger.kernel.org
X-Gm-Message-State: AOJu0YzIefc9fjgBTF7H0OEdO3PIpqzgoYpB2LqfZ2dFxuO3vYgOzC9V
	+AZ/OtA+/qMXw4Qg2e5+vwUJx7WnNhlq0DhVTgKroqVTtdILw3NmlvLrfANzOh0lmoR93wPZhw7
	iPiSRG3+0J1sswS6Y+VGuo1XpNAnEtjA=
X-Gm-Gg: AY/fxX6VTyVhRarV4Ejvvk8eMY+fpPV8jdhMmUjatXfejBJesXUpqATsYNDhBB1jzFQ
	62weKO+hOrWU0tq968QrIhj3AwcRe6dg5hHSf2omN21iWrlARGciBvwcxbA4qcjIAOl1/81ABAJ
	hQ9BW0u9wCzlhe+WLnCne2hlqhsgpJ0jxn3nX38PQSlEiucZyE/j3lhw1ZHXG7M42y+fCpQ80JN
	synA3Xu80RM5oGjCr5PGVQARTdCExiS/BCmMKWuQKLW6UWJb6P8DWhvcHHo5w4+fiZBiw==
X-Received: by 2002:a05:622a:11d6:b0:501:19f9:3267 with SMTP id
 d75a77b69052e-502a1e1d28bmr63451541cf.6.1768602848961; Fri, 16 Jan 2026
 14:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-15-joannelkoong@gmail.com> <a27b24fe-659e-4aa1-830c-7096a3c293b8@ddn.com>
In-Reply-To: <a27b24fe-659e-4aa1-830c-7096a3c293b8@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 16 Jan 2026 14:33:58 -0800
X-Gm-Features: AZwV_QiiMEB70mjQQtE-ONSiuvMpiyLjC7vn_qltG5J3j8DN9QJHbzP9RyC58ds
Message-ID: <CAJnrk1ZC0x14Oub=_Ah0zdEo6Rhy7Q5c4DkY-bNbeae+Tdb52Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] fuse: refactor io-uring header copying to ring
To: Bernd Schubert <bschubert@ddn.com>
Cc: "miklos@szeredi.hu" <miklos@szeredi.hu>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
	"csander@purestorage.com" <csander@purestorage.com>, 
	"xiaobing.li@samsung.com" <xiaobing.li@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:04=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 12/23/25 01:35, Joanne Koong wrote:
> > Move header copying to ring logic into a new copy_header_to_ring()
> > function. This consolidates error handling.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 1efee4391af5..7962a9876031 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fu=
se_out_header *oh,
> >       return err;
> >  }
> >
> > +static __always_inline int copy_header_to_ring(void __user *ring,
> > +                                            const void *header,
> > +                                            size_t header_size)
>
> Minor nit: The only part I don't like too much is the __always_inline. I
> had at least two times a debug issue where I didn't get much out of the
> trace and then used for fuse.ko

Unfortunately the __always_inline here is necessary else builds with
CONFIG_HARDENED_USERCOPY will complain because there's no metadata
visibility into the header object which means __builtin_object_size()
can't correctly determine the header size.

Thanks,
Joanne

>
> +ccflags-y +=3D -g -O1\
> +             -fno-inline-functions \
> +             -fno-omit-frame-pointer \
> +             -fno-optimize-sibling-calls \
> +             -fno-strict-aliasing \
> +             -fno-delete-null-pointer-checks \
> +             -fno-common \
>
> After that the trace became very clear within 5min, before that I
> couldn't decode the trace.
>
> > +{
> > +     if (copy_to_user(ring, header, header_size)) {
> > +             pr_info_ratelimited("Copying header to ring failed.\n");
> > +             return -EFAULT;
> > +     }
> > +
> > +     return 0;
> > +}


Return-Path: <linux-fsdevel+bounces-56687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36592B1A9C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433E3164EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE72235364;
	Mon,  4 Aug 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUdbm84A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B831C5F09
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336878; cv=none; b=YQjP+1CwM9+nHzFNDvuviy1UQtyuYBj493I6xwoSPG20Hu4Q8QLHYH7HklIogJGPHrnXBG2pwMBvmTEdcLiwOlzvHrP/asCXFzVYDT2N2GfyXnzGIkXEILP6CEuO2nzh8/N1PjyArNqxhJcMz1ikp3rETAUVMsLo5p5KkVOKOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336878; c=relaxed/simple;
	bh=QTWznTbgv/hmeJ1fBa87AUszKW8tkF7EzOr0/pR1stg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKcL7HO/fjOl8vfYw0wi+1LV9Z0W+rNt4Q8tkgwP0CMyNRwXkBMelwkrqIIyLHb+w1FhXiOVWQFlFCdmA0LX+EQWkJFIksvaJZShdcLqVQxDGK/SWFh+1AFMb2xDzWp9FvD5M2t/DsnPL/QXyqbp/OpeDRBv1WqCXvhL2Jj/OHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUdbm84A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0673b0a7cso136051cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754336875; x=1754941675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrOnGWzkIooUjPhodPTfN2zjEbxz+9LZiG9j8SdmlDM=;
        b=QUdbm84AxvEaZku+UwbYsF5aJ+a5Dl8DvJnpDUuO4gOoy5AvA062yn5zEZW6Ut5VfW
         I/+i+jWSorfUzwYEmu5MI3nVt6zMdNmy9XqbWGs4vpJF31kRqqckoGthgMd08WZJ8YAa
         FvZLyfBL5iqnM9f/0V3lrfW+pn4lz9WrxRmPjaFXMVZ5IcrGnB4vY1GmUcibvkyU4+Gh
         9lbY3vilh0eFnQICF9fcuFFGJ3VMvHmmV3KCumeboS6I7ihkrKXCUWtebLU9CgCft3rV
         1We7Dg2MqR9zNShLLIfZDkfXKEbB9U2jvTbA5vGLF2RP6rVB0pCMfMg7jXZi34Bw1IXc
         GOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336875; x=1754941675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrOnGWzkIooUjPhodPTfN2zjEbxz+9LZiG9j8SdmlDM=;
        b=PaKgZF2CSDhIzyNMkUtfct23mVULJGGCwzPc+jpbZoS9Qj4U6ty9E5cQI6zWur+370
         W8hscg3yRe1fm/4GW8iNzbD3T1RwW1MW784u4BvbXgHEyjJroY2XADYx/oQTbwS21QZN
         4ryX5uKnd1VOt3bypJK5TuaMqJPxZUUsJipR6xfq6IApD8sUo92nyXOx0SN1EndH3Amr
         XdjbwlSu51rFccdImQk3IO4MrkJcnAGn5m4wsSy6WE3LgIo01i7TZ1I4+iM2n7KLFcdS
         Z4NeUIumM2F3v7jCiNUe0sIZTImjhzcFYxqPIldKr0b6UaZB9p8cRukPcv+pIGN051wl
         QkKg==
X-Forwarded-Encrypted: i=1; AJvYcCUP2vgYlEyj8YU8/hYVGg6Yz6/siDWehCJrbr38grqanEooczxiNwP/RRbpXS1dzxZ2f95qmmufSFvHxlCD@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuLbKwALC4zJU65D9PXnudEP2SaGRPPr9UVAVxP2UCj/J6fMP
	wlR5nNbjL0P9DO9oMYnnUMQp4rZTLDky6UDUy5z31IlESbdqUHNfejvWDwQF/nGIwQ+DBzYpXdo
	HxCRwEdPx1d8R/GXHDa/RDUeUC6ug8V1OxEILfInu
X-Gm-Gg: ASbGnct9sSVRWDwUGkOl4a4rPgWuKJPl+ShpU2PGg9drLBwXLZD5F2Eb6GP0F7W25S4
	LPIEoao3kOmUgIdqwo+cXo8ctuuoppDC0QZBngohGaTEnmS30aPkqKEZld7GtKA5raggHTotiqW
	ZqGtYZrWnItHwycrPKxISjIqWUkAwLjB8RJETdupXRvWOKBeOJdLL/PQp4PKKOwmUp3kAh764LB
	QT268p2gpvUFKO6vb4vG3WWoGMls2YlcWR+WTM5sd7UIbKw
X-Google-Smtp-Source: AGHT+IGGkXixoGEopgPQv5ZQ3AULcDnsyZ7goBmJ8ApcANZ57+NTCDIxVUNfKMZhmEp89RWhBkkf8KOQt4ycU2NrFZ8=
X-Received: by 2002:a05:622a:287:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b0810767b9mr725341cf.3.1754336875055; Mon, 04 Aug 2025
 12:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803204746.1899942-1-hsukrut3@gmail.com>
In-Reply-To: <20250803204746.1899942-1-hsukrut3@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Aug 2025 12:47:44 -0700
X-Gm-Features: Ac12FXxSpVG6cJouTBBDIkB3VjU9nbAkPZdRVTaV_ZXsscSmQ5CiigJdhAnw-OQ
Message-ID: <CAJuCfpF8+MJ2xmS+dC2O3LLtorW_ugLNJozZw-KM+7fmnSHFhg@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix string literal warning in proc-maps-race.c
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:PROC FILESYSTEM" <linux-kernel@vger.kernel.org>, 
	"open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, skhar@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 1:48=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.com=
> wrote:
>
> This change resolves non literal string format warning invoked
> for proc-maps-race.c while compiling.
>
> proc-maps-race.c:205:17: warning: format not a string literal and no form=
at arguments [-Wformat-security]
>   205 |                 printf(text);
>       |                 ^~~~~~
> proc-maps-race.c:209:17: warning: format not a string literal and no form=
at arguments [-Wformat-security]
>   209 |                 printf(text);
>       |                 ^~~~~~
> proc-maps-race.c: In function =E2=80=98print_last_lines=E2=80=99:
> proc-maps-race.c:224:9: warning: format not a string literal and no forma=
t arguments [-Wformat-security]
>   224 |         printf(start);
>       |         ^~~~~~
>
> Added string format specifier %s for the printf calls
> in both print_first_lines() and print_last_lines() thus
> resolving the warnings invoked.
>
> The test executes fine after this change thus causing no
> affect to the functional behavior of the test.

Please add:

Fixes: aadc099c480f ("selftests/proc: add verbose mode for
/proc/pid/maps tearing tests")

>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks,
Suren.

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testin=
g/selftests/proc/proc-maps-race.c
> index 66773685a047..94bba4553130 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -202,11 +202,11 @@ static void print_first_lines(char *text, int nr)
>                 int offs =3D end - text;
>
>                 text[offs] =3D '\0';
> -               printf(text);
> +               printf("%s", text);
>                 text[offs] =3D '\n';
>                 printf("\n");
>         } else {
> -               printf(text);
> +               printf("%s", text);
>         }
>  }
>
> @@ -221,7 +221,7 @@ static void print_last_lines(char *text, int nr)
>                 nr--;
>                 start--;
>         }
> -       printf(start);
> +       printf("%s", start);
>  }
>
>  static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps_r=
ace) *self)
> --
> 2.43.0
>


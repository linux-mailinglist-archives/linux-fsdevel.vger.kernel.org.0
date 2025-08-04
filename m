Return-Path: <linux-fsdevel+bounces-56692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED91B1AA87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E5180A63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D523A98E;
	Mon,  4 Aug 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhHLNfgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52366215055;
	Mon,  4 Aug 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344143; cv=none; b=LViTGcxi5jrCo2LnqIZ4JWXtXWpY/kiuPjWfNTXhfVIujdkaaHG/kiv3fPBxfGccagEMYNlCPoVpytcKlyTYCcNnaSkRrz9xAazeu6w1XF6mBMoAXvNfovdoLddQSU+DGyrrRc0hL22ojM8VynrMAR2v93bICEmDcXgAoug5z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344143; c=relaxed/simple;
	bh=2x8KOgz2q7JfsX+Pl5gpGDVIep4NWKJe4BoPRF/W+iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We/MwCuVBG94IAlh/O0xG+jOae/NI+Bc8o6yP89xwt5i7ATs0lybX794MHXnT9ZSKWW1qRKpv0xDY6ucpBxZIiWKqjabDOXJdw4v/5PA0fKct4uYb4YQL4NC9e4RHtKIRBzEt8H2So3k4gik4s/GvLt6N9ZPRI7vYd+Mad/RTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhHLNfgx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-555024588b1so4751114e87.1;
        Mon, 04 Aug 2025 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754344139; x=1754948939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muTFQg3ki9PD9IOpXqr9RHnNzLZ07myg3+n31XmzRDU=;
        b=RhHLNfgxPkJaruuE6OH4KYocN4ndikgJ/q86exc/ssqy4FNt3lCuyCM8xwF9+7CGAi
         NVqVl8v8rF1eKY4xalzO6Ul/QxvP+sq1fJ+AnbzCU3tNPH0uc8YFW4a61iYjtLvaqE5Z
         Oy75zcz792GDIBuvEcZzxT2eQB8EiW+Z98PQE8RpKt0F5S/xehm4L1oEWMOB1/f+9wxU
         N6ig4iRgNkzmHx+qi4vpy83mfKI+caJBhpvcm5v15yiJf2InhjYKmPWldyZtbcsMYRQj
         hXVeyQ4ZWdZ3j4eJeeH8DJGDnfDAi0yDm0+xopatNxBgxHCiP1vhjx2LHiavWM0t2ihl
         Lheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754344139; x=1754948939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muTFQg3ki9PD9IOpXqr9RHnNzLZ07myg3+n31XmzRDU=;
        b=nUCmYxN2RZ4ILVpn/WEvBJL1fj3J5oKOvsgi8KrW+48otQNUeR2g64fJwB/A/cYBRh
         e9/uMpFQCj9ptKfSWWZjLcK7Uppu5aJKT9fCuH85K1L9Cs68EvBZ3UCJx7ZUqZ/OHNHT
         tsTXmT9gnFmiD0BJ1xMMQzNCs+I/CXEBP+L9q77g5XEMXlnMLBZt+jZ7+7b2uhvjStlO
         D5xdGEb70yeCbfRUwa3vzHh4f7Qoxs/SBA/tc219/WmiRIr6aXb1nsTlV1jt+gL1PJ/5
         UDF3D5hdQkJS5/dlA6kN9DkRs9q5jVnRPmHQe2GC+0RpIMGHwS8t/l4X6p/e4OA6y0io
         cavA==
X-Forwarded-Encrypted: i=1; AJvYcCUXhioUGHV3anRphXieoqPi5A1zC7R5tq/Hqeg7kvUkhRAGJFxBJSluTGvDfMmg+OutUXUjXxGMMPxS+1mj@vger.kernel.org, AJvYcCVWdUFFxwgwjOncTO3v62soNduB4TYn7nCnMit4NpoffJhLcpdobS+VpZE7kB2dc0A19knLu5Ug8avN7E0hgP/x@vger.kernel.org, AJvYcCXT21JRZo++epWxee0LR+426SWamsxCunmrml5uWZ8NsAz7TPwQq009uUGbdSrVFkVYU4mV8BVcM0lSF1Z/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UIVcmENYtT2gqd04Hrfh29dIADrFzBtRqifZ8iFZ+g/iGQqh
	aCm4l5SIubS7j4oGlKWZOq09t1wo6LB4j027p5RHMxBTeMlUIocR4UhQ03f7H5CuzJytWCAcrxQ
	d4fJ19h3ROm6h0vMe6D5MfS+MJGnVYr8=
X-Gm-Gg: ASbGncuUSkmmTPMlPhzp5BaE/CHm0YI9VhQaUbC3E1p8Uk4wtUAUagfesAY27mDdb4W
	vzjfr5SmAGcOAN2h3OuZvd7yBkl6TKAudl20v7ZNPVqQ9aNxVLNveVmWyvMCMcbQIGUplCNn6m+
	RIUxS0MVEXf7MeXJSWmT/81D7L8im1S824fvGsfvacJ/uYj6121WMi+uEYE0mXaccTmGugWY9bS
	M8Keo8=
X-Google-Smtp-Source: AGHT+IFlZbW5lOCGSQjJt4+9a1bHOnV+gUrJQ5yivlFyz/JksHbYESP3g6+3UY9godJESN82MYvslsY/wq3q989OsgY=
X-Received: by 2002:a05:6512:3b87:b0:55b:9595:c7cd with SMTP id
 2adb3069b0e04-55b97bd17d6mr3134536e87.54.1754344139144; Mon, 04 Aug 2025
 14:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803204746.1899942-1-hsukrut3@gmail.com> <CAJuCfpF8+MJ2xmS+dC2O3LLtorW_ugLNJozZw-KM+7fmnSHFhg@mail.gmail.com>
In-Reply-To: <CAJuCfpF8+MJ2xmS+dC2O3LLtorW_ugLNJozZw-KM+7fmnSHFhg@mail.gmail.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Mon, 4 Aug 2025 23:48:47 +0200
X-Gm-Features: Ac12FXw563ckk6p2a5b2SueZmIkjD4EhqnLA6zSn7xgCZHTjWW399iUzCrYmTHE
Message-ID: <CAHCkknoxpKV80-S3jByY1xnRXd1Pr=v=D2a0ZcgnY0-Hnya56Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix string literal warning in proc-maps-race.c
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:PROC FILESYSTEM" <linux-kernel@vger.kernel.org>, 
	"open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, skhar@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Mon, Aug 4, 2025 at 9:47=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Sun, Aug 3, 2025 at 1:48=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.c=
om> wrote:
> >
> > This change resolves non literal string format warning invoked
> > for proc-maps-race.c while compiling.
> >
> > proc-maps-race.c:205:17: warning: format not a string literal and no fo=
rmat arguments [-Wformat-security]
> >   205 |                 printf(text);
> >       |                 ^~~~~~
> > proc-maps-race.c:209:17: warning: format not a string literal and no fo=
rmat arguments [-Wformat-security]
> >   209 |                 printf(text);
> >       |                 ^~~~~~
> > proc-maps-race.c: In function =E2=80=98print_last_lines=E2=80=99:
> > proc-maps-race.c:224:9: warning: format not a string literal and no for=
mat arguments [-Wformat-security]
> >   224 |         printf(start);
> >       |         ^~~~~~
> >
> > Added string format specifier %s for the printf calls
> > in both print_first_lines() and print_last_lines() thus
> > resolving the warnings invoked.
> >
> > The test executes fine after this change thus causing no
> > affect to the functional behavior of the test.
>
> Please add:
>
> Fixes: aadc099c480f ("selftests/proc: add verbose mode for
> /proc/pid/maps tearing tests")
>
> >
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks,
> Suren.
>
> > ---
> >  tools/testing/selftests/proc/proc-maps-race.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/test=
ing/selftests/proc/proc-maps-race.c
> > index 66773685a047..94bba4553130 100644
> > --- a/tools/testing/selftests/proc/proc-maps-race.c
> > +++ b/tools/testing/selftests/proc/proc-maps-race.c
> > @@ -202,11 +202,11 @@ static void print_first_lines(char *text, int nr)
> >                 int offs =3D end - text;
> >
> >                 text[offs] =3D '\0';
> > -               printf(text);
> > +               printf("%s", text);
> >                 text[offs] =3D '\n';
> >                 printf("\n");
> >         } else {
> > -               printf(text);
> > +               printf("%s", text);
> >         }
> >  }
> >
> > @@ -221,7 +221,7 @@ static void print_last_lines(char *text, int nr)
> >                 nr--;
> >                 start--;
> >         }
> > -       printf(start);
> > +       printf("%s", start);
> >  }
> >
> >  static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps=
_race) *self)
> > --
> > 2.43.0
> >

Thank you for the review and Acked-by.
I will add the Fixes tag and resend as V2 shortly.

Regards,
Sukrut.


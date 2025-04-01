Return-Path: <linux-fsdevel+bounces-45442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5FA77AF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719CF16BEA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240B202F8D;
	Tue,  1 Apr 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1pmv1Fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32371EFFB9;
	Tue,  1 Apr 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510504; cv=none; b=tSNCqA9g1KKrrfdswOvtcbJ+ouoPaySO2UW7hnGljNT0MV707gwjseCo1xEyjFGTWOeSZrsbUKBPxHu5BF+q8j5jg/RCqyNhujIv8QxItbaj6xwn1oCn4tcwjr7Awj1zzQWeA9IITdbMl4LM++fl+oCc8waOz4A9N/Mqzk1WYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510504; c=relaxed/simple;
	bh=m4laPdMmU46byYc56nGcmaELtOKUu7C5XqlobFaRd10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syDD0B2Rgucz9fimwM6335Z2sFTKjBHDBEzzedPLnq3ZWJoseQeAagv6Tq/Th3zRWhceVY+VNG3+IRiS/C0d0PGGrRHhM/GmhvmkZqCLv2W/HBy3unrQOZKVHBbhVE3TPgmhPB+UcAYMsUOaA14oF3sUx+fCZ/DX2ddRBDB1kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1pmv1Fi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf3d64849dso845644166b.3;
        Tue, 01 Apr 2025 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510501; x=1744115301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tYwt2cv0fFgVs6/0Lv6OgdTM1+86ji/NbaPbN5vO9g=;
        b=T1pmv1FijRu2aGaoENBVI0O/ZO+CnbyThLl8JGxx1uVekMGOGk2Ldngc9V67kuW2mE
         7bESmXc3CYnKYJ5/SHzYHj1GSWsKhARBdjutiDSqOX+an1+IuqwV/I9pIaNM63wzCaPV
         Gu6mmbBMF9JxtL9DIpScR2l3XLhkEYgZJiSurMC8UHF5G6sMVjXZBJszdssLlDIrY4LM
         KgZ6Ed+HsyqO7uYgRS+9TTtMaiYLMUoUqyDC0ax+jStBmxh/P0ulYDcKrsnEpqsjqGoM
         tM/ZTPc/nO76ppOboDvixRVkyMwh+P1lgVuZx4PvNiKz80W/oOKqBQjaFSmVGx95XpUj
         QBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510501; x=1744115301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tYwt2cv0fFgVs6/0Lv6OgdTM1+86ji/NbaPbN5vO9g=;
        b=BxV30vZnJ1TFe6XUkOiWDaENn2mEx82H3N4zBNayndRRQdH6apZ2r9YimaxcgyFJUl
         VDWdulSDGki6uXtv9O6PCABWNRqRhsy5CWnhghGXGrjZ1tqcUeBRIY+jtZ3rIl/Wz8ar
         g2uWGz+sm7z2D42AJDOzBMq5022Zh26/QK9KK7QB2EiGJ9tViLFlQQsrW7QT0LWZHElt
         r35KtliFQlP7iGTNiwzpT4Sctcybw4GHCzdlo/NSN/5DZloGzX7SmFi68zLok6CpSdar
         biwkWxqzXpVFTTQn5wquxoj6/qoMRMv2BIwudBbktoGmc+q6UtJWR1n938pgwl2WbDbP
         eIug==
X-Forwarded-Encrypted: i=1; AJvYcCUS8VDpmtPGPH6Yfd9eK00bo91pUCh5VJdUc7NBDFGHirLIsRtTltKq8QpvQVwTOACL+bhho9p6F0qj9wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgbZFpfjpIOG9zIrHSXKchcDm5ht/LNbkDSIGbNb9kZPHV8h7
	ObhuFIwQqOQu6ypafjAwP43kkENygFV+gEp3xopYeUzsqIgAGDpL3wjNIKzjvGTXSVtHT8BzSGK
	7yiHEFN7hxRnBEhYIhIP6pzacht1ey+3V
X-Gm-Gg: ASbGnctZnCTt8MkjbNTlNVjw+V6EgYl2uL3zY1pxpYDnFp6Zeht8QkYZWKFwvqwd3Os
	bcEycXwyffEY7Cy/Ufafl/zFenkd1sg7H94bzMQDrqjb1uxLWU1dlDrT6FpYZc1japacfy7N68K
	T2/lYyVFiaWZyr2N7q7Ovy9ccH
X-Google-Smtp-Source: AGHT+IHrbEHEVghunvMZXU/YsBgllcTk8T1ugLlKN0mOrZpfgHp/483PsY4Jm+oKLcnw9kgXwRxnrLARUM2byfYdiiA=
X-Received: by 2002:a17:907:a08a:b0:ac7:1ba8:d2ce with SMTP id
 a640c23a62f3a-ac738a5a614mr1094831566b.32.1743510500931; Tue, 01 Apr 2025
 05:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401050847.1071675-1-mjguzik@gmail.com> <20250401-erwehren-zornig-bc18d8f139e6@brauner>
In-Reply-To: <20250401-erwehren-zornig-bc18d8f139e6@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 1 Apr 2025 14:28:08 +0200
X-Gm-Features: AQ5f1Jqhj1MVYH-m7Fclp96ASNuM72y_stkcpuGOzxOyF1APKBuiLznmh-uhSq0
Message-ID: <CAGudoHF_Nfjq1nLZhMbFr3GJz-z=9Z4goacCgXbifxrQX7yiwA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove stale log entries from fs/namei.c
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 12:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, 01 Apr 2025 07:08:46 +0200, Mateusz Guzik wrote:
> >
>
> I have zero attachment to these comments so I'm inclined to agree and
> remove them. Please anyone who really really thinks we need them speak
> up!

ouch man

this submission was a joke, which is why I only sent it to the list
and skipped the maintainers as direct recipients

it *adds* the following:
>  /*[Apr 1 2024 Mateusz Guzik] Removed stale log entries.

I can't tell if this actually landed because the url:
> [1/1] fs: remove stale log entries from fs/namei.c
>       https://git.kernel.org/vfs/vfs/c/3dddecbd2b47

says "bad object id" at the moment.

I very much support removal of this kind of commentary, but this could
be very flamewar inducing and I did not want to spend time on a
non-tech discussion about it.

However, if actually doing this, there is more to whack and I'll be
happy to do a real submission with more files.

Even in this file alone:
> /* In order to reduce some races, while at the same time doing additional
> * checking and hopefully speeding things up, we copy filenames to the
> * kernel data space before using them..

I think this comment also needs to get whacked. Copying the path is
not optional.

--=20
Mateusz Guzik <mjguzik gmail.com>


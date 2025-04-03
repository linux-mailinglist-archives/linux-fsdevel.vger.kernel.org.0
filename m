Return-Path: <linux-fsdevel+bounces-45687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C2A7AE73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15347A23D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99222157E;
	Thu,  3 Apr 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8p5Q01G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87C221542;
	Thu,  3 Apr 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707853; cv=none; b=jOKax9BgSfkqAr3ZFFaMWxfqs8oJraTd76c/SOqot9DYHOJj5jky1q8OaFPHZ+cfM0CyHYcGYUX/nAd4cu3ptVwAdUoyPnNh3XsdPpnxIqOzGwmrRy+R//QcJ9CDFA6sHIgCgpKGVx6oie68Ap9UGppM3z0332Se49vIhM4zukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707853; c=relaxed/simple;
	bh=OTjo/tKLR3WPYodETfsXfLg8VM23UquBH+KKE8wFJN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhKeX4BfqVvi3/0g5R7CpzHH3U6pxJjQX+iD4DCxAl0XlAmC+/Zh8i3JNDQxOZdD5yJwoV3ili4Mit2SFZ2nOYAqlZFccmf6R0x67EC67Q4K0IcHbfaMf8+1rnkxbKykdxIKjmxPO+Il2y7YRTMm0e93cjRrj8zd0FO8asOZ7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8p5Q01G; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so2189742a12.2;
        Thu, 03 Apr 2025 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707849; x=1744312649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahbiwhoPrwAtlrPFF2tpPZpPMZGZnu56TSDKHCE8CL8=;
        b=Q8p5Q01GULPzNChio9m5AwznU8sGMSa7GCsm1gHjA20V/fwjzMhDUYI4DEU5MxK9Cz
         gVYg0gt98GeoUJ8KQCNq5LEurYuo7Yxgxw/4Md3hcW226FGPx9Au76H5uXqmowRRlCUv
         GoHIe0aKHw3N6uLuqeC62tr64TrsF1BNBycczB8q9XbMJX9Fb6JK0CP/jjtvwl2kX2+t
         75I3HkYZDAWttMHMxMij1/tOjvtrTTNSuBmlVhSbCByMcOLs+nhdyfH0vz0y0cl8sA4Y
         k6Zm9ZsxjbcnRlZu0SyipbuR0ccepM3eaENLdpsQLpzPYcqX2TF/JUhnT3nByulGhigN
         r1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707849; x=1744312649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahbiwhoPrwAtlrPFF2tpPZpPMZGZnu56TSDKHCE8CL8=;
        b=pL0YxoQAQAiASYg1uhe8M9UcQi5QX7GBSBsYP9kuCS8/+dTbhArZKjU3FKo/9sdNu2
         JYpZIZjvlqcqx9LE9au/AyCRe3y7IyOroVpTbKwZiy4vQcBes0MhjNFbOms83q9H6gUT
         qCkTfomhR9m/Nthdl9uzwZCSdINzAvrkSrwQVn/t+lSx8OWmE7/luzL6TXosczzS8Ha8
         cQ15bRc3q4gbJ9exKx/MwKeuvgwgIT9XXpc+52I/NhXN7iFMhHzVvBk0H8pVrGWpFScS
         Sh3AOyBWKUbm8xK9Vn4Pdr7OX3Jb46JDPvVDVZ5xZp2FpJWcawEd+UE5poFvTQYnBUNE
         H2YA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAcM6rGL0rVc2Fchfb7nNhqj/GAJisfALFqurWsfCVNmXVl0b0tJFlp+uMGk2kKYaqsStSP0NpCMZlKA7@vger.kernel.org, AJvYcCXyzb9ZH6twrUHMMNmwu1l881KYquOCZpuAIqzNM7d7DP5wdrG9lorAfqSrI/b27bVRtRmb3w9N2JVqQ3+U@vger.kernel.org
X-Gm-Message-State: AOJu0YwCheHMlzRMIgrY5eIzccP/1L5gtjzDktdJyTMr8KJl9IvKHGM2
	11eNHbRyIRvcOfGLfWJVO72EzBpkWZPpy1E0XonJTsOVtAch5JNWjrhB276Z0edMhKw4K027Q9P
	zjGHTZpTAaCIUuc6jyFvzSlmg848=
X-Gm-Gg: ASbGncujT7pmQSSyhdQmyCAAQiBRRwHEco1Ag2yu+pQ7V3RxHXsMpGdBn/jZdiv6QBC
	PKJsiFaczHXUhO4htUUkKJSZBe2byX74hznyXTXSTUObqWNoz509un2DL7+Vm18gx5IXZZa8nKQ
	9brmk+f8z1zW+2yZuh8tql0RvV
X-Google-Smtp-Source: AGHT+IH8kmO6We3wFONetMQCKiv24i6fWBwcHdiR+O3u1Fe8qu0kbN1q7zkh0YFqhbHmFn48xCDXX9FestFkdMNkzjU=
X-Received: by 2002:a05:6402:5186:b0:5ec:c990:b578 with SMTP id
 4fb4d7f45d1cf-5f0b3bc6eb1mr261159a12.19.1743707849176; Thu, 03 Apr 2025
 12:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-vfs-mount-b08c842965f4@brauner> <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal> <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner> <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s> <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
In-Reply-To: <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 3 Apr 2025 21:17:17 +0200
X-Gm-Features: ATxdqUF2zQ0e3bF2DBKrGyKkJNg9jf0JTVYCRhBFeO2UlZcU_IpR7khItHLIALs
Message-ID: <CAGudoHGOxs0V0VHxt5MBO0axvCK0ucByXpvzFiADOVbTvhv_yA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christian Brauner <brauner@kernel.org>, Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 3 Apr 2025 at 10:21, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I would argue it would be best if a language wizard came up with a way
> > to *demand* explicit use of { } and fail compilation if not present.
>
> I tried to think of some sane model for it, but there isn't any good synt=
ax.
>
> The only way to enforce it would be to also have a "end" marker, ie do
> something like
>
>         scoped_guard(x) {
>                 ...
>         } end_scoped_guard;
>
> and that you could more-or-less enforce by having
>
>     #define scoped_guard(..) ... real guard stuff .. \
>                 do {
>
>     #define end_scope } while (0)
>

Ye I was thinking about something like that would was thoroughly
dissatisfied with the idea.

Perhaps a tolerable fallback would be to rely on checkpatch after all,
but have it detect missing { } instead of relying on indentation
level?

--=20
Mateusz Guzik <mjguzik gmail.com>


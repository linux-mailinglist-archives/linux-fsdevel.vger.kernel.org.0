Return-Path: <linux-fsdevel+bounces-41107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A054AA2AFC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059E7188B855
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AE19CC31;
	Thu,  6 Feb 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9KI2xbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80419CC02;
	Thu,  6 Feb 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865050; cv=none; b=GOPVWjoAM1nvoiNjMyB9GTCMjCjfetLuqxoPNH5O3F4Ckimz5f5eWWnhO1I6DrYwmra4igzOvVVNvhcwqtNZzw6y8GhD5Ogc3/GfFH5M+ajnISbsTFhVesAtkLsagtW+TfJ5e4nbO9vgILHw7LttlSBxnQK+A6VqVFQkNa+N3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865050; c=relaxed/simple;
	bh=l6MjXnuWAv/gRQ3hQXr7KLM26pGvUJgUnoZKmLjUOQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXuZky9MGGsq6lY35wxN7Hq/AmgSiugV2gK1x/j2TVmX2vuNwK/bkMuqDu5yq3/XkF0RHbd02oCLiwlw1NnE7cDBxvIrbo5Om0J4sz+xrGMk24XGa/+pRJsU3M8okWtTvHSqFsN4eoAwdFBxSsmspsdoWc8njDDFxZowjU0Py94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9KI2xbR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a4f1so2583466a12.2;
        Thu, 06 Feb 2025 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865047; x=1739469847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vi48hN2gJyYWaltR0StCx2mNBtyl8gr15bCCuXyAGY=;
        b=J9KI2xbRTLIMgLBMHN87ixHk9M8B0dF0Fwo3FJ78neUlb0IFPHpwEh4+6QEk2jjW8G
         kw8hNkkIYQiELLt7OgOC2I5iMqYI+cO80CMDDENk+jCkD88CqHThIEawFNtYW8XXTjo9
         bx+TR4Yyi/xi84LbUC+7Mq89ZQ/erHEhbNrJJ0hTcJ4KuTuG6PaPuFWeiPbQbk6DWbW2
         Ey5Sj3D3t4WF2RWe3ri1qTVYIVMcIFGggfs90+Rto+j/DlkPYQMAyE9B2Czk3PiE36f6
         kScAnpo6W/9qSjou7kXiuSQlAy3hNm43SWVPmXEZlRnQI8xLmbnF3cQE/HNZEEehM71E
         BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865047; x=1739469847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vi48hN2gJyYWaltR0StCx2mNBtyl8gr15bCCuXyAGY=;
        b=e8mgZfvjlgLq1pb+84Xa7UpD29bY1lCfW90kCHAv84MaT5SjqL2EgosmRU6mKXJi9Y
         5towoddXatRf1eMs6tCqRcBlDDdYF4OEIIQiGr1guOBCP+kpq11zHnTb/ZB3aAEQrlIA
         PVagzMGU7PM/p24cjcGrmNeJcSDUSzDdhA7DU4vJKFEOw+bLZl+LiaqodKaJKiPEBX1Z
         rMNABsm4ksOEn3Uth3YUGXwb4ieIX4FccbqhDMmTWYd/YE9rs9Y4gFgC/R98MIBDxjoU
         uMkYu3dF3epqJEEan/9dfaH45gaSISiYyJIe86wYgmjAa8WG70mEmXjffyfAUbprYmzH
         WAcw==
X-Forwarded-Encrypted: i=1; AJvYcCV1zkyMyWSCYIzLQhdm6xCuWTN75uqN/tFcOJdFHT9mf2368WgljM3vQjMZwzUfpepMCiSHPVrJtuMFQa/X@vger.kernel.org, AJvYcCVowFpz+5TKjovWc8OF72+uJfQ9yHORGH8OhXPGgbfYRvViyJPgb3PF0jFl10UBOYCUH+RwZm4UxBvc0MXs@vger.kernel.org
X-Gm-Message-State: AOJu0YxSriyP1Cj+rxfq5bOPg0tMjvYKBLI8Jp1VfC+8Hrbv9DmqrBLW
	3CvmvWYpev7wWd3H2ZzV66Q/of8q9IfzG4BggtCVVJ5fANsxB+FI0IMjY9VfafE5Kg4H59Cn2x9
	Ai+UnsAHfe9gcv8r3iS0Q9MJ14Mk=
X-Gm-Gg: ASbGncuAw89RPquQJTrp/4JnArX2iQ9YNmTPlcuY+ZHB4o8HAX8bs4Lar2iP7P8rXvE
	H54ObRpbE3hq0teXaRunZhpiwpaCDdpgUkHvlX1/Tbn83e/Z52NuksAzdIz6FOJ6mjSUogIA=
X-Google-Smtp-Source: AGHT+IHxLnIvE7ZLNXZBWoCm8TLsHOZBUC8zCVS5oq0xZK+xPM4+q5OSMZh6agqWRgXPxl/9GYxazO73AMJJPvsUGmg=
X-Received: by 2002:a05:6402:40d5:b0:5dc:db1e:ab4e with SMTP id
 4fb4d7f45d1cf-5de45072163mr461529a12.19.1738865046859; Thu, 06 Feb 2025
 10:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT_Qy8uWVn5dESZo8LDj_VSLAhkFfxNaTkD6ZwvYARVo3Q@mail.gmail.com>
 <6cfcd262-0fe4-4398-999c-ade674191edf@p183>
In-Reply-To: <6cfcd262-0fe4-4398-999c-ade674191edf@p183>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Feb 2025 19:03:53 +0100
X-Gm-Features: AWEUYZm25agmsUawd30oCoeygH7QeZUlpLnMw9QX3sxXqpUG28I6gcyZ9DHKWd0
Message-ID: <CAGudoHHT1bULKPy8BGnEM3gshOuLwh=i1nwuJz-vHfX0UP-LZQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: inline getname()
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 6:11=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.com=
> wrote:
>
> [cc lists and people]
>
> > +static inline struct filename *getname(const char __user *name)
> > +{
> > + return getname_flags(name, 0);
> > +}
>
> This may be misguided. The reason is that if function is used often enoug=
h
> then all those clears of the second argument bloat icache at the call sit=
es.
> Uninlining moves all clears in one place, shrinking callers at the cost o=
f
> additional function which (in this case) tail calls into another function=
.
> And tailcalling is quite efficient (essentially free):
>
>         getname:
>                 xor esi, esi
>                 jmp getname_flags

Side note is that so happens in this case the compiler had funnier
ideas of pulling out parts of getname_flags into getname itself.

As for the general notion, it is cheaper to xor at the callsite + call
than to call + xor + jmp. Also note the total i-cache footprint absent
sufficiently fewer consumer will also be *lower* without the func.

If the routine was doing anything fancy I would not be proposing the
patch. For something which merely adds a zeroed-out argument I don't
see a legitimate reason to keep a func just to xor. It is merely 2
bytes.

Ultimately this being a minor change which I don't believe is worth
arguing about and I'll have no opinion should the patch get dropped.
This only showed up because I"m looking at whacking atomics in
filename ref handling and *that* is definitely something I'm going to
argue about.
--=20
Mateusz Guzik <mjguzik gmail.com>


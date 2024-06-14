Return-Path: <linux-fsdevel+bounces-21686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9B9081CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 04:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70804284017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977A1836DA;
	Fri, 14 Jun 2024 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4RfEauM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149A183083;
	Fri, 14 Jun 2024 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332934; cv=none; b=QytSD+7Nbl0zAQ79YtwJRlprbUqc8aW+n/YYDASt/OJjREddkVjZ6UCsBTeNHy1lpAO+FczEddC5K41xnCDBBvAD1PfY02mzbzryP65XFqouEIKqXTL9NS+z5EVDco1EfkErsAPaiitNjVmbBbE26liipURkZqn1CBA7BvdKMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332934; c=relaxed/simple;
	bh=vNjTA0syhWWpwu4OQvLgeCxKSSMi3SLyACzq+WGQKdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3mzQV9l4IXGUBEnFlJ8DidJgeef9VIE5dPeZkDJMGjbZfPEa4J7TJKR63bv243DMPBsRWaDdqdFDbLkMyaYf0BnrJoNY93wwWlWBr8mjoVdhqHSivLF1/E8SaU4s4+D8FSNkPclr8saGz4TPMpXbvwaw2JxaV0ki+byDcIkbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4RfEauM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b064841f81so13799756d6.1;
        Thu, 13 Jun 2024 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718332932; x=1718937732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkn1Dqg/KvSsIEf4PMDdbgaHl7N3wpCE5dnCq2yPOs0=;
        b=j4RfEauMXjxQqQpvwfxVMUXnZh+zOan8Ibj+eIRWz/BFjPSrkoAd6y5WVXKC4mOZlX
         zpvL4mlIxlQFD0D5MWJZGVW47Ce0DqQMt0HfBCCQGKAtZ2PoyQb/Ku3FcLO25GZVRVHA
         5TnNWmKz4v4zCcKGOKvqVANbM+sAV66N+sfD8k6kd82VTyLjWqWC8k3pKJ4p2f6O+XYB
         vBRubLXoz2Ldh25ZTNyVoyI8RH3ajd1m+bnn4qpqC7PYjuMfctp44ng4KO79mQQyxfRc
         d/9z9XvfK+Drlvt6MuC9VmTjn3Uw18yrgNqGkR0kSLyQ7POkZMo56ke8SjiTHZvlAbf7
         wPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718332932; x=1718937732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkn1Dqg/KvSsIEf4PMDdbgaHl7N3wpCE5dnCq2yPOs0=;
        b=D//UuvOPEQy/YMwoXz53VwyW2Te5rtVa70Tx1nsUrbUXZAD1aJ4SIgCnDBrkkoIIlB
         sA6qlTb/An19Wo85tBce7yUa1HveFLr0lUxjsUHMjzbaqm9nFrl8dkJGhpPofDH3+o5e
         c4VaH+1ZUoYTQBlu+Aj+CGSlOlitqLfLkTUucAfmTcCa0KDVdT5a9C0+nkparn0TggBi
         JPjcqqszSgEFR+nPm0qJ/zB8w7nNVKKwSBeOh0Ptzw03vTQPUGBI+3Im4u2l+s86QxR+
         Do8eoJNTskH3hpOZzYr0Y28SF/Zcx026nG9/t5gHo1uruJkq9FN7jfcnpgweIHyO3eiS
         /UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwPgUywI3Ed4fLS1xr5h2RoxhMpv2kIIVv53YJBYH4ATYV6Xms0hDvFb0m/4GF9YJ9j+0WULCU5+U3UBmOF/y8uv47L/p8fQp+wZ3FNp9eALFptUd0iLQ8dT6uUvkJwfXh+A4ps8yhgWYvbMNF1PvG1lajsLg/pIqK7IE28Q86L4cLF0uhrm7tXF3vRrugt/CdnyveqwgGafsK7wH/uAwhZP0E5GB2tHS8dXoVYvKrmUYQ73fz+y241LWLl+IHAc2fL+87B00P5GNpLHKQZw/lorUhwt2A1ZGPxX06XGwCjxJYSzj6Og+Je0PbURTif6Q4oirJ4Q==
X-Gm-Message-State: AOJu0Yye13G9yt2IChSfhKxQ0eK78IxlaqtlIARg3FPKPs2SH6DNL/O3
	OJW6ByPDXrXE/uKr7JG8QWta7rsZccmEX594xjtSEcbHk6FeT1lkCatw9TaKRaj9xmlkUQgDct5
	0csKOaDNj1U8iU8VKttY7QulSuJc=
X-Google-Smtp-Source: AGHT+IH2yJkDatqeZR2Ou1juwPDu1s/BD6Hx184YCW7utolqXQ5u8htp4butw/HzKwBNPXerjjKUWiJm/DxherGGPpI=
X-Received: by 2002:a0c:c581:0:b0:6b0:8ff6:7565 with SMTP id
 6a1803df08f44-6b2afd6e8a0mr14215336d6.49.1718332932181; Thu, 13 Jun 2024
 19:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org> <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
In-Reply-To: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Jun 2024 10:41:34 +0800
Message-ID: <CALOAHbCrZp2XV_zp0-mH2frW2Fk15Tz-A9J0K6gcJTbSXvTsPg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 6:18=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 13 Jun 2024 at 14:14, Andrew Morton <akpm@linux-foundation.org> w=
rote:
> >
> > The concept sounds a little strange.  If some code takes a copy of a
> > string while some other code is altering it, yes, the result will be a
> > mess.  This is why get_task_comm() exists, and why it uses locking.
>
> The thing is, get_task_comm() is terminally broken.
>
> Nobody sane uses it, and sometimes it's literally _because_ it uses locki=
ng.
>
> Let's look at the numbers:
>
>  - 39 uses of get_task_comm()
>
>  - 2 uses of __get_task_comm() because the locking doesn't work
>
>  - 447 uses of raw "current->comm"
>
>  - 112 uses of raw 'ta*sk->comm' (and possibly
>
> IOW, we need to just accept the fact that nobody actually wants to use
> "get_task_comm()". It's a broken interface. It's inconvenient, and the
> locking makes it worse.
>
> Now, I'm not convinced that kstrdup() is what anybody should use
> should, but of the 600 "raw" uses of ->comm, four of them do seem to
> be kstrdup.
>
> Not great, I think they could be removed, but they are examples of
> people doing this. And I think it *would* be good to have the
> guarantee that yes, the kstrdup() result is always a proper string,
> even if it's used for unstable sources. Who knows what other unstable
> sources exist?
>
> I do suspect that most of the raw uses of 'xyz->comm' is for
> printouts. And I think we would be better with a '%pTSK' vsnprintf()
> format thing for that.

I will implement this change in the next step if no one else handles it.

>
> Sadly, I don't think coccinelle can do the kinds of transforms that
> involve printf format strings.

Yes, we need to carefully check them one by one.

>
> And no, a printk() string still couldn't use the locking version.
>
>                Linus



--=20
Regards
Yafang


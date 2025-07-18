Return-Path: <linux-fsdevel+bounces-55490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413FDB0AC4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A74189BF71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42698225A29;
	Fri, 18 Jul 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EE+xtiZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566C224B04
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878946; cv=none; b=Wqh+EHRRP7MIeNVxWjExJW48FFtztbKi+dYfDVdNxWx34n8kZHeh5pnc1UHbKolDzF372KcvZ3dG5F2w9wVxzSAENWcoINR/0ThXTZS7esq0RzlswoF6BZND8+T9h8IWo16puy8Q4QzwgnOcxXtfPPW8oCxWp+W2G5hgJ3RpTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878946; c=relaxed/simple;
	bh=qo67utYF/ovAn2X4y/cKDIWgVFy2L9OSLb/CZy1qQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/lMoEc0yxQzLoHqBEM8copSTSChSLhjqq+mMZQJWqrCQwPn23q9VmguUJF2dhCo4JqdZLZdUmvwJwlQbYm3n1rJaHueLRNeE4ZijmkC6PQBpOSziP/15azbgwC4FZXmgqiyY72SJgR0F0lmUSBa2iyFy3wBzrMff3LWeeVtPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EE+xtiZV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so4967144a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752878943; x=1753483743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=EE+xtiZV3pTL9spwkSPTfXDisyDviHr83y5B1p02ZwHtfhU/KDq+pIIHR7RsuK14SH
         YGaRsknFWNaSIExvUcrr8w/2ojIq/u8D2Lm+gU/gb/kQxdeoPePtzEu6kN3gfYRVTdE5
         Xq8RE4dACVdiKWcysdDMnrOqC08hlJa4sTESg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878943; x=1753483743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=lqb/9S4/qHpyJxpaOSqtok+Z31rOgasRr3XJ3HzN/s9FbeO3Hoh+04psycLy9xw5UI
         aGSy9k7iqgfPYYiHwIM8jF7TFiZRF+XEkMX2n1uVnxwPnqURDUQFB0t2ZQWXXv6huVhA
         2EqbFjC+SG7jUbzOnI2IlBY4I139+XetqZyrUY8Z2t3JkKiTXAX+kcZY6EHZTqeEm7UF
         B+3NSDt0t/4fQL0IZWEdns/BqJJQRCibaGfhmmShI86oxGrkP41h3AKQjo2QDFb44Gkx
         mMp03Daoj5myxEOZmk5WN81o9Ben9ueB3rAsW9VX8FxyWj7TLaQx0v69t49BR0Ti2wMv
         /t7w==
X-Forwarded-Encrypted: i=1; AJvYcCVAdn+Vv3Exrn5+9j5qPpHEO+t4jA7erW/rkWU3CmEaPGxA4uHF5eqTs8amH9QM4UoOESIqwhheHa2pyxpF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkAIyBL6IAHPsqlGB4ErmitwiTNhy6YhCWeilpv7kw3i8ooJB
	uRj8J4K/9adLmYjHEKs52eCC2yELKbLVlLoB0dA0xjsF5Oslt4jcIo4Qs4sGJ7lQUMgkNfCejni
	1bKZZ1v4=
X-Gm-Gg: ASbGncvoCblVNvEvbpaM5LpQ8eX3LxeM08uU74ybLnzyRqydqPFmWmGX64ukrARw9kG
	5ZBqnj3aHiNcuBr5bHczcXDHnpj7iFiV9aBsD/+TMKb9Hi1T+bGCbw/j4pDW4eL3BldmCwKI4Qm
	ndX0a4VKLf/zquyQJfXkmWbRFxWMcgFaYfuELsI0ddrOF58P8JblE/L/MubzZ3maB2oxuJwznI9
	LOL8bftB4ZgoU+1I9xmym2Sj+wwCpfGIfbQI8x7EnFVHpQfJc03+4nu0pmDamHpfjPUrEGicU7y
	th97GqoCrb+Vt5SNes5sJ+ALxgKO/LEEqEgWeDij8C9jECrNyvqqt9sbbGFoS4dqsEg3GfwAXss
	awbAB9xxgbisI5pp3kez7UXLcOjAYiWadPdXVNRxqpA53CO3cRhy8zKRdl4ZTWA82bT++737V
X-Google-Smtp-Source: AGHT+IGRT0eY0J6lEaiTHW/Lr1xZEqQTX63+KFuxVjC9oep4MkWN3v4Zr1vuV9pauF+WHxeD0zefrQ==
X-Received: by 2002:a05:6402:2692:b0:612:b24f:4b1c with SMTP id 4fb4d7f45d1cf-612b24f5701mr7003305a12.25.1752878942775;
        Fri, 18 Jul 2025 15:49:02 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907bb58sm1578517a12.57.2025.07.18.15.49.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:49:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so4967123a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtX/32HKhFQnJWhroPasOB9GMxtZI7Hy6NPi4MJ2M9Rjj9rJTVsyt/Zc6FfvXuy+eUfImPwPiCoZeAmXC1@vger.kernel.org
X-Received: by 2002:a05:6402:84d:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-61285ba5366mr11281504a12.17.1752878941898; Fri, 18 Jul 2025
 15:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
X-Gm-Features: Ac12FXwPQm0wFuMqO4T5e7rkg71dcrU60Bx64WOT68AUbiGf34w2BtStF_AEh5c
Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \
>
> But that second case obviously is exactly the "auto type" case, just
> written using __typeof__.

Actually, looking at it, I actually think the NIOS2 header is a bit
buggy here, exactly because it should *not* have that cast to force
the types the same.

It's the exact same situation that on x86 is inside
do_put_user_call(), and on x86 uses that

        __typeof__(*(ptr)) __x = (x); /* eval x once */

pattern instead: we don't want a cast, because we actually want just
the implicit type conversions, and a warning if the types aren't
compatible. Writing things to user space is still supposed to catch
type safety issues.

So having that '(typeof(*__pu_ptr))' cast of the value of '(x)' is
actually wrong, because it will silently (for example) convert a
pointer into a 'unsigned long' or vice versa, and __put_user() just
shouldn't do that.

If the user access is to a 'unsigned long __user *' location, the
kernel shouldn't be writing pointers into it.

Do we care? No. This is obviously nios2-specific, and the x86 version
will catch any generic mis-uses where somebody would try to
'put_user()' the wrong type.

And any "auto" conversion wouldn't change the bug anyway. But I
thought I'd mention it since it started bothering me and I went and
looked closer at that case I quoted.

And while looking at this, I think we have a similar mis-feature / bug
on x86 too: the unsafe_put_user() macro does exactly that cast:

  #define unsafe_put_user(x, ptr, label)  \
        __put_user_size((__typeof__(*(ptr)))(x), ..

and I think that cast is wrong.

I wonder if it's actively hiding some issue with unsafe_put_user(), or
if I'm just missing something.

            Linus


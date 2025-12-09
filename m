Return-Path: <linux-fsdevel+bounces-71025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7ACB10C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 21:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08C930B5669
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D382874E1;
	Tue,  9 Dec 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SwmgwUa2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF423E356
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313284; cv=none; b=PtfzIfUfQLq6riT6ez0BZ2oAqHeOHXh8iIGr/lt/04dUYJ2Vv+DJtB5zfr65O7xZAhs3ya/TkuXnBRUgqs81+CMkrqwANyFIqURAgHKnTXunylRduTrJTEdExYLOdlSG36pV7h3vSqcbzgSr+6UZS1yOOgjDTZoyM+UGzRdnRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313284; c=relaxed/simple;
	bh=rd2xZtg1TUqhPE9MjX+asDiZUF22CLDQ+9AXCBYKRVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD/9F3OyyTSgzf1ZpfkMOyaTxgpqwQsg4FTugh8aTABDppP47VBQQfLdTdj0/28IHBVfXUsXrz/p9DHh+PQy0LyBqmk/0WcpKRmnIErRLet99Y1d58wCi9g3p9or7wzl/MEeO6DesKEfyTbzvbzOFeppEus9Sk74eQDMIR3ylKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SwmgwUa2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b76b5afdf04so981660366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765313279; x=1765918079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=SwmgwUa2KyMqVEumunkw9qn/GsOPSDPkmeuGYd4QgTJIGeRkuPPuRi0A3nYxXXvE8J
         v9SMVZxTaIb9t0NkQwIqmAxE0eCGjls6qCYF0UzGgqLak2TaCdfHVk+4uv6x5luVMbZY
         A5tCRA+ja/+7G7yE98Iv7v2kx4DhHKFxdvaKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313279; x=1765918079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=nAg4RSqw4RgN/raEln8f7YKzpEOQH6sIEbRVFqHAUlL8G2EU3d1iGDD+V24udAqx32
         qk9bbljZQWSWrt0l49WrFojLXmj/047zmg7Ks5GymUU+NnKqEMd/nR0mmjhfEgQc6Tr5
         lsgKyj673gZIdUtnVfTAc+aSsJT/N+EJxTbAfLg9f6zHqhN0Zxh7Dbtqxo9BRsM/9VDt
         V0jo8m8Pq+XVG++Bxx8tm4zGlsDm1vYM3CoOMyK3b7NqPIfiM028lli4CXZm2OY7iBzq
         cisavnnyZsA/lbJbyM4Y2pKFUr8c/BSKODeF9ByprvDQokjgdIEIlZSUUiOlYFKl8KYr
         /3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVCb3VEFuHhghaY3/qYS0QAE+7+Lw2uT8JnjPw+LCmKaFGMq77/S9MoCbI9ZvFvXAf77ZkqMk9qsH67e+4K@vger.kernel.org
X-Gm-Message-State: AOJu0YweAsn3TbJ7V69AKYQCWu51oehzWFi1IgAQ8xWYmBGiIQbE/oYQ
	aWODH3kUf8Nzwyec34+Utu3Tu++NZ1fT1WFNufok5njXazHYkH+6N5orN1Dtv7XFDY/xak59Juo
	o3AJrQuWF/g==
X-Gm-Gg: ASbGncscBxH7iyHfDYdeVd1JY8z5DIYaTuPi6Pa3c0pPu+MFRkTVEZEEiTmgv0qmZ+k
	cs1s0XCosj4AS52tZvIDTU23LWDAwSQcduDJqHf5pLTkfHCPCJQZf/Q42RG0agPwdjISJrEbhnr
	P26IsFeK1xYEwAevJn9HgJlwhpvPtsOZnbyCX8cigSdivM7mcdlMfmNeldu0M2F4peg7zWtVCou
	i7E4H6VYt2ideAQ/+tRZ9JNF3Zou1Aog8X94Ts1I7QLUqbyBR3cjhBiB/zPgILQPIGqT/Um1SZq
	xtH0U1DOHVkOGJ/NYYhDTMoxXl7SuboMS9rK3jQjvurR2v9Mk92/9rSq5zXKUz2RJ/hLXMVyQOR
	kyBhnLSb+8XR6uh4csOEsnDkfRE8KqZYRzjUFNXM2xp6whFF8B/w7avTYO2enAo4rmje+WHc2Q0
	9cQEvCiKqRtTLTV06r9b6V3HGMTBumtbpK5qmpPMc35i14vy8VgzJrbfFQzbI+
X-Google-Smtp-Source: AGHT+IHNBHwnQFWb9x+PG4Uh+5VU73XQlSFONwDdJVwkTiR8wozkgCb7TT1n2RaiM7rWCI0wBzry2w==
X-Received: by 2002:a17:906:fd81:b0:b2a:10a3:7113 with SMTP id a640c23a62f3a-b7a243df75bmr1281163666b.29.1765313279586;
        Tue, 09 Dec 2025 12:47:59 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4a53b39sm1516506966b.67.2025.12.09.12.47.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 12:47:59 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso9084085a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 12:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjE5VEHbAGDkw3H6newwvT1tRd5EmeflFmXrf9ZXgkht0p//i/IB+TcMMFr3x3fxTx1Fwa/S3k71AnTLAz@vger.kernel.org
X-Received: by 2002:a05:6402:27d2:b0:640:74f5:d9f6 with SMTP id
 4fb4d7f45d1cf-6496db38dccmr139683a12.25.1765312868177; Tue, 09 Dec 2025
 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com> <20251209032206.GU1712166@ZenIV>
 <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com> <20251209090707.GV1712166@ZenIV>
In-Reply-To: <20251209090707.GV1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Dec 2025 05:40:51 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
X-Gm-Features: AQt7F2qPCXJihSB0EifxcMqIJwZJZTW_3j7hMQ2OwASD92TgZWMxviusY-ovH6E
Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Tue, 9 Dec 2025 at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, speaking of C23 fun that is supported by gcc 8, but not by sparse:
> __has_include().
>
> Linus?  Seeing that I'm touching pre-process.c anyway for the sake of
> __VA_OPT__, adding that thing ought to be reasonably easy

It sounds straightforward, and I'm certainly not going to object. I'm
not sure how much we'd want to use it in the kernel: it might make it
slightly easier to deal with various architectures and the "if the
architecture has this header, use it, otherwise use the generic
implementation" kinds of issues, but we do have fairly straightforward
solutions for that already in our build system ('generic-y' and
friends).

So I'm not convinced it really buys us anything - I suspect it's a lot
more useful in "normal" projects that have to deal with non-standard
system headers and possible lack of libraries etc etc. Our build
environment is so self-sufficient that it's not nearly the same issue
for the kernel.

              Linus


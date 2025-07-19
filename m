Return-Path: <linux-fsdevel+bounces-55499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822AFB0AF33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F894E0177
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3BF239E84;
	Sat, 19 Jul 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKCtxXzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3656227B94;
	Sat, 19 Jul 2025 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752918754; cv=none; b=pu1CYdAfH6LT5Pyjc0MTaxBgAiwDEJdTNzueiSrACmDBIS3RSFxKAdraFECg+Lbd2LPVZovhJz9+8qcfIHi0PduXWuq1XSq1u0KJ64mLdrDp2FebfSiCj2dNrGp6tLd68aAECa8bs4x8PzqWacbce/XXCZtcwxepBxiU//rRd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752918754; c=relaxed/simple;
	bh=oSt+1bwQznG4gMR3tFfughPMF0WDaB7Y07l3ebktgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSZCiPfrl4LtCQXWvKSBFVFmbJ5CCmoNTbn73rs30MpzUC6Out1EPaGy3vvMnKuI/RIXIk6kBNKC1odfBPj/26GSsOrjegfHX2misgvNfbcmbXWk6cfBSk87b3YL2FAbpn12vu1FfVKUWubTyfbCUBZAsL7fY5vLw76Nmwsw9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKCtxXzR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d54214adso20612785e9.3;
        Sat, 19 Jul 2025 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752918751; x=1753523551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pEXn5VHOGjD9SP45xNUPOGCXrKn0jYGF1BCukLPods=;
        b=hKCtxXzRTaCZm0wGBSkNIcxm4b4aq7S79pQXEA/aonYCm5GGHai5by6PtYCNvHGQiq
         nrPqX6+TNROHPSEWypuhFjMmyeodYslkei9EU/ngGFPRhQ0hdNctk+6sLIe4tu+YAd5y
         eBCXGeR2x3VPUc2k/fdoMIIyaDG3eIWjCjf330YWOYw0LxeDD3Wej4fYIETDjKwgXpyo
         LejBDeMXBZEnhxSSZoCRpjGWpYOaVHjG3aPnS7tg/Bz8D59mJviZcraH48LpXZLJ6Cea
         /85xOD0q9j4YBK439c8q9AahuYK8GSvsWsM/q2o8Sn69VBRRyan28fakqnLCtRtF2K8N
         iNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752918751; x=1753523551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pEXn5VHOGjD9SP45xNUPOGCXrKn0jYGF1BCukLPods=;
        b=qAHiyyRCshbJJZUDg9hewod149Jo9SPrTBivp5eQF7UJRFyoCwejaBnDF7tDDsawIc
         vIKM5gEHi8aN3h+KHtp51+37AZryqDAhP4Wj/cvb29hFzmD8uK90u0/9aghFwiBfMv8N
         oJZK6u45VM5UYCNSsSF+rKtWw9+6RODUN7rVRa4LQ5tNhuHby2zLCfdBbtkHSwWvIEqO
         9UHIsL+dqitKS+BxJerUDPRAjKTsgfxleU8a3DJDNqbYSdu2Sm7oz4xczk4p9E6K1SCR
         a0Y9xOzxoPhRKE7isUmUwMegCboOCAY5TLjTYCXrLijkf/6ytCestxkMSS21W4SaI2PS
         WKuA==
X-Forwarded-Encrypted: i=1; AJvYcCUYTFNo89fqvd5m3Bd4gX6GPlB4BIhOiFKjbqQgBW4xL25SbKXVzHNmhjt+9FeV0TSUwAzttzbMfcoKIp1ZVErX@vger.kernel.org, AJvYcCV+hTnNQ5SZiZ3aFJnyQxAzd9S3AoArY92DLukxAGPhUvmyGiT/79ttuzwqxuHTmeUxyeo5qtXHhDklj3AJ@vger.kernel.org, AJvYcCVGNd/NRwazYBzrkL8dhy7WHmyaT2FDMEf4qSQDzfodEAxGkZlyJGSuBDUX2tHh+FHa3CYz22wWqNcu7dZ1@vger.kernel.org, AJvYcCX3BvTAS5xc6iqo4xIbKbYxRqqRZWHX94foq5KhpfsbfoxQCLCFAxDu4HOYKwtwe2R6DTneOzATlMx9WRlRTA==@vger.kernel.org, AJvYcCX5d8+8OHdWafoVYEzAcoLzzVfSzmJxF/iy1dl44e9V7uVyJJsDo6ERcj5+s6GJHuoXn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgt/4U+BYa3PG00MHbAriBGPLqAHcSYhro2I56LjrG4OURztvI
	JHyhqLeULFG+UbpQUOJEwzHOzf1ksT13XiCeooXgYQi91ziJAjhdNda5
X-Gm-Gg: ASbGncu0GPUnk7EtkesxcwN5xWWGLvhSSC9+tqoOz4wga2KIWWV0EEuk5+V7TTc/OA2
	m6BOy8RFv5l9MKCWdyyiirNqHwb2NKfTo9aH7UCIgbjBUoWbTOwFPV+faibebd0DqAxUjPrXN5+
	YCQB9aS+5JZO3c23QfZDXLotmpab00GUdbrey3arf8ECaLt/rcnx8XxaKZXTkCWuFxSOCgYAkOV
	P8LQk1ruqG9Sy2y0tQ46IytS34C9it/6jBj7Wqbz29q2KCqx22TPRHeZ9rEkAgK6oGyvgFapf72
	RlrDnaIdw/0G/FVDu4QsILKS3lPYv0k+yG5kEMzLB7VqWzJMxAVgivryygNhLQTP1FPy7DjtFsZ
	+0XOSw9m59FDOE0GBRto6uWVK5tSNbzf/vEkxBpR5j23Nsu3yxL4KsLbJ4U6o
X-Google-Smtp-Source: AGHT+IGgS3eKZd0WOE5CaGVORMk8w7YbhfbUyHdCIflKLfBmlFtKqD0yPw9BMSfCnK1ze+Ow5Wktqw==
X-Received: by 2002:a05:600c:3484:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-4563535d2ddmr77234825e9.22.1752918750524;
        Sat, 19 Jul 2025 02:52:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm100634135e9.8.2025.07.19.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:52:30 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:52:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, Dan
 Williams <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook
 <kees@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc
 Herbert <Marc.Herbert@linux.intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj
 <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, NeilBrown <neil@brown.name>, Peter Zijlstra
 <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Thomas
 Gleixner <tglx@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>,
 Uros Bizjak <ubizjak@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, Yonghong
 Song <yonghong.song@linux.dev>, Yufeng Wang <wangyufeng@kylinos.cn>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-sparse@vger.kernel.org, virtualization@lists.linux.dev,
 x86@kernel.org
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
Message-ID: <20250719105228.1704538d@pumpkin>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
References: <20250718213252.2384177-1-hpa@zytor.com>
	<20250718213252.2384177-5-hpa@zytor.com>
	<CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:49:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

...
> Side note: I think some coccinelle (or sed) script that replaces that
> older form of
> 
>        typeof(x) Y = (typeof(x))(Z);
...
> 
> with just
> 
>         auto Y = Z;
> 
> is also worthwhile at some point.

That one needs to keep the typeof() - but the cast might be spurious.
It could be either:
	typeof(x) Y = Z;
or:
	auto Y = (typeof(x))(Z);
but the latter could hide compilation errors.

I'm waiting for the next 'duck shoot' (after strings) to be casts.

While casts of 'buffer' to/from 'void *' are fine (and not needed),
casts to/from 'integer_type *' are definitely problematic.

And 'random' casts of integer values could easily hide real bugs
and most just aren't needed.
Although you might want the compiler to make the result of
'u64_var & 0xffu' 'unsigned int'.

	David


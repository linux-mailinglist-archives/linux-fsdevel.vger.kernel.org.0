Return-Path: <linux-fsdevel+bounces-71002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4735CAED25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 04:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFDF9302CB96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 03:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E89301012;
	Tue,  9 Dec 2025 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jwon6Qvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D92253EE
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251531; cv=none; b=SVsGmHTOWa6+BqcwFsQcffMXjRUCbRsnX8kZNutc3BOfmTK/rHzLNIbBt30XPK5dKGCvxasaGpG6VAFsx2Jf+EjqaIScNBQYI12fiEYtEYpvs5TjhqCaXBjJo4Le7XAoymYyMOTP0oRtljx32oapCR6Gpc+QcQHHQOBOaGcCl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251531; c=relaxed/simple;
	bh=mArw2vAL0D2NHk8zLQ2Ijxxx1bFuIg9r7rH/hnyrq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFMDalG5/NL4GThXkwDqMI85kMa49hA41fVKk8uD830WrLnuLuQkGL7EC1/9wyDf3z1PzH+Z1Ux3JSrnJgKYESZGC9EL3suSEzF6KwXBGhOYgRLfFavJYuPLt7sMAN1S1Mo4j09QZYg8V73RaCtDekIFiML8jTwQTudtQ30eMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jwon6Qvj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79d0a0537bso663731966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 19:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765251528; x=1765856328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=Jwon6QvjqNk+k8ihfNdlwW17GtlBj98lBU6rNk/7ZbfAQ+jgqBGgmsAdWxrsHqniZF
         pcEjZ1WwjXyI8nFC5na6KRIbBUXMGc7VN2fAqrjXUSFxFIzoXY2KUbmmJZ4u6MYi05B/
         +wBMvWOGc7xreXHHPFqfLJ0XY5l8kKzMW7RkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251528; x=1765856328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=TfNc2PogbCLbHF2L3VJ0w589b6u/ZVAYuuqd4RapGI7Nkgs/MQgyyET2nFaGaeJDQQ
         Xw1hdyS+j8HnmTHVlF7Me5H75m/wfxORrC/s4zUrxySHr8ETV0l7iOFHJO3XXY/flssV
         DsiQcXfyklngTI74Uw/L8s75n2FGXAnJxGJ+H0+cLzZnLjBRrQtx606S1kjAzH5ki46e
         NxYaoveVqmtGmYGuGU87UQFne2P3Lp6O17Oq7xvcZK5Oi64Wjx6N+zeQta+9cBjMAMb0
         R6Z1eHyfWTkK7PUrAHZVOQ4HKaW5hzOdwcOhMuOQxTJXGw4jM/w9DJMA3geXg53OOSxr
         Qy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw0/w87bq436Szp96JViQGUY+UgTqDxxN8SpqR9bYmctxNIQf0IRs31FCrZI4mG8mGQFIkDInDyys27gws@vger.kernel.org
X-Gm-Message-State: AOJu0YxKppYd5zzxNFx9rBqdYMjBAlybx5d5gXyY4oaWtOrZwqdf6eyH
	987l56o+4sjRAngKuCD0evPJFroGhD207XvWYevd6pJ15BSG9WnV0UEoUFoc2x/qWpmxnXcB2eu
	+IUOlrRSx5g==
X-Gm-Gg: ASbGncsM4uANUwmCCbFRpzXnQHYcY0eos3Wwd7tIihn35K+91/d4fOipsN3w07/zar/
	NabVkA/K6hik6ddLfigBNzHAZh/Aj5KH/71YcIrOugTRRQ9Jl3ZVzqzNgw9A9NGK1TaN1vWDXVp
	mgk5iFe5DR8Kp7+MLX4qQRx6ioDIlcKvQtqDi0vPHutvIOvkoVykQUVLdf6qrq3ORhBWL+0ovF4
	Tt3+MckH/4q5Y0xx5xAFg3ZcugIUr4AMXr/zgDZL1ZrfuVyNuTmnljPvfwYqBn751bLKs25ySoG
	jkJvY0g1+K/8siJndO00hvW7dg/WTQBNJnI4xZTr4Syrfq60TAOoxB7SinvM9doGSysO6qoN7yv
	uaCMpxN4wiOJsJrD3auSnMTlFcQ3ScSZn6wuX7zx+pGFddATiF8BAisrQ3qIHGeaDzj0IXQhaQR
	Huh9iK8RGzhZWiqSSVpLicCJDjIK7BcEdNq5JcPGWKz+SNDKNOGmMLlXw9+m1T
X-Google-Smtp-Source: AGHT+IFzQLhdab/gofsIM+K0CdTXqFSfvehwZPLTiJrGYHLDst5dCGg1IGtXMPReNPqS/BL1sLNt/w==
X-Received: by 2002:a17:907:982:b0:b73:7184:b7d3 with SMTP id a640c23a62f3a-b7a248b229fmr940133266b.58.1765251527771;
        Mon, 08 Dec 2025 19:38:47 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976003sm1221150166b.36.2025.12.08.19.38.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 19:38:47 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso2771828f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 19:38:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU87BlLKCgnwrZyWAmypv3aRXiGtxzUzvek1uNI0Lfe3U9srC6Itma2KY1Zctvx8e59zSCEFO6Y3knUkge/@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:647:5e6c:3220 with SMTP id
 4fb4d7f45d1cf-6491aded554mr6980906a12.21.1765251222388; Mon, 08 Dec 2025
 19:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com> <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
In-Reply-To: <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 12:33:26 +0900
X-Gmail-Original-Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
X-Gm-Features: AQt7F2ofRIAXVmCzZb3EAMnphwigz_H3r18InwGDDrhalL1GL85PEFWZ4uBTknk
Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
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
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 09:24, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Yeah, it commented on the master branch, which is of course ... yours.

Ahh. It's because you didn't use the standard pull request format, and
instead did the branch name elsewhere.

Which btw also messes with my "just cut and paste the address" thing,
because now I'll cut-and-paste two different things.

"Poor Linus - all the pain he has to go through".

          Linus "think of all those extra clicks" Torvalds


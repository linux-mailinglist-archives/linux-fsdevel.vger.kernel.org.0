Return-Path: <linux-fsdevel+bounces-55491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E2B0AC74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC683B7616
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C35225A24;
	Fri, 18 Jul 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xb0eyiHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D17D098
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880015; cv=none; b=A7bkHMxYl8BdhMwZMfLTpaNjHiCPUPsqZ0LIQw/ZtqvFnbd9j/Y+hB1bmLbsHWWo7CG7zwlutW2DVPJ366wcOUM+Q+ryIXGa6+pcUrsAauzbtZm53h4Bu9H2OH75e2sk14pma6oP9VrZzC8zwcFTmy8NmlUz9SBHgjcWEVKpSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880015; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m69x2itU0xaKgcC9wfpVZOtZMyKI0Fho07WWLXPFKwNrrS81LODXm5Z56rQJ6UE0P1GY+ypP2KnerRIp76GZn7NDPBu04+IhEdmt8vLKgoiVrL1hVPzoONcjMBBykJ1Qq9MszZNSsyCFJ2Y0DvGV5vyliSc1kEAvEzhJ01Kl/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xb0eyiHE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aec5a714ae9so284757066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752880011; x=1753484811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=Xb0eyiHEVm2Ow8vG6dsBHLmY7GYHDorpf6tlMmOawhRoanAw/PvZGD83cMhwIosyqp
         MF6RloTO4W71gMwlhRpnS7BT5WLMnQDQ3poo5VJWugcxS2/CtrEHuQxBLSs5AlJ3qJGm
         HVCzT4qyBZ2Ao1YfZXwD0y6dROoFJDjpA07JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880011; x=1753484811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=UI0dNqP8NCOhbMR78ZLnOnGyJRngboHQ3YnO5yRLFvAk6FNYgwf5Dj2IPd4IRxoYmn
         q1CmxuBkOxjjs3SeIAaEyWLUu/cM7zpduNXj6ucKsFK2krr1TQ5oFQbA11q0OVofeeoF
         mgaVT1Abo6mfQqX67vreJbcgMBtwunCrTGTVFbfpLtD3yux0S4nP7Qw1qESPQipHKDBp
         2IQ709bIXqAIIxJcSQu1o3Yi6Rp4xiC1jcyZgZ3Z5qat70OiO8Y9B6EXRRg4S1W9IgrK
         jrDKWut1ZJWd+/7MeYlkarsetwjCDG8Mz3FQ3JBAEz8Z2q9wMptIM0Y8d4dzDotlJOyQ
         YOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg9WzFT2PQ+VQfsl0AiO+xObaSziDkLHKiDq4vQHdNNeZteFOvnIC450A9LFtvBBMx7JfFQe8Zcwc7BWbt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjy2CBvT/VBqcyVbXoWTpeRIrLKZPM5tls8SBftUZlRcEdGIeU
	ykKiTeodxFC6SBT6cOK1zaBVj5j82SGj6ZVxW8VvTIuKcfNh1SFvMEHZn+U5g380NYpdXQuaoEb
	GNfmPhgJW6A==
X-Gm-Gg: ASbGncvr/Dg2aKad9ZWyUN3awRO804VfvL1Q4dPyVRPxAPEY38umqahweShKM7BYpHn
	9S6l3lBQ64gsqZ1/91BqFhZ5KtXz/s3SeMleyW4cioDJgJigkBaJYn61S4saCK2/N3R9CbAONSR
	tBbZd56Xg+kCnBQ2mVrixniUjMrrFSM5cvWb2dMbUNB42Pf2iGgvkdCXIU2C29ZtyLom1IcVAeH
	yUUH4AmEKlgKqwxTzD1Fs0hE1LZ3cHRakI7dzfGak3X8EuxJPDqYgGtsLeeWvU2C7rhV+liea6E
	3po5WXjE2/vcQoFXw+uYLfWTxYBh3ffZ8SbrJUv+1HViBacrVymyuRzB7HTZWwnwBX1TChx+P9q
	NNN87vhGYiSqvy+4o5AT9PgLYOpsR9K7KkKY4fBj/oQSBGf9qO3kPOcdN4/BjBQGEPrTtrku0
X-Google-Smtp-Source: AGHT+IGJoG9ysLCXsxFpXi1jrbHyJjEhsWhL59E0E1eOxhKonZp+Q3+L2huAVkJGQBa0KTuPZ/JiIA==
X-Received: by 2002:a17:907:7e88:b0:ae3:a78d:a08a with SMTP id a640c23a62f3a-ae9c99442demr1272435166b.6.1752880011089;
        Fri, 18 Jul 2025 16:06:51 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d6cfesm197506266b.54.2025.07.18.16.06.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 16:06:50 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso12625205e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHKFE+ttxmv/qEDvByd/tKUeKHAeVX9UAF9etVyQw4FWsjWuYsMymQO8groJiGoxXcBoTjzMA9RJ7HdLZ0@vger.kernel.org
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus


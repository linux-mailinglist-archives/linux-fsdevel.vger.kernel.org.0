Return-Path: <linux-fsdevel+bounces-70994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC5CAE84C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 01:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3C5430364A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FD1F0995;
	Tue,  9 Dec 2025 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RUq74yGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AF221290
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765240053; cv=none; b=mLVwoktCAjZK092BGlEimyhP9AI4zA/9/IPVZo/8CAkd9MTDEvFn7g/ipcp6YbYgWpsowRWuud4yi2ZbWaRCMH0ENuRpuvShi5bM8qckhEuEdRI7BEzq0/Y7+L/cK5Z+9iDc5y9kcGxHl4CJa+k5w9A0xxGR05GxpNOs0EGsr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765240053; c=relaxed/simple;
	bh=JEk3Jb3o2V3Ykrxdybm6wJkA8vNlfxfi4dCZ5w/NQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjMklCTKqCuySG5x/EJYgDc4Tv54LfagD69mcHGtrGj5vb1cnPVvu58XfVWbW+At//J9a5Eglnm6NMHBDTxuRO7N31lKEZvkT5DPqSmvbVVwYOgTtP9SZqvSHij5HrVfc2NTZpjdma+lFIwEs8W7AQeYF2hR3rw7fGBZDrv2Qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RUq74yGn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5958931c9c7so6280417e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765240049; x=1765844849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=RUq74yGnYyKvbn/8TSQ4zTFHiVCHY7Zorr1k362xEd+tys0P5Ok/P/YQylyeuDUcCo
         ZSSt17HKjIqUmudpXE5RTdAX9A1zOB433KaiaolYiXh1MA7CklrJ3F8HqCdQIhNAgNpF
         PVN/GOIMzN0Jj2J9j18pGgbavHi2j0d8mtcWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765240049; x=1765844849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=eFFYiin29BUwLqxejInmgPz9yeCZCoPSt0EDIa6C9hoJAooFKTR9YJwx8HsTjbEZh0
         TPVuTPK8Av/A0WpnTHvb/DIiopM0jI5RsyFT7ANmdzc0EVccoeX4QBWM9jlibnlkU3FD
         GH8/Fdez/oFl3icuccP3MJX41MeNWc+VEn+tp5fapPhXjs3leYtk1pZjN+gJ01mOQ62E
         WcF3aBa2drbTyfCa8xn8JpBWX52Cdxf6vqf5Fo5Sx/1OCRRknIGTKypFhEDRu21doPdh
         4k3z7LYQ8sgQbCvX8AR7UFG/dXGIF6x93URiK1dqF3/mTxz8qGJ7TRe2ljaFL9y6vrro
         6tLw==
X-Forwarded-Encrypted: i=1; AJvYcCUyuE2FyHtCgzLUHRB3SuHDpSgI81IG1YEwTR4kIGyfjCBztcsADrZH0jH+LfSCF3+zgStU9iMv32NJd+Nm@vger.kernel.org
X-Gm-Message-State: AOJu0Yysw4JDApULApdG+WIh3nD+WVKeT2paRcgSnf4Sz4YwPUUYmBPk
	wR3uqtlGNgXA2h/38G29+m3YkgBaHDD/wnrZDykr7HwPGm2vFknUsuY6me4Zydh4odrU5rkLadl
	LcR3ZGdcYhw==
X-Gm-Gg: ASbGnctgtFeg3bYBoa2tZc1Fde5KZzKcWByrK8cKVrFoSKzXafRxK+uc8hOAQz+Yt4b
	4Kld9gREO2+1qoD6u1Z1aQ0ppJmDCUUQfLeTl8LHNX5uhTDezElmXGuCniAofsAJm1FYJmpXj8i
	Hln3E1BOYZluXEkyXD+CCwXJwQWiK7cXWgk4kKz99zrXZ/KGA+bYpv+vavm+Wq2+JVsI6UxW0+v
	s3htzVOnQ7sQGJGpGkvFKKRLMI3oWBOTg4o5YeKL+PSRZS0u+HdND/NWa4dE4p6uDyGF4jiM6KN
	SfXboWBZOEeOowywSrgDX7z12C/s4/t6Va9Z7KaATbUGBaqZo1B8EXEqUHz8rtZc9IbYg7cforO
	QlmmfczH/lI6Aq+zhzLehRpDRXD7WfvCvm9yYBJK9yRNXbzG2DHwnpchrpb4z00gDJq3diyVN2R
	Y5sRhdNBGJDZiJUceNyaO+NWO7sVxziyMCwZWEEPo8OpP8tEEqUNvSz3DnmigbM57VMQhsoj7L8
	zw=
X-Google-Smtp-Source: AGHT+IFWq+rDjhE/QKNKsXjFGK+TwWDeLWaUnz7Vnfq0v1nUnldXaW9dCHpp1wReC85aVieSpPRHzg==
X-Received: by 2002:a05:6512:31c1:b0:595:8200:9f79 with SMTP id 2adb3069b0e04-598853df8a6mr3499254e87.43.1765240048870;
        Mon, 08 Dec 2025 16:27:28 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b24a06sm4627991e87.32.2025.12.08.16.27.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 16:27:28 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a875e3418so38001441fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 16:27:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNMTZs4AWlMWJ4SJNFlWWqmWbuDPsFC2B9Wfp94VXq8nJMGdQfwuIlNLud/Z/9xRD8Kr81QOLVljBfrkqT@vger.kernel.org
X-Received: by 2002:a05:6402:4403:b0:647:8538:fcf4 with SMTP id
 4fb4d7f45d1cf-64919c10408mr8423201a12.10.1765239641812; Mon, 08 Dec 2025
 16:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
In-Reply-To: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 09:20:25 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
X-Gm-Features: AQt7F2roobmnBFxkxCTs46omVLlLQvijaEzayZmWK0Hwr8qZTgYHcUtxshIhuTk
Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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

Hmm. I think pr-tracker-bot is being confused. This one just came in,
and hasn't been merged yet.

That merge commit link is for the hwmon pull.

                 Linus

On Tue, 9 Dec 2025 at 09:14, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f


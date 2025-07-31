Return-Path: <linux-fsdevel+bounces-56449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCDB17899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327173AE752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471A26A0FD;
	Thu, 31 Jul 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar2q53Ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9315A921;
	Thu, 31 Jul 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999087; cv=none; b=W8vhTdK5b5BWpImGXEskhW7agwOTqGbJKnWQfQ4hSPJy1qxDtnGpRobaU7gwnt5MaCLEzcIN+APIz0r6laxKOGAa+DWKxXKeaOvjGF+rR+ivQCq/0f4oK3Rv8Oc1O+1P6h55sEUBZwl3eb37+DJ4wiKvd2PpAA5kADS3Fn/WEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999087; c=relaxed/simple;
	bh=8p0do9kr39Ovsj1Jt2Ef988sMv48J4IdqOMy8NWH3eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzHe8/ahXi5BPNb0MEoWmNX28/2+oNnJ4fptb6tV6uNvaeuo8f0Yxqj9l6zSwIfoE4lxQm17azciblnH37NJVDZhn/jJzmB/JLAAdpSiItl6HAqQwjMBgzxCXdoJ5rD2Snhn9WGVxBa1CU1XkrpB7ZgTfJytdChozIMSoW5GB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar2q53Ks; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b794a013bcso234976f8f.2;
        Thu, 31 Jul 2025 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999084; x=1754603884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p0do9kr39Ovsj1Jt2Ef988sMv48J4IdqOMy8NWH3eg=;
        b=ar2q53KsMve0gOZ8i5NFj2T3qT962EzZS2QlBTdUywXBTHmLPPdJSHQ0+ecK77xllM
         7FOYZtYgyV9a+EFahnjSoWUmiga8chJeoTO0EWGGkRwnxPbbJ1MeQAMm22veu2IAWdOY
         aqhg0TAcvr8O/geyqHQshEJne/KerWOmEV0ETIbvXEEkq4Vj/x6drfop21xDcLaa5j0P
         /uFWxvnup1e1QPtsSKfXDcAX71KtmnRKy6dm7L/3/KvsqTA7BwepNlFwH4cQLb2CR1Hu
         4Q1BUhqfONCHmpL/nBPaK0Q9hkOZE/kg8+FRWbB+gKQv203/ttowRfGjnvrSwcimjODs
         8ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999084; x=1754603884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p0do9kr39Ovsj1Jt2Ef988sMv48J4IdqOMy8NWH3eg=;
        b=VH5+U3UVchpc+FPFfjxWlYh/9JxBXqJhcG6ZDeHFrbLPyiCj1ZZL8vhu/h6NB6vzbg
         lmJuPno8ynGiOVlf+L+nyR3z1oJLwaeLfNIQhb1faO6Qb/oqBMXdc0etVge0/1T3ECG6
         RgqUlB5XkGcNzt6e/e+PXCLgBVOggnTRJ5Xf38LUkJEMacxioXTmlpAdbDwB/9YAkKaH
         ZyulfrxpwpRY51fJb7jNxsE2KXWxnYWZoSwYx+rnpl9+dUthZzBsPI2ro9K5fphbwtIi
         83A7E8qDTuyblFs32fDwMhaT2RQFWe9+TEHLXr9YOnRKAY9knutsCpSaYQD4rpARCO9z
         VcVg==
X-Forwarded-Encrypted: i=1; AJvYcCVP1uqtr3m073HrqXWQXlUGYuNB7SiSByWd+UXwDp6zAwa0V4/hIeZi2p1ALQ4K/VY5/7o=@vger.kernel.org, AJvYcCVu0LbDziW5Q3qucS3Tnsixj+ULQGAgGur9SDjcfNY4VcpyP3+MKcFSInEDbCt6FfPQPRdiqVFL726ETYdcqw==@vger.kernel.org, AJvYcCWOk6t7tivWDAmNpTmP20ZxjeWbGHj3OlgFZoGdz8I72zrc2XycLvdy/MIsfHCnTUJmD2660LV0YrA+UzaW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1mb950xUlyhTXljUtaXsH81PonjJ02VkKKOBJUj9dIjDnrax
	7G7sMFIFPqvs4vSYb2tSSwEXzAX18xB+rL9HbU7l8GU+9wbOdyRRSSkfNKm9rxCZv3b0hZqw9u6
	qCcjs/5fmlEo/p6/aGaeltmoO4e6MkZQ=
X-Gm-Gg: ASbGncsb1MQJNHs6kM5O3SI4peyIN7dPMRsJ4IpjYZ4VUrfgaP+/4csyAp59/LO2KYs
	RoUqtRRDbc9B0Zq/BrqD3tYo8Ahi5ClAwYT3HbVEZSrUnReZgoXfV9ekk7xEg2R5C+0ZSXeIZ7i
	CktFppFqjF9Q5Fe1G4vlz9Yh/uH9KiYazMwSeDtujrBUABwrEOXi6g9U4x9Url1hO1+GU2h1WlV
	Z9xg0EU2eyTPIy0e3oOFlokc/hfHXX1tZBEh7u7OSjvxj0=
X-Google-Smtp-Source: AGHT+IG0e711nCZBo0LFDgFsHLegSjodIkLZxadsTGsG22z/JROwQjnbFz1X9q67z+tQ3FIhJavxLLOe2qR0sWT1Zio=
X-Received: by 2002:a05:6000:2908:b0:3b7:83c0:a9e0 with SMTP id
 ffacd0b85a97d-3b794fde526mr6033980f8f.25.1753999083973; Thu, 31 Jul 2025
 14:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-bpf-a1ee4bf91435@brauner>
 <ysgjztjbsmjae3g4jybuzlmfljq5zog3eja7augtrjmji5pqw4@n3sc37ynny3t> <20250731-matrosen-zugluft-12a865db6ccb@brauner>
In-Reply-To: <20250731-matrosen-zugluft-12a865db6ccb@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 14:57:52 -0700
X-Gm-Features: Ac12FXxHt58_Mh-eFyJd7LrI0WHgpz0ZviNHWw7vHHaiCNzygl-NAmedsTDIJCw
Message-ID: <CAADnVQKMNq3vWDzYocS6QojBDXDzC2RdE=VzTnd7C_SN6Jhn_g@mail.gmail.com>
Subject: Re: [GIT PULL 09/14 for v6.17] vfs bpf
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 1:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> It's been in -next a few days. Instead of slapping some hotfix on top
> that leaves the tree in a broken state the fix was squashed. In other
> words you would have to reapply the series anyway.

That's not how stable branches work. The whole point of a stable
branch is that sha-s should not change. You don't squash things
after a branch is created.
That extra fix could have been easily added on top.

> I mean, your mail is very short of "Linus, I'm subtly telling you what
> mean Christian did wrong and that he's rebased, which I know you hate
> and you have to resolve merge conflicts so please yell at him.". Come
> on.

Not subtly. You made a mistake and instead of admitting it
you're doubling down on your wrong git process.

> I work hard to effectively cooperate with you but until there is a
> good-faith mutual relationship on-list I don't want meaningful VFS work
> going through the bpf tree. You can take it or leave it and I would
> kindly ask Linus to respect that if he agrees.

Look, you took bpf patches that BPF CI flagged as broken
and bpf maintainers didn't even ack.
Out of 4 patches that you applied one was yours that
touched VFS and 3 were bpf related.
That was a wtf moment, but we didn't complain,
since the feature is useful, so we were happy to see
it land even in this half broken form.
We applied your "stable" branch to bpf-next and added fixes on top.
Then you squashed "hotfix".
That made all of our fixes in bpf-next to become conflicts.
We cannot reapply your branch. We don't rebase the trees.
That was the policy for years. Started long ago during
net-next era and now in bpf-next too.
This time we were lucky that conflicts were not that bad
and it was easy enough for Linus to deal with them,
but that must not repeat.

Do not touch bpf patches if you refuse to follow
stable branch process that everyone else does.
And it's not VFS. It's really just you, Christian.
Back in August 2024 Al created a true stable branch
vfs/stable-struct_fd. We pulled it into bpf-next
in commit 50470d3899cd ("Merge remote-tracking branch 'vfs/stable-struct_fd=
'")
While Al sent a PR for it during the merge window:
https://lore.kernel.org/all/20240923034731.GF3413968@ZenIV/
On the kernel/bpf/* side we added more changes on top of Al's work,
and, surprise, there were no conflicts during the merge window.
That's how stable branches meant to work.


Return-Path: <linux-fsdevel+bounces-21664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A4907AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BF1F2316D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095C14A632;
	Thu, 13 Jun 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljbStTQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937D14A4F0;
	Thu, 13 Jun 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302407; cv=none; b=Q85mCHdjtQ7rwJbgzyGWytXfOhtHNKtgipAqGxo74fecGpFZEtYlDPLG20O3uVQCjqe4TSrEGgi1mMMJgT9YylJctDa1HsGSMP/gVjOOrrMJ3QX7CXT7JF9zAvtQ/0k33KQ13IJaSt+RTtY1i1e3UVd4JIqOpHCc99p7InBzP6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302407; c=relaxed/simple;
	bh=wNNl8rrQPycSg4IXL1NS7035Hu/VIN3/XOUEICPOlvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiZ4SmorIk1YInZ/1Iq3gRmgZ/zixa+mUtytDyAq99l/7Wdnj0/cGcW6dHOJgbvG1qkXUS7bQNDKZGsyq8QVAPtzCLQCRHotfWaTZX7FwqNu0v/m1wNTLse0m0FTVuq5Vw2TBr+p+xXvuncduxBwSYZbOEss1dmxO4LLgAazb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljbStTQj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so1601144a12.1;
        Thu, 13 Jun 2024 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718302404; x=1718907204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNNl8rrQPycSg4IXL1NS7035Hu/VIN3/XOUEICPOlvQ=;
        b=ljbStTQj5l2UkGLsjkeEdPMsvJxQgTAJFSNDTfBP+AxdVwMY3IFzJvayeC0jGE/Zex
         BZuJXrcTcVZgTQVqF0HaPpdy3B2jK66EcubnuCFInykukUhA4LaQkglzxmWMcWlt7M+Z
         0iwqpArn1wZRkNy/HISQomyBiGRv3FIUfGOeZ2ZLZk/79vgm5yskcKVACst2cmlUxust
         IiIVtWS7Vdv9zRFRXtllSfV+FARtUPL0/n8sdLxIOrrlbHdl6+VRb/3Wr3RtstBEj7Ln
         QRXlcY6HCDiyyZ6Ao1Fce0DlT/rM/oBx796ByD3G/Vw7U8sKLrc76wAkbElPhHVbxwQ1
         Q1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302404; x=1718907204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNNl8rrQPycSg4IXL1NS7035Hu/VIN3/XOUEICPOlvQ=;
        b=VqvQW7IEJ4+kWlA8kLWke03sNLAdnH+UftVCp81wKz5uZ7fmTSPLS9N4FDidXyrgDh
         Pc3tOjKCMojPNvmAhrSQiugGK9IYwxLxzkrAg/LfKpcBJSWsKVFnxJdsetYfhPKJ5fNx
         5XInH9GnUZYS9tgqnKx0TngCbvyo6w/jSW7s+rPckXcFTtjDXSlQDQbjWqmlM4+ZPBCm
         IAuNwY3cirzCgLLvX5eQCsU1jzenY+l3SF0QtU7OoknWVk3U6zLszIcKEgRTNOq4OAsN
         7om3N1ik7ll6Uaz+vx4rLHf2x11kWlWD6Ne0b7mrpGLFJWlHMkPz6AAKtYXlVefd+9Vo
         gLIg==
X-Forwarded-Encrypted: i=1; AJvYcCW4htjjEbEYSyDF1NGc9fo/7d7QeuxFQ/lY2LtSUuUSS0WgBHgGfCwiOMfryRY7nmJ3bE/oWkv04RG0CQEzpNQD5Bdss2sg0ecnRBsVkmH3DlFAbKwMfEC14PPCCQws6OC1c6WqhFsWPfWsYA==
X-Gm-Message-State: AOJu0YzPjF8NDrUazOMKqIyNIvhf7ce2Cwg8IE17exyrlwJPpLGOELt+
	Omrl6LFWTFiAPvEyaGlPaeQeqVz7vVvw1B90iqByak8yX1ZL0hkduilTtdAFDqVxy7Z7EU9oBqt
	n9FGBF6sdEIi976ERrouH5Fpa87s=
X-Google-Smtp-Source: AGHT+IEDJPaqSZUv5B5MxjIAxl6QnKc6ZsHvMrpeSQPPtVjYYPsRr9TBGMDkk43sN9E+cAoFf9Wiyix2XkFa0c4Z+4U=
X-Received: by 2002:a50:cdde:0:b0:57c:74a3:8fd2 with SMTP id
 4fb4d7f45d1cf-57cbd67f655mr488376a12.21.1718302403764; Thu, 13 Jun 2024
 11:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Jun 2024 20:13:10 +0200
Message-ID: <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 7:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 13 Jun 2024 at 06:46, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > I've picked Linus patch and your for testing into the vfs.inode.rcu bra=
nch.
>
> Btw, if you added [patch 2/2] too, I think the exact byte counts in
> the comments are a bit misleading.
>
> The actual cacheline details will very much depend on 32-bit vs 64-bit
> builds, but also on things like the slab allocator debug settings.
>

I indeed assumed "x86_64 production", with lines just copied from pahole.

However, to the best of my understanding the counts are what one
should expect on a 64-bit kernel.

That said:

> I think the important part is to keep the d_lockref - that is often
> dirty and exclusive in the cache - away from the mostly RO parts of
> the dentry that can be shared across CPU's in the cache.
>
> So rather than talk about exact byte offsets, maybe just state that
> overall rule?
>

I would assume the rule is pretty much well known and instead an
indicator where is what (as added in my comments) would be welcome.

But if going that route, then perhaps:
"Make sure d_lockref does not share a cacheline with fields used by
RCU lookup, otherwise it can result in a signification throughput
reduction. You can use pahole(1) to check the layout."
[maybe a link to perfbook or something goes here?]

Arguably a bunch of BUILD_BUG_ONs could be added to detect the overlap
(only active without whatever runtime debug messing with the layout).

--=20
Mateusz Guzik <mjguzik gmail.com>


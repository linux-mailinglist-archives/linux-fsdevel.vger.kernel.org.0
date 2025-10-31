Return-Path: <linux-fsdevel+bounces-66596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48DC25CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C810418896C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B4A25B1D2;
	Fri, 31 Oct 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei/9L18U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF95227
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923621; cv=none; b=jHcuksVkt4CJD6w1axJWmNmrmX2oXcVi8l60YVORAm+56wVKInOtVOyHmvLTNeskza5hoP9j1tEPqy4eOGo5U3WS7/BoaiW7drKYSgKBF3/6Q0DeoyzmEJCVIYJ0JNAZb2KYzyhHE81qgSEw6hi8yK5AAS3HHbUxZ6aP39OvAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923621; c=relaxed/simple;
	bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZERd9ovjdanY2qujgBBWX0OWDy2fUQgFLVNs1tf2Q7mwJCjdZFFfUIbpFCHnolMNbfN+X11vfturlDwJ+YJJxnPZl6rn9xMYw3jLfo/QaLA5X1Vvgn6FejlEuXR13EVYV+EbeUTq16FczIlCtXH8JZT4tFq0S8xHg0lsqUyF0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei/9L18U; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b708b01dc04so1761566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923617; x=1762528417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
        b=ei/9L18U5HkAuC9pc7V+xpXWsUgxKwYYi76s8mjMJOfjpKLNPLrG1xRUFGf6ZM3Vg/
         PPzWJHhyzrdZHoIfAivQJRkY48f04jO7pvm30/huXE8fAauISJbBapC4GJ8y9rkdC3yZ
         G4GbO705BixBaKye/Cd4CYUVq0FOjFfnEe/C3O+VjFGb77lpwz03E2s6SqtQ4PUrsjKR
         +ravYwt74R7uuM0gnIH1BT5tEeOU9Tu1DJcWw2ow0d+hc4zkp19JMH16HlAa72LEVRgJ
         CCEEHUYRZBc3972zh3VVFxySnZ46+evH6rwuXYZ60dn81RL5VUw3NMNrFedjr1K10CV8
         gjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923617; x=1762528417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKzyL+jmwyriXmBvdMLiERXr9o5a0ykNZSCadruR89w=;
        b=Gq9AMnt2YnCeyhV5YW0ptdd4Uarq6BW82hQPDhCsMd1KBFoaaJjVzNbIXg+HiaCuDb
         G8fa4n3z6tJv5WZLmarHitp5ZermIqkC6sD9+WT7Toy2+aoCjS1zzjtbAEFGqpCZve4r
         9HwzWJt80Yh3DBckj0DuocR+y95Mb4IFrA0bUwyExLB56/52mhfFhCrW4VCHk0QEiMlS
         qRApapoC5ZqG00g4ITMzpu29L2QTg9LbgrGZKysNgthc3GcJ1Xig38iXt05hUVbxtJmd
         5X6+TtJvOBgFKHK5hv356t7roHL2tycWycda0Rbb4/yP/ANtsDF2u1uQpov+7cj1n4+n
         BVdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQVit1cnO3orq+W2DRwmg9dYWhA1+udOjpXapjAzY2iWOniRItFbPahAOXrWgX82PbNR2ND8psa5as6Utm@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZgkwZ8cwNOMifmZRxr/MpvjB8XFznaPJlcl+X+mZKqUq9NnE
	Swqzf+lwpToVyOUQ+0Lq1rDJa1gNfDheDWY20ARbuJMeQKj1VsRWGnipYvAI5lxHm7LWlGaVWYu
	I355V+SznvRwcy0a0pORfFqvHhTAgdyk=
X-Gm-Gg: ASbGncufxjKHkhojeG9USR4YJocKLs42mVOF5CFu9oH8UWuJqQg0t3fX3d2dFWUqjNP
	iFDfOxaZAzmw58J+UL3PKycXs0TfLeVHNwA6LdYLRxsD737l9jhQH3IJh02BvtW6+B1TZARn+zn
	g9PW5iatM1+4I/nCZ6/y3ongSPk8Og41y6tV1ePZ6xk/mCEKUItRR9UT88B/ZF81ZaStHTpEy8G
	WjLOThqNNFtxnCDnGaagL7t0+2nrQf8DdAO8UgpIxTQz73bPCD4DJ7hDLKyOn6hX9J+Gb+JztmY
	BQsjyDenNUkCXJHSPI1q8F8hgQ==
X-Google-Smtp-Source: AGHT+IFi6RrdmaEHmhz0DYmgTu3lth1+AIc+wR+yR6AFvkMfxIA2Fs0w32EasIWGWhuV3loaspaSUVluO52UjOA6gbA=
X-Received: by 2002:a17:907:72c8:b0:b64:76fc:ea5c with SMTP id
 a640c23a62f3a-b707082fb5cmr400438766b.52.1761923617081; Fri, 31 Oct 2025
 08:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com> <20251031-liehen-weltoffen-cddb6394cc14@brauner>
In-Reply-To: <20251031-liehen-weltoffen-cddb6394cc14@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 31 Oct 2025 16:13:25 +0100
X-Gm-Features: AWmQ_bl0QFNEHVEZqDt4NaeU-OmVLetqVQSG0lX8hIbhRTQHi4GhBcBiGlX77rE
Message-ID: <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:08=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > I wonder if it would make sense to bypass the problem by moving the
> > pathname handling routines to a different header -- might be useful in
> > its own right to slim down the kitchen sink that fs.h turned out to
> > be, but that's another bikeshed-y material.
>
> fs.h needs to be split up. It's on my ToDo but let's just say there's a
> lot of stuff on it so it's not really high-priority. If you have a good
> reason to move something out of there by my guest. It would be
> appreciated!

I slept on it and I think the pragmatic way forward is to split up
runtime-const.h instead.

The code to emit patchable access has very little requirements in
terms header files. In contrast, the code to do the patching can pull
in all kinds of headers with riscv being a great example.

While I ran into problems with fs.h on riscv specifically, one has to
expect the pre-existing mess will be posing an issue in other places
should they try to use the machinery.

So I think runtime-const-accessors.h (pardon the long name) for things
like fs.h would be the way forward, regardless of what happens with
the latter in the long run. I'm going to hack it up later.


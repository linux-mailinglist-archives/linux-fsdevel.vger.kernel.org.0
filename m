Return-Path: <linux-fsdevel+bounces-57592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880AB23BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 00:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6FD2A8668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266F2D9787;
	Tue, 12 Aug 2025 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T80HOv/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15C2D7392
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038713; cv=none; b=N1eMQVnZRNeKYF03Udq9XQKcgp5hYcS5w1SREGCZy47pAicNLzMYnYHFagFMDA7IvhqFxw85dmly58eRPdScrxiS8hJEnfKj7BXLBagnaFPEilInCUw+T3/tFCV9KES+BDdvkgTUuaAkTdnr4uxbsbSee5DQqx+nFfTvzmicxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038713; c=relaxed/simple;
	bh=o2ffnv5qZojJnFoBlMbu5tRKE2FmqJ6tybqZkFkxphU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI3WhyTgPWl++/oJLVxoNLDnBVe776I9n2+V8BiAX56Vk8JbR8UscKUdkeQyS+WZRMEtRRR7cSD7isQXoQnVAGeWpqWUPyDmH/Wh+BLyb1TlSysDaytG+SEPkZb/aJlmD6PfkJlyl7q9D0on6lTVNIlcdwYZSE3HURxLKGxqXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T80HOv/6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e278d8345aso584183185a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755038711; x=1755643511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2ffnv5qZojJnFoBlMbu5tRKE2FmqJ6tybqZkFkxphU=;
        b=T80HOv/6jWlYfdCe8vfJHIzSAt6NyaTf7wPW0sEz0+gOUwvvaDXuNeJYuoF+mrtfV3
         n1E6hDAE1ia9RdP8tbtLBvVcRmRJvp/cYa1hjaR8Up/hh/REt6M7db8W9aRIM9nJh7J+
         zwMLc9wXKoqLE2zYtyhZUCxJQBCX8H6tqNrscdt2d8dKba7Osn0qwvzWx252dwRjvNIr
         DaGFqn9K0zifN7PYTYq1mmjw5dkfZUY80c+n7Mp2HHe5vpgICzkU0iEyxBsgmm50sSEU
         CfVvwgxe4yxWDRu+Gg4XtHLp02Ld7iXrv8i10RQAAlpGp/G0M3lKIqf0eMMcaJrbTYIK
         MPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755038711; x=1755643511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2ffnv5qZojJnFoBlMbu5tRKE2FmqJ6tybqZkFkxphU=;
        b=UBCAUs0xT1k14AoMTiIzODsZ4P3UMHdx34UMNB/kUKr05sXPQyUyR8zsjqxWaFz/Xr
         hCP2ITbP6rpvM6cA1iPk34/e+W2GIc81gKGLEIreY8llpXyyrcpPOTYR06HWDMkZjkPG
         uCBce+YzZzue3dJPIWIcdUAnLp9HeYtjkykhHmIPQ4NN4etTyhVXPnCRx6wfZZcrJ6zs
         N5R1eKyYsA7DTQ7WLHt7PrpKfhB0/XXBRFV0intTwwY9ooPYw4VopibG7HyVhqnXX1R1
         isb2+u3M7pnlsW1qoyMWKtSjvHJlB2qR9Ptk0NM5me+hRqaZ9/ED3b3rIiuJgPoNebUT
         Bpvg==
X-Gm-Message-State: AOJu0YweV6tXaEi5QGe/GS/FkflOmPJcFeZ3O0MPdwxlMhqAVRMKGYwM
	R+MkgC2zbNDuagajzLzh4MQvBaWfx5l1wRFUhLWL1otYwh6Lxns5f7/eUJd5PuAj4KSA9T6Jrz1
	mBV0rCrpRVpfvGcOTH2RGuc3TF+8L6Q2IhkZK
X-Gm-Gg: ASbGncvtr3lOQ1Ff3c3bfzbMtummrGEQmzasM50dzc3fDBBInybr09UNQ7rXshkzsoL
	hR8XyQFAI51VCDHXTKEle/OGrQGdeDRY0Q1/JZXhjw8+T+qKwENW8mDl2vKdu2XKXV18gAK4nig
	leX4yxtL7wqigcl8ZvSnGUHoJ9mKMcrQ8v39RFxOk02fpZVUKGdT5+iujEzB/UmVQfIphK3BTkR
	A/g3JlQ
X-Google-Smtp-Source: AGHT+IH8bIEtv9JXpNEEogRc6bxsWkIjxgqN1sCJCq654YuI1mSSf2ztI7KXCh0EbfaacioU7jdAV9NpGAttamhX5eg=
X-Received: by 2002:a05:620a:2905:b0:7e0:cb93:6fb1 with SMTP id
 af79cd13be357-7e865223b9cmr138172185a.9.1755038710971; Tue, 12 Aug 2025
 15:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com> <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
In-Reply-To: <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 15:44:59 -0700
X-Gm-Features: Ac12FXymgD1yk-ULnRkGgmMW-Jf4VoveFjdev7JXcxtBuIybDPwQzwbaFA6njKY
Message-ID: <CAJnrk1Zf5LxMAbNYMNsyphHZbDyC6VxZb41xiz3CBsHdYcwimw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:14=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 11 Aug 2025 at 23:13, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > On Mon, Aug 11, 2025 at 1:43=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > Large folios are only enabled if the writeback cache isn't on.
> > > (Strictlimiting needs to be turned off if the writeback cache is used=
 in
> > > conjunction with large folios, else this tanks performance.)
>
> Is there an explanation somewhere about the writeback cache vs.
> strictlimit issue?

There's not much documentation about how strictlimit affects writeback
but from the balance dirty pages code, my understanding is that with
strictlimit on, the dirty throttle control uses the wb counters/limits
instead of the global ones and calculates stuff like the setpoint and
position ratio more conservatively, which leads to more eager io
throttling. This rfc patchset [1] is meant to help but it won't help
workloads that do lots of large sequential writes. Experimentally,
with strictlimiting on and the writeback cache used with large folios,
I saw around a 25 to 50% hit in throughput but with strictlimiting
disabled, there was around a 12% to 15% improvement.

(It'd also be great if others have time to confirm these benchmarks on
their systems to make sure they're also seeing the same percentage
improvements on their machines)

[1] https://lore.kernel.org/linux-fsdevel/20250801002131.255068-1-joannelko=
ong@gmail.com/T/#t

Thanks,
Joanne
>
> Thanks,
> Miklos


Return-Path: <linux-fsdevel+bounces-47318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9957A9BD87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 06:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A039189AF9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB72185AB;
	Fri, 25 Apr 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FkUZ8NG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC86217F53
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554878; cv=none; b=exqHJdMwLGRPX6e2OwvvJ7XStDScOnBB9S7fniLb/Lw9RiGR3RDaAReIuVsa/4Vb8Ecbgz6yE/41/WvfiJ0PCMvYhUOkNEdSZNp46sthB9SmWyI0YNPomSZxZTxO1lHZS0eL4wKjliIs3N/g/xSQWrnptIPcKxQosuvaO8Ck3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554878; c=relaxed/simple;
	bh=2ek74mNNFIgWcZk7Q8YaK5RG06y977D4eT9YNwdT+O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6lcbuejj/dCbls846YI1bgHwzvEdjLpbK34cQ9v5Nzd8yf8XnJVkWQJGFJN43i3O/fSvqLHDUo1m14hiCxy9uI7pAJvb0GY12jgPuZTa5EkS03ZDAcpGzHLOnnPRssO49nKyjyc6QqzbuoL/m/ZbEkTdKHwPTZc8kHsS7w5Lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FkUZ8NG8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso1254529a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 21:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745554874; x=1746159674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NAE0ezuMYS7J5WA+bsYijLDvptHGpv+uu1oCrM7N5E=;
        b=FkUZ8NG80bHWOEIOM5Quiz/XVpUIy9AjIzIpYpVFop6WXkS/9kKh+XD5/H+bL+tfF8
         LDa1+ZA5OgtoPcbcmOr4i6i6wSPC82w73sTEDaHKrbMcxAY6XPCck6tfSFT+5OeO0WrU
         bosLtAxdpDfm0LYo76NtR7koGAbYdicfLRPVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554874; x=1746159674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NAE0ezuMYS7J5WA+bsYijLDvptHGpv+uu1oCrM7N5E=;
        b=Y7DHWBFkRRqbMhEwH6RW4CAAfNKzdOlaCdlbnSnNaXO1JScYITrp8WvL/QplYQvK5F
         IifpOd7kk9jw5EE15IhcS6JCXyufPXJGKYe2/xTqGEMKmfqjvLk8ozXhAb3/j+UC6onw
         gKunumfvZfLTvhXUwBzCuK8Q1fTfIuWWF4IpnX2o5pl9A9qlv0xoh/wVadXqzXo2Sp3S
         0V3JZR30/eABYiijCcnj/+TbsSSF9QWogXd3Yk4qll4o4MTZ3uHB6kJuJBWaY9Mose7u
         QJGp9LfxX2XKTj5dy8Ntxafu6FJ0UmfBPK3YZfrlRoXXOcHaR/Hx9sC28t/iVBuJL954
         N/8A==
X-Forwarded-Encrypted: i=1; AJvYcCUI2oQeCG1F1cRHhE6py2dRtqMdKF4aSWjLHBS4BA9JRKR5lVOhsAFu2O6HbfjqcheGwMLDxhLlRuESQra6@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWFtuka3m2RBiw3dNRwREmLmaf0mGgE36Ntt1YJOIzM+gW0Oz
	oAq6Pt57Usqw5o+QQ/9C2fv6ZRTeUaYshRlBBjJ4VleZrvL4I5zexlL4G2TKrJGvR81sepEr1Cb
	G9smKmw==
X-Gm-Gg: ASbGncsXWv8NYvXgZmVqA/Ak42A41Q2sFvfd+EECqABroNWZ5Bmi01ebMBNyLenq6Iw
	Bvvz+1ffTlwfMCMKaMvfNHXFC2/jtIAr4K8EI3eXFXJpZyEVRY4QxI1eT4+U+2rI/JpSEgNgUrm
	US6BZl+uQKzzeZmAV/5t+I4GwjcLdsvckZXuLeM18V6hCM6SVLjd37bBDrSv4ZZ+Day27PhCNRa
	RfIXgQ3wwvp1MIi13ze/gU+1GtPBl5nrGc9lyzKnNNXkJuC7n1ysOochAovXYw2o5ZeU0lSgKNd
	cKYWYjIweLPid+eB4DT/DLV2RnN6DWXyScJBAjn8QmHkjm0LqGcDPpuSzFQzzCIVKrnaZRvV8OV
	ePy+QSfMSyQSuczk0lLkkpUHEAw==
X-Google-Smtp-Source: AGHT+IF1RzVstvGLL8XongkrBjLzM/aFo/rjsF+MLA9tcCHWqCXvWGXycmiaFLXGZoGTEodSe2aepg==
X-Received: by 2002:a05:6402:1d4a:b0:5f4:c7b5:fd16 with SMTP id 4fb4d7f45d1cf-5f6ef1b2887mr4230496a12.6.1745554873686;
        Thu, 24 Apr 2025 21:21:13 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703831b5csm624728a12.65.2025.04.24.21.21.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 21:21:12 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso5203519a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 21:21:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQSpWpH8cxLZd9o/w5vkb5laq2J/uR6D5QuGBgQTh9yP39T2dKjyRL5RxMsCXrK8IgdCz+O67URV2VM7hH@vger.kernel.org
X-Received: by 2002:a17:907:94d2:b0:ac1:ecb0:ca98 with SMTP id
 a640c23a62f3a-ace5a48320dmr384453966b.26.1745554871324; Thu, 24 Apr 2025
 21:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
In-Reply-To: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Apr 2025 21:20:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
X-Gm-Features: ATxdqUGW6PrSoybEs-CBS2CL_qi9B6hsp2y203CCwxZ62Ilhm4qWIq-GEHNl9dI
Message-ID: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2025 at 19:46, Kent Overstreet <kent.overstreet@linux.dev> w=
rote:
>
> There's a story behind the case insensitive directory fixes, and lessons
> to be learned.

No.

The only lesson to be learned is that filesystem people never learn.

Case-insensitive names are horribly wrong, and you shouldn't have done
them at all. The problem wasn't the lack of testing, the problem was
implementing it in the first place.

The problem is then compounded by "trying to do it right", and in the
process doing it horrible wrong indeed, because "right" doesn't exist,
but trying to will make random bytes have very magical meaning.

And btw, the tests are all completely broken anyway. Last I saw, they
didn't actually test for all the really interesting cases - the ones
that cause security issues in user land.

Security issues like "user space checked that the filename didn't
match some security-sensitive pattern". And then the shit-for-brains
filesystem ends up matching that pattern *anyway*, because the people
who do case insensitivity *INVARIABLY* do things like ignore
non-printing characters, so now "case insensitive" also means
"insensitive to other things too".

For examples of this, see commits

  5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")

and

  231825b2e1ff ("Revert "unicode: Don't special case ignorable code points"=
")

and cry.

Hint: =E2=9D=A4 and =E2=9D=A4=EF=B8=8F are two unicode characters that diff=
er only in
ignorable code points. And guess what? The cray-cray incompetent
people who want those two to compare the same will then also have
other random - and perhaps security-sensitive - files compare the
same, just because they have ignorable code points in them.

So now every single user mode program that checks that they don't
touch special paths is basically open to being fooled into doing
things they explicitly checked they shouldn't be doing. And no, that
isn't something unusual or odd. *Lots* of programs do exactly that.

Dammit. Case sensitivity is a BUG. The fact that filesystem people
*still* think it's a feature, I cannot understand. It's like they
revere the old FAT filesystem _so_ much that they have to recreate it
- badly.

              Linus


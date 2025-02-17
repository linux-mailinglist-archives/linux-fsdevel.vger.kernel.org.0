Return-Path: <linux-fsdevel+bounces-41824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FD9A37CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CA3AB0AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88573195F0D;
	Mon, 17 Feb 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS/WmFFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D67136349;
	Mon, 17 Feb 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779411; cv=none; b=R+1i0q8MIg2T/n2Jz+QRsC6Y7rVTDz1joRIi+NRsmsakAWjsqyU1Bsrz7TkyiY2F+7MAprbf7OljwlQM01NeErPRUa75zCURdBmWR5VmbV4kMc/tgnZApPYLCrwXBF77ZZkWoaZnIxL8+F52Inql0pX89cBQ5PEcZrq4ulqmQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779411; c=relaxed/simple;
	bh=og+p5GUQckHP5nxbEyvN6VtE9n9dSmRvKYzq880VS7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4JxL5vdhJjVXOJz4GfBsXg7Bs9nvgP1u24BG2G69vdzJGfORI6H4kmslndYw/rVye0Z4PFa/ErhPflCxuXYpNBKJkt/UhrAXR8X7mYZhYf/PJv5nT1qk10dRvb5DPwnG/u7eYdKAsBZnK8atqSFFw6f7zzr/3ITJA5Fj3KVvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS/WmFFB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7404937a12.3;
        Mon, 17 Feb 2025 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739779408; x=1740384208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og+p5GUQckHP5nxbEyvN6VtE9n9dSmRvKYzq880VS7w=;
        b=iS/WmFFBfpr7tdyGD/xQOzUAm/DhAtzd1095gUMpKFLofZR6AWkMOedHwhD4THuksf
         PbYvjrW4Vv8p2cousSfBOn9La/98JJr8KREo46XG3Y8AyM1gNhaxTRiYbKI89H07pfyx
         vFzzwG1xIXgWu5OGSR8HM/2zy6QGH0OytLugSRvFkxieV8r0r4eJsCfZtLPXNfwSlgoK
         rGx+iyttudIATRem8JpRinsghcn9552f5qiUDP5SZcr2mVIrhO0fkZU5pzMXxOiMHPSn
         piHv6yfLOVmEmlZWetG5MnFlwB73WEmnBj4JyszGK+HSxbr5u0L28a14vZ8NVqtczvpP
         fSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779408; x=1740384208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og+p5GUQckHP5nxbEyvN6VtE9n9dSmRvKYzq880VS7w=;
        b=mZJI+5pTK2ntEa9NNx0uG6U55jXaA76L3rw3t9xaVMKFKEp4sszG7qCopE3n+Sk6QI
         qCUP/YEZSBKIjcn8D/p36SqM8c7zzmSiQg3RVfI1CsW+JLs1WBQZg+aTzFGAavmg6Qdp
         WRPCbz6bZfqCDYC2I+SCQCCbJEEItYJeZ4DL8Y5Dk7hQdfv8803XCAMP+ft8dA7AVh74
         u+OEllaQ3e1EMXStef44I2MHUrvQl4zWAuwqSiBeo5QSpIN5zuxviRN3dWUXasU+PbYn
         Nda6KmsEhyG96HclPdXjdb/VlU+uE2yz1PlwPHKvHGQR98U1wOrXOAdiW+PcSXSJKxqT
         SNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVecKUGq/BHc24uFC8KlyGr1dJ4kVvm7D1h2MotqNSC28ZF1u4r3X4YvTN0fikxsTsIQ9CzM2GSfyu/woNz@vger.kernel.org, AJvYcCWDBGAVjZjp+hp1wdsHCbmToJiaiZNSv4j3D0tOgviOZ21efEe2pfd4XY9DqffY4sgimxoNg8PaHZDafjm+@vger.kernel.org
X-Gm-Message-State: AOJu0YwToSMd7dH8lu5kiX+S9v/jvHMAQM1uRAf5hpDdNceyf/cztbcK
	3yw6gOp4ROU4g4gd3HrR9sH/MPt3gaLdlVRV41VjyWngVm0ro4q6dqnbDYIU74Gy6qx4eeEcdA4
	FuqZG3gGC80b3583cFx2kv15NE+g=
X-Gm-Gg: ASbGncvYnf15fnht2L9T5TMCWwtuC8ZtZU1NqfcrgQEHVrDSvAowxCwe3nDb9M0zP5N
	4MEqwBdwB0j+u5aMf4cX0CVShdbqB2kpDoF4qR9J8ejRY3HwT6MbpSpYXpZNhNjYcg+6PIZOz
X-Google-Smtp-Source: AGHT+IF7NbVnwAYiRCoa4WT68JzdRFWhztnH3TUzWcaTCtgXMnkY2M+AGZFKbTQqkjVf9WRONFmw4NDk7X0prL4nfyU=
X-Received: by 2002:a05:6402:268a:b0:5d9:a62:32b with SMTP id
 4fb4d7f45d1cf-5e0360440a0mr10035398a12.7.1739779407426; Mon, 17 Feb 2025
 00:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807063350.GV5334@ZenIV> <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV> <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV> <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV> <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com> <20240822003359.GO504335@ZenIV>
In-Reply-To: <20240822003359.GO504335@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 17 Feb 2025 09:03:15 +0100
X-Gm-Features: AWEUYZnYwfQezLXamJtJQUkfd4R4J-WC2vcMCH6zbVOjTje8hbkpimf0YKjJQ2Q
Message-ID: <CAGudoHF-S-8YBWMcpgiKO8vcjEvR7SGHyV-+X4jo_e7co+esRw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:34=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Aug 20, 2024 at 01:38:05PM +0200, Mateusz Guzik wrote:
> > do you plan to submit this to next?
> >
> > anything this is waiting for?
> >
> > my quick skim suggests this only needs more testing (and maybe a review=
)
>
> OK, let me post the current variant of that series, then we'll see
> if anyone screams...

looks like this fell through the cracks

anything i can help with to get this in?

--=20
Mateusz Guzik <mjguzik gmail.com>


Return-Path: <linux-fsdevel+bounces-55624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09541B0CD33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3791189EC35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF25241CA2;
	Mon, 21 Jul 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b91jcka5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558623E25A;
	Mon, 21 Jul 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135996; cv=none; b=ZKUmhi0cxaSU9GfVfb+wJiaRtcWycfPZ2YoKWhupqZ78gytmkKG67UCgXPCVGs0Yl+fL7MX9/jj9Nh3wsziIOS/b/Oh0V+MzzmozGP+Ycra/1LMPekAUKJZSse9XVttPsWnig4cB+EZOBN53l881FRwgT4X3YtSnQlz7CowOxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135996; c=relaxed/simple;
	bh=vP1W6WJPDl5iLhA+8YgrVzSEMMjQAA4cbViPPymMSs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhwpAwgCCY1rE4TGANc4NHTApL6mJPuLEeJaH+FD7GB06yQCXhBXcaOhx+WUSVqW87qhGgOdmPlLO9DdFjAmOsqeNagGIKWR9aosSS0SooydQ8uksgd5wiMVK+lwDTyO0MKDUmbJGzxfXIcOOOo0wEyWFg0irE5wxlC3mW735gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b91jcka5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2350b1b9129so33239015ad.0;
        Mon, 21 Jul 2025 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753135994; x=1753740794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+8uZUrE32kx3Y8E2ADL7GSixioUYxp87EMR1K59PcGM=;
        b=b91jcka5KmXXh7yzYnYXAxDiKA4klv7OR3HsIs2b9Y1YfeHi9MrX9U1e5c/OCDARaX
         +mvqudKnElkX0MdFOj+LA2wJYYYLkbYPuGej9m58Rdw9SuF2WjkkZqjMGYOwbkT7vD2x
         cmG9mqHf9KWsdL7t7/o69QCBw570zTYRTFXRxuUcg0p2jbUFsfLKG2DYVUYzwv58WxBp
         UfQmg0M7uJKOG30KZPGuE3iWVob/afMq/5w34x7CrDFJfGLaWDnQ/9zPzyuK/0yldRcK
         QJXpHv6ncRRdwJvwsDw2ki0p0I8bmfrTSjWs6lEwxbMI8OInSHr1Fq3Rp0/IsCX6enRn
         QigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135994; x=1753740794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8uZUrE32kx3Y8E2ADL7GSixioUYxp87EMR1K59PcGM=;
        b=kZ4V69sB3sOk/UY90V6sR1XsuZm2GlWmKzGvxVdCQ3pVfFdaS8N3ySY1+rbjHW4yBB
         Lj7MfJjIyU73QuSZlLzJRoXATGa89Dc+8jy3AFGjFSeUlpCGnvnXgPzy7UVEqw4V33RU
         9b3uesx8Utu2XjOtlKW0VGVpytQYfklYtxmwhledFjSCNXapkGh6GIHN8TqUjJNCq7X0
         1BdyAA54qRqitZTUXSqVnilkR7uRgHFhIk2qUEEsSk419rRrbiK0p9oGsGUh9X8TgoQo
         E7q3+wjcj2o5mVMWBuqYAj1EljuV294Q5MpG5VuQ9JiP5uabzts/VCWlMgP6D4efN6Uw
         ssSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEGl69jUVzrghsmnD1vwk0EM7iqkOXPgEj8skTlNgOUh1u0Liy1Xfeit4chuGOv5G9eY3YGUUqKUXHpS3@vger.kernel.org, AJvYcCUVEdwbGAO/RJ/dHEdUbznMQAtKVFJhTXuAZS4/5grwKvOtaYRJ87lGSfmKV1UgptpusI8fql4o0HlvMdTT6A==@vger.kernel.org, AJvYcCV/DEq3UIPYmesW5H7KTJWH4tA36M1xAmIx3nJ6hvKRPsathCsVHwtKkQnK0EIUIp2Ame1dWxwEPFnHqBFZ@vger.kernel.org, AJvYcCXWBMd3Sh4apTlRRszIBwn2gH0oZf5hCebXm/+13+1ui/6CzvlalFoo7One0wqMZI4I7mR6wHDzMsvHKHYRQE2e@vger.kernel.org, AJvYcCXa15VvOweBG5J0H9/5+zBJoRbIavgJx1vla0xu5w2eCofAwzefRG7aZC4jdcnQMk6yvPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhraBrydJ/OnEQ6TMk17sAv92VYfVUaMExnNoVszVR4vZZKCiH
	mCXz8rNSZj0sOhe7cat07Jaila2CFHbrpKLzFAYsShwka2AivAz8C9IK
X-Gm-Gg: ASbGnctZA98KgTmAnB0Fg3jzeBbuaZJAt/segp8zbXowWYqemcSEipgcnLBqz51orBO
	daeRn2SRjTQ43WepNcojiFcMtwUfPg+lYzll16Q159A0sYN/CZ4j/rMpTxNvDw4GdD4VW2cnHTt
	UHl/xn75VVP2C3GzGCtiO79g4XSgkVNMyXbtY7zEj5j4jZ+Ax71VqQCxtuXWh3341bVfUvwU6zo
	90QEdQt6GKoagT5DZsFEESMJiNTqahYxAWgiZ3SD02+rGA6kk/1+kNJnAD9Ft7vNPkfa32GbGnR
	MjeEPKiLYMbp4jWe7PpcdzN1qVO+pyrz5G/Hz00lMslxteAmrWuM1GA67b4+wW8x6FIZqi+fLmU
	lnkRMnXz4s8g4mkP3NUFqa1XKISy9
X-Google-Smtp-Source: AGHT+IHxsqdm2Hc+W3+mvEVuEMVTCQZ2rqpr9FSegnYQ2/jB1XfVrQ8BsAanT22nX0QAmjG9/qtWHA==
X-Received: by 2002:a17:902:d490:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23e25684a67mr299105685ad.3.1753135994080;
        Mon, 21 Jul 2025 15:13:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40cde048sm53740a91.1.2025.07.21.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:13:13 -0700 (PDT)
Message-ID: <0d6e1144567e32bca049e4438395ac16da85124f.camel@gmail.com>
Subject: Re: [PATCH v2 6/7] selftests/bpf: replace "__auto_type" with "auto"
From: Eduard Zingerman <eddyz87@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,  Alexei
 Starovoitov	 <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton	 <akpm@linux-foundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, Arnd Bergmann	 <arnd@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Dan Williams	 <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen	 <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@ACULAB.COM>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Gatlin Newhouse	
 <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, Ingo Molnar	
 <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jakub
 Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason
 Wang <jasowang@redhat.com>,  Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, KP
 Singh	 <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, Luc Van
 Oostenryck	 <luc.vanoostenryck@gmail.com>, Marc Herbert
 <Marc.Herbert@linux.intel.com>,  Martin KaFai Lau <martin.lau@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, Miguel
 Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown
 <neil@brown.name>,  Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sami Tolvanen	 <samitolvanen@google.com>,
 Shuah Khan <shuah@kernel.org>, Song Liu	 <song@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Thomas Gleixner	 <tglx@linutronix.de>, Thorsten
 Blum <thorsten.blum@linux.dev>, Uros Bizjak	 <ubizjak@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Yafang Shao	 <laoar.shao@gmail.com>, Ye Bin
 <yebin10@huawei.com>, Yonghong Song	 <yonghong.song@linux.dev>, Yufeng Wang
 <wangyufeng@kylinos.cn>, 	bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org
Date: Mon, 21 Jul 2025 15:13:07 -0700
In-Reply-To: <20250720065045.2859105-7-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
	 <20250720065045.2859105-7-hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-19 at 23:50 -0700, H. Peter Anvin wrote:
> Replace instances of "__auto_type" with "auto" in:
>=20
> 	tools/testing/selftests/bpf/prog_tests/socket_helpers.h
>=20
> This file does not seem to be including <linux/compiler_types.h>
> directly or indirectly, so copy the definition but guard it with
> !defined(auto).
>=20
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


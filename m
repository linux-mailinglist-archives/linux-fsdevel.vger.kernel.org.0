Return-Path: <linux-fsdevel+bounces-39515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F8A156BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C416F1696ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BF61A4F0C;
	Fri, 17 Jan 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5inegRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D31A0728;
	Fri, 17 Jan 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138820; cv=none; b=LLRONrZLuxe+2SiwldSZ7EAKCGgE6XtcUOVEAQKLiQNVFLCvX+k6zXfhoos/zi4CSHJiTP8NRKrA1Agz+O/dm6fLg6mDwAhFZY3QkeFOCi1RnsA9rzc1rx6egwmacoygUmK6XA1gTknnifesMy0ZxIeWUTRHkQiv3vsCvC+6OIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138820; c=relaxed/simple;
	bh=gCBzXbcWy5Z0p6axDFnyuCK+SdLX5sEX4YfTiqz4eUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sys3UVEuJhlXTjKS0hV5ugyH33PKMq+WpMtDBdSzZtl4/RomSr9gy5gMbFYglx7jNlf3d8DzLGBcsilbI6KK0zXAZvzHSC961IXbz/9Y8QG2FRYOHByeeTMBDrYDZVK05GJZYKESzZVVaNVSCcijmuXMv4MdgUd5LvB/+ut+lYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5inegRw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efb17478adso4264596a91.1;
        Fri, 17 Jan 2025 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737138818; x=1737743618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDsX/LhY8aNBdHxcHQr7zfO0GAMG4ohe8BHhjqjqYjg=;
        b=l5inegRw+h+fDFQC90DpTPiE8kSUyLO4SHAudZ6YVN3G8OFXR2FWRlf7vOczfScFuM
         2QYWgPIup1W38/9iF9W/mWMgnI+Tm59kahH0yxyilDzNvbvs4wjYOu7dJJj9WIobRRxh
         UBN/zLkTDonKph2Ww3Nl8yPUD62t7Ofn2DWtpBQDRmNA65h0qFP/F45kpvVd36zEsjY/
         sfehqBitr6p3A5Lax8Z3R6Kvl+8WGYw6RWNFyBk05BHipp7Wq67BIGUbGGv5tsFBVB24
         OIJS+ykp5+Y3W6vduTMAxexS9ZiOR3jy/KAeFgyKJmhOE2+GEhvx/TZJmuXfUtYMMRUU
         RbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737138818; x=1737743618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDsX/LhY8aNBdHxcHQr7zfO0GAMG4ohe8BHhjqjqYjg=;
        b=R3wBrwawSD4fV1cUbozIR7GavCq3RbjAn5z60eu2kr0HHMrIl4Y4rwcJXrND67hANB
         kKJvAmm+p9yjYJP83JsildqjePAqWKMB50MkDZQwT9thZ/w7/GbDonJ/U6DpBw2nX7va
         G9zJQ3u821hrEo7lpU6dgBgW9lbLI3uxv4at+3ahCscpjSsqxMTSTJElcrHXSkk94QO6
         RpSeZGq7jwPiY6s5f4M8a/TrDEy/gkFKvrwokBnY24/gf8HNGj2VggSc2o1y+ARPk02U
         sI8uLL/B9Ri2rNOnOmCSjIR9ZBngYoTw6mBJkjSejLqdjCKtZ8F3dU8gUILQ3M7M0kVF
         9Nkg==
X-Forwarded-Encrypted: i=1; AJvYcCWs9P9aRIohX0Ach2CoGTQPdlfHfMpD7JEZUUxOsf6P51GpKEOqMTFq32HzUTQhxl+tj+U=@vger.kernel.org, AJvYcCXaWgwpO0EGbIdentmu28z78eXDCdR2WGYm7kTaHfTJn90bl4nblbUvtNOwlPapODHOAqkbpYIvwBSO6+ssiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyA0SawIsJzqXj8wBPoR6J5FUB6tw34Mt9Myv3Jb1kOSmoklaS
	CGWyJFlvMmYsUD+gTSpoIFwVWq2qz3jiMnFXN+T40EBfu6EhxKDcoe7pY1x+tFO7ZzyKrrK7FCC
	12WOD3cr2E7tBcoDVl310je4W4EVqTg==
X-Gm-Gg: ASbGncuNpRNpztphzyhkDkT+cxxfEFeGBpX/raozEEZ2nouEzR0MOPkg0vUmIKvL2kL
	zkrjGifRaMP7imgNLW8ZRqTxt5L/5n/R5desI
X-Google-Smtp-Source: AGHT+IGxbhrpNwOZv6EpeElQXX0N2j1DGVKd+ZJZ0lh+GFCOoWnYlJcqq10rgM4j3fnK/JH/blPkY1sIWgNTEoLBByk=
X-Received: by 2002:a17:90b:1f8f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f782c71e64mr6232893a91.12.1737138818567; Fri, 17 Jan 2025
 10:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116124949.GA2446417@mit.edu> <Z4l3rb11fJqNravu@dread.disaster.area>
 <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com> <20250117022050.GO1977892@ZenIV>
In-Reply-To: <20250117022050.GO1977892@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 10:33:25 -0800
X-Gm-Features: AbW1kva1X96PUMCVO6uDr8nFdtf_7KiWtclvFjWmJJCLuEkJaGOrJAdilS0SuaI
Message-ID: <CAEf4BzZga1Vk0UgPBu=t69xpLzJdW67-9Y9F86PGz=SawxChSw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Jan 16, 2025 at 01:43:39PM -0800, Andrii Nakryiko wrote:
>
> >   - relative stability of tracepoints in terms of naming, semantics,
> > arguments. While not stable APIs, tracepoints are "more stable" in
> > practice due to more deliberate and strategic placement (usually), so
> > they tend to get renamed or changed much less frequently.
> >
> > So, as far as BPF is concerned, tracepoints are still preferable to
> > kprobes for something like VFS, and just because BPF can be used with
> > kprobes easily doesn't mean BPF users don't need useful tracepoints.
>
> The problem is, exact same reasons invite their use by LSM-in-BPF and
> similar projects, and once that happens, the rules regarding stability
> will bite and bite _hard_.

Not clear what you mean by "their use"... Use of tracepoint by
LSM-in-BPF? Sure, to augment information gathering, perhaps, if there
is no more suitable LSM hook. But tracepoints don't allow you to make
decisions, that's the biggest difference between LSM hooks and
tracepoints from BPF POV (IMO): LSMs allow decision making,
tracepoints are read-only.

Or you mean use of LSM hooks by BPF because they are more stable
semantically? If so, yes, sure, that's a good property. Still, neither
tracepoint nor BPF LSM hooks are truly stable APIs, and users are
prepared and expected to work around that.

So, again, from BPF and BPF users' POV, neither tracepoint nor LSM
provides or guarantees API stability (though, in practice, they are,
thankfully, pretty semantically stable, which reduces the amount of
pain, of course).

>
> And from what I've seen from the same LSM-in-BPF folks, it won't stay
> within relatively stable areas - not for long, anyway.


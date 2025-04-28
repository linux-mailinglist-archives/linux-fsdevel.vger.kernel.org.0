Return-Path: <linux-fsdevel+bounces-47474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599CA9E650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B754F189B2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE0189B9D;
	Mon, 28 Apr 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Trj3KLvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C723BE67
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745808009; cv=none; b=MjRVh0saIhGg2SE7JdKgmuiSmoU9VpotMAQ2J1L5VE4ehJteIjju1gsNi2Tq62K0AodTG0Sc+b+4N0MX+OjOB6z3EoISqLCT9xfAhtQLG6u8wKrEfaZyyr3WQUhvULoA8C7LY5p27dPRxtecKo8+hYp2AVcgOEoHWDnc9wUBxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745808009; c=relaxed/simple;
	bh=9ak1Y1LNwKVWK45Mep5TVznM9aXYVsr0q7zxmIKkhMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7Pm8o1SrmaIOIuC7GCP7/WrhdJpAh84rPYyLdADFioF0sZQVh39OdWgCGg22fXmcaqrZfPwe3fZ0MRAVijRu4G2y/uNxssZikeQh046iWZAXqGsgMbfFrOt0/toNhx9A6lSyQi2wRtJjFH4eyr8JlEMMZrftYhlNTXx3gnn8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Trj3KLvi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abec8b750ebso719574466b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745808005; x=1746412805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7yg5nbDyJb2zlJLx/YXnma09SaHzuLtzbwsUIUnGhg=;
        b=Trj3KLvi8UGU8+oc7xMnIWelZ6vVLVyYrTTT+qbyPq4kbYVBadcUBC0q3tnEwWL58f
         iNIjvkwLsBWKHZRGsuwyYEMcbQDk+0LgINC5GBKCx8Ew+d0pXT+DGEnwpQcaiX6FmGLC
         sQGSmA6vq11h4Xon6PK36Llit/S/kGW9GoAK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745808005; x=1746412805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7yg5nbDyJb2zlJLx/YXnma09SaHzuLtzbwsUIUnGhg=;
        b=Uog+E05omDb3Mb0B6w7dUYz/YeGGs9Ic5RlFaHtjkxh7g2anriq9pOkXBLo48vFsCK
         HXLIDRNnb5t8+KQSdAWfkBUfroUSpO93KQXwXOpGOf2b6xrgOMDCclL8g11ePLRdSfTC
         ZZZQqBKJzbT05LCAldDqQexukVCAyfK8G4b9MlYkSWMwFWywrEpwbRHPTQ5hgHn6pK1t
         S7U+yzGSEG7A414lKiqIcOvCUYEMafsGz7JhHSLLpA3YI1ZIXhR188JWbecVX4KygCBz
         bQFVe+sh87xsl22NsaPNipIJ+z98GV/CvviYwY319+49m+Z9NGkqWlrWhMyvRBPy8MaO
         xoTg==
X-Forwarded-Encrypted: i=1; AJvYcCXTregMzDleZvlDvF370XBfIIXSPX2I/aRb3ur/CQIgVLCfhTqntdBausFzUKpv9NlLqPscbmGBB/oFR0A+@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDRDt35yn0QieTECFHbA7swRsduy1WIUwWDU0whLQjui0SCIl
	4kmDsg7MOuaD7fXUYHmTP9dw9Q2KdoVBPDvyOPJi8Ds81N41/gpvyvMVmdREzz+HPojK8FnIWcN
	dz4A=
X-Gm-Gg: ASbGncsOVzcTU1yHVuv1e9sHMGj4e/n7lyV06i9Kbw6tQhW6IXz5eOduHBspOujFLUo
	9PyyfdoFnBg7/JWJhGTddLmN6ZyO526QCcrRBvRWTnW6Xm7BOmkqsCyS1WGCe6gb/LgTh2Kddu7
	2X+bYbI0odTBAquNMcygNUBuJ07qQlFR9jK6ZcJ4ucMg6ElzUWAhEb/2Izh1tVgj2TaFkVWIgf6
	6AlBZ0xxUpO09jgr65lrfx5NUDV1toRHeGlhQlXTEx7elo7Ti7WxOGV2Q+XwVgba87hQFNXyhLL
	4ZabeubaCve+hChhhbh8SgGH7lnPzrdme9M7iDAzQiUivcas5rbEhkxUu5jvz12q3wkn0hOWhYX
	eEHBfiCdaqI5q8Ks=
X-Google-Smtp-Source: AGHT+IH178olCUvPMVLA4RswYPq88Ao3wBl4C6LodmZ6FJxCvOk19QLEp1XjwBnDf4zKKGS0+Y/iDg==
X-Received: by 2002:a17:907:2d1e:b0:acb:b864:829c with SMTP id a640c23a62f3a-ace71038c36mr934329566b.10.1745808005222;
        Sun, 27 Apr 2025 19:40:05 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1f44sm547351766b.176.2025.04.27.19.40.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 19:40:04 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acbb85ce788so814075266b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 19:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9M/Og4Z5VoueVtsnkbVSdE5HtIYCLau422U6rdRokrcUwFo2RTcgCj2sFZXJxtFIJa/6yDFaIZPSDRCCe@vger.kernel.org
X-Received: by 2002:a17:907:7fa5:b0:ac7:ec90:2ae5 with SMTP id
 a640c23a62f3a-ace7110bbc5mr916176466b.25.1745808004097; Sun, 27 Apr 2025
 19:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org> <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain> <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es> <20250428022240.GC6134@sol.localdomain>
In-Reply-To: <20250428022240.GC6134@sol.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Apr 2025 19:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com>
X-Gm-Features: ATxdqUGvyKI4n-dRAwL1ViEnwkLC2od4DD7XTcjrN1q3OFkYBi4GABqBN_mXblI
Message-ID: <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Eric Biggers <ebiggers@kernel.org>
Cc: Autumn Ashton <misyl@froggi.es>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Apr 2025 at 19:22, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I suspect that all that was really needed was case-insensitivity of ASCII=
 a-z.

Yes. That's my argument. I think anything else ends up being a
mistake. MAYBE extend it to the first 256 characters in Unicode (aka
"Latin1").

Case folding on a-z is the only thing you could really effectively
rely on in user space even in the DOS times, because different
codepages would make for different rules for the upper 128 characters
anyway, and you could be in a situation where you literally couldn't
copy files from one floppy to another, because two files that had
distinct names on one floppy would have the *same* name on another
one.

Of course, that was mostly a weird corner case that almost nobody ever
actually saw in practice, because very few people even used anything
else than the default codepage.

And the same is afaik still true on NT, although practically speaking
I suspect it went from "unusual" to "really doesn't happen EVER in
practice".

Extending those mistakes to full unicode and mixing in things like
nonprinting codes and other things have only made things worse.

And dealing with things like =C3=9F and ss and trying to make those compare
as equal is a *horrible* mistake. People who really need to do that
(usually for some legalistic local reason) tend to have very specific
rules for sorting anyway, and they are rules specific to particular
situations, not something that the filesystem should even try to work
with.

          Linus


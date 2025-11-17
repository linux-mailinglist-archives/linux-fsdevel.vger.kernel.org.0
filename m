Return-Path: <linux-fsdevel+bounces-68788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A4C66332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC7924EA638
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE034C141;
	Mon, 17 Nov 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXpvWS2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2034C9AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413640; cv=none; b=mGJz5Gp8zjwjqFYoTNMAowVffXbHkx9/iPq50zDr/DDxC9NcEeQQMWwR/FQ2HRmGnmvRIM9Mku9TgOZ5muLTI6LmDqS2XIDpOsoqwvxMUrVz4iiwRWMYzVfFgSDj13yKNs3q6p4acLRBi86hd2Si3YoH05/KKvjOO4R0D25hYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413640; c=relaxed/simple;
	bh=UxmlAnre1tVYYLXz6QjhoShZeYckMkMwCvEkzjPXsI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+5ze5LKcKQbI/EPrijUbkUy0wny9euReW8AWC2GkZrk68rgUPBXLXJeoWCkg+EHr5oAB3OiWrFmD4OMphZWe4v4vogMCENIW7URie58GNSOUk8v8YWU+KP0npa6mnnHzJ9S1FB0bDa0P1M/qfpvNHnFr+ad06yp0+zJuTWG3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXpvWS2w; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so5233548e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763413636; x=1764018436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+3ZnbBnm9x5rG+AzfKnEqBF2B1DtWvuci9iSsNvxto=;
        b=nXpvWS2wegxGuSyADug0MDEIPxD4CnEwuLpPYRNvqqXMnusDrkCfAnNTpY97PNIhj3
         C+y+W+R80j5Y4GT0kE7r5DkStEG5uWvGgeBokHWw39doRWx6PV+p1GJ2Dgctzu6tQf8y
         cu8r7ozG3dowtrVT/wlbcjuFcw4qtN6CeyJkM2cbAPVHJGkrOYXjxwCzst3RuaxSzphc
         6NSHgaBl8j2zBF3fKAX3FqVaik0XFQqtVgr82577VC8/x0KUWVIVHMkSvk17YH6knImX
         7vfDpdxkhMAK3ss3S8CBA95Telxi6Olx62Ft4OiNWCVyOhz4oiYgkyFNWUreuMpJowRB
         RtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413636; x=1764018436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+3ZnbBnm9x5rG+AzfKnEqBF2B1DtWvuci9iSsNvxto=;
        b=Fm92Frdt+qg2PA6qYXQ0fExzeWm6Jwx0buIFJv8KMRmPjQMEaQ9wysFWMIrHLwjwpZ
         QDC29u/8gz45ZEA+f2DJUyAIALhlMiAWJJUtzjymZSs8afhplmRnU7po4au7Q/JJifto
         OkwDxYZm28uy7E8RtQSjk2qZEWsieDbZqrSQGPQnQtqzU7JN+faQjOp1uH0N+o9h7nue
         6DQ6VpDum7od/BxYIbCFTIhAbW9K2TLgP0XdPTJ1t67HAoXxGFmhIbBG9TLHEhuUUIFs
         OCNj9/DLydQ09Cur+1jVDkBCCboZYQG2qoZG4Cu2cWeJWbEslLrOGDiA3gEE+PYpOkda
         ubMA==
X-Forwarded-Encrypted: i=1; AJvYcCXpLSZARNVbRhH2x+qS1WUODNgxdb7/GF/NGgImKc5yr0S3fUYeuw6ro+in7YBWQ/vqWYjwgJOJYSSJ6O+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kas9k11FpC8haPpLipANMkogoUdapeBkOY+kq2Ge71+bm0RF
	Z+3KQVezl5Hd+TFh8PAZ/n1w/IrMq0gK3X6hWTjPF5KrhsK9vyClR8sLidOg/guWSrexMW0wJBn
	wkwxhDdvtxTFRmYY6A/tPsivlcH6qqYlSDzLasUL9
X-Gm-Gg: ASbGnctT+cqpeZdw4mDxK+qrC3nUq+cF4b8U2KCLOJZY1n/tg+97okyu4+kg2t3IOtp
	CaPCXAUlAnxN6AMgWUdGXbjIgG2z6X4Qkb7CCzKMaxKhp2ljBt5PecLAeICuRfEmv4bTlpqDFS9
	SEheuHC2Z5DRcgD0d1uktMoDEWv4j7fUI4GVshqX34v2yOrxFAdD8TKeO/aXYWgDwpvs64fmJUF
	FbqRzyfacCiCisj6VkkyA/LyYJtwuOY+/xEU8hP5Dns9wsVAO8IcYBUl1wNYUjWKavcJcWGKPsS
	LZRNrQ==
X-Google-Smtp-Source: AGHT+IEyRglFL6CLF2ix5p5nwaJTHq0lTJqTXp+UMeRzhbiWib00PWpc4ebiQNIEHbNxWSgpi8VFmGwgM1LVS1XHG0w=
X-Received: by 2002:a05:6512:2216:b0:594:522b:c6a4 with SMTP id
 2adb3069b0e04-595841c0afemr4885332e87.23.1763413635580; Mon, 17 Nov 2025
 13:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <CALzav=edxTsa7uO7XxiUSx+DZiX169T4WL39vYsn3_WcUuVKrg@mail.gmail.com>
 <CALzav=f+6hQ-UYBpwmAyKHPmtvEq-Q=mOL20_rZmAcTyd87+Vg@mail.gmail.com>
In-Reply-To: <CALzav=f+6hQ-UYBpwmAyKHPmtvEq-Q=mOL20_rZmAcTyd87+Vg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 13:06:47 -0800
X-Gm-Features: AWmQ_blb0RWuMLLJQNAkTQ6osFyJ4ZWbxByNX4sxBWFP3gs7sBB_s2cCPqr0fg8
Message-ID: <CALzav=ekHM8a3yYHHUJNgtYVwLYf1hFhEmrXJjHUXRt=xrSy4A@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:08=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On Mon, Nov 17, 2025 at 11:27=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
>
> > Putting it all together, here is what I'd recommend for this Makefile
> > (drop-in replacement for the current Makefile). This will also make it
> > easier for me to share the library code with VFIO selftests, which
> > I'll need to do in the VFIO series.
> >
> > (Sorry in advance for the line wrap. I had to send this through gmail.)
>
> Oops I dropped the build rule for liveupdate.c. Here it is with that incl=
uded:
>
> # SPDX-License-Identifier: GPL-2.0-only
>
> LIBLIVEUPDATE_C +=3D luo_test_utils.c
>
> TEST_GEN_PROGS +=3D liveupdate
> TEST_GEN_PROGS_EXTENDED +=3D luo_kexec_simple
> TEST_GEN_PROGS_EXTENDED +=3D luo_multi_session
>
> TEST_FILES +=3D do_kexec.sh
>
> include ../lib.mk
>
> CFLAGS +=3D $(KHDR_INCLUDES)
> CFLAGS +=3D -Wall -O2 -Wno-unused-function
> CFLAGS +=3D -MD
> CFLAGS +=3D $(EXTRA_CFLAGS)
>
> LIBLIVEUPDATE_O :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBLIVEUPDATE_C))
> TEST_PROGS :=3D $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED)

Correction: I forgot that TEST_PROGS is reserved for test shell
scripts, so this variable needs a different name.

> TEST_PROGS_O :=3D $(patsubst %, %.o, $(TEST_PROGS))
>
> TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O))
> TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(TEST_PROGS_O))
> -include $(TEST_DEP_FILES)
>
> $(LIBLIVEUPDATE_O): $(OUTPUT)/%.o: %.c
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>
> $(TEST_PROGS): %: %.o $(LIBLIVEUPDATE_O)
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $<
> $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
>
> EXTRA_CLEAN +=3D $(LIBLIVEUPDATE_O)
> EXTRA_CLEAN +=3D $(TEST_PROGS_O)
> EXTRA_CLEAN +=3D $(TEST_DEP_FILES)


Return-Path: <linux-fsdevel+bounces-68814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8CC66C99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 42C1329A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7B2FF669;
	Tue, 18 Nov 2025 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FajRRf7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E926ED40
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428135; cv=none; b=bIY8Z6ArwTxX0zRc7IEhb/z1AfRS+10jDs/JSfiB4jlXuLFvmNmXABwa78uTo6WpTXVJnpmlz0TGOommdFX55yf3R8ngxEfdtO6DNPW52e48KoXRiOdLhGUvjBPAYKwNIwRSMmQAF8JFlEEpZhVRvJBnZau1KUxl2e7qfL5nHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428135; c=relaxed/simple;
	bh=+wMjX6/AXbuiV+ac0BF8ERgzt1h6sAXTNPDP4qr0dUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5u8zf7clKGIhPYfeHT5RLAVrpt2tjkSucYFr4gTw9/caCIPyDkdXRbzqRMIfqPofry3jNzc2l++Q+f+tgbW+0RDrcRv+GQKzXPHkI+38HCnaYgQgRPBo1ogl8nFwjzA3H3up0KfT4SXjD7pVlk8sQhjs+tkvEpFtLijvZcQPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FajRRf7o; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so8291561a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 17:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763428132; x=1764032932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHz3ZSch0j3icwKric4qmANXVXIVVUz44Th0hsI02rw=;
        b=FajRRf7o9fmlOB0kb4b8x4Wov+chvRAXeI+UAvrddRI+7BsoFNJI0/lUxuqEKlIWlt
         JD7c5KmYtgYk5DerUey1OO4jhh/IOtz0UmQN1v2QVUBWU+x8iHa8vDFPhfs29ilxi38Q
         2E9qkLHsnNQx7P/n52/jEdhlyRsYT6qehTnVBwowU9j5YTEZfTRHsTGk9nGvRpfbLXDS
         Pg5QtSxtnOJH1Gf3OiHe5pemZ5J7WwKvIUim1PdW0WXMo9uwMQvk3QDUNneZr5+XJJAX
         mkZ1yrOoRs19zRymo/v4glj53WTVqSZFuhCUxMTZV6r8qoYGrSiLRIbYmy368w+icmd5
         LfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763428132; x=1764032932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHz3ZSch0j3icwKric4qmANXVXIVVUz44Th0hsI02rw=;
        b=cXjEgYKEEf1O1KQR6AvSoE4cW6Z81pKtBkpPU0djB5nwO4oXv1x9jduVXPWD8q1d+J
         AkMm9MqRqrbu8Chtku6Xyviqaqcc/ThZfrZvoMYceiXV5cBrxZ8NluoOjLad4kWsp9Po
         GmtkQEuJur3NXCjKc8miFmBbbGTwGPuWqQjQ0Qw2KAjsoGsgWFZSvkCSA2keB+I83Ato
         qEdDpKEIdGaVzBNv4u55mqompq8sWKr5zFmD8caCPzN3qPrXBSwbxKcwpqUQa8QH1JOv
         OuUrjEiqByBY/y19PU6qCR1MRdVjvyK1JPgDiTIkiAFfGTVgY68rd8/JIIeKw2d5efZF
         aNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9Rek4u7BH+IViy5DZRhb/15hwn6gANbNk+RS0VuXRgrZ3omZ7Ogr9bqyeRMvToGbPV3P56o0WX6TYWX6@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcuP+OiujE79pIuG26fiWf2IvJxdtKffJYK/kTylBufOto4sq
	30oK7Vo/v90Wf2FTFDJvpW9gGSYMVenJHgaTD6Fs6lPHmuodbHK1s2G+bYYj/ZFIwQY7PmEiYYb
	RDo2Cxa40ClM4Do3rKLyYv77+SvPo1vqUVUxJr41Low==
X-Gm-Gg: ASbGncuYwbnhSCtZ9qJVOnp0IZalBlZwngwbburjPPDBmTFR40XWQ6qS+xczW4sB9WE
	Ta8nSakWcuxGGrhyhHFumAKNHwzicKLBbvNNCVSZh54kfZuXwIzICHw3fTu9CYFu9vpnHnDozuB
	/My17yjKWEIMGhHqBH85K5XZrRCg8TMpZrf+YN0Fz2xtvfg+WWg2NNvZhqa+EO/emK7XQZx5a/n
	mBzK5k5h7mQeIcAoYm4QB6qNaE6pY6LbeGpJy68CWKhhIPmYp2uhWP4zzbVofUOHlTIhRC+kh/C
	fRw=
X-Google-Smtp-Source: AGHT+IEZfZGWJ8aSWhQVB4jEcLruJ8I9XFSeNCTF/yy15o6Dh+TeGJ/djBXr3AHvYW0X+PFfQd3I51m6KkeXZLCq7a0=
X-Received: by 2002:a05:6402:524a:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-64350e06a53mr13323263a12.12.1763428132223; Mon, 17 Nov 2025
 17:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <aRu4hBPz2g-cealt@google.com>
In-Reply-To: <aRu4hBPz2g-cealt@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 20:08:15 -0500
X-Gm-Features: AWmQ_bk93gbIXM7C6K1DzdPuJ9gaoWasB_RAHgan8OE5p-hPDMrjsz6s60y6azk
Message-ID: <CA+CK2bD2VDTP7dCaebAOVpNmhyviptRbqLegW_FhAbHkMeN-DQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: David Matlack <dmatlack@google.com>
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

On Mon, Nov 17, 2025 at 7:06=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-11-15 06:34 PM, Pasha Tatashin wrote:
>
> > +/* Stage 1: Executed before the kexec reboot. */
> > +static void run_stage_1(int luo_fd)
> > +{
> > +     int session_fd;
> > +
> > +     ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
> > +
> > +     ksft_print_msg("[STAGE 1] Creating state file for next stage (2).=
..\n");
> > +     create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, =
2);
> > +
> > +     ksft_print_msg("[STAGE 1] Creating session '%s' and preserving me=
mfd...\n",
> > +                    TEST_SESSION_NAME);
> > +     session_fd =3D luo_create_session(luo_fd, TEST_SESSION_NAME);
> > +     if (session_fd < 0)
> > +             fail_exit("luo_create_session for '%s'", TEST_SESSION_NAM=
E);
> > +
> > +     if (create_and_preserve_memfd(session_fd, TEST_MEMFD_TOKEN,
> > +                                   TEST_MEMFD_DATA) < 0) {
> > +             fail_exit("create_and_preserve_memfd for token %#x",
> > +                       TEST_MEMFD_TOKEN);
> > +     }
> > +
> > +     ksft_print_msg("[STAGE 1] Executing kexec...\n");
> > +     if (system(KEXEC_SCRIPT) !=3D 0)
> > +             fail_exit("kexec script failed");
> > +     exit(EXIT_FAILURE);
>
> Can we separate the kexec from the test and allow the user/automation to
> trigger it however is appropriate for their system? The current
> do_kexec.sh script does not do any sort of graceful shutdown, and I bet
> everyone will have different ways of initiating kexec on their systems.

Yes, this is a good idea, I am going to do what you  suggested:
1. provide stage as argument.
2. allow user to do kexec command

Thank you,
Pasha


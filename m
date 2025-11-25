Return-Path: <linux-fsdevel+bounces-69803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E102C85E21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A34C9351326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D623817F;
	Tue, 25 Nov 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HaQ0p0lS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84C22D4C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087026; cv=none; b=TZPTnBErVT6TDLJxIJur3Pp1EsG0KQlZc62QGZaGtEnetXJ8MqsOjLDu8oq1Tuku1RTM7WcpYk9Gt3mWYc2zWmfBr3tNBZpzhLKZ5nULBJ0aEavUjgMm2v+i7rl0W7goIJQlB3qmtbFxbfLD//kp+rcuuA2PA6NyL//Hd8v8upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087026; c=relaxed/simple;
	bh=+LXF37LiU3fuJ7QnC+x6GzPR+lrzHoN3xK78QQ9aMzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv35s/Ey/RklBR1DrP46TuJhMYypSwNt8FHeh2BQH0G5qV7cYjaIZP+EoEaeZ6fjerz06kJP/LXeAzRtEuHeJez5vtvi8goEr9N72ANIBT8a5xarWj+tfBiDtPu5yfvEWOT2ZtlCxNUPqClC5mZ8D2nsiec/YBt8gbp1us68TuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HaQ0p0lS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2927872a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764087023; x=1764691823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZjV6DtXhsZ5AkR3PkxyMa000cMnBKP6+/LjP904D4A=;
        b=HaQ0p0lSW56X6zR1KUOhnv4PeQx2lwGN/tYu/GH9xyPBeutYOe0dGzX/iwDS3ZKspo
         nH2BNZ6SfPIBB5P2P80cjgoTX/Yg39FREOdjc8SlyQw6NGIT3ZgA4F1ssbAprmZEPzZC
         xQ60FRRHM60yM0xSIc0id6TPuKuEbEd/0MSz6/XwODXwp91i7SFcUhXvo6Qm9C1GOint
         3Pwr+FbO5tTX76eyJ1qghWjd/8orHyEWW0fPg/twfLylGI6bSmzrgOItCz+++zSRIGNc
         lHTZIGAhIy2Tcut8YyNEACZPZRJJrSk9Xo0nqzU/Vf0Zkxqx5V8iL2Xv+hQJ7V2R0M3T
         MGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087023; x=1764691823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZjV6DtXhsZ5AkR3PkxyMa000cMnBKP6+/LjP904D4A=;
        b=Zo5RNNilrPOFyh0VDLrp3Ezub2UDM/cIwSdy8aAcCSCU6VEKKDCm0RhRqXOPkCTxga
         pptFEeD6o/4bBlm2S4Jjgq2TBGSX+U+5c6d0MLdkTY3WOXof1K6GiCUAbsctRbBaRJdL
         bgEe2ygYC8ElT16ZkvmPHay4HCm2eG7j+boGAmlVvd8F6l/9L9iR+BZHY4zRZxGOUfVC
         J0cM1Ukh3sHjS23NwkAmfANC/IJPf7v+dIsOwGgrCfpW8YufuZLQ41jzF97ZgcjAPyhf
         crC6jLMEtgfu2eycViqcU3WuLjO1hr8K6KI2Y+ZCI4c3PpEdm7Qc01iMHuloLy00Jcnk
         Srow==
X-Forwarded-Encrypted: i=1; AJvYcCVvHHg8/R6icdjq10i3qxIR1utWabXhi9NCYJhhxh5kkXFB4zXZfUSqq3t1uNmq5PuxQ1JtEJaW6ZZlWH5x@vger.kernel.org
X-Gm-Message-State: AOJu0YwRED7Ie2eVI+taGIeXgZ4/QDOX/J/oBlx3I6CwsGEjr2P+VVYv
	tLeW5qsx3LAe5q4Xr0q1U/QtjBtB8v0+amVOoyNVVyiY7wCSYxJfHWWUg6JNRP9YIASl6CpUTAX
	edKkfQuIOVZwz66a1kdl+y4W0Krd/cQ5mrSzMCziugw==
X-Gm-Gg: ASbGncuiOWcyldySKfqmrE3KxjoKr+6rGoJiinvAYeAPizyM6b55aX86pBCkTRBoys8
	+ItZfNJg681XD5Ld3QDlRYqqAVZHF3xlBR9RobQ+BxwKF9Ca+icLrT2ibvs7UNqS851T+df+nBA
	5Qsc7ktEi6Bqt1vt7Jppxv/JqlwY1VD9Uh1atHF0mNkI4woWhg9OjOKhc9Qyx3How31W2rggM41
	zZiSRXliXYxrt0SY6EolT1blLnPfZGLP94QNDMHriKKalqwnqED96FfysA3Vi2+XTOj
X-Google-Smtp-Source: AGHT+IEE8pFdl7WzD0Q0QybPHjOSG7Z/5A80NYawnvCXoY05NDZWq/KDeZ5UjLXRkONdwsanA3Sa60SF0QSqqiKVFUw=
X-Received: by 2002:a05:6402:1d1c:b0:640:aae6:adc5 with SMTP id
 4fb4d7f45d1cf-6454ddd44e5mr11579420a12.4.1764087023025; Tue, 25 Nov 2025
 08:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <mafs0ikezzf30.fsf@kernel.org>
In-Reply-To: <mafs0ikezzf30.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 11:09:45 -0500
X-Gm-Features: AWmQ_bnmED1MVHVi80Cm4w9yINLIQ5SIv6ctTKaf0R1iFr-NNvQCFN256DGI_UI
Message-ID: <CA+CK2bAbKLocBO8zrhUaevXtsF3BMxyaVznOwSTYxFt6MjYpxg@mail.gmail.com>
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, dmatlack@google.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:21=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Sat, Nov 22 2025, Pasha Tatashin wrote:
>
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > This patch implements the lifecycle integration with KHO:
> >
> > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> >    track the update count.
> >
> > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> >    allocates a new FDT for the next kernel, populates it with the basic
> >    header (compatible string and incremented update number), and
> >    registers it with KHO (`kho_add_subtree`).
> >
> > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invok=
e
> >    `kho_finalize()`. This ensures that all memory segments marked for
> >    preservation are properly serialized before the kexec jump.
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
>
> Nit: This patch does not add the dependency. That is done by patch 1. I
> guess that change needs to be moved here or the comment removed?
>
> Other than this,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Done, thank you for review!

>
> [...]
>
> --
> Regards,
> Pratyush Yadav


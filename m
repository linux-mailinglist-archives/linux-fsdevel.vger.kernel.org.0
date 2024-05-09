Return-Path: <linux-fsdevel+bounces-19155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C48C0B55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC87B22E80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96D149C56;
	Thu,  9 May 2024 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEm/VoPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980B1494D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235262; cv=none; b=JP8rTVVCIoqe02XvKripmxuACeWDAc+VpJ1wguZHnpzC3Smpy9ttW0N54K2h//dzHu4W7WhepHO2llNOt8IpI2rwC9j1NpOUd58SQC+vJSOop/XslysTTv334jI63eHsh/T1eSX/uDQIe2ozV5PBjdRJdpYvLd0PnAlFzXgfwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235262; c=relaxed/simple;
	bh=EL59YAvQ+NejbE+MgsQ0pGcYE6qA6HsEuHDusaEk0N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrjWmM55ddye6/pa6xuI23c0IxDulKYbv+IcpBXJNIJqsOd05p8H19fyUbnj34XlfFXinf4ZKTyIe+6RLL/zJGzXlZEvCug4i+nZ6/oxJ2SDYMj1P3cTRHFIpoi37MDRXijSgavAf7aDVxeUvWK8qdtQh50U5jKhhfk/egcMwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEm/VoPd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4845a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715235259; x=1715840059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72bWBwjQodIuSi8MsUtQvKNvKwdUWjXGREUei480Xwo=;
        b=WEm/VoPdoWkj0T759QWiuYvMX4pHXbQGtGV6B8BdS6/Cq0VFDkresAaaMIYb++Xv07
         NGG+jf4a1dEnvAy0YaC/s7lcBHZYg4XfdFyn0UE/NSSxuV4NI+ONOzRkSN7wuCtF7G6m
         GTOO87BGuQVGfzWL5T65/lgJj6fjNzyMISuP7RyGnMi7ZT8v5eJ20/bJPOff/6tMEzYf
         htFF4m10x/m7ACoxg+H+qSKb1axBk/xf7pNTnIFlBhJxau06TJtioZB85NLY3yGUoNGf
         qsBS4tNQxQMxJEtkUampvrB3zly877wqooUCzxdQkmiqESGQ2AKpeP3mEO/CMSG07Le0
         wmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235259; x=1715840059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72bWBwjQodIuSi8MsUtQvKNvKwdUWjXGREUei480Xwo=;
        b=DAG2SVU1z/uxAQwCwoA48RSKDvy/yXv8jAkVjqlOTdJ5e9rH1EGJoUpdpfteWj6iK2
         xkqLhTFOE9+CZw1gf4mzX7aaaOjjPqCF/FYLkP7BfBkhR9N0VGagIBErqH/YZFRwTs5Y
         JJr7OmEZE0M5P2dLU5Esf1WW1QmIHR1HAMPSFmqMCfx7hks8uHUZnBaNXYia6bPGc416
         141QJvdDcncPPIAQHrGPAxF5zrSHGWhDwFJTgjEVmnQwhduZkXiF9/8+iaWeLc3VaktH
         LFvm+LG6FlzX3RF91uwbsupDvNBD0PI40maaV+nwCE2uNP0E3nekgmyI6fVHEI6Q9Muh
         IvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaioRr9bzOXKK3jPstuEXPyam5qiVyvS3r97AhyE7fqu+gH8pYuoR6UZEt4It3AZslJng/x3oayVH1Q1PDItRrkMUbC/YU6KRlV3I6kw==
X-Gm-Message-State: AOJu0YzxU+XxsYI46aFpXq61l+IqtSK9yc/MqJDLnGrmBrFHNAjryOzY
	PGEw39Au3K/L4CvjT2llFj85J/Oe6j5CYAMj8+v8ZNOJdT9N5sxzu4Xf1Rva+ETfAPZ/tyVxi+0
	wCpQDcv3yt5/R9kAfYLBOIaucAsgbQpSX5mEG
X-Google-Smtp-Source: AGHT+IHsPAG0LEeM4cJXnAxgH06RrdZlxemOxK5bdPXtb66jyshH3jVsPNC7i5pX8kAB1x6smMgaq3eKTmHMEonCtFw=
X-Received: by 2002:a05:6402:5206:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-5733b9d3b3emr79412a12.5.1715235258767; Wed, 08 May 2024
 23:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com> <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
In-Reply-To: <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 8 May 2024 23:13:51 -0700
Message-ID: <CAG4es9XE2D94BNboRSf607NbJVW7OW4xkVq4jZ8pDZ_AZsb3nQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Seth Forshee <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-input@vger.kernel.org, iommu@lists.linux.dev, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:10=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/7/24 15:38, Edward Liaw wrote:
> > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > asprintf into kselftest_harness.h, which is a GNU extension and needs
> > _GNU_SOURCE to either be defined prior to including headers or with the
> > -D_GNU_SOURCE flag passed to the compiler.
> >
> > v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-ed=
liaw@google.com/
> > v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> > location.  Remove #define _GNU_SOURCE from source code to resolve
> > redefinition warnings.
> >
> > Edward Liaw (5):
> >    selftests: Compile kselftest headers with -D_GNU_SOURCE
> >    selftests/sgx: Include KHDR_INCLUDES in Makefile
>
> I appled patches 1/5 and 2.5 - The rest need to be split up.
>
> >    selftests: Include KHDR_INCLUDES in Makefile
> >    selftests: Drop define _GNU_SOURCE
> >    selftests: Drop duplicate -D_GNU_SOURCE
> >
>
> Please split these patches pwe test directory. Otherwise it will
> cause merge conflicts which can be hard to resolve.

Hi Shuah,
Sean asked that I rebase the patches on linux-next, and I will need to
remove additional _GNU_SOURCE defines.  Should I send an unsplit v3 to
be reviewed, then split it afterwards?  I'm concerned that it will be
difficult to review with ~70 patches once split.


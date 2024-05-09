Return-Path: <linux-fsdevel+bounces-19139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954998C0870
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 02:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95C28289B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5FD518;
	Thu,  9 May 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1rhmnQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F4C2ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214579; cv=none; b=q8qqAYzvHcfd05KamYLqQCSPxOsvudn6EVbe8uHM7G2JyWc9ezIKFIyZZrXz3pezXXL6Vsy/IpiEUxnq/l2lMEsEc5PPKaicLw2qtPiOwE/9TGL0p7/350VYmvXQo96v5D2ThdaPPVQbNRzt1WebGAJww+lO8l5ghKJKvpUS+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214579; c=relaxed/simple;
	bh=YFEOyn8HhTR+KZ3cmP9SJDzMJP8/0gmTLnbxrYrAyiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uy/S2WwPX4I9rSm5Hmu1yW5/WotiSn/hzLDZw1Q/SN5PIpk6yXhuUMgxN/luSVMyfzL5MSKBCFxZBVlBUd/bPDZg0YJoMLEOxEPz/5m3bzPS2LCrm9el54WOCoNF+EZlG0tS9Kd1JLSZJNgfrgX/qNZWWw02PwLu0hHqmxJBl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1rhmnQ5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso3605a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715214575; x=1715819375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ze6we/9zl1hwpr5TTVXS+9EQi+iUJaNZFz5eMfIu64=;
        b=M1rhmnQ5tPiYNgd3tYVN99l88xQJCR8QJ093SQ2ZdqpvlnparBv0W5R3gw0uiZoJIW
         OpS/QL8eJjBFSCFRg+WtS4Mr4e8sgr3XF6Fj9sM8TRcogvaHaHeSvC8uTmpzeIK7nx/P
         U7MG5p/lfaoyftQszloEFVlHKD53T+lSbG8Rm2k1ovzoPmXkANijqZHgFbeGAIK7Icii
         K6YOYusn0GcPwD+KKY5aBL+oPTwXT5B1TJ5xzq3oXzHkMgTwfKWDpnhK1YYst/teky9P
         eEY/jKzRKxHTRMapxx/C+MzpnWsiVAkjn6zSY9i9NeLPbdp5Hr1PIkGY86y0jHRXFr+5
         Pg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214575; x=1715819375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ze6we/9zl1hwpr5TTVXS+9EQi+iUJaNZFz5eMfIu64=;
        b=FcUhYK2MJw+yrHQZpQLGpOy4QCd8ceZU5w31tgSptNSaFMyGMT6ZhrqLIqXF9K+twH
         yhYAUL3HVEYU8LFnFH/fug2txBY61D7vsegFcVKL/KB5X5zqOatGpNajrYhTcDxJ9cei
         jP5XXXVK5zT/i/PjbSLItkr0faHMo6owHvbbAM5ipx7aBc1Exk8DQiUJmrYVfosuWfpa
         a4pbw84SrI+MAYppjwCiJFBZIusTE5++urIRwj1WW1KMAo74QYlb2nBI5sbmA9aY/4Sm
         cw7enL+Fjdz3o0lkvfy84LsU68SNAUblZ6NN0RtmetfiQxnzaz4rUkhGNOBMcOTVWLCq
         i5dg==
X-Forwarded-Encrypted: i=1; AJvYcCXpKDm3xy5XAZJtpIXseonDpUFRGJRPDJsk42iLF7a6DRGX83nd37mq8h5rAQiEWtGlgCwV0+KxuTGO0TkkNQJBTcTfLF403CNnhehqBw==
X-Gm-Message-State: AOJu0YwZi2hJWF4z6jK2mqtFuLnMCPoDOu0LtUEe6S9fIOrJJYd8asSB
	BVkLsrLCE3FDaf4vOAAsPYLHvYYpqxkme99s3g1RrS18xJW970b/TSr99p5oZfR9VYdDQ1Ysr/e
	c1U33zupfmCfmA0cWjLdhAAZOWNQ39CY6qbKd
X-Google-Smtp-Source: AGHT+IEpRBxjqO7YXZEC9B8FKVtXSFN03eOTZMizwoUq2jNrJCvIwReN+ats511GKy8ts5rRqhmgn49fpwdVOB7Y6R8=
X-Received: by 2002:a05:6402:742:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5733434b416mr85834a12.4.1715214574664; Wed, 08 May 2024
 17:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com> <20240507214254.2787305-4-edliaw@google.com>
 <ec8ab737-a841-4cd5-8ec1-e0a777744262@nvidia.com>
In-Reply-To: <ec8ab737-a841-4cd5-8ec1-e0a777744262@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 8 May 2024 17:29:07 -0700
Message-ID: <CAG4es9XPLhHhH-Hfm3_m5zLLtiB1zme8pAazMhErMpHqJcAMmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
To: John Hubbard <jhubbard@nvidia.com>
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

On Wed, May 8, 2024 at 2:41=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/7/24 2:38 PM, Edward Liaw wrote:
> > Add KHDR_INCLUDES to CFLAGS to pull in the kselftest harness
> > dependencies (-D_GNU_SOURCE).
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/alsa/Makefile                  | 2 +-
> >   tools/testing/selftests/arm64/signal/Makefile          | 2 +-
> >   tools/testing/selftests/exec/Makefile                  | 2 +-
> >   tools/testing/selftests/filesystems/overlayfs/Makefile | 2 +-
> >   tools/testing/selftests/hid/Makefile                   | 2 +-
> >   tools/testing/selftests/nci/Makefile                   | 2 +-
> >   tools/testing/selftests/prctl/Makefile                 | 2 ++
> >   tools/testing/selftests/proc/Makefile                  | 2 +-
> >   tools/testing/selftests/riscv/mm/Makefile              | 2 +-
> >   tools/testing/selftests/rtc/Makefile                   | 2 +-
> >   tools/testing/selftests/tmpfs/Makefile                 | 2 +-
> >   11 files changed, 12 insertions(+), 10 deletions(-)
>
> Hi Edward,
>
> Seeing as how these all include lib.mk, and all use CFLAGS, is there
> any reason not to simply fix this in lib.mk instead? Like this:
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
.mk
> index 7fa4a96e26ed..df72610e0d2b 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -170,6 +170,8 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>   CFLAGS +=3D $(USERCFLAGS)
>   LDFLAGS +=3D $(USERLDFLAGS)
>
> +CFLAGS +=3D $(KHDR_INCLUDES)
> +
>   # When make O=3D with kselftest target from main level
>   # the following aren't defined.
>   #
>

Or how about just adding -D_GNU_SOURCE to CFLAGS then?



>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/self=
tests/alsa/Makefile
> > index 5af9ba8a4645..9a0ef194522c 100644
> > --- a/tools/testing/selftests/alsa/Makefile
> > +++ b/tools/testing/selftests/alsa/Makefile
> > @@ -6,7 +6,7 @@ LDLIBS +=3D $(shell pkg-config --libs alsa)
> >   ifeq ($(LDLIBS),)
> >   LDLIBS +=3D -lasound
> >   endif
> > -CFLAGS +=3D -L$(OUTPUT) -Wl,-rpath=3D./
> > +CFLAGS +=3D $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=3D./
> >
> >   LDLIBS+=3D-lpthread
> >
> > diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/test=
ing/selftests/arm64/signal/Makefile
> > index 8f5febaf1a9a..ae682ade615d 100644
> > --- a/tools/testing/selftests/arm64/signal/Makefile
> > +++ b/tools/testing/selftests/arm64/signal/Makefile
> > @@ -2,7 +2,7 @@
> >   # Copyright (C) 2019 ARM Limited
> >
> >   # Additional include paths needed by kselftest.h and local headers
> > -CFLAGS +=3D -D_GNU_SOURCE -std=3Dgnu99 -I.
> > +CFLAGS +=3D $(KHDR_INCLUDES) -std=3Dgnu99 -I.
> >
> >   SRCS :=3D $(filter-out testcases/testcases.c,$(wildcard testcases/*.c=
))
> >   PROGS :=3D $(patsubst %.c,%,$(SRCS))
> > diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/self=
tests/exec/Makefile
> > index fb4472ddffd8..15e78ec7c55e 100644
> > --- a/tools/testing/selftests/exec/Makefile
> > +++ b/tools/testing/selftests/exec/Makefile
> > @@ -1,7 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   CFLAGS =3D -Wall
> >   CFLAGS +=3D -Wno-nonnull
> > -CFLAGS +=3D -D_GNU_SOURCE
> > +CFLAGS +=3D $(KHDR_INCLUDES)
> >
> >   TEST_PROGS :=3D binfmt_script.py
> >   TEST_GEN_PROGS :=3D execveat load_address_4096 load_address_2097152 l=
oad_address_16777216 non-regular
> > diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/t=
ools/testing/selftests/filesystems/overlayfs/Makefile
> > index 56b2b48a765b..6c29c963c7a8 100644
> > --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> > +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> > @@ -2,6 +2,6 @@
> >
> >   TEST_GEN_PROGS :=3D dev_in_maps
> >
> > -CFLAGS :=3D -Wall -Werror
> > +CFLAGS :=3D -Wall -Werror $(KHDR_INCLUDES)
> >
> >   include ../../lib.mk
> > diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selft=
ests/hid/Makefile
> > index 2b5ea18bde38..0661b34488ef 100644
> > --- a/tools/testing/selftests/hid/Makefile
> > +++ b/tools/testing/selftests/hid/Makefile
> > @@ -21,7 +21,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
> >
> >   HOSTPKG_CONFIG :=3D pkg-config
> >
> > -CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
> > +CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror $(KHDR_INCLUDES) -I$(OUTPUT=
)
> >   CFLAGS +=3D -I$(OUTPUT)/tools/include
> >
> >   LDLIBS +=3D -lelf -lz -lrt -lpthread
> > diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selft=
ests/nci/Makefile
> > index 47669a1d6a59..bbc5b8ec3b17 100644
> > --- a/tools/testing/selftests/nci/Makefile
> > +++ b/tools/testing/selftests/nci/Makefile
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > -CFLAGS +=3D -Wl,-no-as-needed -Wall
> > +CFLAGS +=3D -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> >   LDFLAGS +=3D -lpthread
> >
> >   TEST_GEN_PROGS :=3D nci_dev
> > diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/sel=
ftests/prctl/Makefile
> > index 01dc90fbb509..1a0aefec9d6f 100644
> > --- a/tools/testing/selftests/prctl/Makefile
> > +++ b/tools/testing/selftests/prctl/Makefile
> > @@ -6,6 +6,8 @@ ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ =
-e s/x86_64/x86/)
> >   ifeq ($(ARCH),x86)
> >   TEST_PROGS :=3D disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-st=
ress-test \
> >               disable-tsc-test set-anon-vma-name-test set-process-name
> > +
> > +CFLAGS +=3D $(KHDR_INCLUDES)
> >   all: $(TEST_PROGS)
> >
> >   include ../lib.mk
> > diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/self=
tests/proc/Makefile
> > index cd95369254c0..9596014c10a0 100644
> > --- a/tools/testing/selftests/proc/Makefile
> > +++ b/tools/testing/selftests/proc/Makefile
> > @@ -1,6 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   CFLAGS +=3D -Wall -O2 -Wno-unused-function
> > -CFLAGS +=3D -D_GNU_SOURCE
> > +CFLAGS +=3D $(KHDR_INCLUDES)
> >   LDFLAGS +=3D -pthread
> >
> >   TEST_GEN_PROGS :=3D
> > diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/=
selftests/riscv/mm/Makefile
> > index c333263f2b27..715a21241113 100644
> > --- a/tools/testing/selftests/riscv/mm/Makefile
> > +++ b/tools/testing/selftests/riscv/mm/Makefile
> > @@ -3,7 +3,7 @@
> >   # Originally tools/testing/arm64/abi/Makefile
> >
> >   # Additional include paths needed by kselftest.h and local headers
> > -CFLAGS +=3D -D_GNU_SOURCE -std=3Dgnu99 -I.
> > +CFLAGS +=3D $(KHDR_INCLUDES) -std=3Dgnu99 -I.
> >
> >   TEST_GEN_FILES :=3D mmap_default mmap_bottomup
> >
> > diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selft=
ests/rtc/Makefile
> > index 55198ecc04db..654f9d58da3c 100644
> > --- a/tools/testing/selftests/rtc/Makefile
> > +++ b/tools/testing/selftests/rtc/Makefile
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > -CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall
> > +CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> >   LDLIBS +=3D -lrt -lpthread -lm
> >
> >   TEST_GEN_PROGS =3D rtctest
> > diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/sel=
ftests/tmpfs/Makefile
> > index aa11ccc92e5b..bcdc1bb6d2e6 100644
> > --- a/tools/testing/selftests/tmpfs/Makefile
> > +++ b/tools/testing/selftests/tmpfs/Makefile
> > @@ -1,6 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   CFLAGS +=3D -Wall -O2
> > -CFLAGS +=3D -D_GNU_SOURCE
> > +CFLAGS +=3D $(KHDR_INCLUDES)
> >
> >   TEST_GEN_PROGS :=3D
> >   TEST_GEN_PROGS +=3D bug-link-o-tmpfile
>
>


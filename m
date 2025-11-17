Return-Path: <linux-fsdevel+bounces-68776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BDC65FAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0263534BCB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC7330332;
	Mon, 17 Nov 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQil5TVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408D29D294
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407701; cv=none; b=mWfswN5SX1meHfwYa+zArL19fsFH6JSHM5T1QmQhE/+7PAbmOMPlvRGSgeocjihynRvmNrmaAgyqnZmvFrcvKUarY9liy0/qYhyOTB9inSKZ77tKG6UBGrqazJQAsMlpYN09ySKSioo9s3iSxRehUiQ6E8xb1X1GqAY6LPGJAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407701; c=relaxed/simple;
	bh=jMsl51RRcfdYOeK+ixIl6fySL+N2GY9YtwKE3nHyvoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UX513Tiix4NWwQTa3y5MbBl56VdnppV3vvUe3Zdy/sXlmJl1uq5KS3B8rAEdpsoM8/I3+0YXOk3qT7IvrANasy9/tIgPy6yR35TcXt1+uHABIbJt6LE9MST8NnZsSvmZvrrDNmtk2UjzKIpO+83c7mgJgJ5nRn1N7lKGq3sK8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQil5TVd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-378e8d10494so61134231fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763407698; x=1764012498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BRv+8HFratcORC0sQfd604lhFEiEUlZ0QaYy4EdL4s=;
        b=PQil5TVdSXdRODQeDw7d1JNLeudd69HwwQ+LcXOF7nDM9V5uUsIuhhyi1s7fpTSmq3
         l2mjJNlzhayCf2oOEwZBT/5FTOe+FrYoLGWy0OM+2u1vwnmAKv9B3tURdOSbvIYgwqRd
         qUHP9oCs0achz4wpdn2yQOLY1qw2MBLMjFmANH7Z6A0DKYA5XHKOfAbaIuq8FtNY7Dcs
         xYWidf/NNvAX/8EFMorCY7TcHiFUCsCl3lntji+QSGjpv5237oggdRzsDadyh5pGhcdE
         zQe/a7pUq8/gFzS37eKMGZWBxXVfDflXBEdEY0crV1ZomrQf1bSwUpUNAkFF0RMBxJfN
         S70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763407698; x=1764012498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4BRv+8HFratcORC0sQfd604lhFEiEUlZ0QaYy4EdL4s=;
        b=nkU0/AsBPPOYmzF9gNXHHWil7Xr7I/wfJuvN07E9O8fJAW+iOcbp+R5EpR1eiEUACa
         Zlb/lK2cl4c9g4fzS66DRs9ZyFydmTfYKLZFyWZ7tog3Xol+RxiIn+7ysFSLYoVVSPZ0
         ih61bkzmS85IehHg0C90pBQT7m2mN1OJr5LfyTwbkmGjpYJ+83mz83QirjxfWPzcGp0+
         dRzf3GNP1lpH4YoVWG16722NOCFPBpPQfVVImYWQgGmR4ysIi8lqF+7qaLMxeXP0VMdm
         baaY0TeCMfqVJ06ADL+acE844x2w3afPj2bCD5VwO9+uLEVydWw6/6k/hE3zEJ61rlwJ
         1IRw==
X-Forwarded-Encrypted: i=1; AJvYcCU4D8xr8ZpfWw9h9YpifqoANCjjWiKO+ft706bMhqRNNcy1SKegIi31gy43VZ6rzeLkBQ2PLHQdWBCaotlN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oheIjeSI5hdZFlZRGpWEgEizKYBUts/cHEDKQO838Pa+dk6V
	Q2QPUCAGE7wIWqU1pWbjg8GAvGAxqdtQOiI7CiW+tu3ELiPVqTLbXcTmNclVpYjqLKuVhR1fHaZ
	NcL9LJIy6LwGHO+4WqSmfLx0ThCAtxZA6iEQRyt0+
X-Gm-Gg: ASbGncsIg9DtqK2ORsbXzmpe59x3FOitUiiNXakCS5A/IaKu5rPtDCBlc0LkR//e/XZ
	uSBYcD6ef/sJWd0lappxVuq67AvM+DZIRkyjW+u7WsbFWAJn7ddzf7o9xBbf6Bc08t2qbJIK//y
	w8NLDk5SgNHusk+hoK7A9SgUYWMuVGiLx1wy0qShUgoixiGK0S+8cpW2iLeSpMB07y2QLyN4n42
	iHddYyRAJhIFgxeIDNodiUYoyWdSmNyA/80+11TLDqfbaWjZnFAJ4Xe4rWuNVzVbpAuhyYliMzT
	n9h/Tw==
X-Google-Smtp-Source: AGHT+IGG0IuV9djGbvzmPZdLLDSHaSz0ZC8Mlezk0LH8epioFYDWl+Qb1KTas1rmPphaGx6WZjM3247aMHYjmr5MYwI=
X-Received: by 2002:a05:6512:114f:b0:595:7dc5:165e with SMTP id
 2adb3069b0e04-595841a77femr4400958e87.25.1763407697311; Mon, 17 Nov 2025
 11:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com> <20251115233409.768044-19-pasha.tatashin@soleen.com>
In-Reply-To: <20251115233409.768044-19-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 11:27:44 -0800
X-Gm-Features: AWmQ_blZR7KFsAxkxa-ZIGOEZap3-3haAeROnQQby7Ige8teO6F_2irScEIZ73g
Message-ID: <CALzav=edxTsa7uO7XxiUSx+DZiX169T4WL39vYsn3_WcUuVKrg@mail.gmail.com>
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

On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/=
selftests/liveupdate/Makefile
> index 2a573c36016e..1563ac84006a 100644
> --- a/tools/testing/selftests/liveupdate/Makefile
> +++ b/tools/testing/selftests/liveupdate/Makefile
> @@ -1,7 +1,39 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +KHDR_INCLUDES ?=3D -I../../../../usr/include

You shouldn't need to set this variable and $(OUTPUT). Both should be
provided by lib.mk. Maybe the include is too far down?

>  CFLAGS +=3D -Wall -O2 -Wno-unused-function
>  CFLAGS +=3D $(KHDR_INCLUDES)
> +LDFLAGS +=3D -static

Is static build really required or just for your setup? If it's
setup-specific, I would recommend letting the user pass in -static via
EXTRA_CFLAGS. That what we do in the KVM and VFIO selftests.

CFLAGS +=3D $(EXTRA_CFLAGS)

Then the user can pass EXTRA_CFLAGS=3D-static on the command line.

> +OUTPUT ?=3D .
> +
> +# --- Test Configuration (Edit this section when adding new tests) ---
> +LUO_SHARED_SRCS :=3D luo_test_utils.c
> +LUO_SHARED_HDRS +=3D luo_test_utils.h

I would suggest using the -MD flag and Make's -include directive to
automatically handle headers. That way you don't need to add every
header to Makefile for Make to detect changes. See the end of my email
for how to do this.

> +
> +LUO_MANUAL_TESTS +=3D luo_kexec_simple
> +
> +TEST_FILES +=3D do_kexec.sh
>
>  TEST_GEN_PROGS +=3D liveupdate
>
> +# --- Automatic Rule Generation (Do not edit below) ---
> +
> +TEST_GEN_PROGS_EXTENDED +=3D $(LUO_MANUAL_TESTS)
> +
> +# Define the full list of sources for each manual test.
> +$(foreach test,$(LUO_MANUAL_TESTS), \
> +       $(eval $(test)_SOURCES :=3D $(test).c $(LUO_SHARED_SRCS)))

This does not build with Google's gbuild wrapper around make. I get
these errors (after fixing the semi-colon issue below):

clang: error: no such file or directory: 'luo_kexec_simple.c'
clang: error: no such file or directory: 'luo_test_utils.c'
clang: error: no such file or directory: 'luo_test_utils.h'

> +
> +# This loop automatically generates an explicit build rule for each manu=
al test.
> +# It includes dependencies on the shared headers and makes the output
> +# executable.
> +# Note the use of '$$' to escape automatic variables for the 'eval' comm=
and.
> +$(foreach test,$(LUO_MANUAL_TESTS), \
> +       $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> +               $(call msg,LINK,,$$@) ; \
> +               $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> +               $(Q)chmod +x $$@ \

These semi-colons swollow any errors. I would recommend against using
a foreach and eval. Make supports pattern-based targets so there's
really no need for loops. See below.

> +       ) \
> +)
> +
>  include ../lib.mk

Putting it all together, here is what I'd recommend for this Makefile
(drop-in replacement for the current Makefile). This will also make it
easier for me to share the library code with VFIO selftests, which
I'll need to do in the VFIO series.

(Sorry in advance for the line wrap. I had to send this through gmail.)

# SPDX-License-Identifier: GPL-2.0-only

LIBLIVEUPDATE_C +=3D luo_test_utils.c

TEST_GEN_PROGS_EXTENDED +=3D luo_kexec_simple
TEST_GEN_PROGS_EXTENDED +=3D luo_multi_session

TEST_FILES +=3D do_kexec.sh

include ../lib.mk

CFLAGS +=3D $(KHDR_INCLUDES)
CFLAGS +=3D -Wall -O2 -Wno-unused-function
CFLAGS +=3D -MD
CFLAGS +=3D $(EXTRA_CFLAGS)

LIBLIVEUPDATE_O :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBLIVEUPDATE_C))
TEST_GEN_PROGS_EXTENDED_O +=3D $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED=
))

TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O))
TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(TEST_GEN_PROGS_EXTENDED_O))
-include $(TEST_DEP_FILES)

$(LIBLIVEUPDATE_O): $(OUTPUT)/%.o: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
        $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $<
$(LIBLIVEUPDATE_O) $(LDLIBS) -o $@

EXTRA_CLEAN +=3D $(LIBLIVEUPDATE_O) $(TEST_GEN_PROGS_EXTENDED_O) $(TEST_DEP=
_FILES)


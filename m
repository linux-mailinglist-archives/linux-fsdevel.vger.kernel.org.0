Return-Path: <linux-fsdevel+bounces-63418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FBBB858D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E7C19E0348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAE279DAF;
	Fri,  3 Oct 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLHoC1RP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB25247DEA
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531888; cv=none; b=NgweTaBSufOGJrru7F7/9xkBjtQjVQOTojTLsV2okF6+egF+/743EuRSHz1Gxgb6R+ULSTWXkr/7RipHafMcDjh470mzkv6awRv1wGV8vAWlv6HA5gHtwM7I+HAgTl6GVmcMtYo8IwUvMNmEFDXY6FcuYRn70cEx3YfVldvDwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531888; c=relaxed/simple;
	bh=/6Xaaj5PK20veSY+mLJPosJkzbGDglUy0snLHTEUBiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcfiVYb+F0YFtjELzYdEzciOTmMV4+Suwuq5flEWNxl4JGtRfvBilDjSOUm7kBO+raaZZqTXrV7CR3lL1SZcsFU7YVT0hqb2kKNveSkrbmrKt0zZihURB9IYtBjbl5qw4k8HqDV9s8OMWXlGGh46mUcaj0Yg8yg6pqKCPAzQKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLHoC1RP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2731ff54949so28305ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759531886; x=1760136686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7u2P+PSagmsp23Fv3FgF+5IpL86SkzAWEDMP2n+Zzg8=;
        b=YLHoC1RPKEL42YfyKqga57d1+iOjHsravnnqVYS5Vy5kgRFXrLggAhnqqXaFPrDpkJ
         zZaAas0VjMWDmdjHHr9Lspl4vAKiHBhbZ4Q2xRRXtZ7AhrReHK/i1bkGg/0ljE1OFS3i
         8KcWxAR72izP/WKDeT2OVSfrV2EIRgbUOJE9p4SonCKDe6Jb3UInO7pqDdG+BM0ggsQU
         WiYOIiVcTqrIivALQ/BExnlCGY3pEL3Klh8NUWuLZXfxsZxjWGLt4q2QyC/CFd1loWu9
         z0eqBE6lonczeqU4mLjRaDGlbX/wxzT9Hy9o31Sk1PEW7K2sG5BtBVahkzzzoLaKDpQY
         KrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759531886; x=1760136686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u2P+PSagmsp23Fv3FgF+5IpL86SkzAWEDMP2n+Zzg8=;
        b=NwJtomnEE5xxiJtrk7Q9sG5FbRGcem6z/3zE0JU5+NEmyfQ5Opu9LOzfHb0t2OAH+/
         SeuUG+UDm93zlPO9uX8VsQ9NVHZ8p/ZNhsMBN9+PrkzessgeuIrkauJPhtbTX+JlnbyR
         o9Z2Rw3Ro6hrcJDhmHZ03uGAUaO7I+w7Mm4I82poPfPSh+pg2lGVrt08/hBViKTa4ZeZ
         h3+7EIT7ssLBBFHxpu6W2saTU/D+498ZwriEB6UBaE62MgcvVQKqS37OHt7jiDXTMwxO
         9cOCb+JaxVym4dUTX65htGh/xuzlBaZmyuIUJr5zMvsu1c/YA/kWZkaHF/fBA6Q48acR
         lS7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbsgbGnkoTeWB5wav2RjHgdnk0Of4xJQ0AdprlAQ0gaGRsmy0iZnoR5pOGbM+sJnJnlaxsQYpB8CBaEsSu@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8kkJLqzN/O7I64XZ6INHHAy8ggCBxDi42WttuoGbJukyq/0p
	Lphwy1CZWJDgHT2eJuSm/28daTzABsvhQV9z1f7kVJ3mgvqhqcFpzGDx1cFzSbtbmw==
X-Gm-Gg: ASbGncsfr8WwxO9NRcYos8KZ8qdjD5P2+cLaATk2M2DEFcFmKaaQTHtItTL6K7z8Nll
	5AXMb5kZzImBNW4/AFTwqK0Eol/6frA48X9afgrdYAlYj4xafOkbiH6O9MhV7T9la+aguegx9Oc
	nNIDzv7tHycqcmXhBoC7TNws8SJSTWHJv7sd2G20SsHqDoJM42dXNcaK/w0EGdbjKW29oMDUANE
	m6UetAO/vnzGMgrb/FqT/nbsvdTXyzbK8+gXBiQrYOwJGLiauvmN+yJEWt8HF1BKtHrZmXQTZNp
	ICGLX/mqz7G/k+f5AiNVZcYJdNZthzkFKQiBVf+spsuPoAoSa+Q3g0zD+4LLyqF3HqO8igG8pbe
	2m/w5IydCNMYNUC/DaKfxHh4wlQdLULMaMuMnTJRjsuBIhXKg/hzL+Buep0e95CW2/0zL59oSEb
	3QnpVKWMLsw6nTiEO0sdeAlINj
X-Google-Smtp-Source: AGHT+IHA8zSvfzM9A0JES1HZ6Wla5qDr5R3dr/EmP4gFU7QjRiucWkm3AaRWAh7ay0GuYtgIuX5jSA==
X-Received: by 2002:a17:903:22c5:b0:275:8110:7a4d with SMTP id d9443c01a7336-28ea7dcec8amr1599745ad.0.1759531885870;
        Fri, 03 Oct 2025 15:51:25 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0204edf0sm5962934b3a.44.2025.10.03.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:51:25 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:51:20 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session
 lifecycle test
Message-ID: <20251003225120.GA2035091.vipinsh@google.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-27-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929010321.3462457-27-pasha.tatashin@soleen.com>

On 2025-09-29 01:03:17, Pasha Tatashin wrote:
> diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
> index af6e773cf98f..de7ca45d3892 100644
> --- a/tools/testing/selftests/liveupdate/.gitignore
> +++ b/tools/testing/selftests/liveupdate/.gitignore
> @@ -1 +1,2 @@
>  /liveupdate
> +/luo_multi_kexec

In next patches new tests are not added to gitignore.

> diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
> index 2a573c36016e..1cbc816ed5c5 100644
> --- a/tools/testing/selftests/liveupdate/Makefile
> +++ b/tools/testing/selftests/liveupdate/Makefile
> @@ -1,7 +1,38 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +KHDR_INCLUDES ?= -I../../../usr/include

If make is run from the tools/testing/selftests/liveupdate directory, this
will not work because it needs one more "..".

If this is built using selftest Makefile from root directory

  make -C tools/testing/selftests TARGETS=liveupdate

there will not be build errors because tools/testing/selftests/Makefile
defines KHDR_INCLUDES, so above definition will never happen.

>  CFLAGS += -Wall -O2 -Wno-unused-function
>  CFLAGS += $(KHDR_INCLUDES)
> +LDFLAGS += -static

Why static? Can't we let user pass extra flags if they prefer static

> +
> +# --- Test Configuration (Edit this section when adding new tests) ---
> +LUO_SHARED_SRCS := luo_test_utils.c
> +LUO_SHARED_HDRS += luo_test_utils.h
> +
> +LUO_MANUAL_TESTS += luo_multi_kexec
> +
> +TEST_FILES += do_kexec.sh
>  
>  TEST_GEN_PROGS += liveupdate
>  
> +# --- Automatic Rule Generation (Do not edit below) ---
> +
> +TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
> +
> +# Define the full list of sources for each manual test.
> +$(foreach test,$(LUO_MANUAL_TESTS), \
> +	$(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
> +
> +# This loop automatically generates an explicit build rule for each manual test.
> +# It includes dependencies on the shared headers and makes the output
> +# executable.
> +# Note the use of '$$' to escape automatic variables for the 'eval' command.
> +$(foreach test,$(LUO_MANUAL_TESTS), \
> +	$(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> +		$(call msg,LINK,,$$@) ; \
> +		$(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> +		$(Q)chmod +x $$@ \
> +	) \
> +)
> +
>  include ../lib.mk

make is not building LUO_MANUAL_TESTS, it is only building liveupdate.
How to build them?

I ended up making bunch of changes in the Makefile to fix these issues.
Following is the diff (it is based on last patch of the series). It
allows in-tree build, out-of-tree build, and build other tests as well.

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 25a6dec790bb..fbcacbd1b798 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-KHDR_INCLUDES ?= -I../../../usr/include
-CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += $(KHDR_INCLUDES)
-LDFLAGS += -static
-
 # --- Test Configuration (Edit this section when adding new tests) ---
 LUO_SHARED_SRCS := luo_test_utils.c
 LUO_SHARED_HDRS += luo_test_utils.h
@@ -25,6 +20,12 @@ TEST_GEN_PROGS := $(LUO_MAIN_TESTS)
 
 liveupdate_SOURCES := liveupdate.c $(LUO_SHARED_SRCS)
 
+include ../lib.mk
+
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += $(KHDR_INCLUDES)
+LDFLAGS += -static
+
 $(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
        $(call msg,LINK,,$@)
        $(Q)$(LINK.c) $^ $(LDLIBS) -o $@
@@ -33,16 +34,16 @@ $(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
 $(foreach test,$(LUO_MANUAL_TESTS), \
        $(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
 
+define BUILD_RULE_TEMPLATE
+$(OUTPUT)/$(1): $($(1)_SOURCES) $(LUO_SHARED_HDRS)
+       $(call msg,LINK,,$$@)
+       $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@
+       $(Q)chmod +x $$@
+endef
 # This loop automatically generates an explicit build rule for each manual test.
 # It includes dependencies on the shared headers and makes the output
 # executable.
 # Note the use of '$$' to escape automatic variables for the 'eval' command.
 $(foreach test,$(LUO_MANUAL_TESTS), \
-       $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
-               $(call msg,LINK,,$$@) ; \
-               $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
-               $(Q)chmod +x $$@ \
-       ) \
+       $(eval $(call BUILD_RULE_TEMPLATE,$(test))) \
 )
-
-include ../lib.mk


Return-Path: <linux-fsdevel+bounces-22286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF6915A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2DB287AB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2D1B3F35;
	Mon, 24 Jun 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpRmI7zp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AE1B14ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271784; cv=none; b=kVlX2UYw/QmuCHDbDoGrsErH4wrTKHZGLCoBFzkeQlJRvq7UqqAwPZWXSI5jXjc9suwv5a2GiLYgqnHMCD+UKnShkswFkgpU1TggyldWI1azpvbaIhm1lhPACswzp4CAkpQ3idqgkqn0ZY6wNr6mZ5pQ3FaNrkX4HmXTAHKSpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271784; c=relaxed/simple;
	bh=Vn2wAzsGFTLvBvD15AbUZj/MnMw/n9DKUySpFM3EEW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iSaBNucTMb3JMjnBk6PMuDqrxp2ET+yd86zqTWvKFUe2UwMKGooUZ3lhNvJ73lWxliIanjtz2j4tShKI/CArhIg84JPSew1X+/beWNMrnGEiUmRha6orsnqYrZ7bmtgtugG/rchnXASYN3GqNqTKV6VezXGfAmt4wdl5qpkyyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpRmI7zp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70679e6722aso1461982b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271781; x=1719876581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=ZpRmI7zpfk4CODpNByZZ+NS8/x8bXWS2416efYVuGf7Bo9fUY27KzEH0ECEG9UShmJ
         3ldX92/Dy5dbLaUbu4bBonueA39OU6w98bFvzlLPptylShgVgSzktpzS3AL13kQBPn6/
         2fFgZEd7Nq9NkuBj2JCwAzhN8087n/nIbYzLGyBwjWPy0CyGjcP++/vyhSIZ+7LBLjvk
         E9CI5gOTAT6WIxx3AhSFXwLFz2BCxfsL0Nh+i5L6Pj6mApiu/cAA3VSz2yMYyv6L/Ys2
         pK2hCdzXbof1FrBy96lC2943PubZolSrqBkllCPI5+Op7wu0AxZEU6CxM9vdYMkQQn/V
         s/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271781; x=1719876581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=lOuZpHO/srRsjkF5lY9b3pDAtBVPnd8Yv2kAgqCORnq7DpbNNwrnSrcfSw4ufY/IqR
         EY7x4IBr4Gj8wlnjg3/c30Mo+VNlWwraqk2V477totHlmzVSmumgF82iY+UCx5o84/V6
         5DYqQwc1EkyjJEdi0yKoXQyNE0APgquMPk6vHYc0k3OII1E057vni7vu+NNInf2zn/CL
         E+Va0cWybmILoXFjusnbL2ut+/gcCw+HnWEvz3+o00foAQxyFrhMQD3g7KJPU1Fa8MuW
         12vSLxfAvqyMYwAh6oRLpYiN3WxXskKTD3sp9pXDJ6RYtV6WkNhMign04WWnM2czmKAm
         RicA==
X-Forwarded-Encrypted: i=1; AJvYcCW8CQtXYge5YCVbQCcB4dBbKoDWINhmBk7jdaVa9Ok+lOejCZMeUgyemcmi2Bh3ZxKE3fvGyMD9GTh64ECXZQ7LzeegjCO5W2OimILOVw==
X-Gm-Message-State: AOJu0YzCaekM2vQOSc5/tiKYJ5+TN7ixSQgtRCE5nD8aWRIgu2EuEVv3
	/EY/G6MvHRBM+29EmbRu1meFfW0bwJtzuHBbSiesG4HV1dgcLqgnGRt/GJp9r1JXQzD7opGHIev
	NTQ==
X-Google-Smtp-Source: AGHT+IHpQrIc85Iwvne/JtUL74k7CtaEnEbXK9UND6RiBewc+A4BXz2SYDvXCOVunV74/hhFEZKy/c23brg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4309:b0:705:d750:83dd with SMTP id
 d2e1a72fcca58-70669e5e132mr244774b3a.0.1719271780764; Mon, 24 Jun 2024
 16:29:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:17 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-9-edliaw@google.com>
Subject: [PATCH v6 08/13] selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..4ee37abf70ff 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
-	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
+	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-- 
2.45.2.741.gdbec12cfda-goog



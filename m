Return-Path: <linux-fsdevel+bounces-22290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66229915AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850561C21E62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024F1BBBE6;
	Mon, 24 Jun 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1VZz5A0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D21BB6A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271804; cv=none; b=kAthurLx+15AdbP7RhUftaxvSrMMIgYpqg84tcylAg2ln2cAzdUoAyPEpYkl+3KaKaB0xTilYHJHSNmm4Uj8FK55AlVNLfS0c/2KiaI7dB4RzRdNsHj3TOOTjyVWvMMIKF/jtNELqDYoyCzXMiV6oI3fWE+d27jhcG577wehxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271804; c=relaxed/simple;
	bh=HKl8DYXudRkj2nEiXmQj8vs+8XvlCafs7fYfuFr5khk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQWnfYerDNa7ZevdnoKGKviTUFlw/V042kwSzI803Me9FeHbngFqlZFPlR8NLqhcJ+5u99SBMxCeRIGyCjv+SjhzRDEmLBxnduhG5kyK+Btz2l2/YnaA4o7iA8bQg6KsPWvX7rMpHaOzRC2fLG29Qrlrfbe/BDI1ADXqGj1eLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1VZz5A0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso5433005a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271802; x=1719876602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=L1VZz5A0VEDktw2LPT6BNr4lgic3OPfHYjLXM5bpsEW7dm25Z1NKkUVGeebsGTBXp7
         BdKHriPY1tcFX4quwQXKtE2blCShX1aDAYwT0a4to/iUKq9deDcNQZz4oS7/3nleTyJE
         Yzyej+qxGtjArH2WhuIp+ESU1JaHd99UGpBoz4K/Qhk5/Bk3yelU9MKadaV9D4u3+e7l
         WtrZk0ZZ6q0gagvlA80Zjrxy0n7xS0TpkZg7OqxIIjxvDsR1HeIL+q0K6pM6QqPPBQkE
         hq4mzk7DyJSScAoTzDnLaxUriGJmfcDABgmTr0TRRHW721YpkRAocm7i2CYr/RiS0Z11
         YOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271802; x=1719876602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=JZGNeo8tAoy5/FvU8V54sx+dZjkScj02ueSAcCMgLY6I0pVnn96uvyqElWwOipzYp8
         HK2kIQk0Ur8CLmYDZFm4wYfgxYfgRYml/WUjn5/F9VURSNAMIFesUzVnINgUmZT3JZYP
         iHA7HE3s7YHJkaAotb34CMltNqaSutF0tq857AYwMvQLf0j2dbpa6UcDvpvhK7BKLKx5
         rjIODEhhwDV9qb+8QmX2/+M/IR5qZg+WrDEdmIOfF/VJoPCRpGx7dT3k7bhduhkF26kt
         G9lcWUSFS4rYM1YnW8RfDw/FzwdBvjooH4Hux6T5wnWi+klq2LvgtoKmSYJgJqdwJOkG
         vECA==
X-Forwarded-Encrypted: i=1; AJvYcCXV49QYDxTgvQRqeaQKP2ZkBiiR9UUmxEVGHAfgleCDyffx+sNwhOTGLdmIs6u6HP3Puu22NSxbhackxe9fFpWAUmxKrXA0tVWXoyIBMA==
X-Gm-Message-State: AOJu0Yw+7VMbykHA0crXegD7glMsTRaDOCNkr86KMl+UC9zMx9+0/vKY
	WiNpcL10kTccUXMo3MsiUJ6Wbcnqowc2S2M0iAxLa86gGweARoPTxaTh/k92Auu8BhqHeT6t9HU
	PEg==
X-Google-Smtp-Source: AGHT+IEfb9KUh1OpOD8DwIk/54klv7dSo/nLX1YPQZQ44FjQ7tb2FCGqwu/ay8BBa1IDIHl2DafOvSF/pwc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:654f:0:b0:6e9:6c12:3523 with SMTP id
 41be03b00d2f7-71acda64918mr19622a12.10.1719271802360; Mon, 24 Jun 2024
 16:30:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:21 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-13-edliaw@google.com>
Subject: [PATCH v6 12/13] selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.2.741.gdbec12cfda-goog



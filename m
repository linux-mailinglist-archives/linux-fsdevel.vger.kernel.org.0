Return-Path: <linux-fsdevel+bounces-22452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F991744B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 00:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD311F24315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D817F506;
	Tue, 25 Jun 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+xHHygr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B217D374
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354903; cv=none; b=GCgBU0OHcvKHBfhhkgFwfR8NAWHZIejbEXrXQaKaP3DzMaqqikto8vfwfv+3dH188p0GB4TzzcEUgoqw6KMHnVkXJ3lgKsHbw/6J6MzzW4Wu965C/m31i+ivBOer0pHuqs0beyO86D6AtSiriulp0C7MhIy3THvO2PpLFVLL5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354903; c=relaxed/simple;
	bh=91Z7ox9LiBjORVtCWaAzB8GD58RrfZz+zWI0Wxs5FyY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m1NzXwzvJVxWDRMPwV7eA+kYrhMQ9VPnP+dXNb2R/AW7CfZjr1PVsywchvEZgogCmKCAYZlCKlyfRz7IdPESY14RiS8VZOYXO9CodZaqDmlEPbWDSashuUc1c2ojqGTSRtBqqmA14/LfGuNDhCm/1zDF4FzxPfE/XivpPrTi+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+xHHygr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7068613e4d2so4497349b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719354900; x=1719959700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KACPm6o1sF6MfYdPebomXscoE9qCB1ha0g1j4OaH67g=;
        b=c+xHHygrtnx3ar0uqm0QnBauxwQRcQHGDB4+KqRa+qVZ6AP2sBSOHc2t4rAP+4xtc/
         jNZmyp0ZC7AD0QDzcMj5AeCn44eDwFQ+UJLGbapw0AMRut/OCLT/mzf7pIDvDdNb2Ufe
         OkknPhAsq+vcMblteP5T+SPFpGFKmz5gBuaDxzR2LSEV1dHxuBCRhvOBFoRqsofR4uat
         u7CqKcu3egVHcX5uGPl9xuv/4J8aMuF3xW+e6aWnqZ9/+x3BMOgIAkT8y54BdYAunfVY
         zpLSpfcBsZs+AVN45RRvjXvCqus4saGtRXR74luxea9WwS0pX8nd1ka+QQQJX/8QvRTp
         mAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719354900; x=1719959700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KACPm6o1sF6MfYdPebomXscoE9qCB1ha0g1j4OaH67g=;
        b=QG+eJlH/f9v+Fx99bdtwlH8b+A25Dh/kXm1InZPt2KJF8jTChaMTEMv2rdb2LvatFD
         D2dNt6RZ1bWsdNcgaA2kZ9GznqIwqsW1V42CsfH1LHsi2aSXGe3szShzQC6cIojISNrN
         vsFWf9P+SNhXO0XyLlg0j5XbDWrMiTIw8+XHJD6A5nxucoVBFFGIGTyE6wgsrBF6CA5L
         cLeIjXtYhE727IbooK9BaDilEELi+80VkksCfNe/N4/1ouaF2m/7jIjEe5fEro2/lL+w
         NUN5fDHQnntnPrjSgGZt74OlP5Tg92T7q+VqIJBIfwHmNkhhadBYajZyI8H0tBi34OTl
         gBIg==
X-Forwarded-Encrypted: i=1; AJvYcCUP97K9NGAMh/1fWGs13ugQVxCkksrOtKkoqLNmOCaARrgkXTKmb2Vtb9bWNqW+fQpBMVk5amK//rGmVSpN2mUE5qOm1yI+CxsJx4UE0g==
X-Gm-Message-State: AOJu0YzmNjsIrbI4Wyc3Cf75XCuFTlw0rEHTrdZ87ePnLrRViETnTEr8
	k3j60netln9FPCW500ikBDHcnGcguBeb8btYoAbuqkXPe+WSDzcZiNx3jWFS/N7FYN7ZmxLtI1P
	NUw==
X-Google-Smtp-Source: AGHT+IFpOX5CcrzFldMsRz/JodHWPPYjtr1mfNvHUywvuU1/bJCVZhZ6TnspYz+fdShAF0CdfuxKj2ZiUg4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3698:b0:706:3f17:ca6 with SMTP id
 d2e1a72fcca58-706746c2606mr330723b3a.3.1719354899705; Tue, 25 Jun 2024
 15:34:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:34:44 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240625223454.1586259-1-edliaw@google.com>
Subject: [PATCH v7 0/1] Centralize _GNU_SOURCE definition into lib.mk
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

Centralizes the definition of _GNU_SOURCE into lib.mk and addresses all
resulting macro redefinition warnings.

The initial attempt at this patch was abandoned because it affected
lines in many source files and caused a large amount of churn. However,
from earlier discussions, centralizing _GNU_SOURCE is still desireable.
This attempt limits the changes to 1 source file and 14 Makefiles.

This is condensed into a single commit to avoid redefinition warnings
from partial merges.

v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
v2: https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@google.com/
 - Add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
   location.
 - Remove #define _GNU_SOURCE from source code to resolve redefinition
   warnings.
v3: https://lore.kernel.org/linux-kselftest/20240509200022.253089-1-edliaw@google.com/
 - Rebase onto linux-next 20240508.
 - Split patches by directory.
 - Add -D_GNU_SOURCE directly to CFLAGS in lib.mk.
 - Delete additional _GNU_SOURCE definitions from source code in
   linux-next.
 - Delete additional -D_GNU_SOURCE flags from Makefiles.
v4: https://lore.kernel.org/linux-kselftest/20240510000842.410729-1-edliaw@google.com/
 - Rebase onto linux-next 20240509.
 - Remove Fixes tag from patches that drop _GNU_SOURCE definition.
 - Restore space between comment and includes for selftests/damon.
v5: https://lore.kernel.org/linux-kselftest/20240522005913.3540131-1-edliaw@google.com/
 - Rebase onto linux-next 20240521
 - Drop initial patches that modify KHDR_INCLUDES.
 - Incorporate Mark Brown's patch to replace static_assert with warning.
 - Don't drop #define _GNU_SOURCE from nolibc and wireguard.
 - Change Makefiles for x86 and vDSO to append to CFLAGS.
v6: https://lore.kernel.org/linux-kselftest/20240624232718.1154427-1-edliaw@google.com/
 - Rewrite patch to use -D_GNU_SOURCE= form in lib.mk.
 - Reduce the amount of churn significantly by allowing definition to
   coexist with source code macro defines.
v7:
 - Squash patch into a single commit.

Edward Liaw (1):
  selftests: Centralize -D_GNU_SOURCE= to CFLAGS in lib.mk

 tools/testing/selftests/exec/Makefile             | 1 -
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 tools/testing/selftests/intel_pstate/Makefile     | 2 +-
 tools/testing/selftests/iommu/Makefile            | 2 --
 tools/testing/selftests/kvm/Makefile              | 2 +-
 tools/testing/selftests/lib.mk                    | 3 +++
 tools/testing/selftests/mm/thuge-gen.c            | 2 +-
 tools/testing/selftests/net/Makefile              | 2 +-
 tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
 tools/testing/selftests/proc/Makefile             | 1 -
 tools/testing/selftests/resctrl/Makefile          | 2 +-
 tools/testing/selftests/ring-buffer/Makefile      | 1 -
 tools/testing/selftests/riscv/mm/Makefile         | 2 +-
 tools/testing/selftests/sgx/Makefile              | 2 +-
 tools/testing/selftests/tmpfs/Makefile            | 1 -
 15 files changed, 12 insertions(+), 15 deletions(-)

--
2.45.2.803.g4e1b14247a-goog



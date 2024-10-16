Return-Path: <linux-fsdevel+bounces-32148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E89A1553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4221C23583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B201D5142;
	Wed, 16 Oct 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VrVGzd6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C41D47A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115860; cv=none; b=MD1+ItntxCISmfRDtOCR0Vh7FlC0qRKrPZGYOMxiS4q1afLjEsrLNSyu3buip5jxaQdT37BO/u5G1Y2cghRrDzMVrN2hta2gEKVfxflG4eKv6FxiP7rvaqXku/YbomMK/27MN/I3ONHKoKww09w5OgrN54n0Q3pydrZ8Jw6i5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115860; c=relaxed/simple;
	bh=9kjhy2vHa1Gp13YAES/5VqrKFHfW2hdUEmv2eN4R1hk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oM5qjR0qAeUuwoawmIXl9rPRe8eK+EotIEdtn6t7Eo9lw4FMQnlV9JQpi1OKEXUoMhRDP5LDOM+zEqVGqzUSs2Hwn/dog75O/SX9HcXGsZ+ZvFxV3izjNZbo/B0rQDz19liu7sLhXWzaX7pk34lYaPawrOme82jC++X3HceRuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VrVGzd6P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so2896175ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729115858; x=1729720658; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbTHbF9Ivw4XRDMx9HdyTZiIkXcNQVZ5i0X+Hm69Xao=;
        b=VrVGzd6PMhIOx6izxQg0OoUk0RFnOfXaO6dI2fQUpBrrnGnE91LFQcJWxPwSEfMb6o
         gFbUfdKQwFj/XuvCF6f+h973/TTX00Cnvu8hcZfTHTFE6BFTMq0Tze6GsXPlE4i9mp5S
         aPq1d3FIg+AjQKWfB9UNYrc3YQ6qcg2Mn9/OlpQtHsnqAe2XHqm4huu7a1u+2SJOAGAa
         nI5Dk+iR70juWHOKkAp6rCQK2SHldUQ/avwUgvZ5ZKjAzV+y0U89zoYuEOoWtUNO+Ufo
         ekBDk4F6HEER+flbdHOU+D7HMY7Kz+7Ezhkd2dz1H2K9McJ4R3FSTOVTc/mM1kshIV2H
         7dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115858; x=1729720658;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbTHbF9Ivw4XRDMx9HdyTZiIkXcNQVZ5i0X+Hm69Xao=;
        b=udfznLEepY4+zVseQ3/s8nbvGNyMB3cxhtEgKsJYNArEvBnSRe/qljbFWnRm7QkeCp
         wFNTmGIHYC1umymPQbe/TVqkbIWkkVAxkhV2WdNsgr8B1+U2+O+nTaeXCn6vk0jolej/
         zMxrthH22PUyujOy/rkQacf53ZQJyfGe5L4QeITe1G3fMLpkUSiNzK1u5BFLFqTQOX/y
         XKA1dw55/meDnAwnNqHWavjNKcVctDmmYIqt2KD3096tMdcrZNEBgmD3Y8aJikbBOgcZ
         /mapmxgFYrS2blFPa62+GRcyXDozzE7JXLScvJ9Mwh/nmRUIy5k/MGqSIUxADiFHNJzV
         49iw==
X-Forwarded-Encrypted: i=1; AJvYcCWPuigBymEZhQt3Yo0TsUJK1Wxv1FG4eqsT0CRU9kkGJh2Qh5t8qqKk9u8alTYMf4Z4OsEN1JjY61eO1CN6@vger.kernel.org
X-Gm-Message-State: AOJu0YwPw7DUD08OzofP6eydmnebBkF2CcXNfmsRClAeEhT2GhKmr3GG
	Cqq70/AGIGklpRU//E04YHJXDN+yHngG/+y51CJFkgvmgqaK9KHTxlddg4dERAY=
X-Google-Smtp-Source: AGHT+IGX6A+4da53eE5JVmAt66yi5VB34Fb3sCGuK9L6pAJhKzMIQkFG7OhLQxWfzEh6vHhReV6qYg==
X-Received: by 2002:a17:902:e747:b0:20c:bca5:12a8 with SMTP id d9443c01a7336-20cbca515a5mr181896915ad.60.1729115857576;
        Wed, 16 Oct 2024 14:57:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87ccasm32973295ad.62.2024.10.16.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:57:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH RFC/RFT v2 0/2] Converge common flows for cpu assisted
 shadow stack
Date: Wed, 16 Oct 2024 14:57:32 -0700
Message-Id: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMw2EGcC/3WNQQrCMBBFr1JmbTSJ2oArQegBijsp0qZTM4iJZ
 EpQSu5u6N7l4/HfX4AxEjKcqgUiJmIKvoDeVGBd7x8oaCwMWuqDkkoKdjw/7zb4hLHYHqfBDjg
 dR6OgjN4RJ/qswRu0zWXXNlfoinDEc4jf9SipVf9rJiWkqPdqQNvXpkZzjpQCk7dbG17Q5Zx/W
 7YJALgAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

x86, arm64 and risc-v support cpu assisted shadow stack. x86 was first
one and most of the shadow stack related code is in x86 arch directory.
arm64 guarded control stack (GCS) patches from Mark Brown are in -next.

This led to obvious discussion many how to merge certain common flows in
generic code. Recent one being [1]. Goes without saying having generic
code helps with bug management as well (not having to fix same bug for 3
different arches).

High level common flow between x86, riscv and arm64:

- Enabling is via prctl.
  Enabling and book keeping per task_struct in thread data strutures
  differ on each architecture. This version of patchset doesn't
  try to merge those flows.

- Managing virtual memory for shadow stack handled similarly.
  From kernel's perspective shadow stack writeable memory which can be
  written by only certain selected store operations (depending on arch)
  This patch converges this notion between different architecture to
  allocate, map and free shadow stack.

- Virtual memory management of shadow stack on clone/fork is similar.
  Treatment of copy-on-write (COW) or using parent's stack (CLONE_VFORK)
  or allocating new shadow stack (CLONE_VM) are similar in all arch.
  Thus logic to setup shadow stack should be similar on clone/fork

Mark brown introduced `ARCH_HAS_SHADOW_STACK` as part of arm64 gcs series
[2] and this patch set depends on it. This patchset uses same config to
move as much as possible common code in generic kernel. Additionaly this
patchset introduces wrapper abstractions where arch specific handling is
required.

Generic code and arch specific code for shadow stack are independent
modules and can call into each other. This is by design because each
architecture's enabling mechanisms are different but at the same time
from kernel's perspective it's a special memory which is writeable from
certain selected store operations.

I've not tested this. Only compiled for x86 with shadow stack enable. Thus
this is a RFC and possible looking for some help to test as well on x86.

[1] - https://lore.kernel.org/all/20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com/T/#m98d14237663150778a3f8df59a76a3fe6318624a
[2] - https://lore.kernel.org/linux-arm-kernel/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/T/#m1ff65a49873b0e770e71de7af178f581c72be7ad

To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Mark Brown <broonie@kernel.org>

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
Changes in v2:
- Doesn't carry patch which introduces `ARCH_HAS_SHADOW_STACK`. Most likely
  it'll be merged as part of arm64 gcs patch series.
- moves shstk_setup back into x86 portion. Primary reason is that entire arch
  specific prctl specific handling can't be made generic easily due to arch
  differences.
- Due to prctl handling code remaining arch specific, removed generic wrappers
  to set thread status and shstk enabling
- Removed x86 specific comment
- Added `SHADOW_STACK_SET_MARKER`
- Link to v1: https://lore.kernel.org/r/20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com

---
Deepak Gupta (2):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      kernel: converge common shadow stack flow agnostic to arch

 arch/x86/include/asm/shstk.h           |   7 +
 arch/x86/include/uapi/asm/mman.h       |   3 -
 arch/x86/kernel/shstk.c                | 223 +++++---------------------------
 include/linux/usershstk.h              |  22 ++++
 include/uapi/asm-generic/mman-common.h |   5 +
 kernel/Makefile                        |   2 +
 kernel/usershstk.c                     | 230 +++++++++++++++++++++++++++++++++
 mm/gup.c                               |   2 +-
 mm/mmap.c                              |   2 +-
 mm/vma.h                               |  10 +-
 10 files changed, 305 insertions(+), 201 deletions(-)
---
base-commit: 4e0105ad0161b4262b51f034a757c4899c647487
change-id: 20241010-shstk_converge-aefbcbef5d71
--
- debug



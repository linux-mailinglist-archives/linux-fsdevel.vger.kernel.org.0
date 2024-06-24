Return-Path: <linux-fsdevel+bounces-22278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F21915A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAAB20953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567801A2C3E;
	Mon, 24 Jun 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj2YUkz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747211A2C06
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271738; cv=none; b=mrdNIwpzdFwknqrwbAi48CIS1WoIFvsWWtrX5vNluGbj0YUqrqXtrmNnZCUJHKvafPEAbpfUEXMQ2xzyA6GxQLGNf6rQ+d6GtR4OIkVDO2//zqqF3qNhyyO3xsiYBwZRg/SZNhai8Wrcy1410CFdebox90o3K+qa6lmqMw5tYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271738; c=relaxed/simple;
	bh=PoyedOSrLslMpcZQkdr7wxw6LDAVWLOCZchvs+PQ4E0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QFnsk7wz65IFLjKapB9DWJIsK548vdFTOrs4mU+mc0iX7DrYdlZchfUvLGi5zJB0M1fU9texBMuIaRQdIEA+sWIqZ+JzvMTBQtIhQUUGU6n8/uDp3RL0djzX+KI/pNEzwlOARYksLbo3vq0Winj839DMHP0AZmLfGeudIRmgr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lj2YUkz+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b58759c2so9681333276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271735; x=1719876535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEnvDY+YQtOlDLldfWY9bO5cHBXotclBQZRJTAhLrGQ=;
        b=lj2YUkz+6BbU3CtVtmDBgEn/AyEwck95YPAoY7NjZrq/xYTfkTkmUSoGhGaS39L6HQ
         6xnPXupoE6sxrB7vMxI9E6p+gXHRhTrv47fHIKzit3szMOUo4yOkdxN5DMsV/DRtF+87
         6dFNnCm/PF7O0/7vpf2NXoh/gBFsJVu38onMci+8YzlrSUIEX/QlOP8K/nLFldNVOEO3
         Z6CIT/oLvxPWvPnGvoUVtLr7tdvsJn72XlqRkRxfuH/L/emchZ38ofpfk7cn5z0Ohmuy
         TAZ64LV9oDbfL7XwyfODiEhplgU0JGnSj54K/vuIvRQk3JdW6pK5AM9OuA0AOzk7VFU9
         V9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271735; x=1719876535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEnvDY+YQtOlDLldfWY9bO5cHBXotclBQZRJTAhLrGQ=;
        b=IjZWWnTv56Az7uHIcFtqNzUjtj500LOy5/qCYrg4XyfRUxmQfRHNVJnlXMDAu3rgrU
         nWGQVexZVxD8ABLVVVo0EG/cFdcCNiyQNCojb+mGJtxezKsieA4Y9VSZpQYqPy3n6KBm
         4uau77eq31QVMvU6QJT1x4aU7usVz/Ui3PPfcv38zqkK+8E12xJIXJwF3a2muaTXvnON
         ptE89a7dhDqXPW66crVkhQgUP6Ak65GO+nBNS+RWx4q6u/K6AZX9T/yEowkfWVPzh7M+
         KcgNbqs/qoMLomOiIH+7wHZZmv4cCIBnoyZ/A2ffRLemwRaf1Sxh8LR2xyd6NkDdLVFB
         JXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKCmOGe14kWrafbM4nEBGtDcBMJpT/AaZo31mqz5NS23boPtfLvhAA7IU4WRjVq81i8Ooias1ZYnnWHzyOUPSsqH4Fy9/6qsil7oxtg==
X-Gm-Message-State: AOJu0YwhIZtY+v9RXmOdM8Hn/TvbCX+KDXZ/FghsLL7RoHOGKcd1IuKy
	QS/HTPZ/KihJnu7N0p8vJzlrMmd1H/yGM0+j0vZNOl/Glqd/WZrwOiwADUgLaHfeLSISsoaZXom
	/1Q==
X-Google-Smtp-Source: AGHT+IGo0nBr4OMWeDQdXO7gLmA8943vaa7AUjGpvpzDg1f7Z8BrI79oFtF9sCT7oXO1KDCB6pUDmCcxQng=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1081:b0:dff:4788:ea88 with SMTP id
 3f1490d57ef6-e0303d692f7mr20462276.0.1719271735356; Mon, 24 Jun 2024 16:28:55
 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:09 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-1-edliaw@google.com>
Subject: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
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

These patches will need to be merged in one shot to avoid redefinition
warnings.

The initial attempt at this patch was abandoned because it affected
lines in many source files and caused a large amount of churn. However,
from earlier discussions, centralizing _GNU_SOURCE is still desireable.
This attempt limits the changes to 1 source file and 12 Makefiles.

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
v6:
 - Rewrite patch to use -D_GNU_SOURCE= form in lib.mk.
 - Reduce the amount of churn significantly by allowing definition to
   coexist with source code macro defines.


Edward Liaw (13):
  selftests/mm: Define _GNU_SOURCE to an empty string
  selftests: Add -D_GNU_SOURCE= to CFLAGS in lib.mk
  selftests/net: Append to lib.mk CFLAGS in Makefile
  selftests/exec: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/futex: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/intel_pstate: Drop redundant -D_GNU_SOURCE CFLAGS in
    Makefile
  selftests/iommu: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/proc: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/resctrl: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/ring-buffer: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS

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
 14 files changed, 12 insertions(+), 14 deletions(-)

--
2.45.2.741.gdbec12cfda-goog



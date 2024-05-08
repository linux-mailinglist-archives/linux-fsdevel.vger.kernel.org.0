Return-Path: <linux-fsdevel+bounces-19117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D68C0328
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4353328201E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B312C81D;
	Wed,  8 May 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwMJg9F9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082C12B156
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189517; cv=none; b=Nd8SDlBmZwSBqv5G9X9AY+i26RNMyC1ybP4g222VqTzpDDM1USNCnGygZK8R/sYtAciww11GH1ds3bpq/+nSBnxtBG/L8KWeU/nD944wL0E2Otvj81MC0jAWncNswsh3MFiuiasO2rSDf0WZNOwW5f/T013CzfUtCfYX62javOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189517; c=relaxed/simple;
	bh=eUy8l4dx1nlgASZnAXri0kDxbx6zhnXlB+I6YzLFjTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9B5sTdtVrq186CO72nMf8wGHFdOIxrSB4xIOytS2QFMgNpGqEngRJ6zSMztp3Mk7tEgv4lgc3D6KB+5a1g+ub0WCh26Gjhp+W+sP5nOcgS+kafngq3FSw3Ccyd6E70UkHyzbT1pe3MibqPHnEegybOCb0lTFba6y3U1tob2TTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IwMJg9F9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1edc696df2bso36527725ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189512; x=1715794312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rcMwpi5swukR9fu2rr+tgqRl98owlkzS7lAQiTyYR0=;
        b=IwMJg9F9lQfEe+AzV5jXn9VE/b5xqYgCuZThGRFk87TXfYrsFkqugIBbidix+EdaPm
         Wtua8BqjGwxslnquNHT2gXwsd/PUTcLhRmZIi52Ax8Wa2KSp2tR02ZvfQDPpV6m7oeIt
         KCkRtVeZjbZsbsiROw33eBmmRddR5m6kMa5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189512; x=1715794312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rcMwpi5swukR9fu2rr+tgqRl98owlkzS7lAQiTyYR0=;
        b=TSF30LMOjT73e2ixudMM/J9X8U9SQGFpbGK1gz1J9Uw8gRCIlzh+p9qWeKQ8Wtr/Ae
         iryv+z2M3km/7vTqrgSMs0cJSOG5A+5lZ+88KalY04Z4AdXg4hd/bVYUC1qA9iU/H3Lt
         4jl5wD97gsBV+H9SPsR7OyQMQUHojW4OeyEawMHC0R2ODYn6p7MFXIgn7tdH5L7WalEV
         dpWrsaAR+KqjNhyS02KZrzzwoPPJ3xt8QYECOpiBw3j/E/8yiFfjwvxTaux7ZdVKEV7g
         8trIygbhokF3TboxKnq8mxRp3k+m5Ii/iqFt1zgAJt8yBgI51EOiWMnhBRHnpJ0zFUwN
         3dpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeuSBtjoNy9xvfePKfL8NSmVHiZGIHouRHhIwky0t1772w57laSoknb7OxUmL/5NZ+QoymnExHuD4uHQdJHPa6FSyp8ES8879GkDy/UQ==
X-Gm-Message-State: AOJu0YxmyorVDmIPXeG5bSececemRIZN01x2wLT8RFe3HGd2e0AMaMP0
	kzWSjeinEWWW+mWYlWJgm06UOz64OmQwrNnD240BC+2yeAyaJhcI9Ap3PQLGzw==
X-Google-Smtp-Source: AGHT+IFNr+b2pAfQcWXsO87OnrvROJLzoQf+GfNtUyLNTbuK3rS25oOgdGVm7lFzQQasZ1Pfzw4/2A==
X-Received: by 2002:a17:902:6506:b0:1e6:766c:6a26 with SMTP id d9443c01a7336-1eeb017cfd1mr35094695ad.12.1715189512601;
        Wed, 08 May 2024 10:31:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id la13-20020a170902fa0d00b001ec412676adsm12094121plb.275.2024.05.08.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:52 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Chris Kennelly <ckennelly@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] binfmt_elf: Honor PT_LOAD alignment for static PIE
Date: Wed,  8 May 2024 10:31:48 -0700
Message-Id: <20240508173149.677910-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508172848.work.131-kees@kernel.org>
References: <20240508172848.work.131-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5293; i=keescook@chromium.org;
 h=from:subject; bh=eUy8l4dx1nlgASZnAXri0kDxbx6zhnXlB+I6YzLFjTw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7cEJD8sdRg2kTQVgy9QHVOS08welrL7Y9Xmg
 lC0fTmRrBSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZju3BAAKCRCJcvTf3G3A
 JtM8EACdAwapwoIf1FEL7K12lEwr6cSDnpSo/80JcopA9tWkFKXsiep6tWvoxZDOzJ1vc9e6b4V
 YLAAZBeXNl/xk6VrycAfh+xwdHN2k+KNbWvuJiD34NZowKV8tHkpCLzfyBMxlsEnwkpvxp4gaSj
 d4IhlEOcmwxk6K5OT+QsSmcjMCjEBIVRIK0goPl4GHq8aOi+sRueJ8TaFrjvw1+8mrbvG2DdFCe
 Uv8kWkvlo/ILaWPFZ0NusPLLdDhExA73NKe/ve4YZAfk0p6FRzmyWuHOaT7dkEYmU9yuB2JtgFA
 K2DJetC6ue7f0Q13jS3/JzqgB2vtfz+FNYDwsf5pZqI/0ziFNMCvidOe43tE7Iw0Lmdt2/BgPNL
 r8gTuz9/tlA2bbDc3e/kRUhuX5nwaHcjR/r8IVSalFQmyqc5IPAk37VHvGDmg6DIbep/8qnwvCF
 QLG5UBoysuC4MgK+oc4o06z7rfYgL2DuXeo2iJifxHJslw72FqLeVf4SKpDzrWKHhqNWvN5fVlO
 iCNqiQqRpRch+qbtKbcDu6uw3gg9q5q8qzx+EEXIHGhqVyKXRZKdXgMmXXp/my+9/udZV/cFPHl
 Axrb6nLzkWUCWdMUTIN4aZHCt5ihat6gagmdxw0UNkomFQUeEHsgPbhNUGZztz5L0i7eTM6zPj0 PxL8C6OI/h070mg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The p_align values in PT_LOAD were ignored for static PIE executables
(i.e. ET_DYN without PT_INTERP). This is because there is no way to
request a non-fixed mmap region with a specific alignment. ET_DYN with
PT_INTERP uses a separate base address (ELF_ET_DYN_BASE) and binfmt_elf
performs the ASLR itself, which means it can also apply alignment. For
the mmap region, the address selection happens deep within the vm_mmap()
implementation (when the requested address is 0).

The earlier attempt to implement this:

  commit 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD p_align values for static PIE")
  commit 925346c129da ("fs/binfmt_elf: fix PT_LOAD p_align values for loaders")

did not take into account the different base address origins, and were
eventually reverted:

  aeb7923733d1 ("revert "fs/binfmt_elf: use PT_LOAD p_align values for static PIE"")

In order to get the correct alignment from an mmap base, binfmt_elf must
perform a 0-address load first, then tear down the mapping and perform
alignment on the resulting address. Since this is slightly more overhead,
only do this when it is needed (i.e. the alignment is not the default
ELF alignment). This does, however, have the benefit of being able to
use MAP_FIXED_NOREPLACE, to avoid potential collisions.

With this fixed, enable the static PIE self tests again.

Reported-by: H.J. Lu <hjl.tools@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215275
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: Victor Stinner <vstinner@redhat.com>
Cc: Jan Palus <jpalus@fastmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/binfmt_elf.c                       | 42 +++++++++++++++++++++++----
 tools/testing/selftests/exec/Makefile |  2 +-
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 56432e019d4e..cbb07a9c02d4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1088,10 +1088,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				goto out_free_dentry;
 			}
 
+			/* Calculate any requested alignment. */
+			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+
 			/*
 			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
-			 * and loaders (ET_DYN without INTERP, since they
+			 * binaries: programs (i.e. PIE: ET_DYN with PT_INTERP)
+			 * and loaders (ET_DYN without PT_INTERP, since they
 			 * _are_ the ELF interpreter). The loaders must
 			 * be loaded away from programs since the program
 			 * may otherwise collide with the loader (especially
@@ -1111,15 +1114,44 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			if (interpreter) {
+				/* On ET_DYN with PT_INTERP, we do the ASLR. */
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+				/* Adjust alignment as requested. */
 				if (alignment)
 					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED_NOREPLACE;
-			} else
-				load_bias = 0;
+			} else {
+				/*
+				 * For ET_DYN without PT_INTERP, we rely on
+				 * the architectures's (potentially ASLR) mmap
+				 * base address (via a load_bias of 0).
+				 *
+				 * When a large alignment is requested, we
+				 * must do the allocation at address "0" right
+				 * now to discover where things will load so
+				 * that we can adjust the resulting alignment.
+				 * In this case (load_bias != 0), we can use
+				 * MAP_FIXED_NOREPLACE to make sure the mapping
+				 * doesn't collide with anything.
+				 */
+				if (alignment > ELF_MIN_ALIGN) {
+					load_bias = elf_load(bprm->file, 0, elf_ppnt,
+							     elf_prot, elf_flags, total_size);
+					if (BAD_ADDR(load_bias)) {
+						retval = IS_ERR_VALUE(load_bias) ?
+							 PTR_ERR((void*)load_bias) : -EINVAL;
+						goto out_free_dentry;
+					}
+					vm_munmap(load_bias, total_size);
+					/* Adjust alignment as requested. */
+					if (alignment)
+						load_bias &= ~(alignment - 1);
+					elf_flags |= MAP_FIXED_NOREPLACE;
+				} else
+					load_bias = 0;
+			}
 
 			/*
 			 * Since load_bias is used for all subsequent loading
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 619cff81d796..ab67d58cfab7 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -6,7 +6,7 @@ CFLAGS += -D_GNU_SOURCE
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
 ALIGN_STATIC_PIES := $(patsubst %,load_address.static.%,$(ALIGNS))
-ALIGNMENT_TESTS   := $(ALIGN_PIES)
+ALIGNMENT_TESTS   := $(ALIGN_PIES) $(ALIGN_STATIC_PIES)
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat non-regular $(ALIGNMENT_TESTS)
-- 
2.34.1



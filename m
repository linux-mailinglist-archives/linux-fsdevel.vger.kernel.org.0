Return-Path: <linux-fsdevel+bounces-11904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A50858D7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 07:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F041F22517
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AE1CD26;
	Sat, 17 Feb 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrMFYxl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BD1CAA2
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151150; cv=none; b=jdfxPsp5AolblM2XYGcB356P7GUg26rG8WM09cEIdr78Up7RIVnYDGSaHqSN4nw7j7QYy7GUPqfl4lP1obBdZxj4QpqvDVA3S/fRGkntytaLYykBPaNiOddmzpEsDZOZoL7s+5gFqAw0w/9leGSFRLfDDC4ibDdp22a4B4cwBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151150; c=relaxed/simple;
	bh=J8yZ3FuS1LWrR5jVIrwba2SyB7GFZoxGQ5Gq7wzczYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkVGFTMzFaY6F36V+6QmmXnjsyJSXDrhRaDWfGKEKKDk96vt7SBWtoTjRm4Xv5bRLGDwSKDmcc9CFJcr2fVBDhwBm62a0Xy6rUbB5jSQxUjNJVcrCYI68SuAbnqDCuEhN4YwuwKkCSZBCiqhw5AWG7zrgPDjjhRQ9SBHiz9R3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XrMFYxl3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e11a779334so1764250b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 22:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708151147; x=1708755947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfIR0fBKHcHTu35XI9I/l5YesMfUJfSS9sUu5LMaD84=;
        b=XrMFYxl3HbmiYA5MznqQAnAqEKe3T3Dm0cR6E0hq86QLu74Lvhhb7IOERfDTKi3C2Y
         VocL+m200E/RatXK7Usd3mwvwPIs8cSWxwewolMMJ14LnrNvpomSxHwsI+eyf59ipSwY
         6i409nuhdmpRiaDccspRbhRV6R9lXtZKQLQKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708151147; x=1708755947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfIR0fBKHcHTu35XI9I/l5YesMfUJfSS9sUu5LMaD84=;
        b=NJtRZQG92nE8X6RsIuOzcdLvSIaNxOzGptlYkUIyFXJ6addyif641jFg34ds8lzjvk
         CkK6GFgmofXmLP3dFSJKOgmBAXDL+1vIGSW2empV/7gswfLVUgeXoCTV4eu1Chxcfghm
         iOko54+iwH4vuPHxxPUdIzQE3djobKxUgeut8JZ8cqOr8NhbPPgcvO/E/r8Q6KmfRSVF
         jCf7iEaCUBjpFMjgk770SOki7pEpq9tDcYmaGRk7EPKbvy8V6ZaWHULRJ6WpfotR878D
         2+vwGzMAXA/HxS3VkkhiQMidgJv+JEn79LVHm9pioo+N7f6xH2LhD1YV3WuZ4B4EG7z8
         61Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX8vnFozHa0ixXgmyRGjpo9r3DMFlHZDcVe+Qf0A/veYVqtdyJzkWfhelXAfK+Y9/pi/Wbp7c/+ATz3444I3htareimFj5F0QmaS7MSuQ==
X-Gm-Message-State: AOJu0YytSTqhn17sOKC3UqrH8njePmDFptZspE6Fdb7jRpZwo43X3BXp
	7vvC+lpJK0FEgTaIF+SbAAuzxnaAFPyuChMyJYd1f5dF40nMUh9TMqTcdd8DVA==
X-Google-Smtp-Source: AGHT+IEN7kra6nhd0C/U//cqra0sN9TAy99jtLP7gl6N1oR+rsshp77a8Yk2AxFV0aGXX6usEqGwwA==
X-Received: by 2002:a05:6a00:2292:b0:6e0:8c11:9878 with SMTP id f18-20020a056a00229200b006e08c119878mr13296297pfe.7.1708151147635;
        Fri, 16 Feb 2024 22:25:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006e35c1aceeesm233949pfq.197.2024.02.16.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 22:25:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	y0un9n132@gmail.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	x86@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] x86: Increase brk randomness entropy on x86_64
Date: Fri, 16 Feb 2024 22:25:43 -0800
Message-Id: <20240217062545.1631668-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217062035.work.493-kees@kernel.org>
References: <20240217062035.work.493-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=keescook@chromium.org;
 h=from:subject; bh=J8yZ3FuS1LWrR5jVIrwba2SyB7GFZoxGQ5Gq7wzczYA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0FFofylSSc0zctidXuws91GIZAfUD3EvfMTgD
 C7ILFWiQEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdBRaAAKCRCJcvTf3G3A
 JuvKD/0YST+WQlVawQvhCb3pQXdND3wneO4rAAc1MIaPKKYFGzOMCeSQYBifV0JEeFHph1WsrQC
 n4+hCw/MTLwSm24DnSu1EEevAaPtL2voVeq16UMZrkG/yapEWn3+250s3daI8qSEHpaTs+lqmrY
 20PeyS18a3NDnzD6VRtlc/Ud4NM4lTrD59tsR9Zypsk8QkTOW11SzkDOU36Vewr5lvz9WlASgCb
 uX115bQ6YNYuZQkpWi0z4MlnmeNcdOuQnupP0FwTKJDVMHrN+vvFac+rR68LNoQtHQMqb0yZKXr
 iaQfIX0RbdI1t7Ns/XMSdQQfLgvkslY3PnQ7KanuL/2iVQSA+qYKaUHT1q5rU9VB+w3Dck4Dmye
 Mw0zNvdQB8Y4A4EnGY6HYyO6ucLRSQtEfIuXbYYszYSq6wZmHI2F8gQrXTQN6dKrHavZBh6DOSY
 Ep4Xtnl5207P/j3tkJ2WlgxPesAECiupJebylL9V96dhr12EkUmNs83ixnDjhgIhd/q1C66ZLuD
 gOP5XrfxOIcEw0QQFj8sFRcjpHdAnouwZruQruo4ED1IAeSMX2ThvD6Di09uNBuIX4r27aUDkF4
 PMMxi3r0jO2Iy/OhTCP2lOG3dtuz7BSAH3EaHzmxqr7QyGazjc6Mux/rumcsyyFjQTLaXMsCYg5 3MpCUeeX8WL+hxg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In commit c1d171a00294 ("x86: randomize brk"), arch_randomize_brk() was
defined to use a 32MB range (13 bits of entropy), but was never increased
when moving to 64-bit. The default arch_randomize_brk() uses 32MB for
32-bit tasks, and 1GB (18 bits of entropy) for 64-bit tasks. Update
x86_64 to match the entropy used by arm64 and other 64-bit architectures.

Reported-by: y0un9n132@gmail.com
Closes: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..45a9d496fe2a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1030,7 +1030,10 @@ unsigned long arch_align_stack(unsigned long sp)
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	return randomize_page(mm->brk, 0x02000000);
+	if (mmap_is_ia32())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
 }
 
 /*
-- 
2.34.1



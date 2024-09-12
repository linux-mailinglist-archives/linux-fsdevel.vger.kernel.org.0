Return-Path: <linux-fsdevel+bounces-29243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C31977514
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF62B24A98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED61C460F;
	Thu, 12 Sep 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w1HX3dhW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128A1C4608
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183080; cv=none; b=ITnHn5NsLD+CHR3BON2ZXL0iQChGk7e99xf/3Tpzx3GDbXHnSB9qfNWq4L6Ou7vqYauMksSqBUxOAkX5DK/rucoy/GMsiplsYsul00Zw142m6/5AFOZliglDPDn0JKIkpqkiT39Tr7AqKysCn7NvJh+0FNdBlhTP3l5hIesvdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183080; c=relaxed/simple;
	bh=LF9JFBeV/w0Tu1rgdik6SFw4VnRCKV9PL95oOmfueSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8/UDFJC/EITmxHpYU+yDAE5NvBkKfLz6l80NLpqhbkiepT1ajUg9+too4C3Kl+sCYbtWyN1dvpVV/+VfqjjaZITmTcDpgiHKuttkk4vCJZFt2hrJsCTAqlbQ6+mGAlyzN2qjY1qGH5eb+8HZMgUXuvuaCX0IgPffZHhiFGW9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w1HX3dhW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e1081804so954477a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183078; x=1726787878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiNSEhiMyi/vclkP3i3QvX4mx663SI7U/pxriPsJ9Y4=;
        b=w1HX3dhW7/8av10709OZHuKpk3PYg+XY9pcfw+7PDI95H7JoH2RWFOVFx5S7FWOB1s
         +BGwS7941kA3+6x27a/bMPT1QfckE8I/64VSWCqauiFiVMOXgaGfijQNnIoP07PLKkx2
         +tJJagUD/T0DnPE2rHfW3JnUB0rabRArF2/ZMzeCkwNA3QeC4Z8Rja9zgD0AZGeQ8Gs7
         2IjMF5eb4t1q4XSyTutqfEozWW14kHP4qckYk0Q8o9ncDw1iwCvAc+qyAXfQppvBfirX
         jjhz4eCnTD47s/qcdHJvvNpgyZ1xFKD8LPNtUdhJL0vgDxwk4m4OhfHFwuuGUZz6SmfO
         5Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183078; x=1726787878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiNSEhiMyi/vclkP3i3QvX4mx663SI7U/pxriPsJ9Y4=;
        b=kMoUceXIoBG6JyYxfOnQCpebFXl3f22+w2S4m3h2bjKB9XzwtsGpmVOyNQpkJWhLW/
         4+oeh4DKQE68kx/X9NsgM5g87bKPboexsiKhBHb6wddPqFOwwic4JSRP7kVWO4ESeii3
         fwz84bnxSKHsfZuEWRlH0A6aZdWBY/ZwvWltKgpmCjeh5l3iHAIWcxIWLjjZcajJqUWD
         ucZc8urTx7nALHwRsJoCGfk2bUp12HMZg2FK0y5xN1MU+213N251wGwDceCPH+Q+wFAD
         +xHZ24ey1uwz1HRkrUmRDd15kPd/oJ8mLqeBBKG7ySMYdKN0xHTGPLlRcKz+0EXqykw0
         kZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrs9Oy0yDRZ20Mym19kwxZp0ZIVfJ6ti2as+SK0QWfpA9ExLliXEUvbDL0BtEMAUCsXS2FUbl3UfAJ/cL7@vger.kernel.org
X-Gm-Message-State: AOJu0YwnswA9EjxQUDjjx2WwA29MifGLFCnMB413CeLPA+0g+z9k395i
	MTdh1/BahLu31yADikhG1M2cu4RVCcfHg3pkWE9vvwuPJKkdHZBys5lc3Ifl6O0=
X-Google-Smtp-Source: AGHT+IF4e0NCjicspxUUMmlG4elk65ZCg5cB6xw18ixrBvYAVw02n2WNOur1Dg21kRqmRwms2SEZcA==
X-Received: by 2002:a17:90a:fd04:b0:2c9:a3d4:f044 with SMTP id 98e67ed59e1d1-2db9ffbcbd4mr5139066a91.11.1726183078465;
        Thu, 12 Sep 2024 16:17:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 12/30] riscv mm: manufacture shadow stack pte
Date: Thu, 12 Sep 2024 16:16:31 -0700
Message-ID: <20240912231650.3740732-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index af4337774fe5..0b6c66fb853a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -732,6 +737,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
-- 
2.45.0



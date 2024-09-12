Return-Path: <linux-fsdevel+bounces-29258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090F97756C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3529D2811C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423A1D416E;
	Thu, 12 Sep 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="y1T+TbMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C1D4168
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183141; cv=none; b=jepeEqjmyd/d825p64sKH+np2wUJrA7gg0SLF3Je5TJll8AKqTegiUlg//r1qEKu0WUgVkzwjICaJawbLUyw/Um2JPgu7Mw4MXf11CXK9LvBG+b5ru6iY10OOCZ1t91gQDB/2viXWthnghkFf25Tu5KBOMcDvRPkfU5rTZH6WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183141; c=relaxed/simple;
	bh=8vzmalV6KmaCAbIfBFdrbzedmECOlptfCmKh2INUmUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwZCZLA0jLXppnBRX0ZBplxGFU4GAFIVMg4B38z1hj+mBL0iZKM5B/fWKZoq5/N1X0Vjwqfw2uciybjMJKUhyPeWiKYy51zObC3M/YgY3SaTNcEG0idfw2SeGj6iYez6/uzb4nu6+wd2n+k05j7ucS4fZmNwk/XbuFmLFr2JpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=y1T+TbMz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so1124043a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183140; x=1726787940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4D/20yGykkpsrImg7wGRo0iFbIK8mOpJga3H67yqrM=;
        b=y1T+TbMzJMUi7LvY8UQPN04sBb1u5AkA0bxPb1y1DioMNIgRx27OUG9GRSOMIpLMDi
         OoAAm+VRHsB4oHoVV760K95Cf4Ps5/8ezbtAkbfAW+zmsNwxFYg+1dm0B3IuNEyxOc8i
         /5cM+aKuZ11XtTND41n1BGwltmAiWuXajPD4kQgDhGA7yBsP/2tKo7ET4yF2AuK3SrE0
         dvmvhrXBOqCI+Zgegi2lMxPDFTPrdj90MKvqTmjhOpEgaCHNIvwiNoL0dzRKcureylRh
         6LH8Hzw231PAc53eoCYgaSoOHfWHIXOGGimQpZi0gRGrIUXxogAyaf2nCM3KpjEV957L
         SOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183140; x=1726787940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4D/20yGykkpsrImg7wGRo0iFbIK8mOpJga3H67yqrM=;
        b=ue8m9ewSrnz9DWH06Dc0005FTUw4ydjKsHvybVNUADLKZsYxkfQt6L01SfzhEPRH1N
         sPLuhncUNh4c5U1zBfdI+UaWbz2tZvZhNV0mFfPWZ39923Gx4+nn/6SqH7LtfTnqt7vu
         m6j+yXZx4gZnqe9Kc5Pl+th8898DZfC0U6RHbhFjX7f5ApNjgRW54xjb5uQKfMCx6dqN
         V45u2zbz+2cFEkJWCN2TZ+LjwlRks5Tvh31xRDUTNiKnS0Ul25HOFcTU32bg8gdx4k0d
         S8AaeLhYI7CATkfT0dLvqHdIO7yftlAlmz0AKzb8xbQdttVjvthazr3VY2WI+/uO2VNz
         lGOw==
X-Forwarded-Encrypted: i=1; AJvYcCVuniv8sXE5yHph7nvITafod/ItWNYd9MjSJLffJDNSUoZKIytNOLQOHfzUzIenYTtFGzx1Chvbd+ILlrOc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjub7CUqv0HHfy3Y0jp4B3PmEoN6V+6JycyNc/08/lgde/9YcW
	uBDC17VprImYUesFasrfFDcGrzZ4nAfb/nSf6nk94wL8lymBH4i6KP2ey2E+rSM=
X-Google-Smtp-Source: AGHT+IEQ4DyvIPot4wX3TaeOhc9igc9k0ddrlo9rAO0eC0Cbq71JlaUH+P/ak8XpjpWlABFI12/jIA==
X-Received: by 2002:a17:90a:4b88:b0:2da:8c28:6561 with SMTP id 98e67ed59e1d1-2db9ffb41ccmr4730379a91.22.1726183139830;
        Thu, 12 Sep 2024 16:18:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:18:59 -0700 (PDT)
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
Subject: [PATCH v4 26/30] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
Date: Thu, 12 Sep 2024 16:16:45 -0700
Message-ID: <20240912231650.3740732-27-debug@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..d5c5dec9ae6c 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..98f72ad7124f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);
-- 
2.45.0



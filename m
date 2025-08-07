Return-Path: <linux-fsdevel+bounces-56943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903AB1D07F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1EA726678
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28124BBE4;
	Thu,  7 Aug 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h3BWZfhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F3239E6E
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531120; cv=none; b=Tz/XYZ11i/l5vAqZ6Afm/inUVjB7rbk58pFOAT+cvPaX39x9piMuH6WqFM/JMUhbm/JLz5ilc4lIupoTySxW7qb/XG8RPePyu7oGRbO87fnkrafz+xtcAVbV1TqY0ZZVWSuswJ7ysXBtoIZnhzwE1/Iijzes90EolhC+GwC1dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531120; c=relaxed/simple;
	bh=RZ++fAXg5VoJ9aULwrUGHh0jUgxwzggc0842qo3hOvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLIfHdUDLum5rNNaEaGQkAOFqTkiM3FEWNWNldJ0Ek6uGohb53DCa6zUc0i4BHkSQpQeLux+qjtxl26NiYX5Bdvu4VvQYzhCqz3xQ8W308sSemMMMocbHac9EWU/rYodJ/8wt+q91XTKF6yZzU3PCBB+elnjRwjol7CsbCSM6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=h3BWZfhk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-707389a2fe3so5507826d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531117; x=1755135917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtKfUzOgupFaYotRf3a7eOnx1rqlnB537wzbb8Z3Bb4=;
        b=h3BWZfhkG+WF4+EcWwY4730YQ8ldiyH3oNiieZ0NLStWuOeP9N/2b+8vNQArNgCoG+
         mLaksFDoAYGVeemswgDli5X9eI1aT7TdvLoPtyCuulwXojVEj9CeUH6m+dTeRk6JgNTN
         vq+PXePRJ6wKDdGH7O/TNoh7U4iTFA3Ys+eTAsObiPubV1iuXtQK61w6Lu5wo/7u6p4U
         BLdn1K8UBWvtJvY8epYMe0hC3kYn03Erna9X6Q9M3pu8KKuz+1YFA2k4h7LS28SxuAYv
         vstbh2aEWtln7Jzc1VE+S5WZTOCFCTp4BrwUt/yVTypuDfGumlmVAtSng/a7IwLQCXIZ
         ChIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531117; x=1755135917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtKfUzOgupFaYotRf3a7eOnx1rqlnB537wzbb8Z3Bb4=;
        b=MoPQCjxywyIprgOVtERbzCMGmT0SQ8i4+2s188wUHkIOjKa8h4jHNsR3kecudIkLLi
         VTM/Jb+gjEajMQ30u4+RpsJmoGXRgJYHMUVdSIr5DZ61TNwCgcqIQs5skNm+TxRg9R9T
         Xqs6S59QBv6UjhD+FeZGdawmTdLAlDe1t/hI+cxG009N8+cHGg20DPyNNGHN+nQ/ytt/
         3cO9HNkCFZ0WtZYxsfHyVKa9urnKVxLxEsfMVg3gi86bYX6RHlKiQuml7V+h73apcDus
         jFH5DIXrEPNeKN0S2pllcCcdP4bFB/lKJB6e44m8+z9VlVCExcURP5L9YtER3nC/2sKW
         9h4g==
X-Forwarded-Encrypted: i=1; AJvYcCUeGt8jKZi0BBrX+81HfapJlNXeS6dwgEwcx7Yh5wWvabwpUFwxKssuz1FyOJHpp2ZPAnWMUcD9FsGsrIpQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPt0lisnyoK3kFvx5hUL0JTiy8sFyZxcZBnqeNVYN1FoB3Peg
	mFcHGAGgICsFhwCSo7cnfLLWw+Dkqu6r4Av+SKZp9p+10gfkPPj+KChPC0B+9drwmmI=
X-Gm-Gg: ASbGncur4BYYS80hS/J/Ufqdcyduc6gPDKvcF4Cxc9MG3y/NTnIxJJbyrjGELx2k2RK
	WKVBnhvlOXWIiHhAaINiFFyTVpeNDe372CPZAcsxAkEQV9ex+Yt2GYITeve8rQaieZPYMmRGafy
	JqtOzqD8D4QsbCWg6zxTYESiB9Qx73nIopRVKpy7bRR1gOrl6fP4+8e0DjXtMF5TAcAZrljJIBR
	2dG05VyCoM/O2d5v6+qkTg+NoDLVmbVLXmsESNNT6RLJcdudCMRbVG7yCXx/rtDPValbpH3/jZX
	+T72x8J72GjKhQ/NpZZ26IN/D+IeWTQvCgbis3JCTSae29755FjsOZUZUZhQU8W4j/fS81+4cjh
	OrwaXP4+jv+K/d3GpAw1BM5s7sloSMB535SQuzazWicpc1Xtd+H6MM9Idq2qenn9Y9UPsu3CILN
	KPEMDwcnwidTmS
X-Google-Smtp-Source: AGHT+IHDHBBqboi0c0b6rcDIt/ymD1qcIlODHNQyebDLYVOHVLNPjCPlRPjhkhoVVjwmxNLgx8k5ag==
X-Received: by 2002:a05:6214:300f:b0:707:29f9:3bd1 with SMTP id 6a1803df08f44-7097964ce99mr76346136d6.46.1754531116814;
        Wed, 06 Aug 2025 18:45:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:16 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 20/30] reboot: call liveupdate_reboot() before kexec
Date: Thu,  7 Aug 2025 01:44:26 +0000
Message-ID: <20250807014442.3829950-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.1.565.gc32cd1483b-goog



Return-Path: <linux-fsdevel+bounces-68575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D1C60CE1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BC644E50BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B72749D5;
	Sat, 15 Nov 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vv5M4s4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D926F2BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249665; cv=none; b=SnlUo3Z4By1EXw72XZ61C83C4EmCu49PwwVSQaa6jAIs2iRlaPTu9PVQGWBCzIx0Wn4lxQHZHeP//7pH8CRYK4Dfj8/exo9m1/j4chwZAINGhOkPrXZ5el2kbePsCgsZPTkxp4OXbBe7dQoyydZCfceelzHpIFOShaxeDrPfKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249665; c=relaxed/simple;
	bh=E5mYrrro8NuMkC7HPDRevyvgCJvESo2IchKI5QmQD24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbMDZx5hNMDIqESWvbpyXCqRJK1covmnH/0+JtOAk+vLo57ngSfVfIMR2PaEYhSqGutFMyEP/iIBkgt7aY81ZGAORpxyEr0KI+W6lX6sDBzSiOSfgcTmxuNqPDjF8ZbLA7G4LsPfP3IH3GEiMIh2aMnqYsyrYhJi3AE17YJrrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vv5M4s4M; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63fbed0f71aso2518150d50.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249663; x=1763854463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffF6ShDH072kEeRsAneEmG7BXpD8z3YnDwKiTvXVzXs=;
        b=Vv5M4s4MbrZaPZzUnOkFJ76hhvkmuERgaGRqL1tIN8y5KepaYZOw/Tu+Xu3Edtl9t3
         25ZzhmpORqXbdS5edKlWEm8miyI4KHd7WrhVY/GlR5x9/Tfxa7Ehko7PnW0rhCYHMN9W
         2EByd+g5tDX+koAZ2B1VF+N7NYy39cMtfh0fgPezQ9fyndvKYl6ZhEVVAyTzRiT4yEoE
         m+4ZOebyBqp07E0dzUi/V23AdQIkp9wNWMusu9Jn+hD6trtyRonySzmz3T2beA5STHE1
         dnoMYv0YvAD3k9es+LFyckE4vVWCpJ8aJAPBjIbDNxvhtWIMmoIpAJbRL2RXb+kE6ELY
         Avrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249663; x=1763854463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffF6ShDH072kEeRsAneEmG7BXpD8z3YnDwKiTvXVzXs=;
        b=Zdr2tbr/s6eKaq07Q3KsN+hRzULqwQWMqlW+U0kDXw5xScOSsX/kXj91vQQjCNDdgY
         nq2BCUU78cp3czbET/gJU6cv++3KoxYXg986/gOnaYFnxAKbZXtUYsrtq2fXMmH5tN99
         S5FO2dylTgCaCxv+RaKLtxNE7PL82pa9Kuw5TSfXPGH9V7dthjsE0xNnU11Zgfo0a/UD
         xakho/4dsoynqscPW2FhvcYxEiXMRUotKK9jSgUzw1ZDmcpxBpcz9xU/q+y6FSMtOMVN
         ZlJpiavhiNyw4QktpScEVr3dZRmx3DFMZdL3T7vfpl0oYr46SDF6ZRm6Mf8GT+6IDBC6
         taPA==
X-Forwarded-Encrypted: i=1; AJvYcCUXh/zSHzHbkDJrjBneddDRkYiDBj7v10RPnyPyV7OxL2+bnkChjXPM27PAP5Of/slkn/z1I+kEFn0bJCZT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7m37AgW3YshFPaj7FPXQINX+XBSLmAA9qGHJ22xVtY9S9D3Bl
	IO+IZNjTVN1mxa79LtqAJIuaSPwn6BrD+5znukg/s1YiyRB49WDxLlCh8j+YqzvEWgQ=
X-Gm-Gg: ASbGnctiRrQw4adXuq4RcQtych5BNMh0qRo1hiC4xbpnZYRvbOO/fqn0GzXI9Hubsm/
	JKLoh8q1iFnfRRj8vdUmFVkXUt/vF923LFUIsDRpM0dSrL9ccAYShrfJRTXIGcf+0ibzq3PPths
	ZLbEfk2FogbgbDgpkPRfHrOS6Vlkir8mlNBLXREkVlDcAHRkrWG3J6qG0E83Om32tW61erZhtOk
	amJJikMlPiNpBdxZymKy50kdvdhoyX20JovIIC39UktePYApV0fLuKVYLuEnO0pJyRiOiq7qYxf
	pAoujo7FzpxG/btPud4afPTUPQ8tPEsteg6U1q1cIYRd1sLcPYj81FwWDY6RFVdWGQ461L3gJv/
	ljAf93wzDVxplV5tAb6etJgRVDEXCTXUIETrcVm9nyt6AhyrdnA5M+99HdlE4jswCCE2mpbxBYJ
	bCwj/gdsggO6rj0MFj3OQpx2J1sx2mjDXqRMJ9DisLQSsQJjfjuv2bRAzOHnXiw/ZGBCIoQHeD4
	Xfcl0Y=
X-Google-Smtp-Source: AGHT+IGaaou1T8IlNwnvhEGAvgtl5hmvWdjNxQr9knw88/sarPOBHEpKzr0vdGK9CACIRmLZkXd5Qw==
X-Received: by 2002:a05:690e:4366:b0:63f:b6a4:dcbb with SMTP id 956f58d0204a3-641e76b2c36mr5840850d50.69.1763249662685;
        Sat, 15 Nov 2025 15:34:22 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:21 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v6 03/20] kexec: call liveupdate_reboot() before kexec
Date: Sat, 15 Nov 2025 18:33:49 -0500
Message-ID: <20251115233409.768044-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the kernel_kexec() to call liveupdate_reboot().

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final freeze event, allowing participating
FDs perform last-minute check or state saving within the blackout
window.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state. An error is returned to user.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a8890dd03a1d..3122235c225b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -15,6 +15,7 @@
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/liveupdate.h>
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
@@ -1145,6 +1146,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = liveupdate_reboot();
+	if (error)
+		goto Unlock;
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
-- 
2.52.0.rc1.455.g30608eb744-goog



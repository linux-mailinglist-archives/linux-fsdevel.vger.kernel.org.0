Return-Path: <linux-fsdevel+bounces-69485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA8C7D885
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951AC3AAB0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE02D47F1;
	Sat, 22 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ahw62As7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1D2C376B
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850245; cv=none; b=kDdm6bK/SuVf+wRgAfspaTd4daxyiQE+bWtb9znZKmxJ6XEP5Ze5I8hKGCeDuJmFGDMaMyW+pjuZ+6/+8deXqFrAohFPinRF7+pa7Cct7Rq7M6etjJZBzY8xyqdtUeH622/5aME6V9slSE1j/AUHNZES52Z5tu/UQwtua6/n6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850245; c=relaxed/simple;
	bh=yqW0eNnuY6iaIAb81qp9+q3ixuk1RWq84gZvp3pOj+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MavMHovyjP0tO0LB4vq6MI27SeBxsP95zP3YNILG8VJjmn3+snpK63clvhhW29SCscFjsLyCtCfZFftoZGJvjOO2qnjHyav/zF249sA3dvpFC+5/qD4EpyaTjUX0PknGYgRL8Mg7RT3izgR4ktb5IHvssj4ynUGw0amxZyTMiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ahw62As7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a7af9fe4fso33199297b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850242; x=1764455042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5KiW0twGUwiDqt6nePE1kGiL7dytg0Q0KVXgthRcks=;
        b=ahw62As7z5Pp8+KVpJHLR9K98pdIlj4hIScu5BSMiqHYogLBwdt0Z3cU0D8d6e4cQt
         KEdBqtYBy+hQMXiTLQf73825DkW9KUJlGFg5wrca2+TTLZI1Ur4KXZqPrj5A1aLjpM3v
         w3L1ODvFkjxH01tstd9dWyuBICRTf96ckT7HYnN7rCREQ5ruCucOR91nlwm7W0CGPePH
         yoQmUtOBjgdVuBMaCbFfF4thHh/bOOVJImlmIY2YqT0YGOqj2UzZ2AZpVIixd38MOMNp
         UVM5X1Dlvuxe3qHPkEuvpKUCjkPTOehJIUCBlwzitQsR1h2Q4l7ayDq+dCI99jJVKS0t
         +7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850242; x=1764455042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5KiW0twGUwiDqt6nePE1kGiL7dytg0Q0KVXgthRcks=;
        b=PhD5pd3Kc2wAvD4XzHgksCyNocG619//TCVO3UKilX+Nmq7trohwCgquiNk5w2HUZq
         3yaEZBsTi64LgieM6aG2Sty7Qm5PTFEwRVL3mIZFFAamSn28yS6QJigy3QpjO0f9h8B5
         yhntRbQ3C7vKoq3mfd7YNnnWfhcI9TYp86NAqNUHJd4V2m/SxGXsVmNvgOkqrJ56uzpC
         V+EvhsJ+Aix2TYWy+5asWDuYC27Ep1/O2li8WO91OphLFkOwgTru+n+dt/Akujzg/JxS
         ZO7/15ud15ms1sTWnTBAoI6XB5XAAmQ5LsvjtGLUGffXZDefcWethTl7a48UERUQDmd/
         MGZw==
X-Forwarded-Encrypted: i=1; AJvYcCXBhExWerwr/+LxzH5CWZS1nawn0znudSUvd/TzjtgzqjrQV8CsVcFdg5I07mYo6aJE70ElUqNCNZiejwiX@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDUkNYg0pFnuNEdxAoVCFEGW63siRVcKWben+WNISiQQY5/oG
	fgcOlnhIGU293FnzR8X2sTo14E5HUWfU3yZ0DtfabFDJvdLWgK8Jrmh0inCtR+jNElc=
X-Gm-Gg: ASbGncu3WICLTuUbSOplJp+JHjosq/ZOUb6uaU25PNMGp0APr7NuooZtavnUUGtZ9oz
	5ftPdyBDhqEhlZGTyOYR58CAHQ1srY6dQIAjJT3MHQOc9oibpgQ+nNmC0aw1aP6F73GWnB0zXKx
	EZEE4r9C07xj3Iepaa+mm80awacyUkNk+FnMySufT71PeMYLo5GHP6GQZT1+VEVGa3fdYfqTamU
	VQHoR4GCgc/tzZbcwtDoA/1oqzqP0Ghr8jQABNXdTeRu1CylqiKnT3Q5zSq6x43YFsePDFXdISo
	hb3LDqmYj15m4SphELcaPLMoMfst1K+8TWe1DfA/VvrC3jyIHeFB19FaT+nGIqXD142+MsvVBtb
	DP9H4q0KhG9VzEj0bN8NI2QCMRep+dYhxlFtcr6dKgreCr5SMQsIWb6BwH2bQcYig5NQj+gEj6v
	LZ9HLRxndSjh/L2bJe3AwJiE30Pd2KmWbY/4WS4yNasKW7t63pWqkDo4aq757UY6VRhXNlSujrp
	/ePF40=
X-Google-Smtp-Source: AGHT+IHuoY23QTvRNhRkhmDmGHRrDBpwbesFLAGgRZdemrA8LoJ/P/EIeiLQ/hTmePkctRQeLMtVhA==
X-Received: by 2002:a05:690e:130d:b0:63f:abf6:1c9 with SMTP id 956f58d0204a3-64302a4b3fdmr5160190d50.25.1763850242430;
        Sat, 22 Nov 2025 14:24:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:02 -0800 (PST)
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
Subject: [PATCH v7 03/22] kexec: call liveupdate_reboot() before kexec
Date: Sat, 22 Nov 2025 17:23:30 -0500
Message-ID: <20251122222351.1059049-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
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
2.52.0.rc2.455.g230fcf2819-goog



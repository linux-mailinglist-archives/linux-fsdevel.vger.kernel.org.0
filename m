Return-Path: <linux-fsdevel+bounces-50166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FBBAC8AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B14E39B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C022068B;
	Fri, 30 May 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RNJbGHOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0D220F30
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597323; cv=none; b=d1gbtXK7RTDMOo9/26zNfPbovabh8VgBSR409kxg3pWnVthZXgZ0ri1bLzn1nSk+1HEkK+t+tO/177h4buYYx5I5WFQbsAWhPmMXhpL05E/PkQHiPrO5IoL2mVqjBVnqK0auVkGjs2RafcYN3a9B4JrNtlDqUmi0GiZ7T/l3DnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597323; c=relaxed/simple;
	bh=ppCxvzGPzwxMK0c+R/BjMfinsaxs9oKUnADG8qsL8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwj9EcbDlRPi37P76sV1Nx4m6keD/yucBX1rrhLoeYD8sDW/ZKcWwfFI67V+7fEZ/U6fFcDRgdQUUgwo1IUeLJom2YVhy9oZBYlyXhVrwySj21riZjbP6Htqy1TCSOCewrxxTvS2GVqiyRETR/E5wFTblY3vqTnjqNigFc6u11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RNJbGHOV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af908bb32fdso1302363a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597321; x=1749202121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/A+gAHA3ZAGJfkMi3IvOeV45q7o44ZhkocltOJrpQQ=;
        b=RNJbGHOVy+7gA5xoBsRaT1rKXF040JsAQapN8McX3jn1Wyk4I0ZZsaZbS8pB8DpatB
         3g4kRPZGZxPujBKYFUZMfrHtujffJ6DNwYHUekHRdsao5cXm3myz9VwKiW0EuyowgMpp
         PIq4oAY9ym5CCsuoHm1VxXGovdSKOHG+FuKhYGkKeL9YBIHHrbtc9YanYWLHXJH0UO0a
         LESGRa9jM7y2+XjtsoLNrWJIkVkQFrL6526NQ1Dw8BichmkPc+kjMxzJ27kZyTD+tHiw
         Zj/SCHFZIYYbr2XsoSF3U/5XhRQ5EWBkm35poP/UZR0nPRMb18IBTzExgW4+GBKCcGFy
         SKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597321; x=1749202121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/A+gAHA3ZAGJfkMi3IvOeV45q7o44ZhkocltOJrpQQ=;
        b=VhVAnDtrer+urtmSCoYZFjPado/jD5fVb5mTHb+IwCPdged7TU3iP7pSaWnXPcz8Qx
         52f7mxhIpZM8B8SdbJcRzbJwJ+UV2T4NCAZ76fovhjOUoF4Y1k0yKVQ54ePMdOhK9PVB
         O+LJxJfYrcBsKGXVnGqae8UF327XBgaYV08mmzZhBcQ/6VFfufMkKRMtwpCLtBoRo4Wj
         zvH+RUGkJPGPh/rV8tzNdR+WJMQafsUfEPbqtAUlucEuimk0PFpTyYm9FJy43A3yBNYr
         Z/tuCrvJtDwD2/UPek04gAY4UdGB7Zl144FhbejJdiah4bFV7ir8GS6EAwOANwOVnIir
         ob7A==
X-Forwarded-Encrypted: i=1; AJvYcCXVZBB8gRo1WWxqcJvIyhZaEXozyxXFkexYrxFl3WuVRLCbyi0pzXn77vrMKOxNEL07vAxy37Ls6Kiwsj91@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OeD7wHlTxZR3COrOnSzDWaVG1Y595mQ0ucXDD6lwACZCoT/b
	H+6x+Cpwtb19a9Qy7oUo5iaY0IYxPcDFYa6ojVDb89pxDv70Yc3du/PW9vXeElyKxRc=
X-Gm-Gg: ASbGncuBEoIb7XMAD4kVzKNSaSTtf8ymn8fSalm5NkVKA/SfBlKN5JXrhH2HoHVfmpA
	c3Y+mQli2R6yD62JW4YR6aj64GX4KhqmPPVtgrZEeH/v3V9KT5ib2NO5m/edHxBkRezAfKIcTkn
	Qz+XVirE1kMO+uq6vlSFbaIwLxSHI+8KgkT6lbO953UP1DMAZXMU3ijsEN3txb74hS3t92WLJDP
	GP+nOMXFDoDpE+TjYTU7LooJb840SpiyXfq4MJNADBIX84A/I86yZldAKRaPwg1ojKlgolI+3pP
	SzJYcXqlgPoOh4wyjpJ67Vs/dYCR9Z5RXf7KKe62ugv+abvCgk3AjW8PmT5VT1UeWDm573Nj2K6
	/q2JCwbHthTW/VhVANf25
X-Google-Smtp-Source: AGHT+IGtvKSy5BRqT77HroAME3q1wPsiRK2qsvrkfhGABhYMviWMHBoI0lrSImjloPHkxtdJIsjzUQ==
X-Received: by 2002:a17:90b:4a0d:b0:310:b602:bc52 with SMTP id 98e67ed59e1d1-31214e11d96mr9868483a91.2.1748597321318;
        Fri, 30 May 2025 02:28:41 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:28:41 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 01/35] Kbuild: rpal support
Date: Fri, 30 May 2025 17:27:29 +0800
Message-Id: <e68046d85a19a0d161e6f76f31ef6a208c646bb8.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kbuild support for RPAL, including new folder arch/x86/kernel/rpal and
new config CONFIG_RPAL.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/Kbuild        |  2 ++
 arch/x86/Kconfig       |  2 ++
 arch/x86/rpal/Kconfig  | 11 +++++++++++
 arch/x86/rpal/Makefile |  0
 4 files changed, 15 insertions(+)
 create mode 100644 arch/x86/rpal/Kconfig
 create mode 100644 arch/x86/rpal/Makefile

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..26c406442d79 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -34,5 +34,7 @@ obj-$(CONFIG_KEXEC_FILE) += purgatory/
 
 obj-y += virt/
 
+obj-y += rpal/
+
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 121f9f03bd5c..3f53b6fc943f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2359,6 +2359,8 @@ config X86_BUS_LOCK_DETECT
 	  Enable Split Lock Detect and Bus Lock Detect functionalities.
 	  See <file:Documentation/arch/x86/buslock.rst> for more information.
 
+source "arch/x86/rpal/Kconfig"
+
 endmenu
 
 config CC_HAS_NAMED_AS
diff --git a/arch/x86/rpal/Kconfig b/arch/x86/rpal/Kconfig
new file mode 100644
index 000000000000..e5e6996553ea
--- /dev/null
+++ b/arch/x86/rpal/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# This Kconfig describes RPAL options
+#
+
+config RPAL
+	def_bool y
+	depends on X86_64
+	help
+		This option enables system support for Run Process As
+		library (RPAL).
\ No newline at end of file
diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.20.1



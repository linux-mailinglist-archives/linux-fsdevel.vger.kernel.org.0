Return-Path: <linux-fsdevel+bounces-67480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6FC41AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A79424500
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EC3358D2;
	Fri,  7 Nov 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KlrOE5Ab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A4319864
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549542; cv=none; b=AHo+3ratwexztSmOhQrV29ZsuAph+BnbhnmTul5KWncUJBzwrVzBFYEw9tEzqSm2yHLFj+8ug4HAYqJxh4GA1AqoyuXwzTL8qt/7obcoFgRm+FFocUAwdrWH+BAxazhJX4cW1IKXZuRoT19+RSTB74ROQGM4CbpiBg9njEQdy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549542; c=relaxed/simple;
	bh=2AXBG/P4zHHPE991SiFKrlF/2yl4Orgmw9rox7i8sZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIZ5psHR8iGc6RYbhdmTUgV+xFLF3z/chPd3/H7JA0dvPDZ/SK9E0fH1rDIpbezlPJOJCHk3sQL6sgB0RyUxoA9DMoCg+q2rP4izxfTz6WhYHZLKmsskee//v1QLY7rwwecXfBac5eH1diw3umZ1tjifm62qYsLcD6o4nX+QZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KlrOE5Ab; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640b4a05c1cso1164466d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549540; x=1763154340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG3KZj/IJ+feH5LNOQCm1I/xQEDt38CQ/0swaPI9wVw=;
        b=KlrOE5AbYBpsv4e2mhXSJRLmPj6kQUoPp8bfWosYQg1KcuemMvi+VqHr20Gs6IG7Np
         tROfxZpQI8C+VW3/ojJiRzQyNKxTV/977xFgNnfJyA2MQk2dvdlDF+TsDsYh6V77UJEc
         9OClbSPa4kE5JnGEDErFu+/uMY1tr902iyYZbMbRH7aNvGHIyAtIrwFU+3T5aSrUJsMB
         NppOm/UVb8f35QJA/XMDdnOe2yxintuvRrqY6dNvJLbkL4wkXpNqLAb59ZQehESpSCaZ
         CbvGZi3IC0cBOuESBiMXnkUAnGXCPp9eRvXeMC9NLQGPwY+y/ecIm6uohrUxkLeacJPJ
         c07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549540; x=1763154340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eG3KZj/IJ+feH5LNOQCm1I/xQEDt38CQ/0swaPI9wVw=;
        b=nGrk7saNukuRNfP2T37P30c/9dc+OyP6y4ZGSO+X88OnMWr0Hg2jXuRurEGzb8F8RI
         hjBsj45mAkd2GwdlAnfPAnBPQYIr4jVfwnsdes8w95CNKa5ag5C1coVMRPKpSzSFcyX4
         VnzI6AWb/Vm27woX6lN4UlCe+4x8yfJwlYmE2p692jY1i9RTLTFcGjVu9twDIyKXzfp3
         Citr4VwKToyNSWA1QINw9ubYcNnRrJ4SvMjpFxmUGRNeqQ+L3mC0sqiF37Nir1moJmow
         rQdt+ubnLE+61gTgC+f7gdIpaObl/vpTOux3Iqyf0uHtn0QMeGqtX37SIX+mhk8Xir7I
         dbFA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTK6VkxFyvD27gv1DuK5NPWvjnaMXxOQ4qIYSksuIjy1ALVUUexi3X1Gmd7nsER88ypvD698GR33UMsXF@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSp4B6YMP4JQOxCR9kKPN7UDDiSvhxezn7SajOE34ytEjj1Ov
	cNY3lLL8JiiEH2oXyzvga86Ka4tHnZW6orteZRk8sTrPr71WoMo9KlvjTSvqJykYHGw=
X-Gm-Gg: ASbGncumeRHHIci6M+7Yl8g5l7JRJr2VDZGaPEP/9GrMKMU0DrL427D9o3dy/CDaRW0
	YV/aWzzTmPST2HCqWtZq0VTDDRFlGiG16toVgKKTITi7GXyFrQXef1XDbFSseFZOtjp+ArE8PIp
	jkNHxQV5IPkCi9pvgD3uU6lNCoqPaAYN8NRtKWWkEV7bLGqsGYUFkWHY23vIARaRrfgJzvzpFun
	sY4aaMToZAYvXihEiTnqpKcXk6EnY/6sdRkuOd/hX/F4G3gNlm20SL/9HwE9wgIkdeiyaCDPnnN
	NUQugQRuBpYJmQz82/Nm2qH9ef8eXkwTTAJT9qJjAue82LCNcImlSCMe/Nkwuy+508R7mFSC1vt
	H+diUNOvnltnIT/GbPv3PRYY1rpq4trUpCsuv0Xg94InLTOeZRttvyuF0nfKNhyDPniVk9vclSB
	EQf6w2wdFpHAFiWYb9EkgUneevJ7aMg5GA68D1fq00+jQ+OdQ7hLNTum1r3qmyUWA=
X-Google-Smtp-Source: AGHT+IGgi833lso4oL9ECYqCcFQNiRqXoYUWKz1MoKHjJMaptGXdg+WJ5uxd88A3KFV7TB/Wv9G8Zg==
X-Received: by 2002:a05:690e:431b:b0:63f:a524:1f93 with SMTP id 956f58d0204a3-640d45ff3e1mr344048d50.68.1762549539784;
        Fri, 07 Nov 2025 13:05:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:39 -0800 (PST)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 04/22] liveupdate: Kconfig: Make debugfs optional
Date: Fri,  7 Nov 2025 16:03:02 -0500
Message-ID: <20251107210526.257742-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO can drive KHO state internally, the debugfs API became
optional, so remove the default config.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index e1fdcf7f57f3..054f6375a7af 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -54,7 +54,6 @@ config KEXEC_HANDOVER_DEBUG
 
 config KEXEC_HANDOVER_DEBUGFS
 	bool "kexec handover debugfs interface"
-	default KEXEC_HANDOVER
 	depends on KEXEC_HANDOVER
 	select DEBUG_FS
 	help
-- 
2.51.2.1041.gc1ab5b90ca-goog



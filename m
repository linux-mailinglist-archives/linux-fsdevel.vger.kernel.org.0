Return-Path: <linux-fsdevel+bounces-68582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D62C60D38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 545E935E667
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA628B7EA;
	Sat, 15 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DJ/Bocdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FD26E143
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249683; cv=none; b=hTIGiP9RJz6UOqAH0NG/AxAztWcy798wgka8q5G3YxeF5QUTfJRAEPvwOy4YlgxZGLmNiK/XllZLkeSoEU9xKi27UnGh/hPnMBAZMuDTCztO/6OhaB3AANlF+c8OjYpLAvnHOm23OdBreRifzEGdFJ4JF+o1TjntvZWCF0KsfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249683; c=relaxed/simple;
	bh=BcQ/q/HLfjUC/A/ryQjCYpP7otXrO8RSxRHDXnqgx54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjrh9PJMiXjQ7+4BE/3NU/VhaOId+GH9q6ibmGbW6vsZc+ud7Ccz5CioUtauzM9BtqeQ04nFHLy4mv+7KptpB85mUXbeyfOmd4uEuaH3U2vaAnhHNzzsv2Hm6GfpFq7mOJUYI/8Y/tDbQ0Ze+rx4yFb4eAgjgtfgQBfYArd/faE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DJ/Bocdf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7881b67da53so28945237b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249679; x=1763854479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMpZqjn+eetCXAXNQY+bjgKy9hWait8fsWMBfgLawx8=;
        b=DJ/BocdfPWOR4Bxk7q936aHJKqMhTobW1Pm8UA46plJ0JXAJyLM1vn+tri2NewiTgN
         FEsiCkJNq5hB+1e1+ARINqp6E5rNq2nNGb2OlWWEUJc7c6TtLz63MEw5kV0bTrsK7akj
         RskPchmn5z/wk9O8o7LdX62v+GA5DF3aNGsmeuKxCUgYUNXeA6a5sO4s+qjb9nPs6PLE
         dpt7yllYlT4mMYFRco89JhXp2Raz+CyWEoeASCdxuXIZzguneWTiFKl82du9uvjOLauL
         Wa27hHoPt5X7yXg6GA9ix/zVcaDDEfyiNKVdOdnAlA6g5vYrm3+ej609WTgQkQO/RDJh
         kZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249679; x=1763854479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMpZqjn+eetCXAXNQY+bjgKy9hWait8fsWMBfgLawx8=;
        b=ZxdRAAEZjnFnudVHToipcOdDd228INS8FFrChzxb9+B9bkeMLJ0NAIozHbdQuI6mln
         gAJHa4vNrdxtEwpu1Ou8YyUScxliIQe2Oj25PDrCrBoUtuQYVdViNh5e1yp4gvogAIV4
         Qm4O1rMCGkTNRN2DdEYtpzlZkX8UGTInrnaEd6OjNLsl+Lucw+uv+10ZNt+b+JAPmrDm
         dafFHQ+h37EF/HRzpOlrZeQlwKPwXXqYvM27JipYoXa3WjW3TC5bjFroDoizmnEOrgxv
         Pp3migyWe0y3jHR8hrhz8dC7knkvEzsgn6aHJNxikYDGpIZ8EuSUYrVVUaY9PaXafkOb
         MIeA==
X-Forwarded-Encrypted: i=1; AJvYcCXvEBABU/+m0zzko9Ig4NwzRFhVVmDsLPcsxCB2qBJ2QYeypeQA+5xpSIN6Cd7vbmrFIsr7ze5ZcZXoftXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwiojv/O06fehUPGqfP6/uTfj+SyJ2LxUgBVnybl/fDErkUlAr
	CiJpW/q8vumg3NOzeT52g91pbuK3yWNmwkKBc+34g/d75VtTyP0kOxvDXLTcKh9Fny8=
X-Gm-Gg: ASbGncvFEy0DuCekKy92X4ZqhbUdfPaxWkiRkcJBjzFHzojqUv9aXnmqh/mMwFkMS4t
	tf39CFwOKL3UGkFRT+GNLFtHJueO89FVVOF0DYdoFu3ieFEJ8Mzqx2Vnoj8c4dz3v5tb3vLiMoU
	9CEYoDus6ty+FlDKSeHXi6dF5e2bAR+kgjOYc2SPdvfzWPdH3sihmCeqE1/DJK2gbspB1eQTk9H
	3vlTOEn6WVaZRfvvFPITGUiNPvtmWO7Wl4H7EIeZS5216elngyLKukTJ95qGPGIkJgsILp33dZ0
	pG99sEXV8xFELpu3i4hsFE+mXYjbxBcM7oZ1UUEeeLHQVVs/BaS/Pe5dMzgWi/sbgff3hVBbgsk
	OfS/tixVETz/wMUML1M+LFgfreO9b3o6wKK/6GrQ6WaBJjGgou4LEEv5f/R10PpolGkNQ/Vm/pv
	fNPd9YbudElTNH/DRoU8P0MKAQZFnLRzqtbVjviCi4jLM8dMElON/3TE7eshZVyGi73vmQ
X-Google-Smtp-Source: AGHT+IFpvmU4rwVaUle/Xd4qMbKiIN+TYBpeyYU/cujp1isseucHsBaZ4L2SnGIl5nDP3gsBZTrPxA==
X-Received: by 2002:a05:690c:64c4:b0:788:1cde:cabb with SMTP id 00721157ae682-78929e2fd13mr69921557b3.20.1763249679369;
        Sat, 15 Nov 2025 15:34:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:39 -0800 (PST)
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
Subject: [PATCH v6 10/20] MAINTAINERS: add liveupdate entry
Date: Sat, 15 Nov 2025 18:33:56 -0500
Message-ID: <20251115233409.768044-11-pasha.tatashin@soleen.com>
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

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 500789529359..bc9f5c6f0e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14464,6 +14464,17 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/linux/liveupdate/
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.52.0.rc1.455.g30608eb744-goog



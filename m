Return-Path: <linux-fsdevel+bounces-69815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBAC86162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D65093513C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0932ED40;
	Tue, 25 Nov 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZnbNAtt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990F32D43C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089958; cv=none; b=gwg93vh4L6jGrPUEZNDo6TrOJp8Hc3qWkek/tk/sLX3smOiWLoZYKzH3IBAWKdXiy6AUAxVf4ahrUJjRzPBxeuGZmSq9Kk1Zkh4QL0JmZIqpe+3IwCtr2+mO+kbO6oB7LdrrTF455eNHEw1dy47xMypa0tUWWJNGy2wYYjON3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089958; c=relaxed/simple;
	bh=rtE+Ceb6uvxsJ0lAv2S8AcwD3k610VK53wkRvQDM1Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnk4o6i83hC44jP3vQVaaWVaDbN9ZKD12S6BOh7aNrWHoZo+pqcXMXkLoTRqg0ZNHrUOm+HiZdmZdT1oU+D4ZciLPlCIyPEalimhzwoza6GNTR5esnUrFk2orBPIKFL7rsiAgTao26nYEsseNIoWmIT93YGeQOIdkgojRwsxieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZnbNAtt7; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a76afeff6so58534007b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089955; x=1764694755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2VZ/uSTE9rekrj+aF+jwkex/aSDTyF9XJpHnZs+90c=;
        b=ZnbNAtt7KY+wWAuqReoR2RU9F5Ma3kWXG5zsoZkHcnNSfQZKMB/3hC9D3dSkFO0VhE
         dJy8Dj9mMLwDiIA0QdIQCYl/jPGvqqlVMJHKMvv9PN5Y/yd9M+uOXNUXnQL+Q6TBTJrM
         BYEWSJCK9Lv50BX48dq1nDOYVxPZJFdLdYRkC0F5nxKb7cqbzoaNZsaeSLYj0pVsn+8/
         ktOUlFYKrl+Hl2/xFPou+GGkkv3nk1P0q8g9vWm5dVUB7sGH3AfD1xO0SkM9MztzJ81O
         bwKo7ppBP6V1aNqe+mIKt1B67oEK2t4AcDapv3I+b1vAemUHDCsraUHzHaRDf0fyPDvR
         PqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089955; x=1764694755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2VZ/uSTE9rekrj+aF+jwkex/aSDTyF9XJpHnZs+90c=;
        b=kQ277ZfOaX1Wdh2kOlPJH9tit6AQYHkVE6vIGNnoD8g1ZGJ/RT7YXPON9hCwqnw0SS
         KmEvc/fXKYCcnONah5mV+YDtygJJO1lrd0Onxe0h54bOOPii5GMSWuV51VESYABowpzm
         Q1Q0h/mVlp7yU7KZcoWwmgRlgkfr/ZHyKIBu52uT3iklVdQy3Ms3+Hj+J7oLv+7aQKBw
         YrBLTlZxKN07CMYK6EJUwfQyoeP6CGY4N+j8E8lgaFLZQZLhdAENWbCIRUlVgqDhe1EC
         +uYeQ+dzAq0P5zKXZ9E93f2o+WurPDnJvzg8MrYLbfnBer6HZPcN4YLbK55V/TvxGAJU
         l/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPUdwyNmOc5AFcqmj+mPoH6Etj+tVBjcIqB77GQSW41eTZ9OIkj1KOxND/R3e34knjoC8vFVYJco7BruA6@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqQp+4QSvAgX2oZhOSTwiH4toigcgMftM6mccVmyw1kShDQWR
	fSjOsD7v+QX61c8pR3y76MGEwZA6FpN1fyBH/118s0yk4QAmouM+XwBJC4mDQbatUEE=
X-Gm-Gg: ASbGnctoJqEncY9GtT4xg+9ijOs0m57nInpLUBQIdUHAwwDhr6WoG21rWUwLom3AXX2
	XcoO0w6pwoBLJpIvldxXK/XgCwWNF1GNKeM4NeAIZuoDgC+krHethmpQ4Cvd1DOiWWBBqKqHJrn
	bi7dA3GvFsJqTs6uhAVU7QXv4/H6VOpmI10MaA3BUFKm3htQPFbT2Yd+qVdR+ARprMoRXwMahu5
	K1Nynswbggby87Czw5/uaXpDzWydjjrQrIrfrqfb11jsNTilKVESd+0ZyMq+qrRSrCaTIdrDCxx
	BYimdZtu6hTQze6nzhw/BKHFbsIOg3OGvmDTMHzvfP/g1BVGXjTRqIzot4NwTyKHvoh2LbVwcpy
	bqd0GqFT5qtQ8iiFbvkp/NppkESVG6ZoUTqkxxgcD2WKKG3qckWrdqMdpUL8WFZ9lcFvjEGng8p
	DQHtZunS6ZZxeUzHnfx3X2I1N50TRLnQELmoGEqYVCwrIJsjQN9RW2KytEwCqZ8PUpfEBTr94be
	JxVUVk=
X-Google-Smtp-Source: AGHT+IHp/uLRINC+2mEmiuoSxBmCL/SWIZK6CY7B3JageMUTar9wmfaPytTKzucTyEwNZIYxmxjOcA==
X-Received: by 2002:a05:690c:61c6:b0:786:4fd5:e5dc with SMTP id 00721157ae682-78a8b53925emr120116757b3.36.1764089954718;
        Tue, 25 Nov 2025 08:59:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:14 -0800 (PST)
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
Subject: [PATCH v8 09/18] MAINTAINERS: add liveupdate entry
Date: Tue, 25 Nov 2025 11:58:39 -0500
Message-ID: <20251125165850.3389713-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b46425e3b4d3..868d3d23fdea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14466,6 +14466,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Mike Rapoport <rppt@kernel.org>
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
2.52.0.460.gd25c4c69ec-goog



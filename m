Return-Path: <linux-fsdevel+bounces-56949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B00B1D095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613735806A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8226D4E2;
	Thu,  7 Aug 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Uun+cnp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1321250BEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531128; cv=none; b=fTi5P0uKdRvB1x4Gs1iB4DDb0rlADPbVOtfGT+FRfI45H6fzQBmsfAROlhF0E/7tXwhkbuU4smZfQY6WcFfnok56FYCDnl/ylPFQ+GXgi4IDJTyoa+bMvw/iL/oaXRdMZ/Et1724zMEIRflZj7ThXpu0oYf7qW6pWYYRJ7ZuCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531128; c=relaxed/simple;
	bh=MQ63LnQeT5I2XWVR3/9t21kTUDqY3sDHkmER0gtcW/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX9OGdtM7929voEy5dOi1bj/KwmqMV9C6BceDzNbc8FczVvDT0sBh9jJaXWkkm5BgHpgdx0xHvaq/mIYO3HXlA9QvndHa0/vGe5n2SBf016zRFRhNfpElcH7ywwWWUchbz4ZkgFqerG1xfjU4Q0xN0P5c2zjO1csYZ+qj3TGd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Uun+cnp/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70756dc2c00so7504506d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531124; x=1755135924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA/vUYeCxNkI6poJfbjFNlz5+YRzYcbbQ+LvASsW6yI=;
        b=Uun+cnp/XZzGsvmDPlAnMsb6mrtGv5dYDxU0XO8gk/1VU77Obpair0DmYTgs11wixy
         OEvZkYCAJnBva9a70vWXvsavXZ4astcUadDqnQZOlrHFrWk5w/Dgab6t1Yr4bdEofaQJ
         uVYfrN4ICKA63QtOGO+reRstzuz4o5FnyutjFC1wv5COdWV3rkVxWL0cgs1NsXcKUGKp
         yyo8h6baecjst6NVS7cbvibmGvPtTJYKh76QOTQ0rfRGdLrRF3bd+XaJ8DtiYw6wTLUu
         hRlvoi3s4xhmoDs+Coyx8VZC5jj3DpTlml/n/UfO5TUSRPiyrG1fLlah/nfGRkJx0ivL
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531124; x=1755135924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA/vUYeCxNkI6poJfbjFNlz5+YRzYcbbQ+LvASsW6yI=;
        b=lb7Pi/T/THPkLmKVhCPoqYc82rygXx3epN69HYPZj2vnsOlqlx1EOj5VuSFs+TdPfl
         EYNb0iWB3dAFK4yGifyQ5BN7MisaSL51y7aAh6a/FoZkVq+CjlDphNZ16xzXQpdqYHYw
         1H7P2AlGM8/t/XAUdfISKgkE5UGiBjZahXpG2YBFX7T4dbVDDpyXsbzkG+KGGY/vJnw+
         WWhNC9+cU6b1ZDvh6QcL0OVzWmyJoA1b9cZ8R96DBZSKaf4Kv63VaRCIdUT0xBp4uuKT
         E+DXpPbGDniKKVpzJx7f8fdElmtsMFFpecW+pXgasGA8K2EGFXyP2QUuRZwgn2qWUvTG
         OwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXr9yRimVuIOB+IAO7AVw8hoZwc4jQZvHiSqHas4l3NITdN8yBZfZmiMLbdsM0UqFgHD7VhNkCe3pZYunky@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL50YlMWwo1DrlbrJ+x0dmcuJsGKlIA/D6AOT6soekuYZotC9
	m0Zz981o26q4PWoIr/gYaeH/QBfNTT8plajTh7n9LRvx9ho3LHGz7ekZ5szuwI6p9AM=
X-Gm-Gg: ASbGncv8KbvTWQoIPbsbCeWOxi9N1v6u5TqluMhX0tnIUEnGO6IOX9Qa7dAJBwdw9T2
	rGOiKhS83pEf1fuwtsNkcyHVmP1MYJeoXqqWBhfuxXewNwsCgqmemwjhPh7UfPqTB0ntUS0ue8L
	F/FZ/aH/XcoPQ3FQibOeU5FqRttkRn76PqHttbYFHUIJOusr+PdrDYwFqL/lWpYXCGw8pvUtMp0
	pahD3pV58CIbu0jiSSbja2fwFGFU5VshyQlGyC9knkdMBVn5iUtvXA79Zg5VY9jrsTtnrcLyvZa
	ehczOa8uXZZChhYtQ6KbqbkvTv3SMt4ZUfb4acyoU6ihuvmf44dTy3Hy6rGDLCO3V0fFwAnV4UK
	tt3bSdxsA6EHvrfp4T+rxNPQtumqtmOg+eUB2vyZ3TqImaDs7L0xiXNG8Uhi+LX0VNDxKnwQJyf
	Q75EZjxmJBTbW9n8jFnfMTTZU=
X-Google-Smtp-Source: AGHT+IEmxyIIEpF/zYXpWh7lst20k+6O+/3teCC6bRoX7mK0ce9gFr80XAlcr6QckhUk2jTkrcE1vA==
X-Received: by 2002:a05:6214:27ea:b0:707:3314:793d with SMTP id 6a1803df08f44-7097969ff73mr76803076d6.37.1754531124250;
        Wed, 06 Aug 2025 18:45:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:23 -0700 (PDT)
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
Subject: [PATCH v3 25/30] MAINTAINERS: add liveupdate entry
Date: Thu,  7 Aug 2025 01:44:31 +0000
Message-ID: <20250807014442.3829950-26-pasha.tatashin@soleen.com>
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

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35cf4f95ed46..b88b77977649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14207,6 +14207,19 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.50.1.565.gc32cd1483b-goog



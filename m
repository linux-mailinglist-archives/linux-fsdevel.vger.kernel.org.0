Return-Path: <linux-fsdevel+bounces-67488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1344C41B16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6763D3489C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A687342CBC;
	Fri,  7 Nov 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PHmV1+0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D66311C0C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549558; cv=none; b=MFUMh+YxOC/TJLkCU7jVtDh4A9ag1pX5ZPE5u9Nwk7d5haom0+2QVt9B2V4BybCtJ+qiJy+/S+JSFuH5yXPBHxOAVpTSU46Dsg38eqMsNKU8+nol8AZA7E8embbaSZvW0qU6kir7IC7b/bM4SzyR58hR17NZvAEaNVjT3f4dM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549558; c=relaxed/simple;
	bh=EhnYH4OG1yQcNdExdTlX8DtkF4c1hxEUjRTi3VHc5ZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlLotxVf+KbVvY64HFO7157FcGFHYKQTwkfRqFsbK+0CoRkjsEJ6cJI3yu3NfD8SRI1SdvbAq5qc4kYwoLolFzx9lQ1YXqnkJ9tUXRomAoC6wLiBP0I4SJtVBBSIHiMmO2oEWVHjhlIy6yKl7QTbZGshtIU3FIptDKjCV7MzgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PHmV1+0H; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786943affbaso9584367b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549555; x=1763154355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFdqd9exB0x0hPzLUkgD+8tlEyMvj6WmHDEVMBDy3B0=;
        b=PHmV1+0HTM4I2RRR9QcPLEkj+0X2mOIPFW/c/iVOIQ+G6lMV+NVL/RE7ppGcfIxdhW
         0U2jtlN5hjXIMoLjs9CR/aL6Qm7CtCEAOu1+ePqGvVA9m10YXnJ6rLK9gk/wqI9tLPwd
         nvoQsfv2n0I328Ox6vxQ665eJ1aVcMhdC+4Ui33ojb0dtauuJ+lg2sL6oLulnE1s6FQi
         xK+dsyDjzxu8D+irAcaw+oX7xa5M0NzXzQ/ZWqFxQ0Hm9P+3NCCwlTtmgvsxfYoYefqF
         PUwoxvORZLZcZM0CpAomnD8/VOQViGHv3LutaAjgIep/8BOrk7no4IInRZMBmqYBqC8C
         aNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549555; x=1763154355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sFdqd9exB0x0hPzLUkgD+8tlEyMvj6WmHDEVMBDy3B0=;
        b=LkpIsc3SPv0rRcDs1y7IJmzuslLmd1rkldoLaCNVccdo9TDdzL3gVNg1YZkzs5jH5Q
         21bt94xv38pcbn/Yf+tYjn8Hv5ZNtFcmqSIMnZPvh1nxfhy3tV8p/LT4TrEY2rXT8sWB
         w/UIqjf9Xo1zhqCWMzU1tBzIKW8yPhIXn/Qm/Nc1ewvzaS/SR9LO7wbJbc+1HDysuu1K
         rBClXtSsGMQQ0carcB4lLcuhVLVBv0G5NWL++QbSAj2GDagJcTGVgd2FjxvJ9cPg73jh
         N8h0AUA5dV0j40zfgB3dl6VXg49yPK3tMZyxecQMTxWDPwIZYYOPux2vlToRPa9zG4fs
         YkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrnBa2S6FkhBWPiqN1Q1jcKyeQBewftUDFqizgkPUhmLNyHoNQ5OtJ+sCozleDzT8xZ6AQdo1QfrA9f5ZB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhxrGb6z6VT7Jhr6xk930J3H7k64XL0xq3+IUzz0yCNM5D79x
	iX2+rVA9uYnCWNdUMK4DznN9spP3rPnofOIcRt69ZXH2MjCZ+lqapW8bcsxvH7LXsh8=
X-Gm-Gg: ASbGncu1jU1s1oN15CWfDw4ju3LPzAPcLvLZT5mVrvCND250rDHOih1m+3lShcY5Uhf
	jaAC0UMzSjU4E/DDYO2v8nI9Ptpch29I6APdGnPdJ8CRaYE7PZZT+bGVvriGq3AyY7CclZBON4b
	T+YbduremU/SbgekAcpY5bVhwA43rHQYG2vLIk+b0r4kdZw477WiGlr9be48uOfnVCy/+vjZUCQ
	6HeJuie/3wkVabwK30S7SFb4TN1nT33BfeGjtAeWpucAvqyVOviPHsQlL94YoOCFfTQfIyPsOdh
	CQq7twbbaAj0HckBkrYkgKo0o+ioudOcPgy4rk1DTGQVq8FhgmXRJWrHhcgFFz6iWyTWvyXPz2Z
	/76W3w/aoWowQ8zKkbQ1jaswFY7BHq62BgQmTJjAVliN+8O+/RyjLHfv/CSogUBaNfsDQo+Ozno
	QNEK1ji/cDQLUxx4KFZpzplJfP777UBxlExQ8hOveQsqjaVaog1ERCN3yEib/kwgkD+UJPgJ7sb
	Q==
X-Google-Smtp-Source: AGHT+IF010PbDrS6Jp4mBjzKbhPzLzB8jkjc+eSVHmds1J2sDdVJ/oNxdwOHlro9GSCJe4RgFsfJuA==
X-Received: by 2002:a05:690c:c004:b0:786:4860:2226 with SMTP id 00721157ae682-787d5400978mr6003887b3.32.1762549555336;
        Fri, 07 Nov 2025 13:05:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:54 -0800 (PST)
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
Subject: [PATCH v5 12/22] MAINTAINERS: add liveupdate entry
Date: Fri,  7 Nov 2025 16:03:10 -0500
Message-ID: <20251107210526.257742-13-pasha.tatashin@soleen.com>
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

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58c7e3f678d8..11b546168fb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14512,6 +14512,17 @@ F:	samples/livepatch/
 F:	scripts/livepatch/
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
2.51.2.1041.gc1ab5b90ca-goog



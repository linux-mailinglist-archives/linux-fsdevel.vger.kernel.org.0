Return-Path: <linux-fsdevel+bounces-60013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A11B40DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405675E1954
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487C346A1B;
	Tue,  2 Sep 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPE46Tz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1961261B75;
	Tue,  2 Sep 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841919; cv=none; b=X6Z7JoayeQYcwlPYbiUTivYC+Z/yZ1HoVb5J1ZYUxsTYuSTlPlvY255yf42TNA8+Ihul3qxHG6tNahgm0WCEK9zbU9vK5YDUazQtIM40m+FtCA5vQ/uZfZ948/YucNO2ZV9yfL+vliSJGH80njnYTb737o3dfK4bwtWtAq3JHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841919; c=relaxed/simple;
	bh=HaZVq77hCeEKJj48W9T/SV2y0EXDcF4xBD7RBPytWIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLOuEGPYRxODXa8gJ46vJNYSdlwoN8D7R7RyFTCSXfne2y10x7VAeWZv/MlDwG59tyRc0JRRcuSTjiUKMHbxirMNkz2I4D0/Yjg1FPgEX4QCLLpNncdwTOjNF511vReKvqk0GQL115E3IZ+c3fgLmg3svqnkZHQl2pZNr+BQcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPE46Tz/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77263a06618so231795b3a.3;
        Tue, 02 Sep 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756841916; x=1757446716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kLBob4ZpoHhTQlAXB2V9hETmsGMAM+pRjiWrcqYh6c=;
        b=FPE46Tz/SBFD1fWLR9+LX5tG0si3zsMOrGaOWS41foC4R5zkBSQ5sGmEKo28Nbx5/U
         L8tW4/Aqwp+hZ6IcP8leAqkfV7ZimVzu8ZDvPF72RBL43ADy2QZBsOQns5HfrJE+WANo
         DVR2AYC/jTtG2fbFxqVQ5+Aei4N2yXkKc3OE4L0dJMcwVMo7n/7J5VZjpf09Zn38EzHY
         TlNhAAz6RW7oz2RIXg220ywHm8P3TBPMNQx8RsAKm/dIsdJscHKCL5jQfCjpgQQr7apZ
         kouXuIdqoTPibDWt5479endQU8uKUCp4qxcSO6QkowyZxbzz6xe4rPM/aZHn+k0iO+61
         JdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841916; x=1757446716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kLBob4ZpoHhTQlAXB2V9hETmsGMAM+pRjiWrcqYh6c=;
        b=GMH8El2xK2PhXRHO40KLPQz4bsuLApkwJFACqgC5k1fTcLFRYTvkxti5P73QljsKvC
         QMGUFrILvRcbJKImZTWT3sPzZ1HszXKDhET8JzMkdkQ/ie28tO5PNwbTqGngEdZNgG3r
         SapYSbDkR3c98FL+PTN9coqzmAkjfQ1QNsupe1F2SG+KHzZ0W2o6MfkGzSpE7E35BmmI
         P6csw6ZRaISBAaKDeh1AcRvf/gWFjvAq8EOefEZgTZV7mkJSp4lgwPaMsudxiMSpYiKp
         VxZzeE9wuVn/DtKKGh1HbydPrvZIJNu5FppAgNYkpDrngY4C7r0TAKeZJm4fZHYL6HEa
         CGqA==
X-Forwarded-Encrypted: i=1; AJvYcCVFMhlUcxjFZJ7rS6xCXFT723z7rYPYvMiPaTE4jtIzvZDo9n8Q7aYplTmDdSEaanfrnfVN2FllZwD+vC7aEw==@vger.kernel.org, AJvYcCVh5r64WDIB81xKz8SgDmQUjw8Ma+TE2w7yn3HlvJs+w1PIUBUT0SPCw9In2k8MTSLrE9xlXa/0t5Z/Xb+Q@vger.kernel.org, AJvYcCW6BYiYhmknFZ5WybBp7C5JYzNAVGCg3D69UBYpHU/Z0S8kL2CNtTZEEl9s1ZBI+T5gNaRxzMz5dXff@vger.kernel.org, AJvYcCXGXOkSVDtl5b6Y+coZYOclv+yx25m/Zi0cm6nSoddv2KP6XSNFPbTtvFcHSTmE2vQaL53f@vger.kernel.org, AJvYcCXpUmK3gY+lbvOofo4gB8zBbth7Nj/wZZuxB+qMlCtxUddbSSI25OnS2oK4StxuFUigvw7Sf32UFPCE@vger.kernel.org
X-Gm-Message-State: AOJu0YysF5HLzo514jaBpt6SW9KHC8lr6WH/5groo44GD7Kzbkh+RmQB
	wAAu8+PPvK1Iwfz/5Vjd940/pstDgEx5ifKnEWx1SFUWbQ/0TjjraUvBYlFjbOF4
X-Gm-Gg: ASbGncv85XEulmPstwmplujcwBPOraQV3cbjh+UwfYzZkYS4+E50QjZuR8o2suPtusq
	1rv+K7Ehj7yHrFusNySbu2Fw4Vw0n/cZo9n9NTy9okqxrMVfgGKmqNLqr3YcLmRHc0tsCrpVkAJ
	c5PU8lVVWQq5a4QJ84wPKrutpQVxiHRWN5HHoSecMKES34V0BV4eIrPGBG3Qi/QjI7N+D+noLAB
	o+l9b/HsNuHJ/ITgbV3ogh4IPeUpshH9vvrSFlhU3KMunh3s6/CNpN5RyN478JPJ9kOckElNuS8
	70BPoNDrZk3q9I4nogdea15vBUvcGK8TZ5hTC/iTSzxqG1hrPIdT/DUW9ceRMkjx3S6rTgWSD9q
	Mj58ma4osuypK+ovb8q85BN7LpA/I
X-Google-Smtp-Source: AGHT+IGhEhOhFp7BmdZi4Pl90JZtjsQL2QmhqyTXezZ3L1cETXjqvrmjx+3LXTI/4Qf1FAWGWRCAbA==
X-Received: by 2002:a05:6300:218a:b0:240:d39:ffc1 with SMTP id adf61e73a8af0-243c847a252mr11620306637.5.1756841916066;
        Tue, 02 Sep 2025 12:38:36 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:c842:443f:2e7:2136:792b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm14567108b3a.19.2025.09.02.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 12:38:35 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	corbet@lwn.net,
	pbonzini@redhat.com,
	laurent.pinchart@ideasonboard.com,
	vnranganath.20@gmail.com,
	devicetree@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] Documentation: Fix spelling mistakes
Date: Wed,  3 Sep 2025 01:08:22 +0530
Message-ID: <20250902193822.6349-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a few spelling mistakes to improve the readability.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
 Documentation/filesystems/iomap/operations.rst           | 2 +-
 Documentation/virt/kvm/review-checklist.rst              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 46d0b036c97e..191085b0d5e8 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -66,7 +66,7 @@ I. For patch submitters
      any DTS patches, regardless whether using existing or new bindings, should
      be placed at the end of patchset to indicate no dependency of drivers on
      the DTS.  DTS will be anyway applied through separate tree or branch, so
-     different order would indicate the serie is non-bisectable.
+     different order would indicate the series is non-bisectable.
 
      If a driver subsystem maintainer prefers to apply entire set, instead of
      their relevant portion of patchset, please split the DTS patches into
diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 067ed8e14ef3..387fd9cc72ca 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -321,7 +321,7 @@ The fields are as follows:
   - ``writeback_submit``: Submit the previous built writeback context.
     Block based file systems should use the iomap_ioend_writeback_submit
     helper, other file system can implement their own.
-    File systems can optionall to hook into writeback bio submission.
+    File systems can optionally hook into writeback bio submission.
     This might include pre-write space accounting updates, or installing
     a custom ``->bi_end_io`` function for internal purposes, such as
     deferring the ioend completion to a workqueue to run metadata update
diff --git a/Documentation/virt/kvm/review-checklist.rst b/Documentation/virt/kvm/review-checklist.rst
index debac54e14e7..053f00c50d66 100644
--- a/Documentation/virt/kvm/review-checklist.rst
+++ b/Documentation/virt/kvm/review-checklist.rst
@@ -98,7 +98,7 @@ New APIs
   It is important to demonstrate your use case.  This can be as simple as
   explaining that the feature is already in use on bare metal, or it can be
   a proof-of-concept implementation in userspace.  The latter need not be
-  open source, though that is of course preferrable for easier testing.
+  open source, though that is of course preferable for easier testing.
   Selftests should test corner cases of the APIs, and should also cover
   basic host and guest operation if no open source VMM uses the feature.
 
-- 
2.43.0



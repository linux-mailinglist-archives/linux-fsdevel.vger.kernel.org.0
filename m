Return-Path: <linux-fsdevel+bounces-28912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287C9708F4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AEC281EFB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C2176259;
	Sun,  8 Sep 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9xKHqRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631E26281;
	Sun,  8 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816541; cv=none; b=XLKq2rZWEkC4MURy59rEHYxHuQRsU8fJsHr5kGTs+50srQKV9vj5BtoYvcnojOi5Sk0YYySW5Vwcpjl3Bs1iKRN5Y+EMsLys99FnyDr3Rgv7JGkBeyOJIhpf25ahalRWOeJCjf9PLjQeuVduBoFXDgAgR24h3eBY2zby3itT2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816541; c=relaxed/simple;
	bh=ODeLpK4Af15QLuBE5+94jWGI6ekq3Rl0Ngi9ZJdlkvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo/erU8V9FTf0tpYu1jjPEIwn+eT5TZermcE2J6zqBlWOqW86d+nMEOFxObyxyvJmBROm94xvYtfBzoeAYEqxSisITMhSju3AhB4XvNnOxqweFkHB8xIDdAjFuR78WHaOzT+4bd2Fkub0EevSw/BAyrTzknab32VdkQJpr6XZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9xKHqRP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99c99acf7so219052485a.1;
        Sun, 08 Sep 2024 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725816539; x=1726421339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsm4RBB/t1W/avz/RLFv9t+SfuXFUhmHDDisoJZDHX4=;
        b=S9xKHqRPQQM7xPhEStgC00isOr/r4gEGd8azrYHW2eHIwEIhTU6j+lO8in92a9dDjG
         Tqh0c7Io9+HgaupshO/OJMb1+L+7GO80OhOdv3rdMXHMceeYMKMPD/kdrO/m6cw42fIE
         RP2WHlJPVsBkrJFMCikbcZPkbXHqHi04Egt8TqgZLA5GL+BajET1V2GTfqRtayCFIi/M
         UfFCFgJCOT0X4UcgiK7/1c4uKjQ70zZY1owGr1KG2VvnsvcRAGjcpX1VJ0M9JlboCS0J
         GQmZVuXJ2czNrl9uCF8JKiIkD3cZHDEZM5gPkEPdA1AY/UIPmbKkxza0rdd8jRRj/QW4
         UijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725816539; x=1726421339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zsm4RBB/t1W/avz/RLFv9t+SfuXFUhmHDDisoJZDHX4=;
        b=B3wqw35L928dDQ6wnVY1jOwV/mP2NLWObM+BsV8WyHj4qayHl3b9K43MkO6PgJcd1k
         nnj9/irXdO+6JCTMPUDXphNtfPtlztmlvaJhqVDjSVh+IL1Uhzi8Wb4KnyK8MOuJN+a6
         gIBi8cxtzuJagMDsFHaFNllvpUNrUDYibbRXTK7SIeXZ3UwmnxDv2Td4GgjwU+jYe8zk
         nMVUW/6ToxbX/LK8JDaLxHXMaUu/mBjRmkI1Cv+F3URxVi4cwx6LtFJdDkYXTDFxXvLH
         JCbkTY4ESC4/d+f7g7qo5rigPdjG5GJLgEs6NuKTVk/lc3ROrzUMFRbXINykU4htx1rh
         JZeg==
X-Forwarded-Encrypted: i=1; AJvYcCW+0ORQRj3az9mP0rFMd400eUkby26l2G40tSctfaECfeZ8JaEzGsOvVmX2W53SrFK5ukCDrWreW4Drg7Ls@vger.kernel.org, AJvYcCWHG5lLIr7kGznmT8m8c9RtjadyCDRQN1BQzdXEqEEpLJrSV/e5HS1n5buReeBJ+gvU0/wjyF8/7Q4wVFE6og==@vger.kernel.org, AJvYcCWxOJCKfKVIaHrYM2btYj4v1A8PUwQhSsm1e78FYmYdVRzP/XDoP7O+FQ9VcmtBj6SzqxLBd6iekvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KAuroSOVRz8RnL7OugNBCkLje6MQky7+yyGRDNmQfjY2gvR7
	j3WUUCEMIc/FMBSwX9/miSEcUxqQODKTQu3avo2NOfUqZSjLP48f
X-Google-Smtp-Source: AGHT+IFsyFIKWpHy038Lxs6Jr/2PCnsALaerIi1bPVPX58yVKn+KBHywpybD0Fvqok+idKj5a7aUew==
X-Received: by 2002:a05:620a:40c7:b0:7a9:b9c6:ab3e with SMTP id af79cd13be357-7a9b9c6ba9dmr10025185a.4.1725816538546;
        Sun, 08 Sep 2024 10:28:58 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a9a7a040dbsm144713585a.86.2024.09.08.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:28:58 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	corbet@lwn.net
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs:filesystems: fix spelling and grammar mistakes in iomap design page
Date: Sun,  8 Sep 2024 13:28:42 -0400
Message-ID: <20240908172841.9616-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/iomap/design.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index f8ee3427bc1a..e2d34085dd0e 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -142,9 +142,9 @@ Definitions
  * **pure overwrite**: A write operation that does not require any
    metadata or zeroing operations to perform during either submission
    or completion.
-   This implies that the fileystem must have already allocated space
+   This implies that the filesystem must have already allocated space
    on disk as ``IOMAP_MAPPED`` and the filesystem must not place any
-   constaints on IO alignment or size.
+   constraints on IO alignment or size.
    The only constraints on I/O alignment are device level (minimum I/O
    size and alignment, typically sector size).
 
@@ -426,7 +426,7 @@ iomap is concerned:
 
 The exact locking requirements are specific to the filesystem; for
 certain operations, some of these locks can be elided.
-All further mention of locking are *recommendations*, not mandates.
+All further mentions of locking are *recommendations*, not mandates.
 Each filesystem author must figure out the locking for themself.
 
 Bugs and Limitations
-- 
2.46.0



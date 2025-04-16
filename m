Return-Path: <linux-fsdevel+bounces-46596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D758A90E7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7474449D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256020E323;
	Wed, 16 Apr 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQGNyZA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B72DFA42;
	Wed, 16 Apr 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841797; cv=none; b=TC4Garms2ufO4jOsa55kBcS6y/qyHeqZdCwOuGc11sIr9cT+9D2pzSWMB6hGPy8KF03tPs6+nrAHrMq7UaWbsalwZbHK0gtGYf76WuHHw2vzhCRsUoE7oF7naJZLRxmCbAkB6FozLoZ9pdJ2wRQkHkGMpQsbZNglYOlwmhCNobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841797; c=relaxed/simple;
	bh=km03s/ApEuoP+yjZ0S9m4vFeekoANUUOEXarU+bE4II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcdBCVUkmdfP6AU/xuiEZ6XzEI/xhWXoU9Tu6mUsvS3p25GXT8kxeRNZi4gasV99rFVp6d3J+T4L9blhGOyWJc5CunS7k6vvcLbn8Z1EcZwOtiiL5tIBD8cziYuhOBPmUO40GGKwPmG1UPq/YOX6uZqzWngnmD7OOtNnmjNpNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQGNyZA/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso246096a12.2;
        Wed, 16 Apr 2025 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744841794; x=1745446594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViE0qUIBJKKtk7+Z2mdJ4Yl+/Jbq8RUc3f56cxXVUkU=;
        b=mQGNyZA/3qEeE6Lk3LA/vSEAXnUjvSYZeEnbO8idneGqAlfQL/bJn4IyeBzPOWKWvT
         i4jyYae49WaPSxqkMbnEPHu6JXAJ5QtcbGDZYlGj+m68VpCcwpx3e8XAx424uRYYd6w2
         kXCPHpKc2/K4cJSafaCEGjeRLyprzIHyrb63clWK9T7A42ssaGhUzBc392x0y6j0fk3T
         AQIqRZbMBRIb/yK/qRTxKMocXxN4X6/D/DSQQWoS2FynRcmuh6IqPaCHLFTiInaOsEu4
         7yekp8JLiv4+1gqtr9QWasskpqAMcOTh+QLeOu7ZEMVpyn8uGb1f6U1FeDI8O0oge3HV
         IMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841794; x=1745446594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViE0qUIBJKKtk7+Z2mdJ4Yl+/Jbq8RUc3f56cxXVUkU=;
        b=VLWv35NOwa0dcY4CvxZ7wIoGlQPGuVLb8hiZI8usmPK3mEIl0aZwVXk0ppvJqf71g6
         kOXbMa0xHZfW3eDljJMK/iXH+mPNzhjpIeIF63AJaslYL2eRCw0QnLFS2VVYwgGJbHlq
         JRjJVBqKkyBOJG/YcAeO/XxDyAestcbf9RDvuFKSKmxqXZsrUbSfuSRCgkKBM/46/FtU
         GQmCIkrT6R5qBS217CB+zhXvMvQ56ArcAghKDrdOkVAKi+RC7hakmEsmAzaNtrz4TQH1
         kTNjDIOl1wthgbzVfG7a+mu6oBz49MLKeniPnG2YVSLG17YDyXJ+BIWbBLyYXC+3yICa
         eXBg==
X-Forwarded-Encrypted: i=1; AJvYcCVFK9am8XhjelS4Duw3FhX0cqziJytEDBAQoyd6noNqd8/6wUHighHXfOnXfYVXEFbENmtLBivuBK/4kU04@vger.kernel.org, AJvYcCVRgZFbSObHHI+JqZKSV3UhoFKVVJjn9xrRxbhu943xEdeVEMzxHlJNwv2dSWD+HWGAH7/JJOVGSniS+x4A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fQdEJPHzDblypFMxamcEpzZ9/Jqr+cDR/kTIXjL7puq9/X8U
	aaQaGO07pfvYcr+WArBRdd7qpdzK7GTG6+b1kaRpds4cKCtrvz76
X-Gm-Gg: ASbGncvXNpkF9TINoYMz7p9Taw9BF9R7xubnrRddZdz8folpY37QZV7a2HEAqr46KBk
	XkX69zOWbh7WeGM08R6YCL8UYvmb/nBd9x3uG8eTYfTFqCODeRqbXue6ieJCdTQpS6aBNn8XaEM
	8qQANEgThlmoyiqHcnw2nbodCDNamTfsgwBmqr4w+eLqBoxtp0CEb21Lrl0nG69uDw5q7Wi+wsI
	RTqxQk2qSrKD5n+idVeBsOHDemgNnpd9pgfnjUR1X0mfmFryy8wShoERh6Xo0kGfVidbNb8zeSM
	wvMV3biOZhymQFWYV2EEp10it4h5yGiRDZBnRAkplZ6Q1KCc8TONMJCztxY=
X-Google-Smtp-Source: AGHT+IHsNdJio93TUUQuuVszdKxDBeN+WTH8Nu14hhRcz1T3hDHUrcxy/TLbT3i9z613UzbZ3f7PhA==
X-Received: by 2002:a17:907:3f1f:b0:ac7:cc21:48f9 with SMTP id a640c23a62f3a-acb4289126amr341414766b.5.1744841794321;
        Wed, 16 Apr 2025 15:16:34 -0700 (PDT)
Received: from f.. (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128c9esm194762866b.108.2025.04.16.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:16:33 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] two nits for path lookup
Date: Thu, 17 Apr 2025 00:16:24 +0200
Message-ID: <20250416221626.2710239-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

since path looku is being looked at, two extra nits from me:

1. some trivial jump avoidance in inode_permission()

2. but more importantly avoiding a memory access which is most likely a
cache miss when descending into devcgroup_inode_permission()

the file seems to have no maintainer fwiw

anyhow I'm confident the way forward is to add IOP_FAST_MAY_EXEC (or
similar) to elide inode_permission() in the common case to begin with.
There are quite a few branches which straight up don't need execute.
On top of that btrfs has a permission hook only to check for MAY_WRITE,
which in case of path lookup is not set. With the above flag the call
will be avoided.

Mateusz Guzik (2):
  fs: touch up predicts in inode_permission()
  device_cgroup: avoid access to ->i_rdev in the common case in
    devcgroup_inode_permission()

 fs/namei.c                    | 10 +++++-----
 include/linux/device_cgroup.h |  7 ++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.48.1



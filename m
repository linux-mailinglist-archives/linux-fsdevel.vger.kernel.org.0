Return-Path: <linux-fsdevel+bounces-45151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC1A737A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE60188E668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAC1AE01C;
	Thu, 27 Mar 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrZu7i0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660E14AA9;
	Thu, 27 Mar 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094902; cv=none; b=RY0gn8Jmzsxz27I2HIIMNVBEkox2mjUJAv/VMM2gA2wsK9IuZGi770KJxeg2S3J8lBxC8b0BKEl2vWab2sIUqP8vElVr8MSCHG2yvUEO+tktutWqdc4IOCY428qlODUE7xHxG87DirX7Z9FLa56mxeOPxTjAcGgatun7BN74pXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094902; c=relaxed/simple;
	bh=yDp5v2+EtKv7vIooGT7aK2o6WBhVIV8zl9ZQR/gjQiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+4CBxCo4DQeNLC6gLiye+VHNKt/RkoGBtrgGB+5CqMx1ZcVkMuxq/wPf/4/QOMuWuhZXhNXAN8Vn4xQGGVAoH5ARBXLNssPrPcFcE4lsekvh3QbGj87tgrWHLV/Rrs2sNW7WgoUEYUS0oxQ7aDtieirCqbs1kGtCSQjAaIGYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrZu7i0y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301302a328bso2172671a91.2;
        Thu, 27 Mar 2025 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743094899; x=1743699699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ro7wdwaqUs2f5wAR7wtoF+lx+yF3AkxnaK0zSEVn14o=;
        b=VrZu7i0ygBtabUr4T7u/PGEU8KhWie4xlvMEP6Z2PXL8yEKCsTwo8kAC3Z0xHrpYoz
         dtJyMGZLe3CQL2v1yktp32cyISQIjAvfwbnHhiMMYPXMuEl+/rZvM6+zBfM4lm+qnqSA
         BV2/CZCrQO6zA9OAHXcSiB83FNOnz5VjKZfDTuE+zM97nL7Irrm2JS89nDDIFZA26lG1
         WahtsaT++7zpcY3rYyu1Z8/Xp3fJTe+bOutKMO+bNH5WHLuhxFD3cpkwm5P96+vDvfI2
         eFbdur31Kbq+qkDHn7Ut6QJIijx75RBxg36TchgWo62Yp0PEvDjNPPZyYtdM2Z6UxRgI
         Gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094899; x=1743699699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro7wdwaqUs2f5wAR7wtoF+lx+yF3AkxnaK0zSEVn14o=;
        b=ilssSQhvnK659GMzaqhuQ49HUUn61D8CPmu566hRcFNPRqJqD4NqEL75QIrljD0h0V
         Ai9CMWLmeYtaG8I3Webd22brJVWB9Dr9x4eXT51XjtgwuLMuW2DVqKffKmP8s9y7GfvM
         qDM0PBgngMS8cj2hrLBDPr9k+SvwU8jlLn/xcL6tjx5D0WBiRUW3ovU07Vi3sF7M01n4
         sXdRhAzbVNHJ8M24H2CAiakSJqCX+ro4rOdGqTCxCH4bDuy783eN/q+oikldbMW+6xNJ
         FGGemeBKP7XD2vYxlH2rJns5m9qfQIWqC63bYm37WkVlSWdVgJdLTePLJ83+OReeavEv
         EYqA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDCZWmlM6CG1piIkg1uOW2QUEhsbGzdQK9bwYxJkhl5jzqXOOzyHYeoYV/+vwPOV5iF+otujj8Q/1i7jG@vger.kernel.org, AJvYcCXXKQWZkqNBqMS5IG5Jof44NN2xG1XC+BqEu7CGoPhymjubZ8AFcT43UeGJbdHSRNqVe6JpWzex+5Za@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCvbIqvt4ksKyc1n5MzMSDoLEk8dXURqLqtgS9xPQeKGBZ4gN
	HufreyNJe4tsf3dMW+GKOWoRbHgy0BZv3ySJBeu9p+xMmEOnBwytH1zu6ob6
X-Gm-Gg: ASbGncsHcdYkMLczXC3WE81EzQKg2rI3fQ6UsjxxUlPqkSjIsyfnfLZ3k4xUG2o04bW
	PDhhDW/S3n0J0GudHvetv2FahrAQuW/JKf+LSUURPA2qsO8iEprH51b4G8WnH5FdNqAKu1gCwcK
	Kk5x2VtXTEM1uPwO29/C4Nl9Ad4frXo1lLbPUAnzjUDHHyn8OyRIArqjrxvbjbcdXlHFj5iXyEg
	QHj85S/DlLlISdc7QMAbZoip0+dm0QDmbRMQj8IfuuYDg9tqmp8rBmdibBCcsdWgnPh1iOPlypp
	RaIxFWRVjY+GcWMRs3xY6ipTsQhilgjdcgjBBJhAcci/PXN4unCaquRGz1i4Jw==
X-Google-Smtp-Source: AGHT+IHQM/Pp/PibTbh/PCo5gLJC81Gdm5sJP68OC1Cj7UsrJA+UFQlDiFaPCECD9hR0PiABxPXOrQ==
X-Received: by 2002:a17:90b:3eca:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-303a7c5a48amr6562193a91.4.1743094899030;
        Thu, 27 Mar 2025 10:01:39 -0700 (PDT)
Received: from localhost.localdomain ([129.126.185.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df4acsm1860195ad.199.2025.03.27.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:01:38 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org,
	djwong@kernel.org,
	dchinner@redhat.com,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	linux-ext4@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] iomap: Fix conflicting values of iomap flags
Date: Fri, 28 Mar 2025 01:01:19 +0800
Message-ID: <20250327170119.61045-1-ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMAP_F_ATOMIC_BIO mistakenly took the same value as of IOMAP_F_SIZE_CHANGED
in patch '370a6de7651b ("iomap: rework IOMAP atomic flags")'.
Let's fix this and let's also create some more space for filesystem reported
flags to avoid this in future. This patch makes the core iomap flags to start
from bit 15, moving downwards. Note that "flags" member within struct iomap
is of type u16.

Fixes: 370a6de7651b ("iomap: rework IOMAP atomic flags")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/iomap.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 02fe001feebbd4..68416b135151d7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -78,6 +78,11 @@ struct vm_fault;
 #define IOMAP_F_ANON_WRITE	(1U << 7)
 #define IOMAP_F_ATOMIC_BIO	(1U << 8)

+/*
+ * Flag reserved for file system specific usage
+ */
+#define IOMAP_F_PRIVATE		(1U << 12)
+
 /*
  * Flags set by the core iomap code during operations:
  *
@@ -88,14 +93,8 @@ struct vm_fault;
  * range it covers needs to be remapped by the high level before the operation
  * can proceed.
  */
-#define IOMAP_F_SIZE_CHANGED	(1U << 8)
-#define IOMAP_F_STALE		(1U << 9)
-
-/*
- * Flags from 0x1000 up are for file system specific usage:
- */
-#define IOMAP_F_PRIVATE		(1U << 12)
-
+#define IOMAP_F_SIZE_CHANGED	(1U << 14)
+#define IOMAP_F_STALE		(1U << 15)

 /*
  * Magic value for addr:


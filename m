Return-Path: <linux-fsdevel+bounces-20069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38988CDA0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451C5B21238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348BE82885;
	Thu, 23 May 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FSVBIdPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEB7604F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489386; cv=none; b=gtgJfrMUjviUW4IxNQQCQsw7H2cLBZhaKlebl6WwcN0LdbHweke/1X0u7GYioCU4JTB8QkZvwsiHL8xlR1RwXSELfYR2qdG6fZWvGMqw/mvAlgzH72Gr/uOP9jNAmeBnyLnn3zqs6cs4TMqBFJzHW2sVzkQL9pkoJFP4iBLg7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489386; c=relaxed/simple;
	bh=OgXMrbQw5esj3pNjQhcGzhpumWC39Xp2gTHLG8/BMdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8QuIAHdqzWYPyZd2KQz/ljYO6pX/e8J/PD45KiZNA/s5Ac8Qw2sCJVTh3dYB/N+TpMyRDm1WzlHgl+Qr7pd9Joax6Z66YNdFfBFvSMuZWOr1g4sqKRWs1xHJIia2K/EMQt9e4sTuxnb3rV8RNOG0xvAjIXOLlJFeLBwxec4Qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FSVBIdPu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f449ed4b89so91455ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716489384; x=1717094184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz+q3u/Fp0102KdTBvg4J3ovItadDXTAdO5aV1qWmSo=;
        b=FSVBIdPuRIIL4vrbmVyp1D/Mb9Jh1aH/4h4pDNRlKAHY+OqlEZmsg4a869XIhDS0yz
         Vhkm5mHaBgBDKjMMCShDO5ONlZY0cIvoD4+RFXHAT8wOgb0gI5xEE86ZjXDTiJgOAYJq
         FTG6Ncp4tC6LbOs5ql361CqAWIyy1wjeuxS3ZcalgOF67z+wjnb1gHKWw6C6/8UmZhwV
         u8xUWlEW/3CdtEjaR5GPKu0Hc8r1BjEnE2btsz7Y8+OIwpCde3cYq0qbFjfnHMZnRicK
         9BgxPqoFBF1XBmE1L/LHFxjMX40ZLZ47FXDdjVui/OJa+nZTutkYkQlW7DPQzFw5UjmB
         hbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489384; x=1717094184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz+q3u/Fp0102KdTBvg4J3ovItadDXTAdO5aV1qWmSo=;
        b=VyvZOw4mv3rTb5+xZst1HhomUJIq4FgoDGk2NaCL8DNN5LlmA9O61YQNnsMcMRLju+
         UFlwtyye3lSAZznWCCSx9LoT1cgrdaOAo1w05hXSySSasno+TRd4WiD42FODAWXo62oK
         mbyk9Jlf+GyKIJ+HOr+srnqP4NYAuOuZzGyOSsQ3EUqMy9+9ebovT23k1xvDG0rJFCgW
         BocjpBaDHsP8zkg6nnm4cbcpDmMRHbV9fkAUvkhaksisfyg1A1uaJK7uHBhMrmr9s5/q
         nDPms4jefpnfyuokgYkZsYq0nuB4ImeTYNflqZrBBdC+FZxLLe05JwbjkBGoiFD8JNb3
         NNUg==
X-Forwarded-Encrypted: i=1; AJvYcCWk4x2edGTy2sL4PlbiU+NUiAEw0TSibAjk+jr/YR8hYo2/Kr/XDHy9zCyCKH4B0YvMxrbPN+1pkkvNnuUxnbfT5t7U8hzDEY0Yekw/CQ==
X-Gm-Message-State: AOJu0YygRTa/LnARVsbb0XTamxZxdh1xc7E9hRO1Hfqk1aiGpOga40sX
	dzf40szt0mW0SNezZEP+dl3MZDGYfshBECQ3Asod4JJyLNV53u6fa20QH3fCNlM=
X-Google-Smtp-Source: AGHT+IFUTsvXDTrQxXlh03uhTPfPZ/be+kqFgGy/t90jRL6U9LRtWnJ8XOVcA+NlDeCpNMF8onOypQ==
X-Received: by 2002:a17:902:6505:b0:1f3:2f9c:bb72 with SMTP id d9443c01a7336-1f448125a9bmr3155455ad.5.1716489384110;
        Thu, 23 May 2024 11:36:24 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f303b062e5sm71161015ad.219.2024.05.23.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:36:23 -0700 (PDT)
From: Yuanyuan Zhong <yzhong@purestorage.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after getting mmap_lock again
Date: Thu, 23 May 2024 12:35:31 -0600
Message-Id: <20240523183531.2535436-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After switching smaps_rollup to use VMA iterator, searching for next
entry is part of the condition expression of the do-while loop. So the
current VMA needs to be addressed before the continue statement.

Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 fs/proc/task_mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e5a5f015ff03..f8d35f993fe5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -970,12 +970,17 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 				break;
 
 			/* Case 1 and 2 above */
-			if (vma->vm_start >= last_vma_end)
+			if (vma->vm_start >= last_vma_end) {
+				smap_gather_stats(vma, &mss, 0);
+				last_vma_end = vma->vm_end;
 				continue;
+			}
 
 			/* Case 4 above */
-			if (vma->vm_end > last_vma_end)
+			if (vma->vm_end > last_vma_end) {
 				smap_gather_stats(vma, &mss, last_vma_end);
+				last_vma_end = vma->vm_end;
+			}
 		}
 	} for_each_vma(vmi, vma);
 
-- 
2.34.1



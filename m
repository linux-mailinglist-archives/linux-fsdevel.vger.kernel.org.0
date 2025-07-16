Return-Path: <linux-fsdevel+bounces-55073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69993B06BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 04:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E92B4E0B6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8C2741BC;
	Wed, 16 Jul 2025 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IeMCllql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CC2E36EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632945; cv=none; b=ap5+Lq28ufSClaoMVuh8y4JI9/zFVwvhDFlD9wGIs1mn7EodLjeJ7n+IeMJjFFgOg7UaQuOf3hYY70vR/JBpVauam7l8i6+r8jDZo7HA/3EUGVn9UhYiBEvmYiGGX3RwSkxrMTvb3OFG9LOD3OXIolLTO9533Fymei5Lx3c5sF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632945; c=relaxed/simple;
	bh=Rx9lx9nORelD5PV7XRAOqXfbpi4d6SUVq+sXc9n6vyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/l6WRRhkplZ2GbYZKcQ8dJ5X3XyybLQPFW6ZUVVr1n/mAD7ScZY35cwNUHBdlbd8joaxRzMKTsY+b/IhfVF1Te9iJMFGQRn0zZkZ/UHf2HDA9UgUM0cRl0AEM7/YYtXInyZrA16Ulmct8CnV8dzHjIencjy/ZpuHNM6fPLS/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IeMCllql; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso4071256f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752632942; x=1753237742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jA7bVHBDl7lZeH0Kulb7fhZoFjiX1X5WAhHQRlN6e0U=;
        b=IeMCllqlaeAWEj67QEF7z1O+dQ3eStfM2hMvviw7zT+s9APXMzUp9QqU2NkhokBRJD
         C3KTf9oIMS+7z5BiNOchpChSc2gzAAyIL3TQsoMncx+nEmJbvp7sEGUEe6YBVJInehRa
         SRWuKwRL+9XypScYlGKl6rnAUU5lMmFtNgvjveD2MtRUqFcb+NeQyyCS35rKBEkEyvI8
         2ouK2TA92yTyYi6ZjHGpthvitV4XuWz/+e8HpoGcrb8kc2BGaFgMEhbVQzZkzv/sXlVF
         iB2gejKABrBG5x2xyJ0/trb1AzUGjE6XpGCFCbgwp3Z1C9mpc3gtzxvD9wBSCJYb/Ic/
         XrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632942; x=1753237742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA7bVHBDl7lZeH0Kulb7fhZoFjiX1X5WAhHQRlN6e0U=;
        b=FMg33rBKE1HmfhtL/ospWpDYwcIB7kg47y+fgIBgY56WJypWKuJl6LZjuY3acc8uiL
         TTFbR1qJTk5YnxI3Qz8YRLcV6R+FKXCfcwdzTuN8JSHOcFr9bGhZ19+tvP4DXxm9u10I
         tKdIleFMfU7BZxQRcbO0wsMidEM3c0IFjmuddE5L9H3fWOmscN57TCjh1nA8pye8Eh5J
         jpv3XOdcZ3PsjREWIo3V4ntr6BIJ4vA3BlJt4KdfFPq1rOqub8ziz2WYv4nTKZe4y8DY
         0g537g3s97IY+k62beoVKpZF/b2GyJBNeVuOIIktkrK7lNJkVFl6eStBZignaagmR9PP
         1Slg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1P2fRD0v/2+JZMPs/1n1U95ox8WuduKsIHT3b/SpoCkQLJ2dtwlMRpQgSXbI6PUXnXFrGJx843Y5EOvz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3OpzAke4ki3Ot1UnJdS0hP/KSt4xyNBSe77zEuqU+z2Xp9nd
	f83uWdgISWJy2vVX0x6Z8xBRNfaWaHqFIoKBO3ZI6CUE4el2gzL69CaKZmmub7FGng==
X-Gm-Gg: ASbGncvEgPtAjwKw7e2zHPoFoRfzbaGFxINfhkE9dr73uKaCBmWpFLLkJQ77jGvtg8N
	Kqeyj1BHOVaCOeEh7P625P63y6dG5v1oUxpQMIWQNMSQntP+65ylj5prOVL6HimpGwThSlYnNF3
	DRTHXAt8cGvClzOOq1Rf1oF9A7gqGIUUPXV9MpJ1g6RBcWA5QFBePaKV5sKoMI1+y6LZhJZZn9Q
	CZRAcLfaYA4f4eJXp1eF/3r8Zl+zhHU07sXB1+J1bSqqMNCGeApQh67X9VFarY6a6L+HoxIi5KD
	+5CrnhL1SF2GeuaBQaLVQBF2FSQGDIQ5WogcOpNnnpz8lUAq430bSZTgKrGv/ykcy0KoEgZHIMF
	hpzldMuNgxuNFjBB7MQ2hqg==
X-Google-Smtp-Source: AGHT+IGyZOlJ6GVbM16Oi7b0A77QcotsLORCLOMXfAHS/yz3ykj/EfN2iHEfWPRF+qrE8N9RROAwKw==
X-Received: by 2002:a05:6000:2286:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b60e53ef79mr463305f8f.55.1752632941997;
        Tue, 15 Jul 2025 19:29:01 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42aeadcsm117851795ad.78.2025.07.15.19.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 19:29:01 -0700 (PDT)
From: Wei Gao <wegao@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	Andrei Vagin <avagin@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Wei Gao <wegao@suse.com>
Subject: [PATCH] fs/proc: Use inode_get_dev() for device numbers in procmap_query
Date: Wed, 16 Jul 2025 10:27:32 -0400
Message-ID: <20250716142732.3385310-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures consistency and proper abstraction when accessing device
information associated with an inode.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751479eb128f..b113a274f814 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -518,8 +518,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 		const struct inode *inode = file_user_inode(vma->vm_file);
 
 		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
-		karg.dev_major = MAJOR(inode->i_sb->s_dev);
-		karg.dev_minor = MINOR(inode->i_sb->s_dev);
+		karg.dev_major = MAJOR(inode_get_dev(inode));
+		karg.dev_minor = MINOR(inode_get_dev(inode));
 		karg.inode = inode->i_ino;
 	} else {
 		karg.vma_offset = 0;
-- 
2.49.0



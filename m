Return-Path: <linux-fsdevel+bounces-58016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB425B280FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB11AE7A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D280305E27;
	Fri, 15 Aug 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHnn9gXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F330497F;
	Fri, 15 Aug 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266163; cv=none; b=hZW1Pm9dbD15KPOV9nmXbudBR7E0uqA3QrZLgZ8e2n1FhcoMSb1Tc24dedkKKQE1i3pGFrs100zekp2TNePGtczkW/WSltnznuSH436+3a5/V1VewemvdqH6LjYQ7LCRQ5ahZhzXf8JVB7cmCOJM35hcYVJVLbvJsN4t56UhBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266163; c=relaxed/simple;
	bh=+aC8tuxth/3ftzMsKGRiTm7dbkZ167G+8GUSLlXDjmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcJLhGPgPYiceNu7rUjc0sBjC7XKqYScIyqxqXcDm0FvDrrNkPSiSpMDhj46BlPm4xwI3n51sl2Yp3qGSQBuva1pwJGjog23+rs+gDZT3di/ZjmWNYL23mTmvxzyEge7M/zA+qTKtR/xPyrZl9jFrB6zwJF8DoAOcHwRhhOlbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHnn9gXY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109919a09so25629961cf.0;
        Fri, 15 Aug 2025 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266161; x=1755870961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htOuw1jckUm3cFOQCy2Ez0sym5NjcBkm+jIoTXRQCgk=;
        b=KHnn9gXYPTVSMjYVnMApEgnAs2Y+UC6Bz045BRy9QJ02oa0ptX9p81ComlfkugnEtb
         5F0VHblHPJb7oulmLHiM/Q1RVNWJOpboiJ9qfCT4cU07P3oADUowNQBu5Na9l9Si7wSQ
         TfBzUrx/+pVdO03QqZsV9aEZKjcdbS1YeoV0EDQQod3oTtakWxGuI2byTXccfcHH+zp8
         dqVXiEeQcR+7LePQq+hgaiVguQmv9tOlBkzsxyWQlYeuw34bnuo9LUGL5zy0j5kXRO4x
         0D1KA3tZGh6C14m2ESB+PxZ59rHTGjw9GOXHXWAid8BqgTXFCvtSq7v9exQM5+JJ+Jlf
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266161; x=1755870961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htOuw1jckUm3cFOQCy2Ez0sym5NjcBkm+jIoTXRQCgk=;
        b=wW2VKHx8d8lyAVTkEmYjfxqpRk0M0AACapt2+Ry99BgGAc0v0t6PLyoMPe3H3SQBlq
         J3rtLvMLmA3Yut87sGdJr/eMPSWWLh5rEK8VAOwbmUbzb+dlM3lklls1ifZC+CjIHx3G
         g7lzL89iP2CO3PzAVTPV3kC6z1oTfb4D7wD6Fj5CF0hMUAUgYVza28flPtW1Hyn6ZzuI
         ZhXj+NiabPiqJJ6vzwyDnvesblOMMWc3Wsw5hJkZQyzbGd3A49yGyFFcrD8nj20w3zam
         bRDgitOREQ6nfS9uS8aWzgwKkQjXEu2Q9Da0UIEO3iuaDUqpLg49Sf99cxGvBotWC+0Y
         3NsA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNlpl4x/q9D7hB4harZcRLlVP8Q7k0Fnm9rssnYoe3ZmOY9czubq/xkVR+FRMUr+sjL6EqW0hKbPE6GrF@vger.kernel.org, AJvYcCWnBwW/U5GOryfizVXASZ+l5VCbkU/uKSrfB74atqVomk2RUwbKiBZD7P3OQRjV8ITSxsC3rsfMXmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9FJfovdwj5zr/VWB9wjP3nMxqnhjzWc/AwO/C/Il7QWQCN29
	qauC20yPs9/ck2N41UQljwQx3dUOfoZcUq4U8pzRtcNxSE3LY/9bosr5
X-Gm-Gg: ASbGncuzUGEFilfE081lGZ6qJ3nV5lV30o06nIxoKAzicnjX/X+M0Y7nA704rg1B/JS
	6JLCFta/ZoFfhClK5mgJy70gjyQ9qvGtGEgjofvTV4fRkL3lyxm7ZTNfAtcXz3bXP2T7s9jbKm/
	rNfA2MfP6/hySZ0o26e4fwuH1kxIApz1cV3rA8ogM7Fg/zfRHyRMcb4lfQEFxLH7oB0Si8YuEHv
	lDA3hIa4Cz9DEP0REuV3871mg98hVjE7u1c9hUfsDMHZsT5aFv1kuw6ZzhIKawRXP2n+1P2judd
	O18Nqfkw9bFNkoC01N8PGC+FGxxsRMuGdom/8eZPoYPiLFpQpPo1ldlnZUzxCNYCloSoF5Y5+1l
	auIOpmvj4tkoMkgsx7Z2V
X-Google-Smtp-Source: AGHT+IFA5ocU0t0P6Vd1e5Jiomncb95U626f/HquasQ6giNUDflHW0b1pvVh3BD+6pcW5GWRqf2ajg==
X-Received: by 2002:ac8:57d0:0:b0:4b0:89c2:68e0 with SMTP id d75a77b69052e-4b11e2c638cmr30410701cf.60.1755266160836;
        Fri, 15 Aug 2025 06:56:00 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de55b61sm9255701cf.56.2025.08.15.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:56:00 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 4/7] docs: transhuge: document process level THP controls
Date: Fri, 15 Aug 2025 14:54:56 +0100
Message-ID: <20250815135549.130506-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250815135549.130506-1-usamaarif642@gmail.com>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
flag for the PR_SET_THP_DISABLE prctl call.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 370fba1134606..a16a04841b960 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -225,6 +225,42 @@ to "always" or "madvise"), and it'll be automatically shutdown when
 PMD-sized THP is disabled (when both the per-size anon control and the
 top-level control are "never")
 
+process THP controls
+--------------------
+
+A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
+and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. The THP behaviour set using
+``PR_SET_THP_DISABLE`` is inherited across fork(2) and execve(2). These calls
+support the following arguments::
+
+	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
+		This will disable THPs completely for the process, irrespective
+		of global THP controls or madvise(..., MADV_COLLAPSE) being used.
+
+	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
+		This will disable THPs for the process except when the usage of THPs is
+		advised. Consequently, THPs will only be used when:
+		- Global THP controls are set to "always" or "madvise" and
+		  madvise(..., MADV_HUGEPAGE) or madvise(..., MADV_COLLAPSE) is used.
+		- Global THP controls are set to "never" and madvise(..., MADV_COLLAPSE)
+		  is used. This is the same behavior as if THPs would not be disabled on
+		  a process level.
+		Note that MADV_COLLAPSE is currently always rejected if
+		madvise(..., MADV_NOHUGEPAGE) is set on an area.
+
+	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
+		This will re-enable THPs for the process, as if they were never disabled.
+		Whether THPs will actually be used depends on global THP controls and
+		madvise() calls.
+
+	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
+		This returns a value whose bits indicate how THP-disable is configured:
+		Bits
+		 1 0  Value  Description
+		|0|0|   0    No THP-disable behaviour specified.
+		|0|1|   1    THP is entirely disabled for this process.
+		|1|1|   3    THP-except-advised mode is set for this process.
+
 Khugepaged controls
 -------------------
 
-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-45416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BFA7753D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16A73A6290
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC91E990E;
	Tue,  1 Apr 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L48RJ2KA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD01E835B;
	Tue,  1 Apr 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492655; cv=none; b=LVoGzw2DqSYhzEP8TCEsrrZpgLy9RQuMs7CWN+b+jlTENc9UdMmmwJzS5n545cyKPZUE+ADBibVUda25tQc2cD+DsJBpm3eELk/eVzDCrIVVTN4Q0uN7CBpUwoP924pmK2p2+xvPvBAcOZ0da3+rWfUuN0Ed6Ayfb6iM7ZV76qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492655; c=relaxed/simple;
	bh=U3HHCQTR4hsEPk4ft8i9Vq9tidtv/Ppf9J+q8Rxeg2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A//GXGRrcIe29UaP83BAxFhp75TsB2STHK2uqphX2w881u307zpGhbUB63AMgrF9932IZmJcivvh+ZuFlUZSOMxsk2D84MWyRrc4xytAsN+dblp3XEmtBMuw1ghxDu1aT1TwSKEh+BuHD6SMMt7PsTL50Ka2y7fBT4MTcPlhCvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L48RJ2KA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225df540edcso115155395ad.0;
        Tue, 01 Apr 2025 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743492653; x=1744097453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qzhK3OhtT1lPNTdi+fIJEPhQ6dJQGnicgcdnXsHADg=;
        b=L48RJ2KAG/qyRYIUWQMpGTTw1WDwi0o+o6eCyKVLLnlKR/pKA0D3dfu2EKCd9HXi6Q
         xwVYYwyiXfSuaQBkJrO/oFqsmn4oxDWFu1GfpI91b3UFiG3chLdCBfRHgeLeAfgo8ouY
         CfD72W0ecexyFIYiWvp9tYJlUZidsNrA6lDRRdEgvUhG2g5+duwLVmaBgtk7Hjq08ytR
         x3d3003xtT27W/y9Fi9PhlaHlGHyZE8cfscYyRMbRuY5anKrdsebDRQpUVxWkbQN1Y61
         TGIN/jh91BHQfl13od1itVcrRDGDxzn0kyCZs/Rq0MEXg6H4BZRyUrGq/CocfXYLzlIq
         4+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743492653; x=1744097453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qzhK3OhtT1lPNTdi+fIJEPhQ6dJQGnicgcdnXsHADg=;
        b=S094NQh7c65evdjZGcwZo+Qhc8VDua7H7WybS9HprmGX+oDJ0GQUfvyShR65wevaGD
         ZUbHm3eBlLef18Vcl559GeGdapZlGiCSRDt2utNsH1b8xZoGrNSbi1IkTXeSpwTFYa3t
         s7QpekIN0wqDqqEZOXnBKR22RBLi+LBxP8nGmC4bSZVMv5LO9kYvXhNwPWVM3N+akn4k
         dcMbH9QzRAR+keObuM9hMO3sb987+BoMH0xRyRNY79s5r23JJUSM58YUt7zyFtrsqF6K
         0Hqh2TdSX1J/cE5Gla+HywLcXDja8LBXGtc9AfQoYOQHE14TSv7TnCkWi/l6mlK6EPbh
         /FKg==
X-Forwarded-Encrypted: i=1; AJvYcCXxuS2UrCApBtRPQDMZwkkV7TDu3wMo4+NwxM5qWkrTxDr6W20rhGtLfgWyaDIdNb69XHC3dzXFO7fRTrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Vv8smk1zILnXC9CaMNtwYkAzoclyrj+yeIJzglVvNWb9ZBkJ
	V1VWUzmBQuohqwFf1YQEmHmWTXIYMEteMJzc3rQCe3WioJu+UJjg
X-Gm-Gg: ASbGncv6VV9NMDpVVUh5xnFCpQqjGsLkQrrbherccU/WSex0fZ0UQaoZ9mFrovcqvsn
	IoDNShS8TnYNieZ+wc3CdjVKghr6CvqfY0PTosodwim8QEtetHakrO+Zpk8Cd42R6ibE7PkpCZm
	YOGWseT5qF/hKAvhv/19IONvtAY1niCXoyz2L1M8Mh7CCZ0I+CLwexoJQ6HjAD0d1dEwtA2XhEF
	BdpPYqEGj5lKpRy57hLbxOILEOtyYdh+7rX19jF99IfLcwdYDkHni0eVZmIKfuxvEnnXkuPL+3Y
	IGCaBgQ5IfPqCJzNAw4H04EFMxu4zCXz3GG3YTUTKe0RZfBvm61b2EDKXNmKUMTFWe+OOQ==
X-Google-Smtp-Source: AGHT+IFmoS/GQNWnKp0MwWOQjYKYWnfkhrisxxDx/k0nzODl/eQ/MI6IbCR0Wj7VB4nySIDL3wnI4A==
X-Received: by 2002:a05:6a00:1411:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-7397f369998mr17601420b3a.6.1743492653237;
        Tue, 01 Apr 2025 00:30:53 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106856bsm8416888b3a.105.2025.04.01.00.30.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Apr 2025 00:30:52 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: kees@kernel.org,
	joel.granados@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] proc: Avoid costly high-order page allocations when reading proc files
Date: Tue,  1 Apr 2025 15:30:46 +0800
Message-Id: <20250401073046.51121-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating a kcompactd 100% CPU utilization issue in production, I
observed frequent costly high-order (order-6) page allocations triggered by
proc file reads from monitoring tools. This can be reproduced with a simple
test case:

  fd = open(PROC_FILE, O_RDONLY);
  size = read(fd, buff, 256KB);
  close(fd);

Although we should modify the monitoring tools to use smaller buffer sizes,
we should also enhance the kernel to prevent these expensive high-order
allocations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 fs/proc/proc_sysctl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..c53ba733bda5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	error = -ENOMEM;
 	if (count >= KMALLOC_MAX_SIZE)
 		goto out;
-	kbuf = kvzalloc(count + 1, GFP_KERNEL);
+
+	/*
+	 * Use vmalloc if the count is too large to avoid costly high-order page
+	 * allocations.
+	 */
+	if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		kbuf = kvzalloc(count + 1, GFP_KERNEL);
+	else
+		kbuf = vmalloc(count + 1);
 	if (!kbuf)
 		goto out;
 
-- 
2.43.5



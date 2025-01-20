Return-Path: <linux-fsdevel+bounces-39691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EBA16F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B77E3A4653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F51E9904;
	Mon, 20 Jan 2025 15:47:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2771E98F9;
	Mon, 20 Jan 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388026; cv=none; b=GpXjFW7vBlmh529cVyW/p9N3pROWQbw3MwihjifUYNutR++GXtaNf3CRUjovf9idV2Bz06+CgKAuKJ0U5JfZTL/VamqenpTJCJy+DJzaBHqnxRsLmnuHV0aEYHix2avkYS5qo1yP5fGNTdiXW2ZtL9gfirgk+b2nAuos+mhicMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388026; c=relaxed/simple;
	bh=oCZTR3cwI0mWDZH/1tfsYDB4/1yx6sPjG3WKSht1uv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUAk/rXrh/wu5D11/E5AfnH/GncJKuNaQkAa02/1yZKwby8uOR8h+eZk+GWEaZUd7AnB0PdsLADidOV+VWCIBjpKOYNjqttQFhh5PZwrQcxedK85w9VjkOsPehBTB2bVYQwJ1ndhvzbwVRMjLX/8DSMWi7zP+XiKfXTEnTyyv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [220.197.236.33])
	by APP-03 (Coremail) with SMTP id rQCowABHTlrsb45n6dNsCA--.50150S2;
	Mon, 20 Jan 2025 23:46:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: "Darrick J . Wong" <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] xfs: Add error handling for xfs_reflink_cancel_cow_range
Date: Mon, 20 Jan 2025 23:46:24 +0800
Message-ID: <20250120154624.1658-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTlrsb45n6dNsCA--.50150S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW3Kw4fZF18tw1rWw1kAFb_yoWDtFX_Aa
	10gw10gw17Xr9rCws8Awn0yF1vkw4vkFn3Zr4IyFsxt348J3Z8JrWvyFW8Cr4rGwn09F95
	Jr4Ivrs3tFyfAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkIA2eOHwOwYAAAsg

In xfs_inactive(), xfs_reflink_cancel_cow_range() is called
without error handling, risking unnoticed failures and
inconsistent behavior compared to other parts of the code.

Fix this issue by adding an error handling for the
xfs_reflink_cancel_cow_range(), improving code robustness.

Fixes: 6231848c3aa5 ("xfs: check for cow blocks before trying to clear them")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/xfs/xfs_inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c8ad2606f928..1ff514b6c035 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1404,8 +1404,11 @@ xfs_inactive(
 		goto out;
 
 	/* Try to clean out the cow blocks if there are any. */
-	if (xfs_inode_has_cow_data(ip))
-		xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+	if (xfs_inode_has_cow_data(ip)) {
+		error = xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+		if (error)
+			goto out;
+	}
 
 	if (VFS_I(ip)->i_nlink != 0) {
 		/*
-- 
2.42.0.windows.2



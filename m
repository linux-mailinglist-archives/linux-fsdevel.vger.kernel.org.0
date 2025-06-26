Return-Path: <linux-fsdevel+bounces-53078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7EAE9BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637625A1BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25A26B761;
	Thu, 26 Jun 2025 10:55:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A7AF326A1AE;
	Thu, 26 Jun 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935310; cv=none; b=lT1fkBK9bhF0NRRz+K2zFcBpQVpP7VmfJq0GBeWJHR+Hg18ZuGis6sx7jXrV6klGwQXD5zg1Ph8Vqye9eMviKxUxs7ucbwe7lmoYhjS/klPzh+lItPLlkfc2bhMpXr/Gjl9RRa/G2KNlXGv2/MKkUjRA4fylA6LC7tVZjXYnegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935310; c=relaxed/simple;
	bh=5dk0wI1bh0HVM00PIbFjraq1e8U1FtyfdlZ87SEHcxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjM/p6ydDCIAchviUoP0Ztu1E/eSC+UvgbPQramCgXGqZNqEybBBprLIoGDbD7AiWgqDSuMwjlNmx5ekKCjAsO5jLVba3DmvqyTeIspXF+0oVQbKq8zQLsCxM+/MoiI0OnLkwRDcNWsC13LSa4VUzDmHDGoDi+JMcRRTvHS3xAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2E0E1604F1A67;
	Thu, 26 Jun 2025 18:54:47 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	dan.carpenter@linaro.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Date: Thu, 26 Jun 2025 18:54:41 +0800
Message-Id: <20250626105440.1053139-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two cleanups for vmcore_add_device_dump(). Return -ENOMEM
directly rather than goto the label to simplify the code. Using
scoped_guard() to simplify the lock/unlock code.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - Remove the wrong change of 'data_size'.
 - Move 'Return 0;' out of the scoped_guard.

v1:
 - https://lore.kernel.org/all/20250623104704.3489471-1-suhui@nfschina.com/

 fs/proc/vmcore.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 10d01eb09c43..f188bd900eb2 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 		return -EINVAL;
 
 	dump = vzalloc(sizeof(*dump));
-	if (!dump) {
-		ret = -ENOMEM;
-		goto out_err;
-	}
+	if (!dump)
+		return -ENOMEM;
 
 	/* Keep size of the buffer page aligned so that it can be mmaped */
 	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
@@ -1519,22 +1517,19 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list and update the elfcore hdr */
-	mutex_lock(&vmcore_mutex);
-	if (vmcore_opened)
-		pr_warn_once("Unexpected adding of device dump\n");
-	if (vmcore_open) {
-		ret = -EBUSY;
-		goto unlock;
-	}
+	scoped_guard(mutex, &vmcore_mutex) {
+		if (vmcore_opened)
+			pr_warn_once("Unexpected adding of device dump\n");
+		if (vmcore_open) {
+			ret = -EBUSY;
+			goto out_err;
+		}
 
-	list_add_tail(&dump->list, &vmcoredd_list);
-	vmcoredd_update_size(data_size);
-	mutex_unlock(&vmcore_mutex);
+		list_add_tail(&dump->list, &vmcoredd_list);
+		vmcoredd_update_size(data_size);
+	}
 	return 0;
 
-unlock:
-	mutex_unlock(&vmcore_mutex);
-
 out_err:
 	vfree(buf);
 	vfree(dump);
-- 
2.30.2



Return-Path: <linux-fsdevel+bounces-52523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A8AAE3D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D916CB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F6239E65;
	Mon, 23 Jun 2025 10:47:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BCB12136988;
	Mon, 23 Jun 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675665; cv=none; b=ZN4BRkW4fHKp/QBG8yIiUYHag3y31/ZRHUz8jgV+6EDIUNTBpsjNop8P0CtEee7JwwlN+aiDY40EZEMZubXIP28Y55F/lSnmRvfVQwnJNx3lcfrIFpWfsniBv8Z9o8U98sfKKzl5kCY6bgrLLUpnYQ+sLungg4Pn+La3kXNYeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675665; c=relaxed/simple;
	bh=yY64zDwdRCY42XgnhSwxhXqXaXXDuygVgFzhpdlOqD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=toLHrg2eUFl9XuEYAAeTcr2TQEHj7D7FkUuXinHJbpQgbvbsxtRiMB1uw5IKQQo4KbsGHkeUux9NhaSiT3lB40CC+psjrouVzYW1SV70u6chCB/97eg/cBVyfpRshHk7JLyNJjuM2UjaM5W0RLnkPthSmgxwhi8JljNzEUzL6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 75C08602FE8D8;
	Mon, 23 Jun 2025 18:47:29 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Date: Mon, 23 Jun 2025 18:47:05 +0800
Message-Id: <20250623104704.3489471-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
type from 'size_t' to 'unsigned int' for the consistency of data->size.
Return -ENOMEM directly rather than goto the label to simplify the code.
Using scoped_guard() to simplify the lock/unlock code.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/proc/vmcore.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 10d01eb09c43..9ac2863c68d8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 {
 	struct vmcoredd_node *dump;
 	void *buf = NULL;
-	size_t data_size;
+	unsigned int data_size;
 	int ret;
 
 	if (vmcoredd_disabled) {
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
@@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list and update the elfcore hdr */
-	mutex_lock(&vmcore_mutex);
-	if (vmcore_opened)
-		pr_warn_once("Unexpected adding of device dump\n");
-	if (vmcore_open) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	list_add_tail(&dump->list, &vmcoredd_list);
-	vmcoredd_update_size(data_size);
-	mutex_unlock(&vmcore_mutex);
-	return 0;
+	scoped_guard(mutex, &vmcore_mutex) {
+		if (vmcore_opened)
+			pr_warn_once("Unexpected adding of device dump\n");
+		if (vmcore_open) {
+			ret = -EBUSY;
+			goto out_err;
+		}
 
-unlock:
-	mutex_unlock(&vmcore_mutex);
+		list_add_tail(&dump->list, &vmcoredd_list);
+		vmcoredd_update_size(data_size);
+		return 0;
+	}
 
 out_err:
 	vfree(buf);
-- 
2.30.2



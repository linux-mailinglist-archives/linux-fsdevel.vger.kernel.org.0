Return-Path: <linux-fsdevel+bounces-10099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDCF847B06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2731F283FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26B12C804;
	Fri,  2 Feb 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uUAHHnSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987812C800;
	Fri,  2 Feb 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907631; cv=none; b=TA/h7cd5i0b+KyqtV+/vHms2j3mEqDpm/5GIMcNHArcVIrRCDtRNVH2fifoU/AlldH8FFEM1VC2ygIsGMIPui7xgyv6k8BXQ7u0YGd4bvvcp3khO9LlHCC9ymc1J7m8k/6uIOLitW5nvY34IVLHHkYDdpBvW2FLCRlAqsaj2C+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907631; c=relaxed/simple;
	bh=NIplNKYnPiSxsRcYozD6/Em7BpOZVdeSTtUJ6fu0NbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMV1HwlhRhtSglYeEZ+l6VAHUkP2eDG+OZUpmAxb1PlnOKBWhCV7wy+V00tq58++KvxJFhsmVkUd1PNccHRscf2zl0DAKUKsagQViJoXnZRmS6JLaTRQ2XXYIS4QCXWJ0VWYouo8IrYdTax/I/UgCPTwVI1Lctn1GPggNPc1Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uUAHHnSH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907628;
	bh=NIplNKYnPiSxsRcYozD6/Em7BpOZVdeSTtUJ6fu0NbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUAHHnSH9qyqiPFbxwBtx0+D9xq4cbcOGLgW4N3moWcT7pudTHalnE5g1pd42JIw1
	 E3TN3gqn3EUKS2dS9BzMQmTDoF+b7/+Qo4cwDn0a2ByIW+HF+RdPmI8Gicr0hw2PC1
	 rvL4NM2lV7/3fJAgKuzVhmtLD4sYUctQymj+dRbaw03MRctwLcGdqytl4bAfkLRnmT
	 4zEaxXtJqlO+Duz6P4JaEGwtf4+/NJP0OjTM0KP4jY3eHJU+9XKKJK07j50wLLNsZI
	 5soy4VlB1L6a0Mfw3iWgCtncLHEZ7CxNE1IQAbBR3d217g1gnazmhpUoUCZ9XrHKcd
	 Qr321w76PHugg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSph2fcvzX4S;
	Fri,  2 Feb 2024 16:00:28 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [RFC PATCH v4 04/12] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
Date: Fri,  2 Feb 2024 16:00:11 -0500
Message-Id: <20240202210019.88022-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
References: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for checking whether the architecture has data cache
aliasing within alloc_dax(), modify the error handling of dcssblk
dcssblk_add_store() to handle alloc_dax() -EOPNOTSUPP failures.

Considering that s390 is not a data cache aliasing architecture,
and considering that DCSSBLK selects DAX, a return value of -EOPNOTSUPP
from alloc_dax() should make dcssblk_add_store() fail.

For the transition, consider that alloc_dax() returning NULL is the
same as returning -EOPNOTSUPP.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/block/dcssblk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 4b7ecd4fd431..a3010849bfed 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -549,6 +549,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	int rc, i, j, num_of_segments;
 	struct dcssblk_dev_info *dev_info;
 	struct segment_info *seg_info, *temp;
+	struct dax_device *dax_dev;
 	char *local_buf;
 	unsigned long seg_byte_size;
 
@@ -677,13 +678,13 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	if (rc)
 		goto put_dev;
 
-	dev_info->dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dev_info->dax_dev)) {
-		rc = PTR_ERR(dev_info->dax_dev);
-		dev_info->dax_dev = NULL;
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR_OR_NULL(dax_dev)) {
+		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;
 		goto put_dev;
 	}
-	set_dax_synchronous(dev_info->dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
 	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
 	if (rc)
 		goto out_dax;
-- 
2.39.2



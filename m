Return-Path: <linux-fsdevel+bounces-11134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B0851986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254D7B210E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83213FE5B;
	Mon, 12 Feb 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Zyy41IcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B63D0DD;
	Mon, 12 Feb 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755468; cv=none; b=tgJ66TlGDzpyT3wNKUS+jjyBwkvno+OpevYCqq7+5OMLWltJuzYovyhjnaCseHLqPP61RYHpLarvTccWUCBiF4yTdc31aK8Z4t7JNO0ncWmAMP8LkYxEKsRg8Xof8gbFhdrjKnuTPLKmWy1T4M5io6aXeLMKj4EQFKiI961kdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755468; c=relaxed/simple;
	bh=I3VS2JL5QdpOumZEunORNSa20I7SphHpfPnc7uZLU3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sV8Hhc+I7YG3Z54Mv/HIjSp9Pfkyar3MPhBxVry1odJjxCHVidPpzzPRAX8Zh9d6ZPZoB/FpJ6fiaI6PWCVbJ1xjyyp5lSCvhx7/Oimb6bUKt1+zjFJFy508wzFO7a/Md4yxOOJdmcAvigzmEDCoMdlOaZNAwCao+1iOmHziKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Zyy41IcN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707755465;
	bh=I3VS2JL5QdpOumZEunORNSa20I7SphHpfPnc7uZLU3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zyy41IcNoqtQbIMqRtQkRf04RF8pHGrvLxtkDunUMa3xLSO7TDS/UTVZLcYlA50F0
	 W1hr+wGMM+ODEVJNO4I89b0Uom5QMH6vetzyPPSevwF0jTDeRAeWyJFGpQqGwx0eWr
	 +nL5vdHpKPv75vPDGb9eGpvPBmp11fTrfr31D6F9z1Z+eosGAw+BFPLxftCWsSy0LT
	 voSfnVGo10xz/kQWoJRH8ILXBsiTAZ/oyHYutOC88YWMjNsXImVaA1M+mXDKeE+dOh
	 zs2AqPHYZ0nsKgPKHRTMA2OXeYdoYlGm8PVTtqi7NNaA7c2CWs7eXGRGoX+ksIqy5D
	 uaViYgjXjXozQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYVMD5XlbzYCW;
	Mon, 12 Feb 2024 11:31:04 -0500 (EST)
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
Subject: [PATCH v5 4/8] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
Date: Mon, 12 Feb 2024 11:30:57 -0500
Message-Id: <20240212163101.19614-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
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

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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
index 4b7ecd4fd431..f363c1d51d9a 100644
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
+	if (IS_ERR(dax_dev)) {
+		rc = PTR_ERR(dax_dev);
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



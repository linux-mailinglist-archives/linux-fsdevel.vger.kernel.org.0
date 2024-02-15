Return-Path: <linux-fsdevel+bounces-11719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01885666C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05E31F27733
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796421339BD;
	Thu, 15 Feb 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vDjxseM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4820132C1A;
	Thu, 15 Feb 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008404; cv=none; b=EvwBmDJ4PzRvQXKHxLqiqRbANRbojkc7uJeB0FVuwZAwy/i7qZ7AfmPqMZIIqM8OCQYfkuWTIf0Zbmtgm/BgJrNTPEPMkfYwdjXm26EmLaEfbIER/JvSTycALZnOeBmvu0esoXRNR+AAc2y/GMTItRJxIOJu6f0pUpjZkzSJqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008404; c=relaxed/simple;
	bh=xPtmgWiHU56eIOTTAS+sj/oIA68ksqZ/i5VE/RwV8cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAl3N9AO2r/NAqnQqV0p1/KNDmc2OLES/ANHaMqbwdVGmMzI63pL8AAyaMDQIj+eX967qL3lsHZt5NamInorkTvyxch9LAq3+VjOZCYzUmzXYVb2JZ5IC8DahuMWO2nj5sttHLJJRTS8L8Fu611fXVFxXfExfHtXIRTsZnT8UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vDjxseM3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708008401;
	bh=xPtmgWiHU56eIOTTAS+sj/oIA68ksqZ/i5VE/RwV8cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDjxseM3uGoNZMHp7D3FWbwVNMSAeAHOAkwaIfhUFXeFVtAl7YV0zsfJqedaxBmDF
	 HghiT/IcBK1PufFC4feeduBoLz3Gp/8+aCkduAWpCMuH6F5jrejmF7Yp4EmaKhhPkl
	 9pSgL1Hoe/1ufK5c+NUXcvwSCQpEvArM7OhGazL/cnqD32qDqsfp/xlaytSQHIAH6e
	 0p6b0AtWXgLOH1Aj0000Jk7R+51JOUBfKQXKvzzNkvQ8aKQknVyur2HPUJUtJVdE4r
	 Xxz4siQNkEmiX0+78ojo8dlyKb0loVQa96kddJLDm9aaErHKKPMSEeWOuWwPtv+x3v
	 dfur/tcl6otfQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TbHvN67LPzZS8;
	Thu, 15 Feb 2024 09:46:40 -0500 (EST)
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
	Heiko Carstens <hca@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v6 5/9] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
Date: Thu, 15 Feb 2024 09:46:29 -0500
Message-Id: <20240215144633.96437-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
References: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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



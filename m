Return-Path: <linux-fsdevel+bounces-11129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07522851915
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBEE1F21DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF63D578;
	Mon, 12 Feb 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZZrr1DQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66A3D56F;
	Mon, 12 Feb 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755254; cv=none; b=SfNWE9qHrX/wLJUUc0jx/YrdX1VoCs1lMA5n2FJld6LBYJad5g0xNBSKeP4p56N9j/Af5R8nqLBIyKfg5bO1gmI0YVC80FAYy8O/RfSGOoigDdG4l/PZx1ysT/TTEGOt4+JTTskyDowA7npAhxlJWpl32xLooREB6cVNcJ8hfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755254; c=relaxed/simple;
	bh=k2sz/frCWDb4R4mtAgpiLkGT+g8hxxE7Hdk6DHyuU2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDfVkHqU1rqmZ8ITKiQNcpZwJ9TWYmLEbl7LVgMJiS/bt3Qj9GHfZ7ClUdcsYZfzES7n4IHL5m9Ra6mjgET3gQyMJNZmvU6PaCrzffN1y0UucMHT3DV7pJJiiPi/2TenapwmNRG4dZAKnmhd4+sNKTvDcrM4Vja0L8AwNG3UzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZZrr1DQ1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707755245;
	bh=k2sz/frCWDb4R4mtAgpiLkGT+g8hxxE7Hdk6DHyuU2A=;
	h=From:To:Cc:Subject:Date:From;
	b=ZZrr1DQ1AtimJocfUuWW9YjFO9Ko886wHKEZj/b/t3qVbPBnd3jlc1BxgqEPzBNRz
	 CGLO3sSlYjlGi8OaD+jQWSzCM2lpa0rPlh5j2lfN4pHDTet9YqNN8aPWzIc4BcaGNm
	 VTIWQI+Rlf/jGcB8TKe6i+zqeaBwQ0RuMxVMC85yXi2qOhJGUQMrIgP4Rr0B/4nxWx
	 cOQ0eQGELKalLtEIqY0Ee4UhXQulAQY7bcXrw+oWU4f8IslM/3NK5r9ZDDjYJOeu/b
	 bTK0UrdwmtePTqwwtSKUKQs6QQ2cETWBMpZmShYyehQrckpNvzGInZwhmX9gzAyrCq
	 lrTir9cna9tcg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYVH11GRXzYWC;
	Mon, 12 Feb 2024 11:27:25 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev
Subject: [PATCH] nvdimm/pmem: Fix leak on dax_add_host() failure
Date: Mon, 12 Feb 2024 11:27:22 -0500
Message-Id: <20240212162722.19080-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
before setting pmem->dax_dev, which therefore issues the two following
calls on NULL pointers:

out_cleanup_dax:
        kill_dax(pmem->dax_dev);
        put_dax(pmem->dax_dev);

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
---
 drivers/nvdimm/pmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb3f1c8..9fe358090720 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -566,12 +566,11 @@ static int pmem_attach_disk(struct device *dev,
 	set_dax_nomc(dax_dev);
 	if (is_nvdimm_sync(nd_region))
 		set_dax_synchronous(dax_dev);
+	pmem->dax_dev = dax_dev;
 	rc = dax_add_host(dax_dev, disk);
 	if (rc)
 		goto out_cleanup_dax;
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
-	pmem->dax_dev = dax_dev;
-
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
 	if (rc)
 		goto out_remove_host;
-- 
2.39.2



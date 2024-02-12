Return-Path: <linux-fsdevel+bounces-11133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA3851984
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05961282F9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9118030;
	Mon, 12 Feb 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VTKykfQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B42629C;
	Mon, 12 Feb 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755467; cv=none; b=gfjEyfFy4c7hzz8oWD9G7PEJNCeN455idNenfri385KNrXOlKtA37jbwaEq5uHGR1eu+TMGEf5GQ3jAjbNDXm5NeYAzbZpo7CEbey2vMnjVHKTEvAuZXz/Rc9hIoxvb6WI3payP1t9+aKqyW54IicEQNABRFICKrxg31gO9eOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755467; c=relaxed/simple;
	bh=CbAyr+xbx+4Y3FlaBdF7mHOoD3AcNitxApGii8uR9rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qk0QdG1RAU5yuZow/UZyY4m4neUUchI1ZX9lxaG4wRcbRFSsQogLh1qOIGGDC9lWiiBamU+VJtVvoyp32mbX/E82etJ8K1oQCqpbnhxDVVKzZTBxahMg6v0Y29KmGHUUzJQoEGOP6wAaWJ6vUlIpaqoRQReeXbzjt4YlTbGIoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VTKykfQI; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707755464;
	bh=CbAyr+xbx+4Y3FlaBdF7mHOoD3AcNitxApGii8uR9rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTKykfQIFeg7MsgPwyNK/d6uzEToAQ8FlD6SGX+bGDjm61vIw37jcpX3CfF8gVZCC
	 oJfrLVqcmHnyN8EYEAo12aQFH0jE3PqvtX9puwfbJ8Dy7S9hiSIDtRAdBQB8Y02bGh
	 1unKHeombD7OmhYiMUdmNLEAww5/+i91PM0mB7JcWV7MY5rVP/J9sD9da10k4HhwLt
	 HWHwDADStQviiCfDbETS9uwAi9jnPHveF7qMZ55QfbukSsZwklpu8abwXhSF825/4m
	 QjgFOnuVbF+GUg1Z8zB+c5h3k9WoZBREVS/p9dlZAwel8/0/um+lsrPfzh92XZ8bA/
	 DZw3KbUi2kHOw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYVMD2VHMzYQy;
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
Subject: [PATCH v5 3/8] dm: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
Date: Mon, 12 Feb 2024 11:30:56 -0500
Message-Id: <20240212163101.19614-4-mathieu.desnoyers@efficios.com>
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
aliasing within alloc_dax(), modify the error handling of dm alloc_dev()
to treat alloc_dax() -EOPNOTSUPP failure as non-fatal.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
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
 drivers/md/dm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 23c32cd1f1d8..acdc00bc05be 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2054,6 +2054,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
 static struct mapped_device *alloc_dev(int minor)
 {
 	int r, numa_node_id = dm_get_numa_node();
+	struct dax_device *dax_dev;
 	struct mapped_device *md;
 	void *old_md;
 
@@ -2122,15 +2123,15 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
-	if (IS_ENABLED(CONFIG_FS_DAX)) {
-		md->dax_dev = alloc_dax(md, &dm_dax_ops);
-		if (IS_ERR(md->dax_dev)) {
-			md->dax_dev = NULL;
+	dax_dev = alloc_dax(md, &dm_dax_ops);
+	if (IS_ERR(dax_dev)) {
+		if (PTR_ERR(dax_dev) != -EOPNOTSUPP)
 			goto bad;
-		}
-		set_dax_nocache(md->dax_dev);
-		set_dax_nomc(md->dax_dev);
-		if (dax_add_host(md->dax_dev, md->disk))
+	} else {
+		set_dax_nocache(dax_dev);
+		set_dax_nomc(dax_dev);
+		md->dax_dev = dax_dev;
+		if (dax_add_host(dax_dev, md->disk))
 			goto bad;
 	}
 
-- 
2.39.2



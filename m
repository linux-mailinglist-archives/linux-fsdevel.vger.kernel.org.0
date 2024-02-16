Return-Path: <linux-fsdevel+bounces-11890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A68586AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153291C21A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BA13AA48;
	Fri, 16 Feb 2024 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPDdKcSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACF139567;
	Fri, 16 Feb 2024 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114986; cv=none; b=R7io9+kEB8xovDRzbgFsEo9zat2LDSeKSFA1+8KefKMbwzxsXr1NFzw8vuzgeZVdhDp3TXQEucon/Oram7JXrTk4UcthzhBAKyrgd+OYMAJDJAUeQHi7C3i7XTf7ZJKUTlyZEsBuLdgCSxqswNvkrmIHcOhHlGbw7lf8qSjz6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114986; c=relaxed/simple;
	bh=FZKDvxwOLKdXeXYFLErtJaz9RUHYu0Q/oOHwXC/6poQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WCgLuNVpUkf5v7Tn/K0dcy1R7B3+6ZBGQTSf3dzRf2zRGgOOcuzSkljcKIJxbCzqG+8sR2kyh0f/eQyXni5Zvxm+vqkEA4G0grikH7TPrnIcUwJ3hm08orjb/zw+ACczGMfsaewcfywmO6J7qlzblVnNv8sD9sYkWyqTPxCV6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPDdKcSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881A8C433C7;
	Fri, 16 Feb 2024 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708114985;
	bh=FZKDvxwOLKdXeXYFLErtJaz9RUHYu0Q/oOHwXC/6poQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JPDdKcSU1v7J4n2vhyqtW0wo+yuczCaaDoXyAiVLDiVfD4fjvF8z33nTw5/YUrgxF
	 4hfexzkX3VXEJRBNJH/XXBwUIdfTjbRSUmXTyxkbID0oYvjKDkhxsQOOiGNK1wnJhE
	 OUzxHdS6lE9CA/1zP8cRM0RP35hSBLZGivQSNIYLqZ/IGAVJ0yF9XN8pPyfpkORUjX
	 m/OorVNf1LFJeMU8fNHEQmLwfSPOi9GO+igiUmg574vQlkr9KX+G8GpQUJQRdtPyxS
	 utLzqNDPLEK0p6RlWee0BCXZ5iwwPkQ5pJq4Oyb5OQyMHcAB8fnSGkGKPM6iF5D5Or
	 ElmtWeeTJO8mg==
From: Arnd Bergmann <arnd@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jane Chu <jane.chu@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dax: add set_dax_nomc() and set_dax_nocache() stub helpers
Date: Fri, 16 Feb 2024 21:22:51 +0100
Message-Id: <20240216202300.2492566-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In some randconfig builds, the IS_ERR() check appears to not get completely
eliminated, resulting in the compiler to insert references to these two
functions that cause a link failure:

ERROR: modpost: "set_dax_nocache" [drivers/md/dm-mod.ko] undefined!
ERROR: modpost: "set_dax_nomc" [drivers/md/dm-mod.ko] undefined!

Add more stub functions for the dax-disabled case here to make it build again.

Fixes: d888f6b0a766 ("dm: treat alloc_dax() -EOPNOTSUPP failure as non-fatal")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402160420.e4QKwoGO-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/dax.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index df2d52b8a245..4527c10016fb 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -64,6 +64,9 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+void set_dax_nocache(struct dax_device *dax_dev);
+void set_dax_nomc(struct dax_device *dax_dev);
+
 size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
 /*
@@ -108,6 +111,12 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
+static inline void set_dax_nocache(struct dax_device *dax_dev)
+{
+}
+static inline void set_dax_nomc(struct dax_device *dax_dev)
+{
+}
 static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 				struct dax_device *dax_dev)
 {
@@ -120,9 +129,6 @@ static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 }
 #endif
 
-void set_dax_nocache(struct dax_device *dax_dev);
-void set_dax_nomc(struct dax_device *dax_dev);
-
 struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
-- 
2.39.2



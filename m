Return-Path: <linux-fsdevel+bounces-32065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D179A0156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D8C284059
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214A18D655;
	Wed, 16 Oct 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8BHQFiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6418CC02;
	Wed, 16 Oct 2024 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059829; cv=none; b=IxwSk1zcnE4WA4T4YcvCCNJ1+v5++/N84WfW0zEXx9oafIcV34eh8w5lzlyavG+x87DgkREhXAA2tW+eOv0VDt7JfAIUGGB0RfXAUICoArnmVTRTeaTxqGjwm2/8WqRMhDWjAm/DnVMwufCUa9f+41ZcP54+sor5NPGJPoXZhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059829; c=relaxed/simple;
	bh=Og38/G7jNcGI3shyyTG9Y9Ul1EbSQha9WhdMrb/+3zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6F54QhRt2H5ZJrg2lSCd2HSriyNSld+caNGEDQB/+ePTqf63AfGoiyH9bg2LfinvmetHOUYUQzHlOFsCKNdInFZ3qNFJJ4IIbiowfj7KwMSU/BNlVn7QX7MRYxacdtyseexH/FDaCEubWPJBS/Ynd1AfKj5SgW8rlo3k/S7YUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8BHQFiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE1C4CEC5;
	Wed, 16 Oct 2024 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059829;
	bh=Og38/G7jNcGI3shyyTG9Y9Ul1EbSQha9WhdMrb/+3zE=;
	h=From:To:Cc:Subject:Date:From;
	b=O8BHQFiQ53bGOJ5Tg2oLQXLwzT78t87mjVWWOC6SaHqciptvr8Dwb6brv0h71PLNQ
	 NypjLMmlFqhIpH1J6Vh9XI3QxXT8WTjxqilq1quVLd5NQUS30gFtWuUOC32C7a/Oo7
	 lWBS6OGkwUEf/UpxnE0CUZd5kGrmcdRetnGO1BnnYpku1lBG/u7xnEX7fiwzs8zw3d
	 Q7sna6M207Gi7UICXtnj1xzHw5Ku8atlKuS4wCbUL/bb9cpnw/teVwCsZ3hu8V3IFd
	 zUldPnNcp9q6axzDa6gOOofyOZLYBLVA3ZopCRMSRWVxk9fsCpJk+0tnSKs6zfTDja
	 6IhjGWINC1DFg==
From: Arnd Bergmann <arnd@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Josef Bacik <josef@toxicpanda.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iomap: provide iomap_want_unshare_iter() stub for !CONFIG_BLOCK
Date: Wed, 16 Oct 2024 06:23:40 +0000
Message-Id: <20241016062344.2571015-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When block device support is disabled, DAX fails to link with:

aarch64-linux/bin/aarch64-linux-ld: fs/dax.o: in function `dax_file_unshare':
dax.c:(.text+0x2694): undefined reference to `iomap_want_unshare_iter'

Return false in this case, as far as I can tell, this cannot happen
without block devices.

Fixes: 6ef6a0e821d3 ("iomap: share iomap_unshare_iter predicate code with fsdax")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/iomap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e04c060e8fe1..84ec2b7419c5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -281,7 +281,14 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+#ifdef CONFIG_BLOCK
 bool iomap_want_unshare_iter(const struct iomap_iter *iter);
+#else
+static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
+{
+	return false;
+}
+#endif
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.39.5



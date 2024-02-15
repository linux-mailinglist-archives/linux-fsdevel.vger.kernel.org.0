Return-Path: <linux-fsdevel+bounces-11715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A54856649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DB1283CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C6132C36;
	Thu, 15 Feb 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MNMKriyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1E131E5F;
	Thu, 15 Feb 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008402; cv=none; b=SKwnTpEE6jFUaDZND2Vrozy1bCKegBHZ4ywZtXsWJwps5RvfCi5ZMjntrGVcnFFv+sb5p9+g+MNpEA1HNqE8ZBsz0CYDorMjO/cC1c1Ne2UleWGeT2Vyo643AXbOdx4i3FWHb5eNH4wdIqZV3GlcJvoJX/IXMIzyyVDrhb1bAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008402; c=relaxed/simple;
	bh=f6KZPJbWgKyyz0b6bsXitRwjRbgNq1j+uFNk2EI6GFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8phvak2kbA1kwbQ+8Lb50G6S2K7G2Km0k1WkyTlyNsdZwTD8dUVZXF8qdO/PSY/Nvk7xs9aMFfsCd0O16ZIO7bQs0TeJ8pTVqknQBoS7r6prrk83rL4gqe7EWzJ022q172xyRk/ubLNwPs2gJpC10s83xo8SAeQNsbW1up9ckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MNMKriyf; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708008399;
	bh=f6KZPJbWgKyyz0b6bsXitRwjRbgNq1j+uFNk2EI6GFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNMKriyfcEhRm3Te0E403P2pXoUgE6mM/5Pp6kXzsoZglAnPXNbbPg16ZVmSau0ur
	 reW5SfChm8Z0470OkoRns543xWrIs3en3Il/nnNDyiWEhHDMLbnNNjcxq4LgSOxrhI
	 mXTAeAf44m6ePTpHEwbZ8zApxSVmjU4mK6q5ngf9/4TWEVjKo8Lxm0jXC7BWIceNWZ
	 sAKMnrvZ1jrWUgaJsMpZ7Ju8+Y91gxRxapWNLNNW2Nhr9seT1OfvYZvlM1tdd+VYUB
	 tn+cV4j3qI2QqFdOah9ub9xIKOK1W79zDjPl5rd69ShO+twx+08NeOjS5tHOGjbcEK
	 nuqG3RHuBrRXQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TbHvM1tL3zZS4;
	Thu, 15 Feb 2024 09:46:39 -0500 (EST)
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
	kernel test robot <lkp@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/9] dax: add empty static inline for CONFIG_DAX=n
Date: Thu, 15 Feb 2024 09:46:25 -0500
Message-Id: <20240215144633.96437-2-mathieu.desnoyers@efficios.com>
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

When building a kernel with CONFIG_DAX=n, all uses of set_dax_nocache()
and set_dax_nomc() need to be either within regions of code or compile
units which are explicitly not compiled, or they need to rely on compiler
optimizations to eliminate calls to those undefined symbols.

It appears that at least the openrisc and loongarch architectures don't
end up eliminating those undefined symbols even if they are provably
within code which is eliminated due to conditional branches depending on
constants.

Implement empty static inline functions for set_dax_nocache() and
set_dax_nomc() in CONFIG_DAX=n to ensure those undefined references are
removed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402140037.wGfA1kqX-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402131351.a0FZOgEG-lkp@intel.com/
Fixes: 7ac5360cd4d0 ("dax: remove the copy_from_iter and copy_to_iter methods")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christoph Hellwig <hch@lst.de>
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
 include/linux/dax.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..e3ffe7c7f01d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -63,6 +63,8 @@ void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
+void set_dax_nocache(struct dax_device *dax_dev);
+void set_dax_nomc(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
 size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
@@ -109,6 +111,12 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 {
 	return true;
 }
+static inline void set_dax_nocache(struct dax_device *dax_dev)
+{
+}
+static inline void set_dax_nomc(struct dax_device *dax_dev)
+{
+}
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
@@ -124,9 +132,6 @@ static inline size_t dax_recovery_write(struct dax_device *dax_dev,
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



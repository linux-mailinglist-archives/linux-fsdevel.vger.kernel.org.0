Return-Path: <linux-fsdevel+bounces-77460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED30MRn4lGk8JgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF63151D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A47E3052ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB68296BA9;
	Tue, 17 Feb 2026 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXtmq84e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF629D297;
	Tue, 17 Feb 2026 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370482; cv=none; b=Pq5aprWs1sUAa9E7V/o5daxCrZwCQgKaOvlpDbN03aUeXBhS031jY0puVCNePfx9b+6Vmm/y1suenlc5YEYt3PVR5zE0vpunA41IBqf5CLX96f1bNUPa+GQ5S1UYTHq3Vn2EsgOVL63vvy3JdZs1nqTefLZNUOXWuIRW08LMloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370482; c=relaxed/simple;
	bh=EbkNlukZCXKfjXWHRl44jLAnaH6c/LmSXUUxkgb/vK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYRXwRhx+EVBC7PyKpLEWF97JW7CkAbuqqxO/bxIHPFK+6tK2cLNFk/mqgf4ADtrLIDQV7nEhNlLDq/SEsvGRKPvGWWmSsmbdlxrOTyz5chTO6f9BCFSdUmQRoPI2LBJhmgIXb5mZsiFJgzaBIe1yBwpFzQtuYHJtyh5FZVOQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXtmq84e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6DAC19423;
	Tue, 17 Feb 2026 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370482;
	bh=EbkNlukZCXKfjXWHRl44jLAnaH6c/LmSXUUxkgb/vK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXtmq84eXXIpCxGba0nnsG2G6hnIqVWiHqjlGaWCXgHf9TCxWH3Zicigrz46lVzZ5
	 qnaqLKpJEquaEnp/kX0bai9GjJ4s9Ipx6zevKYXANioLaiKKxybpGDD9mKsMDjUHuB
	 t+6rhCMK5P9VH/Ms2C+zWsHlKhKFCf6SxolTqbeokdqcL17hxNkx1EpWKFB+Zj4gc4
	 feYtbFndfwE20THPznUzyWVWQV5zGIXx2fqJQM7y4QWf6PE8B4UjmgsUcuWKsVzrWf
	 ipmIvowUUE0DXuyHKkMItW8KyE09cX577t7eXaVKH21/8dhxb2kSIr4NnAy4trqZKS
	 woyOXlk1psBPg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 23/35] xfs: add helper to check that inode data need fsverity verification
Date: Wed, 18 Feb 2026 00:19:23 +0100
Message-ID: <20260217231937.1183679-24-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77460-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DF63151D79
X-Rspamd-Action: no action

Simple helper to check that this is not fsverity metadata but file data
that needs verification. XFS will use this in iomap callbacks to check
what is being read.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 21 +++++++++++++++++++++
 fs/xfs/xfs_fsverity.h | 22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
new file mode 100644
index 000000000000..47add19a241e
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+#include "xfs.h"
+#include "xfs_format.h"
+#include "xfs_inode.h"
+#include "xfs_fsverity.h"
+#include <linux/fsverity.h>
+
+bool
+xfs_fsverity_sealed_data(
+	const struct xfs_inode	*ip,
+	loff_t			offset)
+{
+	const struct inode	*inode = VFS_IC(ip);
+
+	return fsverity_active(inode) &&
+	       (offset < fsverity_metadata_offset(inode));
+}
+
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
new file mode 100644
index 000000000000..5fc55f42b317
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+#ifndef __XFS_FSVERITY_H__
+#define __XFS_FSVERITY_H__
+
+#include "xfs.h"
+
+#ifdef CONFIG_FS_VERITY
+bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
+		loff_t offset);
+#else
+static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
+						 loff_t pos)
+{
+	WARN_ON_ONCE(1);
+	return ULLONG_MAX;
+}
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_FSVERITY_H__ */
-- 
2.51.2



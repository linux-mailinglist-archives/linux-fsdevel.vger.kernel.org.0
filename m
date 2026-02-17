Return-Path: <linux-fsdevel+bounces-77463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAfKIPD4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:25:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC420151E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5D73057495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812622F363C;
	Tue, 17 Feb 2026 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1hn+lWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE702BD030;
	Tue, 17 Feb 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370489; cv=none; b=R21n/fy5jco8ncAuu5lh6apsATt/fwKlSFGcf7VH3XX/vA94gi2Jb0FWzSOXK4+JVLKefqwNWbwHANnqtT7SBfzG/5IM6fCIqWj4xfLrtjM0Me0RFUFuQeyM3srsTjj7qhsZ0LeJFvgBpHRUDbGlZnYLjtl2ScDto8M1jN82InU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370489; c=relaxed/simple;
	bh=fabg84AD4cf23W+sIhNlsB0NtfIIVp2Cc7WOfCtd6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVPqxoTyxle8q33eUbJ2+lWyzB/7tgo92kCq3/6DvA0NuaOBCrwCQ8I/hbYfZV2EUtep8OdxbgzDZLZiFCakMxQj7KZK3GQmfvH+6gwq+DL5By1nUTKCNUKi+W+9Xdi9ykKNOZ+xIXDrCjXVAZgaHo+dXSgOpUkBAQ7yjL5aWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1hn+lWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B5C19421;
	Tue, 17 Feb 2026 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370488;
	bh=fabg84AD4cf23W+sIhNlsB0NtfIIVp2Cc7WOfCtd6Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1hn+lWJXzhIeUfJPrpDTsMtqWtMUFNpayfCpGMTV//ZwMftT2GPpQRRhnr+xrU2M
	 OtNu9+5I3te6SdNrkcTRsl5p33njt2QhgXYFfuG/+ffXwiTUMOmjbw3+YldKxegS9S
	 Y8b9A8EWfL1MpdyQLw6Ze12Gg1yYEHbP0XsnnSjE9pS+KxABfrLM5I3ZpRzp7lhJKa
	 MwaSblZF4RnwgKz/4S5OiIfxOuPyQqQfN1KCE1niONnQsbpUTMD7plONuJ9pR1mfDs
	 iIwr35LHRrbRXEvXWMZ3MyL7R9ZNwxP/ZFDGJbictRZj+bncEK4HD4aVDHfDRL3eyo
	 3nbHZ1rUpUUUA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 26/35] xfs: add a helper to decide if bmbt record needs offset conversion
Date: Wed, 18 Feb 2026 00:19:26 +0100
Message-ID: <20260217231937.1183679-27-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77463-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC420151E61
X-Rspamd-Action: no action

A little helper for xfs_bmbt_to_iomap() to decide if offset needs to be
converted from a large disk one to smaller page cache one.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 4b918eb746d7..4f8a40317dc3 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -5,8 +5,13 @@
 #include "xfs.h"
 #include "xfs_format.h"
 #include "xfs_inode.h"
+#include "xfs_shared.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_fsverity.h"
 #include "xfs_fsverity.h"
 #include <linux/fsverity.h>
+#include <linux/iomap.h>
 
 loff_t
 xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t offset)
@@ -33,3 +38,26 @@ xfs_fsverity_sealed_data(
 	       (offset < fsverity_metadata_offset(inode));
 }
 
+/*
+ * A little helper for xfs_bmbt_to_iomap to decide if offset needs to be
+ * converted from a large disk one to smaller page cache one.
+ *
+ * As xfs_bmbt_to_iomap() can be used during writing (tree building) and reading
+ * (fsverity enabled) we need to check for both cases.
+ */
+bool
+xfs_fsverity_need_convert_offset(
+		struct xfs_inode	*ip,
+		struct xfs_bmbt_irec	*imap,
+		unsigned int		mapping_flags)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	return	(fsverity_active(VFS_I(ip)) ||
+		  xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) &&
+		  (XFS_FSB_TO_B(mp, imap->br_startoff) >=
+		  XFS_FSVERITY_REGION_START) &&
+		  !(mapping_flags & IOMAP_REPORT);
+
+}
+
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 6f3d60f010d8..ab01ceef4d15 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -12,6 +12,9 @@ bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
 		loff_t offset);
 loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t pos);
 loff_t xfs_fsverity_offset_from_disk(struct xfs_inode *ip, loff_t offset);
+bool xfs_fsverity_need_convert_offset(struct xfs_inode *ip,
+				      struct xfs_bmbt_irec *imap,
+				      unsigned int mapping_flags);
 #else
 static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
 						 loff_t pos)
@@ -30,6 +33,12 @@ static inline bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
 {
 	return false;
 }
+static inline bool xfs_fsverity_need_convert_offset(struct xfs_inode *ip,
+						    struct xfs_bmbt_irec *imap,
+						    unsigned int mapping_flags)
+{
+	return false;
+}
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
-- 
2.51.2



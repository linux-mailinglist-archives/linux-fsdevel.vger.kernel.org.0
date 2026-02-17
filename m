Return-Path: <linux-fsdevel+bounces-77462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJfMEuD4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:25:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7F151E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C172B30A6EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075E2D781E;
	Tue, 17 Feb 2026 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNjwT05d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA959296BA9;
	Tue, 17 Feb 2026 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370487; cv=none; b=HJwd6QssqH6DAQiCW+E8MYLngxFVFczZMketi4hUMV8dZSSTzvYPJ4yCtv/jAS4/lgqm6M1n91je1nvthK3HNwTy6Lqa2V420HCVzhGe+ci1svO/L25HDxhznOUd5xeBehGy4Hep+a4dQCEWmnPAh+59Tz/jbdTeBAo9YVcaP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370487; c=relaxed/simple;
	bh=I8YifRyETvb7q1RgR87svO75M02y1ySS8Osl0DZbd98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vzg+mKrnoEYrF4g1/aHnslTeolNU5kLzXhvpgt/jfU/lJZHDXmt41NoWNp5NuxIhgt3+w+IOVk/WoKU1fEr0vKwcIvvuxhuzWNoQ9AOemFTIEzRt8loGtBFGBVaSnkhb8d81LV9cCLb+ZqVWlwwzyiFj6WLkZDHBxR0aau0O+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNjwT05d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9887C2BC87;
	Tue, 17 Feb 2026 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370486;
	bh=I8YifRyETvb7q1RgR87svO75M02y1ySS8Osl0DZbd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNjwT05dk2imFBaLWlE1UvsQPI5ToC1lQEt5q4KIRQlyRsu/XktCWsvz5SsmZGh9W
	 90FGg8jnAQ+nW6IAv/nNeY1An9ebtTYXw5fU/WrctOsmNXRje/WrJigGMwO3C81O77
	 HKIWzJVDPQW/ma22/n+VAOSPBtKZfiQRvdqK8XTaMuYcQOxMghOKzumOYxT/rhS30N
	 YB8+IpB6P9LSIwr2Cv+bFFpzanoRjFJO3Jm3TQyaSaOPwUibkA9zcY3gS4OA371f6b
	 lrJdy7BFdEjP4Y5//tevxoAyfmg+M90mM6v0ebf4bJxV4P9p3RtZ6RY8plNAf1yKWB
	 58ZyO+94SxvFw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 25/35] xfs: add helpers to convert between pagecache and on-disk offset
Date: Wed, 18 Feb 2026 00:19:25 +0100
Message-ID: <20260217231937.1183679-26-aalbersh@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-77462-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 90D7F151E52
X-Rspamd-Action: no action

This helpers converts offset which XFS uses to store fsverity metadata
on disk to the offset in the pagecache.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 14 ++++++++++++++
 fs/xfs/xfs_fsverity.h | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 47add19a241e..4b918eb746d7 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -8,6 +8,20 @@
 #include "xfs_fsverity.h"
 #include <linux/fsverity.h>
 
+loff_t
+xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t offset)
+{
+	return (offset - fsverity_metadata_offset(VFS_I(ip))) |
+	       XFS_FSVERITY_REGION_START;
+}
+
+loff_t
+xfs_fsverity_offset_from_disk(struct xfs_inode *ip, loff_t offset)
+{
+	return (offset ^ XFS_FSVERITY_REGION_START) +
+	       fsverity_metadata_offset(VFS_I(ip));
+}
+
 bool
 xfs_fsverity_sealed_data(
 	const struct xfs_inode	*ip,
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 5fc55f42b317..6f3d60f010d8 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -10,6 +10,8 @@
 #ifdef CONFIG_FS_VERITY
 bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
 		loff_t offset);
+loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t pos);
+loff_t xfs_fsverity_offset_from_disk(struct xfs_inode *ip, loff_t offset);
 #else
 static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
 						 loff_t pos)
@@ -17,6 +19,17 @@ static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
 	WARN_ON_ONCE(1);
 	return ULLONG_MAX;
 }
+static inline loff_t xfs_fsverity_offset_from_disk(struct xfs_inode *ip,
+						   loff_t offset)
+{
+	WARN_ON_ONCE(1);
+	return ULLONG_MAX;
+}
+static inline bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
+					    loff_t offset)
+{
+	return false;
+}
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
-- 
2.51.2



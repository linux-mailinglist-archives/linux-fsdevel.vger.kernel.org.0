Return-Path: <linux-fsdevel+bounces-58948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C918DB33593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9981B2473B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C4285CA4;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Oi0SeSSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A727A129
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=nmitGlzGrWO31khMRzq1u+WMsnUSdc4hphPSDgi/mB+ZNGeDTwl8d4n7llW/pIP0hTPpyPfU4plmL6JNKugfqgQdLFcLAmiKKaO5ZTwQzZfjxXF+diri+tHV+NgfjVGP2dZBSvM+hzZOY9nYBhQtOphRqW4ZBleEhgGfxv3eL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=AYcNMIK4FmiRTpLJcB7hnHcvkBvBIiHTMlWPtHjlnW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBpksQR5a3fuMiK0kgIQUm353Rkz8U852IZZOKW8f5NsdbPtx3S6K28TmWVdXCNF+A8I+/jHUHCynyLQ0i23K3tFczqgub1ALzOT0yU2TyWHH9RvXD5PGaXU97076UmUwEAZxLT+JZYnNphY5Kq4ycpM/c64KonS3kcmSOaKh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Oi0SeSSW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n96wRqFFBaKzKMEOtjH9MbUd/uBYgsG/UsMRixqP4fU=; b=Oi0SeSSWm5jgsp2fbTchlqbmKL
	lvS8d0F/qQJK4PRuSNwzmZIYaQBgRYaGVmhuW2R9UE680jMhlCjoE/KZocA3kopg1bv2BCF3n49MF
	2mu4QO7dvnGstHJA9IFItTXYz4sXLFmvYZO0nfK7Cj7/tdgJ4GTO1JeflzEtM6X7N6vRKiBpckT2g
	IcucCSbUI/ENbCHDZ4mewZ4W0nw8OevUMXPb77GiwQbwWJA12Ft/sPwY0CziUq/kT9namHO2Dn4a0
	9OIib+TGRyZ0gaPvdYHnWn2PgaWfYRCaT1KvrEImo3FaY1KqkArnxDyXekdTLCkI+DbwAjsChwSx7
	1cEhPIEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TFA-25Hq;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 45/52] may_copy_tree(), __do_loopback(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:48 +0100
Message-ID: <20250825044355.1541941-45-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 94eec417cc61..a94aa249cedb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2991,7 +2991,7 @@ static int do_change_type(const struct path *path, int ms_flags)
  *
  * Returns true if the mount tree can be copied, false otherwise.
  */
-static inline bool may_copy_tree(struct path *path)
+static inline bool may_copy_tree(const struct path *path)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	const struct dentry_operations *d_op;
@@ -3013,7 +3013,7 @@ static inline bool may_copy_tree(struct path *path)
 }
 
 
-static struct mount *__do_loopback(struct path *old_path, int recurse)
+static struct mount *__do_loopback(const struct path *old_path, int recurse)
 {
 	struct mount *old = real_mount(old_path->mnt);
 
-- 
2.47.2



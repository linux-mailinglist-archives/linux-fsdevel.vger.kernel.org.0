Return-Path: <linux-fsdevel+bounces-26642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64195AA4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F7B240BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F23BBC0;
	Thu, 22 Aug 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHmnCkMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E117999;
	Thu, 22 Aug 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289937; cv=none; b=VPTPfwnhRjwvLtinUgs7tXm/5o/1F8dmyYdcsMV+RtmrBQSKpPzx5I1124oKQVGhhokHGh3bo2hsR0Crarmw98+ak4Dsnr6VbNyIfFuX04sJHpBT7aNmOoRWXHcIpYxUQhO/hYDYVzc+wzBnBsiO+PkW8lS4wQtXAZ33oSeJGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289937; c=relaxed/simple;
	bh=42X8Gh2L7dyGjX3VvIUPml7cHJOMOyQ+YrI4+eJU3i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqTdXNRGaWzVQyASu0FI4nb/iAgp2xFi5HTapBlg47e+xSHmK/YP9sPLrhv/LbDvbxZjyA+CQ+W40W80DJi1zDbPO6qY0RdvKibqIg5bsQ59iRrH9oLVt9JzPXMNGb08VSm4XNl8w3q0WdqHc7OI8tlq9YdMkLndvgkZ07kb3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHmnCkMz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289936; x=1755825936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42X8Gh2L7dyGjX3VvIUPml7cHJOMOyQ+YrI4+eJU3i0=;
  b=WHmnCkMzcpAArlpU/1n1pOf/2S4t9De+DqnDi/G4pAyyfzDQK0IHzp93
   GRpWZseM5RU2S1tMQ7GF6UwbhVOHBWfQdKRMsqlOwNQakbBI3+q/IbWCW
   JONEuakkjR9f8gArAm/QTHmbaWZ2sUkTBH9ZtyqW+wN/E7tzPQ7pF55UB
   0fJLVTifEckqrwdIsJjaqbIZ2nZvX9yAqOoNTgfDoBzXMe0STpdbb2Clt
   KA8uq603mu8t/X1bvkbSGh1iVkSDO9F9pBX+MopmD1mqdWQf/UiHDYgeu
   2UHb67HrJ3X1vuqISfWczyIz3723LeJdn2MMXug92MDEjH81D7c/Rds0b
   Q==;
X-CSE-ConnectionGUID: 17BLysSrSdW9adgyZsr62g==
X-CSE-MsgGUID: u2M5jakyT7W1o0omAvAYxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574729"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574729"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: tiVfE80JT/CoE3tM7yMKJA==
X-CSE-MsgGUID: qN8Nln/PSDqc4gyj4eZOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811024"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 03/16] fs/overlayfs: Introduce ovl_override_creds_light()
Date: Wed, 21 Aug 2024 18:25:10 -0700
Message-ID: <20240822012523.141846-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will be used when there are guarantees that the credentials usage
count is not modified in the critical section.

This is a temporary helper, that will be removed when all users are
converted to use the credentials GUARD() helpers.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/overlayfs.h | 1 +
 fs/overlayfs/util.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0bfe35da4b7b..557d8c4e3a01 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -429,6 +429,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+const struct cred *ovl_override_creds_light(struct super_block *sb);
 
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index edc9216f6e27..3525ede21600 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -68,6 +68,13 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+const struct cred *ovl_override_creds_light(struct super_block *sb)
+{
+	struct ovl_fs *ofs = OVL_FS(sb);
+
+	return override_creds_light(ofs->creator_cred);
+}
+
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
-- 
2.46.0



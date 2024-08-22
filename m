Return-Path: <linux-fsdevel+bounces-26648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCB95AA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA521F23760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF017E014;
	Thu, 22 Aug 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBfzmNxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42E13A86C;
	Thu, 22 Aug 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289941; cv=none; b=KQi5VGCMd7KHlJdwOyx7ZupuksXikTdreh7j1Uo2Iss1e2ojCYhuBCIBzBQqoJnQP+GjIpObtVcqSLGBppRjC2IRRgGchqExqMkwXyn+OrirFVOj9X/iEdiKrtpC1Jf7T5ajwdl3HJTW/Nufa/+kTihX0z4YkFSrZpO74kiDCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289941; c=relaxed/simple;
	bh=hCCt2JYtwosbUEZibFLaQvSFYiptbQfDlsFFgg6wgIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmP00ty/bxs9MYGoFWcEsShzIVnjU71L1sw4vuIhktywAVlg1t153LCoPRoWncMJoEsyhbmFY2D0QSAmrnGM3RvoEzyprfdT7Q8r7DCpvaPHf2Umk92q6U+UX2E+rLbN/8lwK+Wx4P/czVqaE05+bmKsVx2G0eHZ1XZ17bBC340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBfzmNxH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289940; x=1755825940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCCt2JYtwosbUEZibFLaQvSFYiptbQfDlsFFgg6wgIE=;
  b=iBfzmNxHQESdmCUNC7jLrGYlaBRw7xvIjC++5u7a8Yhe8tA8o9fb/UCV
   jaYmUUlHk7GhraDuRz8PoXXqo8rXvB6tOOldGzwSDPBjIooB00Uzl6MTQ
   0T7eqyOWuSNn5cZs+RSHAviF70Cirm2JdGF8rmvZtC7W9LrQAbq8fJtDO
   Z+ONd3fTyox/Uql1QuAIpFAqJ2V3cjgtFsJQOKjD7BVA/APscelHtJ2xk
   S/ZuLA2lqny4fptcvKGtTwlXhB1GaNQi/dyXwpDtOn2sDg0lSsE6oV0I5
   zKAMbKj5jdhpFJd7Vi2QQiMNl6SnY/nfQ4O+UnfhUw0oLZdFW0bay5lp2
   w==;
X-CSE-ConnectionGUID: gTqdWfumSFedWkj7lX5cVA==
X-CSE-MsgGUID: UDnrOHpvRb2N//N0uXPk2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574756"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574756"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: Gtl0DjLhSfu7/XwFYEwnBw==
X-CSE-MsgGUID: 15/t8TZ5QaSd03ToyA8eHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811048"
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
Subject: [PATCH v2 09/16] overlayfs/dir: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:16 -0700
Message-ID: <20240822012523.141846-10-vinicius.gomes@intel.com>
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

Replace the override_creds_light()/revert_creds_light() pairs of
operations with cred_guard()/cred_scoped_guard().

In ovl_do_remove(), cred_scoped_guard() was used because mixing
cred_guard() with 'goto' can cause the cleanup part of the guard to
run with garbage values.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/dir.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 52021e56b235..28ea6bc0a298 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -698,12 +698,10 @@ static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ovl_set_link_redirect(struct dentry *dentry)
 {
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_set_redirect(dentry, false);
-	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -889,7 +887,6 @@ static void ovl_drop_nlink(struct dentry *dentry)
 static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 {
 	int err;
-	const struct cred *old_cred;
 	bool lower_positive = ovl_lower_positive(dentry);
 	LIST_HEAD(list);
 
@@ -908,12 +905,12 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
-	if (!lower_positive)
-		err = ovl_remove_upper(dentry, is_dir, &list);
-	else
-		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds_light(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (!lower_positive)
+			err = ovl_remove_upper(dentry, is_dir, &list);
+		else
+			err = ovl_remove_and_whiteout(dentry, &list);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
-- 
2.46.0



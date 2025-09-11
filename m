Return-Path: <linux-fsdevel+bounces-60883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD790B527FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A71C23056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56542472A6;
	Thu, 11 Sep 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SUrCrF9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18520F08C;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567138; cv=none; b=tVDZjrBrOSkt6L6+7JvuZp5YxZIxeVZXiSEUUAVIK/44V35cBsQ1taDlHpqXDOjD2XhLynGuH+6VLOtYnobDl71Zj0okOUSuc7YH9q/CkyxiUeipfbCQ4BJZMif23A58rECdBNylslanJZq1TgwrJ99/1j91gAaETSvwAO7dqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567138; c=relaxed/simple;
	bh=xQVHReja3R3eyA+9PSdixoQ9StYDWGQ0WQ0JcC18LT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkRRk+0sucHIgBf8nzZ/hYG2G6v9bNhqB9N9L+OuJL460HMSDE7fLfXID12WBuH1mdd86FyNaWveJPONn4ki5nNoANSDBHAjteXJgAvsmHilQJRa4b1Q1/IHrkZht2Q5hAkHELIGzQGpm33I60n/jyoqI3SSF/y5180eopHMyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SUrCrF9y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qg0MQvEBNWbXSlojq2TZ0zwHoKa8cXMVmPiejbxRINg=; b=SUrCrF9yMtOhphYZBHOlzPRZIJ
	VX++R+SWSoBstEnnN27tQivjErEu5/RsedMPLOEkAfG+9fYPNV1zBmgjw7LDaB0AAWqmMUT8uECxG
	G578LyoIHfB+B0cXDxlMH6BwpIy332FuJGS1WlEDrM/NQK6TyPAtjbOXHE4/PQWtR+kG3IT8H8CQP
	xs0R3EmAWPwRW4J+lLLS06Ow1F6WMRzU9jRFZVO3m+IKRhUyvc0NZzGoznCcfMn3ZheJfRT0a7l8+
	ok9BBSx0jBnjt6LFJ5GcY4t6LfH4finrqX/C2zZXgZqhfESE23JlVPBnVvcG5hNJ7Esmpo54gJaot
	3MRlNqcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV0-0000000D4kd-4AMW;
	Thu, 11 Sep 2025 05:05:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 4/6] afs_dir_search: constify qstr argument
Date: Thu, 11 Sep 2025 06:05:32 +0100
Message-ID: <20250911050534.3116491-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
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
 fs/afs/dir_search.c | 2 +-
 fs/afs/internal.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index b25bd892db4d..d2516e55b5ed 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -188,7 +188,7 @@ int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 /*
  * Search the appropriate hash chain in the contents of an AFS directory.
  */
-int afs_dir_search(struct afs_vnode *dvnode, struct qstr *name,
+int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
 		   struct afs_fid *_fid, afs_dataversion_t *_dir_version)
 {
 	struct afs_dir_iter iter = { .dvnode = dvnode, };
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index db14882d367b..1ce5deaf6019 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1112,7 +1112,7 @@ bool afs_dir_init_iter(struct afs_dir_iter *iter, const struct qstr *name);
 union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t block);
 int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 			  struct afs_fid *_fid);
-int afs_dir_search(struct afs_vnode *dvnode, struct qstr *name,
+int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
 		   struct afs_fid *_fid, afs_dataversion_t *_dir_version);
 
 /*
-- 
2.47.2



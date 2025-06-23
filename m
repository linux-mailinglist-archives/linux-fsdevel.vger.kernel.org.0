Return-Path: <linux-fsdevel+bounces-52443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30DCAE346F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BFC16D2C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650741DE8AE;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CmFSAl/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A31C7015
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=eX99lGiwBX2VmMTRIYn+YxtJJGpnKDDPXVSRTwgAQYuEH4VFbL3h9/2jB85UjQVJkUYBUqKPcf7MCb8Txl+TMwUPYStkNMV8SFATJaIWPEEHiqAgWzsUiwVOy/rosIOYMxfW88aqLwCHGBGob7QhPkJnTc5AB/AmseHqQfwh2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=hIgWP07LxEljQcRVNZxryqGekzuVCdUQbn63bH8Qyf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhoYWO+52/b6Hu9mOMlgAZI7SnX5OFJIl/rciTITBYQKGdMDNOMc96oZU0eAy4eO9HhpSotY/mNxIGdYniU5Q2/HiRQfEN8hSxWW4eWGO5BZDjXpkIxPuQlghyaSdFY6xOlT8/jjWBQHKAfbP8cf1GaHvnJFVCU8q9ST1sYkWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CmFSAl/+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nvfYaG4C9XYz4VpLbN5+kpJh4yJGArPDuPuOJScqcd4=; b=CmFSAl/+y1acCeMx8WcA12Gium
	jwduVMBlf4VLhmgHWEcxBMArInWaUOrrypqwgvNeEjA33PqAh2zvvQ0kNuPRtjo6ySkh9qjwPc+Fl
	0iLM5ChQK9XxCI616gPtuSbxU25Z0X1YO5V0o63rp8y/TUd/vrs3Kaz60x5o649uhjVYtSBIifabN
	hW1sKCqYsJg3BOReVufZ33wHJclamDqB/YUUDjG2veoZoSj9tPUk5qezdZplp1ujndChEAcbGCUlD
	hH/YNZxUyYM7zdbjd7+tkWMcyLC3IvX/7kX7UhKlP498dFdsi9sIqOKAtgM8z3OZ0o3QGpBOrpja7
	1JJL0kVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005KpH-1dEi;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 10/35] constify is_local_mountpoint()
Date: Mon, 23 Jun 2025 05:54:03 +0100
Message-ID: <20250623045428.1271612-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     | 4 ++--
 fs/namespace.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index c4d417cd7953..f10776003643 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -147,8 +147,8 @@ struct proc_mounts {
 
 extern const struct seq_operations mounts_op;
 
-extern bool __is_local_mountpoint(struct dentry *dentry);
-static inline bool is_local_mountpoint(struct dentry *dentry)
+extern bool __is_local_mountpoint(const struct dentry *dentry);
+static inline bool is_local_mountpoint(const struct dentry *dentry)
 {
 	if (!d_mountpoint(dentry))
 		return false;
diff --git a/fs/namespace.c b/fs/namespace.c
index 7454f9efaa27..1d68bfc3dc35 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -894,7 +894,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
  * namespace not just a mount that happens to have some specified
  * parent mount.
  */
-bool __is_local_mountpoint(struct dentry *dentry)
+bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-- 
2.39.5



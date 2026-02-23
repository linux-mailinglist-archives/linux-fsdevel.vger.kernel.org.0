Return-Path: <linux-fsdevel+bounces-78041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGhzFRbenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:09:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C00417EE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7080C309B223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789A37D134;
	Mon, 23 Feb 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUkWFDTG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D53793C9;
	Mon, 23 Feb 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888027; cv=none; b=fXhnkCeRN1q/UCsmWqOrEe6Xl3cbKgcNGTmJQQ1Yl1xybg+HyWfa5VA8N7PpYb/SgKWox1wyTN/rsHMjlRBJBq6HVjICSF0Db+9Vnq8wwDYY5HI7RsgOin24hMcl3ScuXMzFWsBDRTUlTezLaH+PuDYQ/+8fKHN0hcmCco6IOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888027; c=relaxed/simple;
	bh=C0Tn5Qqert+nxmEZHGV8eBHtlX/jCgn7AIaGDuHrPMk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYwgeQH9h08abk5fBxwy+9Bn/1Kk7Y3nrQWT5/XdURCA+UlQEL6UjonATazetAOZdYd0U18FcpjhMjRcylbLu1XjjjDu6jSlutYJygD5MwAR2GXONiq2yaA+XVELl2i2dpvZSMZNZ7BYn/j8perv6H97Zjo3lnl00PFiQU6Pw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUkWFDTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1479C116C6;
	Mon, 23 Feb 2026 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888026;
	bh=C0Tn5Qqert+nxmEZHGV8eBHtlX/jCgn7AIaGDuHrPMk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aUkWFDTGWm+tHZfaiLVcl8oWIlllxWWRLy5pTAs97DgXdZCWRDheVnks5RLns3e0X
	 uNs3GJuL9oTn3yw4ZDjoAn7JI0+zkC9aH3dc/9Dj5oOCSMHsnxHauRmZZRXndlcmTD
	 ExgSihuDnQSv2Z4S9/kYaCjee9nbucz16/5vfKHW5avouWC2j3HIcWJf1hLlwUhyZr
	 nnxHDsJMvdhOk0VodfZLkrX2XI8ubVPD8b2E3zca5y8810EL0jSTWQTgs154wirb5W
	 gN09pYqkAAB5khrzexLUTBCVRBCDLmXC0fiWUjJ4cBztKV5cwpJ+emBhFlkMnKekKS
	 CIGY3h8lAU4dA==
Date: Mon, 23 Feb 2026 15:07:06 -0800
Subject: [PATCH 3/5] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bpf@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733175.3935219.14499232455997407711.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78041-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C00417EE1F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Actually copy the attributes/attributes_mask from userspace.  Ignore
file attributes bits that the VFS sets (or doesn't set) on its own.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h |   37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c    |    4 ++++
 fs/fuse/inode.c  |    4 ++++
 3 files changed, 45 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1d4beca5c7018d..79793db3e9a743 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -147,6 +147,10 @@ struct fuse_inode {
 	/** Version of last attribute change */
 	u64 attr_version;
 
+	/** statx file attributes */
+	u64 statx_attributes;
+	u64 statx_attributes_mask;
+
 	union {
 		/* read/write io cache (regular file only) */
 		struct {
@@ -1236,6 +1240,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask,
 				   u64 evict_ctr);
 
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server for local filesystems.  Nonlocal filesystems are
+ * responsible for enforcing and advertising these flags themselves.
+ */
+#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
+					 STATX_ATTR_APPEND)
+
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server.
+ */
+#define FUSE_STATX_VFS_ATTRIBUTES (STATX_ATTR_AUTOMOUNT | STATX_ATTR_DAX | \
+				   STATX_ATTR_MOUNT_ROOT)
+
+static inline u64 fuse_statx_attributes_mask(const struct inode *inode,
+					     const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					       FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
+static inline u64 fuse_statx_attributes(const struct inode *inode,
+					const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					  FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
 u32 fuse_get_cache_mask(struct inode *inode);
 
 /**
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef1232..10fa47e969292f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1464,6 +1464,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes |= fuse_statx_attributes(inode, sx);
+		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1568,6 +1570,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
 		}
+		stat->attributes = fi->statx_attributes;
+		stat->attributes_mask = fi->statx_attributes_mask;
 	}
 
 	return err;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 58c3351b467221..ff8b94cb02e63c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -286,6 +286,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 			fi->i_btime.tv_sec = sx->btime.tv_sec;
 			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
 		}
+
+		fi->statx_attributes = fuse_statx_attributes(inode, sx);
+		fi->statx_attributes_mask = fuse_statx_attributes_mask(inode,
+								       sx);
 	}
 
 	if (attr->blksize)



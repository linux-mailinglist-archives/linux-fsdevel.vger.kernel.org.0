Return-Path: <linux-fsdevel+bounces-50347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47769ACB0FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89CF1888524
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FE222593;
	Mon,  2 Jun 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQcsXKdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC2343D4;
	Mon,  2 Jun 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872978; cv=none; b=sBImL0f7eytc0T/rFTYCKPmTdo7r8zOBZYEDkKyy0XaUys99GdiF+j5cYVou86m+/OG4uUQ2dnPdIPM1ZbeuNQ53VQ1ybtZFqKdjnrShRwMxcwhzLKHoUZf2UIHSOv8ZbABQwk87j6z66bEkkosFqY4J7YAVCAUMaXmZhb8byV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872978; c=relaxed/simple;
	bh=seErxpiSRxkH2bkmFkFAfk0mHe9vn7gtVplOYiMIB5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hx2eqVxyX76pVkwmei45WQgC4OdhI6t80mxwXeP+a/TQIP0m182dwAuVD125/hOmboxIZWGrtL4LinusE0HdDyi6joCQ3zWCAUbR0dXQgcz4sobwBoDvqrR1xc97WrPcUzuMJ5ktbl87WMaojcLGsWuLZRnKzIMljwNZL5gK0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQcsXKdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A82DC4CEF2;
	Mon,  2 Jun 2025 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872978;
	bh=seErxpiSRxkH2bkmFkFAfk0mHe9vn7gtVplOYiMIB5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RQcsXKdX+GVmH4x3RT3xIArc8bw+bjQyTn77Fjj9Pl18oGbh/3R9rSZNzZF7SSIqe
	 gbZdROVqOqYD9S2Hyw7Hwvd9XQXeya8bzti5ZJP+F4GSn+ehMTOYxwZH81A4ygEn/P
	 NnLkSJMtj2p6vC0b8QR1eNtF2WaQIKVNE4clxPyzybRk9bTWwV2yZiX23nXNLWy+RF
	 LkD792DC2bmn7hb7Z2+kVn9R/nhWlwnf+dN+l/7FOsjSDRdd4lBH6fQhizDxlPWy6A
	 eKtfNHkhOPJHB7Fhybn55POBzdNobLR1++97dKmy7GXpWGpFgFNY/Kn4DbkNzeo7zn
	 y/OnDMSu7W3PA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:00 -0400
Subject: [PATCH RFC v2 17/28] filelock: add an inode_lease_ignore_mask
 helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-17-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=seErxpiSRxkH2bkmFkFAfk0mHe9vn7gtVplOYiMIB5M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7nrG4viER6ob/N0NfNizE5cMqkHwJ1oGwl+
 3TbdrPv4VuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5wAKCRAADmhBGVaC
 FellEACFyFCST+vidRNBnhdQbYswOvu6ZZl3xx/7Z93cUUk1jRfcAUebmiajMBY7ZIkI24lhwBC
 9DTZ0JXmeOJxE+WvmijpCVUAZuH50CKBxbrgwl/KzmG2zqJqp+yo8G88a/Z2iw0dcDBw8Jw+c8G
 MK/95LSJHAqWt7dYgZLGemW+8E9YY71+7t01L6BSuTe2dJQX4mzHlEKQgrOUhuGUj9m5YRcH1Cb
 f4C6uoIpU3qX1iuUU8k9MfcBz0hZiv4oSdvvGRWK7e6FVmHEIJnfen9ZRiy9XAjUhaNEo9Sqkgk
 mOcL7u8cKzDbGfOAzimLVfh5GFjJ0d4d3QbnnObmxp1MjuF8BKuPpbQXDLG56iqUy9dYVxjoKSh
 p4qSKOFRsDDCakNyqFOPSilopZvzid84LZCwTpwTaOReBuq51YXjwZt/AgqEuryjtQQ+pesmubx
 mI24dHo1AC89fp143inbdl383kxPJKeaPZLxz7dK4NXxwHgnO8GPEZAFYVNoEwHvY79v7lUBgey
 AhTEklQ/L8Sr120pUufQBIyHWQfSLPfbQOQqcAROadhxxv8EMzs+Ae8XXs7wNDSOcBx0StXJOz0
 buk2/I8AHQTiH3oT13ANxElPvd+xMeR0MZM0zdJiWIeEKNjC1zMYfDAU/3GDZV7CkJxI+NO05V8
 0sEKNT5TqCT+8ng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine that returns a mask of all dir change events that are
currently ignored by any leases. nfsd will use this to determine how to
configure the fsnotify_mark mask.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 32 ++++++++++++++++++++++++++++++++
 include/linux/filelock.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 95270a1fab4a1792a6fcad738cc9d937d99ad2af..522455196353f64d3150c45c9d1cd260751bd7b9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1526,6 +1526,38 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 	return false;
 }
 
+#define IGNORE_MASK	(FL_IGN_DIR_CREATE | FL_IGN_DIR_DELETE | FL_IGN_DIR_RENAME)
+
+/**
+ * inode_lease_ignore_mask - return union of all ignored inode events for this inode
+ * @inode: inode of which to get ignore mask
+ *
+ * Walk the list of leases, and return the result of all of
+ * their FL_IGN_DIR_* bits or'ed together.
+ */
+u32
+inode_lease_ignore_mask(struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock_core *flc;
+	u32 mask = 0;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		mask |= flc->flc_flags & IGNORE_MASK;
+		/* If we already have everything, we can stop */
+		if (mask == IGNORE_MASK)
+			break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return mask;
+}
+EXPORT_SYMBOL_GPL(inode_lease_ignore_mask);
+
 static bool
 ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
 {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 32b30c14f5fd52727b1a18957e9dbc930c922941..4513a8dad3974bf5fb08e0df4f085d71155e04f5 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -244,6 +244,7 @@ int generic_setlease(struct file *, int, struct file_lease **, void **priv);
 int kernel_setlease(struct file *, int, struct file_lease **, void **);
 int vfs_setlease(struct file *, int, struct file_lease **, void **);
 int lease_modify(struct file_lease *, int, struct list_head *);
+u32 inode_lease_ignore_mask(struct inode *inode);
 
 struct notifier_block;
 int lease_register_notifier(struct notifier_block *);

-- 
2.49.0



Return-Path: <linux-fsdevel+bounces-76095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KamOeQagWm0EAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:45:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDBD1C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9B93055D41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA4313E15;
	Mon,  2 Feb 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqCRjkv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05B2BD022;
	Mon,  2 Feb 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068591; cv=none; b=EvCITRFaK/bRMvLOOx4LXYRJzyOf3TqMWnSsuyNKNBA57qY+jc5K8AXDzXxEg/FKETMRffo5KRRFeweDQPxooTOvwZiNwAPRMliDSuKpI1WgXa3Y44+05yEslMFWdmi/+F8BMpww8z2arrRIPWg6f5GdOv6XilNKswOAZxv+Dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068591; c=relaxed/simple;
	bh=7YJAivDabmVCaffYZ+xp/KQQPYrFGABB229oqayuGzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcrANN3xgQg97k7rrC4N/Q7oL72qdba6tB5fb91VSl02VRxqarcRaE8ZDw5f+wtTjEcM4b+oL2d4QZ1XXdaqgz51ghwjR1pUVyR175endAN5ZFQBfVkZzhO3TL+eJI3rRT6H6Cu36RYcub8j1nGaOBysAL//zRBzr/9QcnP2vTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqCRjkv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A99C116C6;
	Mon,  2 Feb 2026 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068590;
	bh=7YJAivDabmVCaffYZ+xp/KQQPYrFGABB229oqayuGzs=;
	h=From:To:Cc:Subject:Date:From;
	b=tqCRjkv8yvKMlMj/zFrGc4tJrGt/LlZHd1KpVxl9qf0gm0jtb5V0yKAAd4EwiLELQ
	 7hckBhslU2rxHyGsvtliGEvOLVj3CQrV8Pk0EWu6YGBiD3VFOLPodvuTmCQhJh7l2+
	 EMy0TaFF/DQeY+ZVfOxUb18vQ2OoZKO3aGLw+BwmWBKqgoprnJ5SBMAuzx0wUQPoFm
	 tFJLTFloR0gTAwE1xG0gA6c5AiBly/TVLkum9PDHnaoai9p8BH29dNc0BMFtEuJoig
	 SukvtshFrTMo3YEgoMjUV6/Le2Y2wHpeQYyfDIniuaj3CoTspm3z9qx/ObnqSlOPts
	 NxZqDIdaNPFkg==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fsverity: add missing fsverity_free_info()
Date: Mon,  2 Feb 2026 13:43:06 -0800
Message-ID: <20260202214306.153492-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76095-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AFDBD1C08
X-Rspamd-Action: no action

If fsverity_set_info() fails, we need to call fsverity_free_info().

Fixes: ada3a1a48d5a ("fsverity: use a hashtable to find the fsverity_info")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/enable.c           |  4 +++-
 fs/verity/fsverity_private.h |  1 +
 fs/verity/open.c             | 14 +++++++-------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 94c88c419054c..c9448074cce17 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -272,12 +272,14 @@ static int enable_verity(struct file *filp,
 	 * the fsverity_info always first checks the S_VERITY flag on the inode,
 	 * which will only be set at the very end of the ->end_enable_verity
 	 * method.
 	 */
 	err = fsverity_set_info(vi);
-	if (err)
+	if (err) {
+		fsverity_free_info(vi);
 		goto rollback;
+	}
 
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
 	 * Serialized with ->begin_enable_verity() by the inode lock.  The file
 	 * system needs to set the S_VERITY flag on the inode at the very end of
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 4d4a0a560562b..2887cb849ceca 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -128,10 +128,11 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 
 struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc);
 
 int fsverity_set_info(struct fsverity_info *vi);
+void fsverity_free_info(struct fsverity_info *vi);
 void fsverity_remove_info(struct fsverity_info *vi);
 
 int fsverity_get_descriptor(struct inode *inode,
 			    struct fsverity_descriptor **desc_ret);
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 04b2e05a95d73..dfa0d1afe0feb 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -176,17 +176,10 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 	desc->sig_size = 0;
 	fsverity_hash_buffer(hash_alg, desc, sizeof(*desc), file_digest);
 	desc->sig_size = sig_size;
 }
 
-static void fsverity_free_info(struct fsverity_info *vi)
-{
-	kfree(vi->tree_params.hashstate);
-	kvfree(vi->hash_block_verified);
-	kmem_cache_free(fsverity_info_cachep, vi);
-}
-
 /*
  * Create a new fsverity_info from the given fsverity_descriptor (with optional
  * appended builtin signature), and check the signature if present.  The
  * fsverity_descriptor must have already undergone basic validation.
  */
@@ -394,10 +387,17 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 		return -EPERM;
 	return ensure_verity_info(inode);
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
+void fsverity_free_info(struct fsverity_info *vi)
+{
+	kfree(vi->tree_params.hashstate);
+	kvfree(vi->hash_block_verified);
+	kmem_cache_free(fsverity_info_cachep, vi);
+}
+
 void fsverity_remove_info(struct fsverity_info *vi)
 {
 	rhashtable_remove_fast(&fsverity_info_hash, &vi->rhash_head,
 			       fsverity_info_hash_params);
 	fsverity_free_info(vi);

base-commit: 8866b64d3d59f5c9ac5c1c1e3acc6ebeb730f1c2
-- 
2.52.0



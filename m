Return-Path: <linux-fsdevel+bounces-77486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJfVHLQUlWlYKwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 02:24:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD9152833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 02:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52FF6301FF9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA082765D4;
	Wed, 18 Feb 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ+BG/eL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA30261B8D;
	Wed, 18 Feb 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377830; cv=none; b=uLRhLtsvZFsq2b7Thx+K+ikChf/Q6jBg5lD/liKb4uF126ZldZwp1AjxjOUg/5NDT8x/MEcan4oLYOdE6gx2fDzL6SD8yPZ2AyLvYcl1ifqE/4sLXVRV4Boj/QWIh/qdYRE+yGRA96vuy+ziesoMZxYTw9yaD3Y4643AghaIFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377830; c=relaxed/simple;
	bh=Xboojag1vEgmqOg34zLpFazvcP43i/jI0x1goHvyFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGoWsEgKWS+fu92wSemJWXilSWlGCcsZHbO7r8vPKLVQQ+likPIj4vvjQG5QPU5RU0wrqtUePFtF0M6ng6Kltbcya2wfiT1jqGLr6iJkJD+cHmRqkI9D9M9sEQ2nGi+NnX+Sa7OeTlkly4HexLgdUwDLk5IeeaW0i3eaTTOpx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ+BG/eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1169C4CEF7;
	Wed, 18 Feb 2026 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377830;
	bh=Xboojag1vEgmqOg34zLpFazvcP43i/jI0x1goHvyFNo=;
	h=From:To:Cc:Subject:Date:From;
	b=bQ+BG/eLuJWw8bYqg6Iq9tsAx3tFm5EaysXtrmjMcljXmjSf8leEzmwaMvGBM9a2D
	 Di7zQIbdet1YvATbX4SRu3PsBLSepdyKwbt//6eJ6nMjf5hpAv1OV5wwVAEFM9GNs6
	 t3l+rlj37kr36WCJOI0yN62rwcJOQg4PHc72pJrtat+3rYEuHR1UpszqmMft8FX4aE
	 t7JIPI5vUsMPEpVy+GTeyOm8p3pQh8wnijNFBoz01fCv+gfR0gC/xqMw2eApc9HJGb
	 eyM9C9Ud+d+h8Z+joMgFdHlqIZlXd5UYvQz1CD0oKE3+8lfmaqUCqQVgywBqK2scfB
	 mo+ALPctDIzOw==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fsverity: fix build error by adding fsverity_readahead() stub
Date: Tue, 17 Feb 2026 17:22:44 -0800
Message-ID: <20260218012244.18536-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77486-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 06CD9152833
X-Rspamd-Action: no action

hppa-linux-gcc 9.5.0 generates a call to fsverity_readahead() in
f2fs_readahead() when CONFIG_FS_VERITY=n, because it fails to do the
expected dead code elimination based on vi always being NULL.  Fix the
build error by adding an inline stub for fsverity_readahead().  Since
it's just for opportunistic readahead, just make it a no-op.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602180838.pwICdY2r-lkp@intel.com/
Fixes: 45dcb3ac9832 ("f2fs: consolidate fsverity_info lookup")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fsverity.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fed91023bea9..29bbc8c66159 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -193,10 +193,12 @@ int __fsverity_file_open(struct inode *inode, struct file *filp);
 
 int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 /* verify.c */
 
+void fsverity_readahead(struct fsverity_info *vi, pgoff_t index,
+			unsigned long nr_pages);
 bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
 			    size_t len, size_t offset);
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
@@ -253,10 +255,15 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
 	return -EOPNOTSUPP;
 }
 
 /* verify.c */
 
+static inline void fsverity_readahead(struct fsverity_info *vi, pgoff_t index,
+				      unsigned long nr_pages)
+{
+}
+
 static inline bool fsverity_verify_blocks(struct fsverity_info *vi,
 					  struct folio *folio, size_t len,
 					  size_t offset)
 {
 	WARN_ON_ONCE(1);
@@ -307,12 +314,10 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 		return __fsverity_file_open(inode, filp);
 	return 0;
 }
 
 void fsverity_cleanup_inode(struct inode *inode);
-void fsverity_readahead(struct fsverity_info *vi, pgoff_t index,
-			unsigned long nr_pages);
 
 struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
 void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 				   unsigned long nr_pages);
 

base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
-- 
2.53.0



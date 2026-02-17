Return-Path: <linux-fsdevel+bounces-77439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFJ9Kd/3lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB3151C9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E3FE303E48B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174E2E2852;
	Tue, 17 Feb 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH1byuRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D996221FCF;
	Tue, 17 Feb 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370438; cv=none; b=Vf8BYpx8kTGhK3iga1wkPu+DqkouTTQJxpLFA6Yehu4dV+dp5OIoEeblM90pFNWI2rtoCpb+WcBec3zyYvr3be5b5nkei4KNunMMK/YSuKamE4ivec4MEaowCkwjf2LnDmZ8L8700Liaf1G7pMIGWKzP2MQKEGr0VIpqDkKpbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370438; c=relaxed/simple;
	bh=iovMwl3vsSr/1iYASJ0FV9smfRbEfy6LTLfI9l7p9TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4QBAsvSpkEqO+RUJvTn92zGleQ5BBV3ktm/CtDBvUqR+9pXv/fiiDOEkXhLrCClcJSsk5wPHedZwfIOlBG07h6cGfmOihipOfcbv0Ua0n8WwadbwWIdWHXiI0Ucp2MnNbP2p9+D8ZJGrrIw0z1MC/SDY4gmeLAsmMNyr4IW4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH1byuRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C2FC19421;
	Tue, 17 Feb 2026 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370438;
	bh=iovMwl3vsSr/1iYASJ0FV9smfRbEfy6LTLfI9l7p9TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jH1byuRcZUfq/vG39V8bav74f1iLxWUCbDaQVmHGUMBsFBb2PzyXDNbPlC23qGAk2
	 BbEEj5yM2OpIr7RqFlc4WmTSqj1AoFRJrBShnJdIq214s6syKLrRhJgGCZZMZDgKCS
	 2CuuPG+JSRbovOjpR+87V/ySE4HNqyPyCJscmEdeghiaRzoAnlz9olfGcV0VHXSFLE
	 1Uk1fVpCBQdcuplTZcv+mqYKZwVx7DNxr+e5c3woLiysU7TJo2E3tgu9+12Qds0SAO
	 quoHdXAlwyZBFJjPu+X+1MSX1YVS7eVlx/h3+rN1CDGY8ESBMMKUuEoiizhBKLEDlu
	 p+4wkZRcxWgQg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 02/35] fsverity: expose ensure_fsverity_info()
Date: Wed, 18 Feb 2026 00:19:02 +0100
Message-ID: <20260217231937.1183679-3-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77439-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEAB3151C9A
X-Rspamd-Action: no action

This function will be used by XFS's scrub to force fsverity activation,
therefore, to read fsverity context.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/open.c         | 5 +++--
 include/linux/fsverity.h | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index dfa0d1afe0fe..0483db672526 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -344,7 +344,7 @@ int fsverity_get_descriptor(struct inode *inode,
 	return 0;
 }
 
-static int ensure_verity_info(struct inode *inode)
+int fsverity_ensure_verity_info(struct inode *inode)
 {
 	struct fsverity_info *vi = fsverity_get_info(inode), *found;
 	struct fsverity_descriptor *desc;
@@ -380,12 +380,13 @@ static int ensure_verity_info(struct inode *inode)
 	kfree(desc);
 	return err;
 }
+EXPORT_SYMBOL_GPL(fsverity_ensure_verity_info);
 
 int __fsverity_file_open(struct inode *inode, struct file *filp)
 {
 	if (filp->f_mode & FMODE_WRITE)
 		return -EPERM;
-	return ensure_verity_info(inode);
+	return fsverity_ensure_verity_info(inode);
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index d8b581e3ce48..16740a331020 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -202,6 +202,7 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
+int fsverity_ensure_verity_info(struct inode *inode);
 
 /* read_metadata.c */
 
@@ -288,6 +289,12 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_ensure_verity_info(struct inode *inode)
+{
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct fsverity_info *vi,
-- 
2.51.2



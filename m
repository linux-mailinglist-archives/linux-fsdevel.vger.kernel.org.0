Return-Path: <linux-fsdevel+bounces-75199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LVgJczfcmntqwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 03:41:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BE6FC05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D66B3012C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243E35C19A;
	Fri, 23 Jan 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="cLOCS3AH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6C272E6D;
	Fri, 23 Jan 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136064; cv=none; b=S7GRYFKoOkzZ1DS0v5pjhAOQJfgscnnJJ2VvoaTj1v9HQav9uBYvVeCcFJSo+Asay1qyfQiF8CKTOUTjPDevKxrnXYnsTzi12+wOhOcbJMzNGE70sTu1qKJsP3SzrtwARhSqteze5519rqJ/ywNUJwSb5NCtfGdPENLG24G1dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136064; c=relaxed/simple;
	bh=iP+Z1BSfQ34DlgbobzgZtwMFnl9QrexkVBD/N2NOYY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BcQPLGweYxgUktD5oph9A/V3EhzeXkFER8wsYytNjjU6+AzJYe2NqTg8teW1VcEAdPbZEAt7UsVh4cAJ3h3sRP/PewLDtbgXoIJuHe48eV6wG5cGBOR/OIJm7zMTxs3bgZcEbAul5L1ajFSK+4GcCVwdOExbIDVbtfvF/qrdbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=cLOCS3AH; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=cLOCS3AHMRFgD7LSTgAC/VDoE7HKuWV30iTyOzqM6j519inAz1Jm2E10XiplbZYG3ecxm5Fi5pzS+
	 NHH8fzdJ/Q0BERZDemEBKr/bYubQc0x6LkTuqJiOYDfltE/UeY6YcRw/vJWBTF8EfrJ2aSqkIAyF1L
	 zWlVj8/FYX+YT5Rw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-21-12024 (RichMail) with SMTP id 2ef86972dee3c3f-04ca3;
	Fri, 23 Jan 2026 10:37:26 +0800 (CST)
X-RM-TRANSID:2ef86972dee3c3f-04ca3
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sfual@cse.ust.hk
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuezhang.Mo@sony.com,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	p22gone@gmail.com,
	kkamagui@gmail.com,
	jimmyxyz010315@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6.12.y] exfat: fix refcount leak in exfat_find
Date: Fri, 23 Jan 2026 10:37:21 +0800
Message-Id: <20260123023721.3779125-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75199-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,sony.com,kernel.org,samsung.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ust.hk:email]
X-Rspamd-Queue-Id: 344BE6FC05
X-Rspamd-Action: no action

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit 9aee8de970f18c2aaaa348e3de86c38e2d956c1d ]

Fix refcount leaks in `exfat_find` related to `exfat_get_dentry_set`.

Function `exfat_get_dentry_set` would increase the reference counter of
`es->bh` on success. Therefore, `exfat_put_dentry_set` must be called
after `exfat_get_dentry_set` to ensure refcount consistency. This patch
relocate two checks to avoid possible leaks.

Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_size")
Fixes: 13940cef9549 ("exfat: add a check for invalid data size")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/exfat/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f0fda3469404..44cce2544a74 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -638,16 +638,6 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->valid_size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
-	if (info->valid_size < 0) {
-		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
-		return -EIO;
-	}
-
-	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
-		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
-		return -EIO;
-	}
-
 	info->start_clu = le32_to_cpu(ep2->dentry.stream.start_clu);
 	if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
 		exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
@@ -685,6 +675,16 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 			     0);
 	exfat_put_dentry_set(&es, false);
 
+	if (info->valid_size < 0) {
+		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
+		return -EIO;
+	}
+
+	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
+		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
+		return -EIO;
+	}
+
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
 			       "non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
-- 
2.34.1




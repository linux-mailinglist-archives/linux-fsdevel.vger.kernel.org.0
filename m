Return-Path: <linux-fsdevel+bounces-41488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E7A2FE19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DF2166C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21625B66C;
	Mon, 10 Feb 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="26Fx85Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728C1B85FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228530; cv=none; b=ShNfNoEob8PQAzbtACNy6PAZi1y6Ox2J02QIThpFAuYYjEx8XjaBG0xYpRl3pF+yH4Ntmd6yccuZ3kPq600XHnIkVqet3qUaolkbVIJvz5SXtyoiKo5zSvu86hAH+DFWZJ4jyhDW/1l4z7F39gakAh1BfxMRjJMhFG1Ij+xTg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228530; c=relaxed/simple;
	bh=cCsQ599BdQ/LlVImvZiL13y3AJLTvvEusNKRDToUqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evn9Y/CY5y6b9V/SMZMgd4BplbySS9zaC4dsxviBPE+ATb3Vr+4CvVPT1PYOKpo6W6uMY2m+Au3umIG3blqTLFVt7h/LyEsTJTh37Qz2p2v7jfeAIX3EimX0gcXKUG+AGcTnhkayHvKnyTACCIf+ycE9+ZEeU8eUpyUhuiaDNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=26Fx85Ve; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e2764aa46so3466357a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1739228527; x=1739833327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0BsiySjBd6YI9B/ehTiRxMBzGNgYKyNK7PxaFo+m8s=;
        b=26Fx85VeUC4ldpZw137Ejl2N+tY/rd4av/KKRMb1S7+hyl8ylSWr2YvQYwTEzedVLJ
         sCvqjzJsk5NctBJ7LBUQmp8O+D8TKQjLfTjZzhBbZP2Yr7IZfK+DRnUtGW71CgjF2oyz
         vTB8INJsDBq4IY6CO1eBcTs06N5wfLrwerhDhazmMaeB9ECLOVn7u8EfNKyMOjFVX8HH
         T+qlZcF4TqfwVDGNAPo/5VCNHLPD8D8BUrvLjMvrLUguGcLLQ6BxBNzkhavR+D5F/Y9D
         wa++6tNvwChprZt8zBgiwY+Lo78e3ah52PDDMznXk7pE1oGxzzlncQHqEYpTR6H3sZ07
         WjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739228527; x=1739833327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0BsiySjBd6YI9B/ehTiRxMBzGNgYKyNK7PxaFo+m8s=;
        b=PWOAKbsgtqGVf9wjjS6zq1WodEpV15QKsvZqS12usuIEvqV5kpmRmcxxPrE0BEwHUG
         8LEaVxLGQgzpOPMYfpxrCeo28ETUZJuLtVzOqkTdGSR3P5eamn2DEXURtEkGr1MkuLRt
         1SZly7KK3y2H/vTScT0+nTIrFc1KNZ9ZWc9N5HEh6ACjyQ088iLum/fwndJAk3cDX+RS
         qOhTKhAPQEEn9beQjhhnyzINSPL3y80zLUgcoqBoJ1YBZa5zF6a4xupjyyiaAIkOkjQk
         dJzchT0wISjZ/vikL2FnW6ZWD4DM9aFDJPCdB/U360jFziqtylk0USCwxc06mZvFB3uU
         NQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNMv8FmRuZwF18EDxR4VFqvuGhEzpJzFMX5q103MRkxOym3QYFESnJckFgYlQo2spl/koOM3jFxO47e+vB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AmpwHlmIxWyemBsigUkViq4JDlhXnjf1R2XVAnejYr2ig3RF
	xX8EQzWGCG1X0uS/FY0BQOi/z60duNrB/EYx1eRkvi6Lzu9z+0cIU9Vr9/XAfPI=
X-Gm-Gg: ASbGncuPjteYINdbPoF7zMjfShXkCpoAzE3wMaS4g+4KDQn1Y//R7ZOhnJ5nomKT7Z8
	HcMEYvH4zhdr/ZIYLDjX3G/nL1faFft5dXPY4ZoBjDDhzMS0V2vz7trPBGej3/gZ3bv9uKCCYnU
	blRoNLnfkKTD4F95ZEw1XSJrH0nVhi5t4zP/EdTWURUsRJFXDl+2kL6Y3uiLoA39/bvQJ1jpMau
	yHQf39MZCA2GluwKmtNgmB72tJ2e4F36na9znxcMhIZAuWkxGM4FNpJa5scTArttl0bo7zGW6ex
	/TLn78RzwZy9BAorDWjsrDzQaZ4LvgJ+
X-Google-Smtp-Source: AGHT+IHIdqWFTaMylb9YeEfaeH3ruzfGxG0nCI/mMHPwtrfRGrM/xLuS/KV2UgjZCtnMiGeobJr6Jw==
X-Received: by 2002:a05:6830:71aa:b0:71e:959:d73d with SMTP id 46e09a7af769-726b87fca8cmr8951102a34.15.1739228527311;
        Mon, 10 Feb 2025 15:02:07 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:dbe1:12d:92bb:ddd1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9512aasm2712164a34.38.2025.02.10.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:02:06 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: cleanup hardcoded constants of file handle size
Date: Mon, 10 Feb 2025 15:01:58 -0800
Message-ID: <20250210230158.178252-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The ceph/export.c contains very confusing logic of
file handle size calculation based on hardcoded values.
This patch makes the cleanup of this logic by means of
introduction the named constants.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/export.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 150076ced937..b2f2af104679 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -33,12 +33,19 @@ struct ceph_nfs_snapfh {
 	u32 hash;
 } __attribute__ ((packed));
 
+#define BYTES_PER_U32		(sizeof(u32))
+#define CEPH_FH_BASIC_SIZE \
+	(sizeof(struct ceph_nfs_fh) / BYTES_PER_U32)
+#define CEPH_FH_WITH_PARENT_SIZE \
+	(sizeof(struct ceph_nfs_confh) / BYTES_PER_U32)
+#define CEPH_FH_SNAPPED_INODE_SIZE \
+	(sizeof(struct ceph_nfs_snapfh) / BYTES_PER_U32)
+
 static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 			      struct inode *parent_inode)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
-	static const int snap_handle_length =
-		sizeof(struct ceph_nfs_snapfh) >> 2;
+	static const int snap_handle_length = CEPH_FH_SNAPPED_INODE_SIZE;
 	struct ceph_nfs_snapfh *sfh = (void *)rawfh;
 	u64 snapid = ceph_snap(inode);
 	int ret;
@@ -88,10 +95,8 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
-	static const int handle_length =
-		sizeof(struct ceph_nfs_fh) >> 2;
-	static const int connected_handle_length =
-		sizeof(struct ceph_nfs_confh) >> 2;
+	static const int handle_length = CEPH_FH_BASIC_SIZE;
+	static const int connected_handle_length = CEPH_FH_WITH_PARENT_SIZE;
 	int type;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -308,7 +313,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 	if (fh_type != FILEID_INO32_GEN  &&
 	    fh_type != FILEID_INO32_GEN_PARENT)
 		return NULL;
-	if (fh_len < sizeof(*fh) / 4)
+	if (fh_len < sizeof(*fh) / BYTES_PER_U32)
 		return NULL;
 
 	doutc(fsc->client, "%llx\n", fh->ino);
@@ -427,7 +432,7 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 
 	if (fh_type != FILEID_INO32_GEN_PARENT)
 		return NULL;
-	if (fh_len < sizeof(*cfh) / 4)
+	if (fh_len < sizeof(*cfh) / BYTES_PER_U32)
 		return NULL;
 
 	doutc(fsc->client, "%llx\n", cfh->parent_ino);
-- 
2.48.0



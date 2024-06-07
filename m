Return-Path: <linux-fsdevel+bounces-21181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31377900339
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C099C2831A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6F194C84;
	Fri,  7 Jun 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="lOCRlfbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C6194A75;
	Fri,  7 Jun 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762583; cv=none; b=Nq8ao1jVBy8yALTlh0pzMcXl1VkxPomtKdrDlct9V1NgvPsnaU05HIawQKA/v0QD6qgnaBV+3EvRomlbuX0arQGCd0sSo5c2Ju8ObGJS3fzFFnOdb4SX6NPtfh4FJf+EOScyqHhFN3oR1pQYITIKrDHqjdT6PvjkBlhVL8pPipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762583; c=relaxed/simple;
	bh=kH+wsSdgaNX52+l+RYxhfvSSu0fwEe5uQnP97NGPDIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwZy3N3hMTpnOn37g+q7H3oeoUkywVOFCjsiyAAgnKuI8hX7a005Jub9EdnPCPpuwyGPXYuVkzmRl6//Hbv+5NIMphGlbPDKDGU9AqDvcJS3huEmS4BjUgCazOShkmnCmsaB0eABorPQRWfYnuVCwPGi9rI32F4Z3qsLgtOBGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=lOCRlfbe; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 035942111;
	Fri,  7 Jun 2024 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762106;
	bh=rZ+FvsoFzB6Ze1li1a6xt3L+qbetk7U6W84312JB2LY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lOCRlfbe8SKKecox0mm04M6lzDP9XrKOTvottIWpmgvqdPiIKgjXFSA5O3suYHubH
	 rVfryGrXjyJjkUb3qWoNmGFBQIhz9cSH4qOhfaU0Ll2zudT4mNNuetU8jRy77Anm6T
	 1auh4x8qin3If9Joy6mPN25ZqsChJZhGWjmd8z3A=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, lei lu
	<llfamsec@gmail.com>
Subject: [PATCH 12/18] fs/ntfs3: Add a check for attr_names and oatbl
Date: Fri, 7 Jun 2024 15:15:42 +0300
Message-ID: <20240607121548.18818-13-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Added out-of-bound checking for *ane (ATTR_NAME_ENTRY).

Reported-by: lei lu <llfamsec@gmail.com>
Fixes: 865e7a7700d93 ("fs/ntfs3: Reduce stack usage")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index d7807d255dfe..055c2af602c3 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3722,6 +3722,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	u64 rec_lsn, checkpt_lsn = 0, rlsn = 0;
 	struct ATTR_NAME_ENTRY *attr_names = NULL;
+	u32 attr_names_bytes = 0;
+	u32 oatbl_bytes = 0;
 	struct RESTART_TABLE *dptbl = NULL;
 	struct RESTART_TABLE *trtbl = NULL;
 	const struct RESTART_TABLE *rt;
@@ -3736,6 +3738,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	struct NTFS_RESTART *rst = NULL;
 	struct lcb *lcb = NULL;
 	struct OPEN_ATTR_ENRTY *oe;
+	struct ATTR_NAME_ENTRY *ane;
 	struct TRANSACTION_ENTRY *tr;
 	struct DIR_PAGE_ENTRY *dp;
 	u32 i, bytes_per_attr_entry;
@@ -4314,17 +4317,40 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb = NULL;
 
 check_attribute_names2:
-	if (rst->attr_names_len && oatbl) {
-		struct ATTR_NAME_ENTRY *ane = attr_names;
-		while (ane->off) {
+	if (attr_names && oatbl) {
+		off = 0;
+		for (;;) {
+			/* Check we can use attribute name entry 'ane'. */
+			static_assert(sizeof(*ane) == 4);
+			if (off + sizeof(*ane) > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
+			ane = Add2Ptr(attr_names, off);
+			t16 = le16_to_cpu(ane->off);
+			if (!t16) {
+				/* this is the only valid exit. */
+				break;
+			}
+
+			/* Check we can use open attribute entry 'oe'. */
+			if (t16 + sizeof(*oe) > oatbl_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
 			/* TODO: Clear table on exit! */
-			oe = Add2Ptr(oatbl, le16_to_cpu(ane->off));
+			oe = Add2Ptr(oatbl, t16);
 			t16 = le16_to_cpu(ane->name_bytes);
+			off += t16 + sizeof(*ane);
+			if (off > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
 			oe->name_len = t16 / sizeof(short);
 			oe->ptr = ane->name;
 			oe->is_attr_name = 2;
-			ane = Add2Ptr(ane,
-				      sizeof(struct ATTR_NAME_ENTRY) + t16);
 		}
 	}
 
-- 
2.34.1



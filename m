Return-Path: <linux-fsdevel+bounces-46196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD8A841FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A9B3A5FC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37D284B4E;
	Thu, 10 Apr 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tRGm6gEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AF284B28
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285567; cv=none; b=E78CGzsoH2OutA01DZcu2yZKoSyJN8+UNcnWZYIM7TDOhfSWJPiCh/KpAnfzfNPw7yY5kVMkpUuB0SR8Shpnp5NK6RvO2UXovP8twxLHdWyKvQL/Bhq21U7fg+gcarzxz+sSJISBFy+RFRl9ThZdF+n1FSvr46NZuQOtO9fw5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285567; c=relaxed/simple;
	bh=D49T6SLCejeoklZXpuLtznN1S9vbVJSgyfAthWsQsbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Os3L0d9g9kO/ZfrCVZTSMkqNGsvfMsFGkrUFDm2QvMXMElxfLV5lWpC3JClob1JeM0dM7uqPJEc6gSp3GvqjQrka2sEd9XCwUw6TYRvhkgLSoo66MHG6ORkv8vKcrERPYXWQDSIMNFOs56JbBlqcOFX+Ao3bg22kh74JZ1W8lOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tRGm6gEx; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=zJST5uWP36CEOsCjl88kv0G84KCvrKxNsC6tp4ucGOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=tRGm6gExrESRuhHOugUr6E6aas5ITxhJuHtwrGMgrJQmdm+3/Mz7wZjoAj4L7lXfO
	 NIU4QSfA1Qj8gnmlWuKt5BuDY6JdBGvx2aEhe11+CjI+uXoQq1MLhkL+CyEe7dnQgi
	 hX4vcVMf36zWcgtFIJNjdyw65RasYFm8QAl10gm9TTYTX5ibpPMCrMtr/uhJeOCOB1
	 32kRAMVFDzO2wTSSKjwtuUZr+3xkDkvxnlmPzuCos3Y3ZGfrrfEAIYDDlxd2QlI5f6
	 Sa0QoksTsNPc0j8e4lAIKg4GHlcIpMksFyuHceF7QGGD3PgZL+0f5aG908JfwDljeB
	 GDsNgzMBVXw0Q==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id 316493058631;
	Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 3F051305839B;
	Thu, 10 Apr 2025 11:46:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:45:29 +0800
Subject: [PATCH 3/5] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
In-Reply-To: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: hJQ1O_zxNEOTFTM_IY-WeKToB5rZlx7U
X-Proofpoint-ORIG-GUID: hJQ1O_zxNEOTFTM_IY-WeKToB5rZlx7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Constant table array array[] which must end with a empty entry and fix
below issues for validate_constant_table(array, ARRAY_SIZE(array), ...):

- Always return wrong value for good constant table array which ends
  with a empty entry.

- Imprecise error message for missorted case.

- Potential NULL pointer dereference.

Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/fs_parser.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 	}
 
 	for (i = 0; i < tbl_size; i++) {
+		if (!tbl[i].name && (i + 1 == tbl_size))
+			break;
+
 		if (!tbl[i].name) {
 			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
 			good = false;
@@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 				good = false;
 			}
 			if (c > 0) {
-				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
+				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
 				       i, tbl[i-1].name, tbl[i].name);
 				good = false;
 			}
 		}
 
-		if (tbl[i].value != special &&
+		if (tbl[i].name && tbl[i].value != special &&
 		    (tbl[i].value < low || tbl[i].value > high)) {
 			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
 			       i, tbl[i].name, tbl[i].value, low, high);

-- 
2.34.1



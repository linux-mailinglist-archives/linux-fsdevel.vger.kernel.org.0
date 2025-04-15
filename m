Return-Path: <linux-fsdevel+bounces-46465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B77A89D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4410189D229
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E802951C3;
	Tue, 15 Apr 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rY4RX+8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host11-snip4-10.eps.apple.com [57.103.64.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4E294A1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719136; cv=none; b=l6u6MXaIf843x6QCst+Dir0bfGK6hnxQsOlhwnjlYMpJmJIpjBUM2ieR9InRo7o/FNeamoKx/H4emnr8dJzFE92Dhq0TlmKHqqixRIL+09cks5fNuQ8mMQZld0f+eGDuFnFE4Wfsj00tdTj7Q+ZuE99Hml4pXpcEVYFcIR9JNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719136; c=relaxed/simple;
	bh=H7LTL9umZKyDsnfMDzZYM/E8okgqBQBFrUVan+djzmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DNlGVzovV4iYGdF5bJNcBkw8JDsTJnHrJe7xWDKfRaKF9jgnOhwZZS3GvLE0p6SyNDc+eSjgGfO7uSZlDaEhEPdbvtQAXYFtJVK2Io5qpd51kYXU8J8G5jrerqeRSLA3jCFfh+wlh4UMo3+XZeC7beFS05YUcOkWELWXux7+nSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rY4RX+8e; arc=none smtp.client-ip=57.103.64.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=prbX2eDvC7yhKvTFBuMdrTVaSPa9eB/EAv2umF7suu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=rY4RX+8e7g4QCLojUtasymv7m5M97ry3w3nFeup362SH0UJO7shq5Ch8lQJQ3aIbC
	 nQ/nWn4/6PLvQ8WssIqwHmtM+WzNYPcw+JsiBZl0/bTxHcuXxAlmiyiZUjOvVraiNJ
	 FF05PzQKA1KPNPXgJGVDCFXy/K+mPsWWcdCcxVm83UwlyIlqSfwAtuKFmNYql21bUX
	 P89ogrilMe7uTwE0xgxw6dzarAR5uIegf7xZ6GMIVu6qe1bePx3lT0Cl8T4oSeS8fT
	 Pq5jkf9iyPWF7HhaeQSHhM+1Z7a99o5bJO7nBwF/lVYTT3KfTqDSY6vGh/N8b+pYbC
	 0Pt1IGiO1xT+w==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id B5E271800096;
	Tue, 15 Apr 2025 12:12:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 15 Apr 2025 20:11:52 +0800
Subject: [PATCH v3] fs/fs_parse: Remove unused and problematic
 validate_constant_table()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-fix_fs-v3-1-0c378cc5ce35@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAdN/mcC/2WMQQ7CIBBFr9LM2jFQqbWuvIdpDI6DnYWgoETTc
 HexW5fv/5c3Q+IonGDfzBA5S5LgK2xWDdBk/ZVRLpWhVW2njFbo5H1yCbes7NCT4W5wUOV75Po
 soeNYeZL0DPGzdLP+rX+JrFFhT9oQ0Y7P1h4eLyHxtKZwg7GU8gVHj39wngAAAA==
X-Change-ID: 20250410-fix_fs-6e0a97c4e59f
To: Jonathan Corbet <corbet@lwn.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: bl664JtNcEyBld6oDCHqRLPUmC_pp4Ln
X-Proofpoint-GUID: bl664JtNcEyBld6oDCHqRLPUmC_pp4Ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504150086

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove validate_constant_table() since:

- It has no caller.

- It has below 3 bugs for good constant table array array[] which must
  end with a empty entry, and take below invocation for explaination:
  validate_constant_table(array, ARRAY_SIZE(array), ...)

  - Always return wrong value due to the last empty entry.
  - Imprecise error message for missorted case.
  - Potential NULL pointer dereference since the last pr_err() may use
    @tbl[i].name NULL pointer to print the last empty entry's name.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Remove validate_constant_table() instead of fixing it
- Link to v2: https://lore.kernel.org/r/20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com

Changes in v2:
- Remove fixes tag for remaining patches
- Add more comment for the NULL pointer dereference issue
- Link to v1: https://lore.kernel.org/r/20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com
---
 Documentation/filesystems/mount_api.rst | 15 ----------
 fs/fs_parser.c                          | 49 ---------------------------------
 include/linux/fs_parser.h               |  5 ----
 3 files changed, 69 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index d92c276f1575af11370dcd4a5d5d0ac97c4d7f4c..cf56086bbd6622a07bbb1e283a86fea40a98a8e6 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -753,21 +753,6 @@ process the parameters it is given.
      If a match is found, the corresponding value is returned.  If a match
      isn't found, the not_found value is returned instead.
 
-   * ::
-
-       bool validate_constant_table(const struct constant_table *tbl,
-				    size_t tbl_size,
-				    int low, int high, int special);
-
-     Validate a constant table.  Checks that all the elements are appropriately
-     ordered, that there are no duplicates and that the values are between low
-     and high inclusive, though provision is made for one allowable special
-     value outside of that range.  If no special value is required, special
-     should just be set to lie inside the low-to-high range.
-
-     If all is good, true is returned.  If the table is invalid, errors are
-     logged to the kernel log buffer and false is returned.
-
    * ::
 
        bool fs_validate_description(const char *name,
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index e635a81e17d965df78ffef27f6885cd70996c6dd..07a78a5064d05009148fa9780f3e031cd3a9b529 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -379,55 +379,6 @@ int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
 EXPORT_SYMBOL(fs_param_is_path);
 
 #ifdef CONFIG_VALIDATE_FS_PARSER
-/**
- * validate_constant_table - Validate a constant table
- * @tbl: The constant table to validate.
- * @tbl_size: The size of the table.
- * @low: The lowest permissible value.
- * @high: The highest permissible value.
- * @special: One special permissible value outside of the range.
- */
-bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
-			     int low, int high, int special)
-{
-	size_t i;
-	bool good = true;
-
-	if (tbl_size == 0) {
-		pr_warn("VALIDATE C-TBL: Empty\n");
-		return true;
-	}
-
-	for (i = 0; i < tbl_size; i++) {
-		if (!tbl[i].name) {
-			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
-			good = false;
-		} else if (i > 0 && tbl[i - 1].name) {
-			int c = strcmp(tbl[i-1].name, tbl[i].name);
-
-			if (c == 0) {
-				pr_err("VALIDATE C-TBL[%zu]: Duplicate %s\n",
-				       i, tbl[i].name);
-				good = false;
-			}
-			if (c > 0) {
-				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
-				       i, tbl[i-1].name, tbl[i].name);
-				good = false;
-			}
-		}
-
-		if (tbl[i].value != special &&
-		    (tbl[i].value < low || tbl[i].value > high)) {
-			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
-			       i, tbl[i].name, tbl[i].value, low, high);
-			good = false;
-		}
-	}
-
-	return good;
-}
-
 /**
  * fs_validate_description - Validate a parameter description
  * @name: The parameter name to search for.
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 53e566efd5fd133d19e313e494b975612a227b77..8d1c2fdd382fb51aee3ccdcc49735d7441581c26 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -87,14 +87,9 @@ extern int lookup_constant(const struct constant_table tbl[], const char *name,
 extern const struct constant_table bool_names[];
 
 #ifdef CONFIG_VALIDATE_FS_PARSER
-extern bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
-				    int low, int high, int special);
 extern bool fs_validate_description(const char *name,
 				    const struct fs_parameter_spec *desc);
 #else
-static inline bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
-					   int low, int high, int special)
-{ return true; }
 static inline bool fs_validate_description(const char *name,
 					   const struct fs_parameter_spec *desc)
 { return true; }

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-fix_fs-6e0a97c4e59f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



Return-Path: <linux-fsdevel+bounces-46481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A002A89E03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704C4444D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714F296D2F;
	Tue, 15 Apr 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DR0HgK59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster5-host8-snip4-10.eps.apple.com [57.103.66.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3D1FDA61
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719924; cv=none; b=sLaBTwIq663h/8Gcj4dPGBM6Maya5E3AYQMqkbtJjEB8/wge1uJB9ZTZuEfMnfKba4KWGaoP3r2ESL0xiGvy8EJXxu1bNPDH4lPX51rlaQ+5yjGRlvUOvFbSpdOoDMluUsSae4kaANc8MylJFQFasqVykieSsP/BV+yVldB8P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719924; c=relaxed/simple;
	bh=jltUQ38KRnxk/jmuA1LlxaWEFSm+NkVCPiXXnAdFpRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a1cY059jl6UyW7xuyLsHAW9ZBxMSAiTN8SAQRJJB5zVv7gHNscbRw67Yzv6DFFXn1ZfBFPSfLfq/2dewQ9sEqt0IPEwDKoImlYvKtUdoGVclZA8HC+sV9uHB/8BhCT+vkkzxejTfYmVplYKZ5liRgO/+8cMaSrztq1PM0MPvsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DR0HgK59; arc=none smtp.client-ip=57.103.66.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=xgxhhlEqIkEJ2KCZO6AJq72n4YhBAvp3VflUxswOa9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=DR0HgK59oXTDtZh8DRhbuvRwbhy/YziyrZCWNL0juh943oKjePC/NO7TeVXktMmmD
	 YFdQ1/bVERHCkW2K1A+hwLC/MXcyVf7Zk7izcIgFIH0K4Fs4SdnjAoheOXFxCyWOOY
	 sb7FuR3czkq5HGx+NSO+2s8d6oguvV6VrUn99Mq8Alih31juepXBUUMD7+2yr5zo7G
	 5AlUHU4ILRimLn9lSdBLNvPTWk9We2vjTKwp8JZAc7gdBC/ySzofZ7IhcIyw4F9fY3
	 pAM4fM67xdbCbxpoNJ97XlucZrnyzgEeLe+z3N9+7NmeA84INK48D/P7i3yhjwy9po
	 y5//1S1R/CZkQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id EE6F0180093E;
	Tue, 15 Apr 2025 12:25:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 15 Apr 2025 20:25:00 +0800
Subject: [PATCH v4] fs/fs_parse: Remove unused and problematic
 validate_constant_table()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-fix_fs-v4-1-5d575124a3ff@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABtQ/mcC/2WMQQ6CMBBFr0JmbU1LWwFX3sMYU8dBZiHFVhsN4
 e4WFkbj8s3890aIFJgibIsRAiWO7PsMZlUAdq6/kOBzZihlaaVRUrT8PLZRbEi6pkJDtmkhj4d
 A+bOE9ofMHce7D6+lm9R8/UskJaSoUBlErOnk3O72YOQe1+ivMEeS/hbtR9Qiq6irGtEiafsrT
 tP0BqZtyl7XAAAA
X-Change-ID: 20250410-fix_fs-6e0a97c4e59f
To: Jonathan Corbet <corbet@lwn.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: AA4KBPzgyiUMCvSca0xXIiMSyoYGS86k
X-Proofpoint-GUID: AA4KBPzgyiUMCvSca0xXIiMSyoYGS86k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504150088

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
Changes in v4:
- Rebase on vfs-6.16.misc branch to fix merge conflict.
- Link to v3: https://lore.kernel.org/r/20250415-fix_fs-v3-1-0c378cc5ce35@quicinc.com

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
index 47dafbb7427e6a829989a815e4d034e48fdbe7a2..e149b89118c885c377a17b95adcdbcb594b34e00 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -752,21 +752,6 @@ process the parameters it is given.
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
index c5cb19788f74771a945801ceedeec69efed0e40a..c092a9f79e324bacbd950165a0eb66632cae9e03 100644
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
  * fs_validate_description - Validate a parameter specification array
  * @name: Owner name of the parameter specification array
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5057faf4f09182fa6e7ddd03fb17b066efd7e58b..5a0e897cae807bbf5472645735027883a6593e91 100644
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
base-commit: 8cc42084abd926e3f005d7f5c23694c598b29cee
change-id: 20250410-fix_fs-6e0a97c4e59f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



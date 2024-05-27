Return-Path: <linux-fsdevel+bounces-20211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9C8CFABC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56201F22E7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3144C68;
	Mon, 27 May 2024 07:58:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBA3B298;
	Mon, 27 May 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796701; cv=none; b=GSLx6xnFLGDrY+66njteBWhQZhxRCcspvwqa7ichaEvgWAyEw3h6duv4+X+VtFtPq4a+ubXLmaUHomc9+/tMY/RQ0bDqxYgjWyQdjjzG+u9GH/0VzNKeXTeYOymHQlsFW97niU5Sw9v3Dd2NeyFns3aqtRm/XSW7zSIS9vs0c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796701; c=relaxed/simple;
	bh=4XOH+KIQn0yMccABDFAN4+JzP4A4dRp1QiXB4Ol3pCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACz9Vmez19oxnGPqDhlZ0HMoA/in2/sPAJKCc5nTmmJjiREZXDcjalvKzhxOWLVov0UeCV9fKSWP6USvEzWOJiuYuheFegckTn5FHv+QG1Cxe1MTDfSMzFsCLW/IR3ChL6VpHSJAJXRbay0ujjJJD8hnhL6VbLIod6ROFhiPBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VnnxQ1JyJz1ysW0;
	Mon, 27 May 2024 15:55:06 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BC2C14037F;
	Mon, 27 May 2024 15:58:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 15:58:12 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH v2 2/4] fs: add path parser for filesystem mount option.
Date: Mon, 27 May 2024 15:58:52 +0800
Message-ID: <20240527075854.1260981-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527075854.1260981-1-lihongbo22@huawei.com>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

`fsparam_path` uses `fs_param_is_path` to parse the option, but it
is currently empty. The new mount api has considered this option in
`fsconfig`(that is FSCONFIG_SET_PATH). Here we add general path parser
in filesystem layer. Currently, no filesystem uses this function to
parse parameters, we add `void *ptr` in `fs_parse_result` to point to
the target structure(such as `struct inode *`).

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fs_parser.c            | 18 ++++++++++++++++++
 include/linux/fs_parser.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 2aa208cf2027..5d0adcc514d8 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -367,6 +367,24 @@ EXPORT_SYMBOL(fs_param_is_blockdev);
 int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
+	int ret;
+	struct filename *f;
+	struct path path;
+
+	if (param->type != fs_value_is_filename)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+
+	f = param->name;
+	ret = filename_lookup(param->dirfd, f, LOOKUP_FOLLOW, &path, NULL);
+	if (ret < 0) {
+		error_plog(log, "%s: Lookup failure for '%s'", param->key, f->name);
+		return fs_param_bad_value(log, param);
+	}
+	result->ptr = d_backing_inode(path.dentry);
+	path_put(&path);
+
 	return 0;
 }
 EXPORT_SYMBOL(fs_param_is_path);
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index d3350979115f..489c71d06a5f 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -57,6 +57,7 @@ struct fs_parse_result {
 		int		int_32;		/* For spec_s32/spec_enum */
 		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
 		u64		uint_64;	/* For spec_u64 */
+		const void	*ptr;		/* For spec_ptr */
 	};
 };
 
-- 
2.34.1



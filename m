Return-Path: <linux-fsdevel+bounces-26953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3595D46C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418121C20A46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42A190670;
	Fri, 23 Aug 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ahX/SCZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE82193414;
	Fri, 23 Aug 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434439; cv=none; b=IGKexgUAZmpGCLaEheHwYi3cGETXwd2HSiYTOtAjscjjaxmljrlc/86vwUvwbdsoEuoMZr4OSQpjBXg8YqDPODDI+CZPrHlrGWeDv407iWsl/KW/OtgbTOlklwenBRNPuC6iJDI7oWmLP3QH7Bzbv851cgI2HJi/fF2qU3dc/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434439; c=relaxed/simple;
	bh=oAkC2gyEvYqie2BMaBkOi+Q3ObXHcVC5/ivUbijOClQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZRuncdbpYe55kaCks6pH3qOGG76erjM+eteQAMe/E7nuf4CEv46XIu24K8xTpnV04+yuc7IpOQqZ/N4NKPgHMExlrNLxwjjGWBNipyo/d7ZSC7m0x3Qr5O+qjrzk7QpaWLfpy4SYowfS6ke7eERN+BFjsoL1eUAPd1cOLHEmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ahX/SCZP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8fGDhDblxpiWpLMEgOVUHiirq5YHZlp3LvTsoH5n4cY=; b=ahX/SCZPOOraUkYBrU/yJolT6B
	Kaff1CccaDHutwJ9fMceTjyx8yuoufIaCaSXL4xLmYLVu4Ez7dQW4SgRl1UX9kBjwJDz/csOehy2U
	2PLh06v/HDwbslSyxxYPnjW9iFO/fRPxH+3yRnP9tzLA97V7wyfigHZCPaLAOYmap67CMl+cAf/Hr
	k0mPm5XcFUDm4G95UQzuKEKhDVaDMKnqS+ZZEPQuaSb0073EAbelrlCU5MXEQkXoBOtRuL5jj6PgG
	Xx0bNvwyYLrQ1BkNMqP/KAVd/YO9auXgQEg00LEbCQKYOPATfIhN5QBeZBa6ymMaIfap3YL9tbNqU
	yROXwNDw==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYAX-0048Ww-3i; Fri, 23 Aug 2024 19:33:49 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 3/5] tmpfs: Create casefold mount options
Date: Fri, 23 Aug 2024 14:33:30 -0300
Message-ID: <20240823173332.281211-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823173332.281211-1-andrealmeid@igalia.com>
References: <20240823173332.281211-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Most filesystems have their data stored in disk, so casefold option need
to be enabled when building a filesystem on a device (via mkfs).
However, as tmpfs is a RAM backed filesystem, there's no disk
information and thus no mkfs to store information about casefold.

For tmpfs, create casefold options for mounting. Userspace can then
enable casefold support for a mount point using:

$ mount -t tmpfs -o casefold=utf8-12.1.0 fs_name mount_dir/

Userspace must set what Unicode standard is aiming to. The available
options depends on what the kernel Unicode subsystem supports.

And for strict encoding:

$ mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding fs_name mount_dir/

Strict encoding means that tmpfs will refuse to create invalid UTF-8
sequences. When this option is not enabled, any invalid sequence will be
treated as an opaque byte sequence, ignoring the encoding thus not being
able to be looked up in a case-insensitive way.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 mm/shmem.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 67b6ab580ca2..5c77b4e73204 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4102,6 +4102,8 @@ enum shmem_param {
 	Opt_usrquota_inode_hardlimit,
 	Opt_grpquota_block_hardlimit,
 	Opt_grpquota_inode_hardlimit,
+	Opt_casefold,
+	Opt_strict_encoding,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -4133,9 +4135,67 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
 	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit),
 #endif
+	fsparam_string("casefold",	Opt_casefold),
+	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
 	{}
 };
 
+#if IS_ENABLED(CONFIG_UNICODE)
+static int utf8_parse_version(const char *version, unsigned int *maj,
+			      unsigned int *min, unsigned int *rev)
+{
+	substring_t args[3];
+	char version_string[12];
+	static const struct match_token token[] = {
+		{1, "%d.%d.%d"},
+		{0, NULL}
+	};
+
+	strscpy(version_string, version, sizeof(version_string));
+
+	if (match_token(version_string, token, args) != 1)
+		return -EINVAL;
+
+	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
+	    match_int(&args[2], rev))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct shmem_options *ctx = fc->fs_private;
+	unsigned int maj, min, rev, version_number;
+	char version[10];
+	int ret;
+	struct unicode_map *encoding;
+
+	if (strncmp(param->string, "utf8-", 5))
+		return invalfc(fc, "Only utf8 encondings are supported");
+	ret = strscpy(version, param->string + 5, sizeof(version));
+	if (ret < 0)
+		return invalfc(fc, "Invalid enconding argument: %s",
+			       param->string);
+
+	utf8_parse_version(version, &maj, &min, &rev);
+	version_number = UNICODE_AGE(maj, min, rev);
+	encoding = utf8_load(version_number);
+	if (IS_ERR(encoding))
+		return invalfc(fc, "Invalid utf8 version: %s", version);
+	pr_info("tmpfs: Using encoding provided by mount options: %s\n",
+		param->string);
+	ctx->encoding = encoding;
+
+	return 0;
+}
+#else
+static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param)
+{
+	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n");
+}
+#endif
+
 static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct shmem_options *ctx = fc->fs_private;
@@ -4294,6 +4354,11 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 				       "Group quota inode hardlimit too large.");
 		ctx->qlimits.grpquota_ihardlimit = size;
 		break;
+	case Opt_casefold:
+		return shmem_parse_opt_casefold(fc, param);
+	case Opt_strict_encoding:
+		ctx->strict_encoding = true;
+		break;
 	}
 	return 0;
 
-- 
2.46.0



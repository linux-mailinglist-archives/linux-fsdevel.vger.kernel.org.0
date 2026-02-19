Return-Path: <linux-fsdevel+bounces-77682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIZxIcGylmmRjwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:50:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D015C7D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0241E301485E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401823090DE;
	Thu, 19 Feb 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0GJW5jF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E326F2A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483830; cv=none; b=mxG5gFioh/y5ZmZtzOst8nL4HT6YCTJ7a1H8UrpaY/BEzpj3pp8hg9KlwBWZ9e6uCSexXmnJalkSsUWQPFQ0WBqrBoFtU5W7FXBW65UnIqjj7xu8AfsHyLAufnh2c5EXDEpZgdXOjazckAu/h4v3ykLkHHRV8MiY3vX/Vd142Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483830; c=relaxed/simple;
	bh=4FD/S3K4f9ElJp2nm4gy9bONQh/98yi8AGHbubNQaJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRN1DLelkHOMSYAPLDcGYnIQrJDQcrNnPjiNABkiFrb8Zy9ILEPMyPpeziSok/VMmpBiwSv4fwLgXIMYoOkaqgI1+elvKfU7zv5jlQktojfiRRAqktZEKs6ZRRkILmZ8zO3r3UfYKuol/QsZDC5v+1IrZYj4j3Qq1fltDOUQdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W0GJW5jF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b5vSNzkrZcXhL5V43mIsSMrVzXOh03tDbKKaH7gvC5s=; b=W0GJW5jF5F/VJmj9BH4hFGIlGq
	0/9TBpvjLOV7iP5CYILq0aiirM/eTqaobh/MUhWRNd/hnqiqYA8Z3rjW3zq0kEYH/BooPbjWEacVU
	9qzMtbvEe01DsGcO3/O97+T+aeimpnZ+a9jBBrs+uDBCMFe7JeiWlGqRVEJHr4spT4aFd+xCePD2z
	NL/S6HHLSCQTsumk/rjE2Dc/NgA/Y4Z0Ws1Xt5+kxc2bS4VX5MiRMN6K5GmlpVvYJHFnpGWYbNqh7
	+mGbzWrANpA693Nfuy3X4ST7vQ/0WkZt39eMgV/AzKAH8BSSdKKuVIZgEXIqJxyInZCfdGD4S/LLw
	F6HfoNWw==;
Received: from [212.185.66.17] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxrp-0000000AzIv-0ucM;
	Thu, 19 Feb 2026 06:50:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] fs: remove fsparam_blob / fs_param_is_blob
Date: Thu, 19 Feb 2026 07:50:02 +0100
Message-ID: <20260219065014.3550402-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219065014.3550402-1-hch@lst.de>
References: <20260219065014.3550402-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77682-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 016D015C7D7
X-Rspamd-Action: no action

These are not used anywhere even after the fs_context conversion is
finished, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/mount_api.rst | 2 --
 fs/fs_parser.c                          | 9 ---------
 include/linux/fs_parser.h               | 3 +--
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index a064234fed5b..b4a0f23914a6 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -647,7 +647,6 @@ The members are as follows:
 	fs_param_is_u64		64-bit unsigned int	result->uint_64
 	fs_param_is_enum	Enum value name 	result->uint_32
 	fs_param_is_string	Arbitrary string	param->string
-	fs_param_is_blob	Binary blob		param->blob
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
 	fs_param_is_fd		File descriptor		result->int_32
@@ -681,7 +680,6 @@ The members are as follows:
 	fsparam_u64()		fs_param_is_u64
 	fsparam_enum()		fs_param_is_enum
 	fsparam_string()	fs_param_is_string
-	fsparam_blob()		fs_param_is_blob
 	fsparam_bdev()		fs_param_is_blockdev
 	fsparam_path()		fs_param_is_path
 	fsparam_fd()		fs_param_is_fd
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 46993e31137d..79e8fe9176fa 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -277,15 +277,6 @@ int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_string);
 
-int fs_param_is_blob(struct p_log *log, const struct fs_parameter_spec *p,
-		     struct fs_parameter *param, struct fs_parse_result *result)
-{
-	if (param->type != fs_value_is_blob)
-		return fs_param_bad_value(log, param);
-	return 0;
-}
-EXPORT_SYMBOL(fs_param_is_blob);
-
 int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index ac8253cca2bc..961562b101c5 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -27,7 +27,7 @@ typedef int fs_param_type(struct p_log *,
  * The type of parameter expected.
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
-	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
+	fs_param_is_enum, fs_param_is_string, fs_param_is_blockdev,
 	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
 	fs_param_is_file_or_string;
 
@@ -125,7 +125,6 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
 #define fsparam_string(NAME, OPT) \
 				__fsparam(fs_param_is_string, NAME, OPT, 0, NULL)
-#define fsparam_blob(NAME, OPT)	__fsparam(fs_param_is_blob, NAME, OPT, 0, NULL)
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
-- 
2.47.3



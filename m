Return-Path: <linux-fsdevel+bounces-13964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769E875C67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B990D1C2118A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD028E0B;
	Fri,  8 Mar 2024 02:45:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6428DBF;
	Fri,  8 Mar 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865901; cv=none; b=pIgpABHboXKij2vOA4gNo7xOyWJK6ncWXcCJj18agw2PgMF72tAInOle8nxXyQnmYbC698v8l6q2kKUpQWqTQYH2VjnFd/OfdiWtxRdU5Oc2tZzmGipdY0pV/Kz0Kr8aLSV4cLx5eUGLvBHSNiL9G1/FnPWvMKdwOwIRs06+CbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865901; c=relaxed/simple;
	bh=hewgVoh+8E19PToE5glPa2Raity2MreSYsiIMlWmWdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5YMOps1kzneVf3WyOim/VEfcR4MFdPa1G96WdbBZqBUw3+imowvxG3LauwArTg6wWZFCxKj9mY7wUlVBjLs7FLweew0HOs7m7JstMc3LYM98RPO4NoByhrKOYNrGkZG7yj75R97cL1hM6rU2tpU4qzByfDcmOqMX0Mki+ruuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A04B24DA4A;
	Thu,  7 Mar 2024 16:02:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB1F212FC5;
	Thu,  7 Mar 2024 16:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOlpKhfl6WXtcwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 07 Mar 2024 16:02:31 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 1f0200b0;
	Thu, 7 Mar 2024 16:02:29 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2 2/3] ext4: fix the parsing of empty string mount parameters
Date: Thu,  7 Mar 2024 16:02:24 +0000
Message-ID: <20240307160225.23841-3-lhenriques@suse.de>
In-Reply-To: <20240307160225.23841-1-lhenriques@suse.de>
References: <20240307160225.23841-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A04B24DA4A
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This patch fixes the usage of mount parameters that are defined as strings
but which can be empty.  Currently, only 'usrjquota' and 'grpjquota'
parameters are in this situation for ext4.  But since userspace can pass
them in as 'flag' types (when they don't have a value), the parsing will
fail because a 'string' type is assumed.

This issue is fixed by using the new helper fsparam_string_or_flag() and by
also taking the parameter type into account.

While there, also remove the now unused fsparam_string_empty() macro and
change the 'test_dummy_encryption' parameter to also use the new fs_parser
helper.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/ext4/super.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..5a2f178f8fe9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1724,10 +1724,6 @@ static const struct constant_table ext4_param_dax[] = {
 	{}
 };
 
-/* String parameter that allows empty argument */
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
 /*
  * Mount option specification
  * We don't use fsparam_flag_no because of the way we set the
@@ -1768,9 +1764,9 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_enum	("data",		Opt_data, ext4_param_data),
 	fsparam_enum	("data_err",		Opt_data_err,
 						ext4_param_data_err),
-	fsparam_string_empty
+	fsparam_string_or_flag
 			("usrjquota",		Opt_usrjquota),
-	fsparam_string_empty
+	fsparam_string_or_flag
 			("grpjquota",		Opt_grpjquota),
 	fsparam_enum	("jqfmt",		Opt_jqfmt, ext4_param_jqfmt),
 	fsparam_flag	("grpquota",		Opt_grpquota),
@@ -1814,9 +1810,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_u32	("fc_debug_max_replay",	Opt_fc_debug_max_replay),
 #endif
 	fsparam_u32	("max_dir_size_kb",	Opt_max_dir_size_kb),
-	fsparam_flag	("test_dummy_encryption",
-						Opt_test_dummy_encryption),
-	fsparam_string	("test_dummy_encryption",
+	fsparam_string_or_flag
+			("test_dummy_encryption",
 						Opt_test_dummy_encryption),
 	fsparam_flag	("inlinecrypt",		Opt_inlinecrypt),
 	fsparam_flag	("nombcache",		Opt_nombcache),
@@ -2183,15 +2178,15 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	switch (token) {
 #ifdef CONFIG_QUOTA
 	case Opt_usrjquota:
-		if (!*param->string)
-			return unnote_qf_name(fc, USRQUOTA);
-		else
+		if ((param->type == fs_value_is_string) &&
+		    (*param->string))
 			return note_qf_name(fc, USRQUOTA, param);
+		return unnote_qf_name(fc, USRQUOTA);
 	case Opt_grpjquota:
-		if (!*param->string)
-			return unnote_qf_name(fc, GRPQUOTA);
-		else
+		if ((param->type == fs_value_is_string) &&
+		    (*param->string))
 			return note_qf_name(fc, GRPQUOTA, param);
+		return unnote_qf_name(fc, GRPQUOTA);
 #endif
 	case Opt_sb:
 		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {


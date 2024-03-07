Return-Path: <linux-fsdevel+bounces-13910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7538755F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35777B22A17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154991332A6;
	Thu,  7 Mar 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C/djWXY9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mbzQuoAW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C/djWXY9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mbzQuoAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8412FB3E;
	Thu,  7 Mar 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835425; cv=none; b=u2+tibIpPEbxa8LPVEzTksX+mutFIT/N+jmaK8Chcht5femmwrSbX77N/uYPdK6OFJRhRlIvZ0vb70a48nJxioaNHb4wCVfZItfIJkNOl1+Trw2EPsdMPGRIG4s1FHu8VSB05OWA3U8vJ8/kbG96pfYxGbqLQaKKb0a5JrPnaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835425; c=relaxed/simple;
	bh=wPNhnbjYtr8nNf0xfcvCWhf/R2zeOK/14UW2AOf6LHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+sqotT21QBRuHeDKtmaU1C1c+IfOSvJDl5Id14qZp04R5DTj0dsPQPHHCiKAZir8ber56QUK4tsaky+6RiaU/fEnEeFQ6+GCm0yNJwD1IRO4JxLbHAQNDFi54UajD/DucLYcw/RIGJltR4h5yTkQETqIotckUU1pgGuEsny2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C/djWXY9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mbzQuoAW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C/djWXY9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mbzQuoAW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 841905D00A;
	Thu,  7 Mar 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMNJbshkkARiLJa25Qz/aZkoMSzYIEZDxAvRw1s71Sw=;
	b=C/djWXY94UZf8tSS//GXm9k2HLaDnognY2Th4qwfzL+5lFOZ6eDg/lfRfFZk/YXK0bYbV8
	1w4Wh6i9nB18Fp0P/vcAdYDwmqUYaFFtr0LI4PTcwUDwLY2sAaMHvDtrxuKLLZ1eYW1Qoc
	XSvF+dXuaD4HDIkyAfW3DDbhxJsAEaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMNJbshkkARiLJa25Qz/aZkoMSzYIEZDxAvRw1s71Sw=;
	b=mbzQuoAWb39WAt4VKnGIq4DtAR+T2dNJTMMBXhhSrBhsc1zDOqHWQ45M69a8STV4keZxsZ
	68KFqYUFkZHd6XAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMNJbshkkARiLJa25Qz/aZkoMSzYIEZDxAvRw1s71Sw=;
	b=C/djWXY94UZf8tSS//GXm9k2HLaDnognY2Th4qwfzL+5lFOZ6eDg/lfRfFZk/YXK0bYbV8
	1w4Wh6i9nB18Fp0P/vcAdYDwmqUYaFFtr0LI4PTcwUDwLY2sAaMHvDtrxuKLLZ1eYW1Qoc
	XSvF+dXuaD4HDIkyAfW3DDbhxJsAEaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMNJbshkkARiLJa25Qz/aZkoMSzYIEZDxAvRw1s71Sw=;
	b=mbzQuoAWb39WAt4VKnGIq4DtAR+T2dNJTMMBXhhSrBhsc1zDOqHWQ45M69a8STV4keZxsZ
	68KFqYUFkZHd6XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8DB12FC5;
	Thu,  7 Mar 2024 16:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eOCUJhjl6WXtcwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 07 Mar 2024 16:02:32 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id f65e79f4;
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
Subject: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
Date: Thu,  7 Mar 2024 16:02:25 +0000
Message-ID: <20240307160225.23841-4-lhenriques@suse.de>
In-Reply-To: <20240307160225.23841-1-lhenriques@suse.de>
References: <20240307160225.23841-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 BAYES_HAM(-0.00)[44.69%]
X-Spam-Flag: NO

This patch fixes the usage of mount parameters that are defined as strings
but which can be empty.  Currently, only 'lowerdir' parameter is in this
situation for overlayfs.  But since userspace can pass it in as 'flag'
type (when it doesn't have a value), the parsing will fail because a
'string' type is assumed.

This issue is fixed by using the new helper fsparam_string_or_flag() and by
also taking the parameter type into account.

While there, also remove the now unused fsparam_string_empty() macro.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/overlayfs/params.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 112b4b12f825..6eb163ca4b92 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -139,12 +139,8 @@ static int ovl_verity_mode_def(void)
 	return OVL_VERITY_OFF;
 }
 
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
-
 const struct fs_parameter_spec ovl_parameter_spec[] = {
-	fsparam_string_empty("lowerdir",    Opt_lowerdir),
+	fsparam_string_or_flag("lowerdir",    Opt_lowerdir),
 	fsparam_string("lowerdir+",         Opt_lowerdir_add),
 	fsparam_string("datadir+",          Opt_datadir_add),
 	fsparam_string("upperdir",          Opt_upperdir),
@@ -424,12 +420,13 @@ static void ovl_reset_lowerdirs(struct ovl_fs_context *ctx)
  *     "/data1" and "/data2" as data lower layers. Any existing lower
  *     layers are replaced.
  */
-static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
+static int ovl_parse_param_lowerdir(struct fs_context *fc, struct fs_parameter *param)
 {
 	int err;
 	struct ovl_fs_context *ctx = fc->fs_private;
 	struct ovl_fs_context_layer *l;
 	char *dup = NULL, *iter;
+	const char *name = param->string;
 	ssize_t nr_lower, nr;
 	bool data_layer = false;
 
@@ -441,7 +438,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	/* drop all existing lower layers */
 	ovl_reset_lowerdirs(ctx);
 
-	if (!*name)
+	if ((param->type == fs_value_is_flag) || (!*name))
 		return 0;
 
 	if (*name == ':') {
@@ -572,7 +569,7 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case Opt_lowerdir:
-		err = ovl_parse_param_lowerdir(param->string, fc);
+		err = ovl_parse_param_lowerdir(fc, param);
 		break;
 	case Opt_lowerdir_add:
 	case Opt_datadir_add:


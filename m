Return-Path: <linux-fsdevel+bounces-13199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E221286CF54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8115A1F21567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7978270;
	Thu, 29 Feb 2024 16:30:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FA160638;
	Thu, 29 Feb 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224220; cv=none; b=hBPv59AVeJOSCvrXCS0lIzE9e1rdEnAInjRJE4Kc+HI5O9xDN2zPnt2N3KmPnZ7RuS11p9nbzeRG+UI1LBuKNBJEcUu/RI7xCeTKHm9iyQoVOYRGm3EX3kJMmvB2EmwOZJyCg9jugxDlLNopWyi1FeY607WjFEVuLkmjBds2A80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224220; c=relaxed/simple;
	bh=vTk9qY7Ap4iFsr2Q/nS6b1xXOiZqaEGYtgbyecVJ1DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9RA8N867OCZN485wPgnbFg9UUjtqoKbz6+PdKT2hqIME4z2MheIq/8rKYQmmXJSGkBSXllNOezjo/7LmhkxxFC+Q1f9I5QzsZaPsj0bfedfdVlQQe7vKbwFKLxnpDUpc8SagBlGWaiI0VarGRL1J8n1yyaob/TF51lxEi25DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C35BD21E07;
	Thu, 29 Feb 2024 16:30:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0355813A4B;
	Thu, 29 Feb 2024 16:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMIpORex4GU0PwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 29 Feb 2024 16:30:15 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 71ffe845;
	Thu, 29 Feb 2024 16:30:14 +0000 (UTC)
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
Subject: [PATCH 2/3] ext4: fix mount parameters check for empty values
Date: Thu, 29 Feb 2024 16:30:09 +0000
Message-ID: <20240229163011.16248-3-lhenriques@suse.de>
In-Reply-To: <20240229163011.16248-1-lhenriques@suse.de>
References: <20240229163011.16248-1-lhenriques@suse.de>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C35BD21E07
X-Spam-Flag: NO

Now that parameters that have the flag 'fs_param_can_be_empty' set and
their value is NULL are handled as 'flag' type, we need to properly check
for empty (NULL) values.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..44ba2212dfb3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2183,12 +2183,12 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	switch (token) {
 #ifdef CONFIG_QUOTA
 	case Opt_usrjquota:
-		if (!*param->string)
+		if (!param->string)
 			return unnote_qf_name(fc, USRQUOTA);
 		else
 			return note_qf_name(fc, USRQUOTA, param);
 	case Opt_grpjquota:
-		if (!*param->string)
+		if (!param->string)
 			return unnote_qf_name(fc, GRPQUOTA);
 		else
 			return note_qf_name(fc, GRPQUOTA, param);


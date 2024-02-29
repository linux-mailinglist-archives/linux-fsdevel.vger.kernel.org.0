Return-Path: <linux-fsdevel+bounces-13198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E986CF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD281C232B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2365692FD;
	Thu, 29 Feb 2024 16:30:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41663B9;
	Thu, 29 Feb 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224219; cv=none; b=J9LAZXBiqWpmHfiXOdGz9P4WjMjUnniMyWa1x94z9PDBSck8HyKkIZR+UM0VFIsieHo0liDjUAqAWxhwLWrrS5AvBYteghLKifXCP1L7eZzKnhWaY8nKEMHOXla/DHnqExbsiXvgKIDPb4VE0ujOrwN91S4pB+EkWsMIh4tSu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224219; c=relaxed/simple;
	bh=Xk9XcUV/m/3qcxL2T7wAJKSjMepPVZ/pH5SeAdJs0Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bze0lyIMrz2HfK5K/SP8NxAoMjq0TeCiXtmbDWtKvYytYgmuUB3XZ8dLZGF7nIdjVOjL3kl4eBmQAiov3TPdOOTyBR6t6H/e8O+WKLm4nJqn4CKaNfUYu853odRD48/saBgpETPnxY83syKC31IpcDCIfjqB6c2txjX3OrS+Dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E036C21FD4;
	Thu, 29 Feb 2024 16:30:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2150613A8B;
	Thu, 29 Feb 2024 16:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNTjBBex4GU0PwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 29 Feb 2024 16:30:15 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id aac9d32e;
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
Subject: [PATCH 1/3] fs_parser: handle parameters that can be empty and don't have a value
Date: Thu, 29 Feb 2024 16:30:08 +0000
Message-ID: <20240229163011.16248-2-lhenriques@suse.de>
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
X-Rspamd-Queue-Id: E036C21FD4
X-Spam-Flag: NO

Currently, only parameters that have the fs_parameter_spec 'type' set to
NULL are handled as 'flag' types.  However, parameters that have the
'fs_param_can_be_empty' flag set and their value is NULL should also be
handled as 'flag' type, as their type is set to 'fs_value_is_flag'.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/fs_parser.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index edb3712dcfa5..53f6cb98a3e0 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
 	/* Try to turn the type we were given into the type desired by the
 	 * parameter and give an error if we can't.
 	 */
-	if (is_flag(p)) {
+	if (is_flag(p) ||
+	    (!param->string && (p->flags & fs_param_can_be_empty))) {
 		if (param->type != fs_value_is_flag)
 			return inval_plog(log, "Unexpected value for '%s'",
 				      param->key);


Return-Path: <linux-fsdevel+bounces-13200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87A86CF78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6464EB2C726
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D887A12E;
	Thu, 29 Feb 2024 16:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1E381B0;
	Thu, 29 Feb 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224221; cv=none; b=lsF24aMoUe1awThDe0rxMPxaGCbqUkphiBAFU83JXSpF6R3hXjNQymk+p85QTGCMQsNXCQQXBoz7lVmjSVmDavlwPcoSOCLwJFhGMNg//soa7fttdjJC15vCAbx+UN0vV/YHGzj4UZFV8mYl0HmtIZ4AD8p2dlA2YdUleGtl0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224221; c=relaxed/simple;
	bh=6/KrjLjKH3bauC/9VQHcqfuKTv2YG01tiR8gHwzXGeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7t78A9Rgy+56mEwEI0BXEbRdNzBjOnyFifnt3nC2YBcMfOnhD1Wpp8aaepujSZKFq3ScCG/GZH8hn20tsgmI7vPtJpQFQyGmEy7rRLPMsQlLmSclex/v9qIXz1XCAT+Dop4l94QYdknK0cyM8Xy64UfeQbE3yNQ5Jf7QnmOeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A728921FE2;
	Thu, 29 Feb 2024 16:30:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA54713A4B;
	Thu, 29 Feb 2024 16:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEMPMhix4GU0PwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 29 Feb 2024 16:30:16 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id bdc647ed;
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
Subject: [PATCH 3/3] overlay: fix mount parameters check for empty values
Date: Thu, 29 Feb 2024 16:30:10 +0000
Message-ID: <20240229163011.16248-4-lhenriques@suse.de>
In-Reply-To: <20240229163011.16248-1-lhenriques@suse.de>
References: <20240229163011.16248-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A728921FE2
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Now that parameters that have the flag 'fs_param_can_be_empty' set and
their value is NULL are handled as 'flag' type, we need to properly check
for empty (NULL) values.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/overlayfs/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 112b4b12f825..09428af6abc5 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -441,7 +441,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	/* drop all existing lower layers */
 	ovl_reset_lowerdirs(ctx);
 
-	if (!*name)
+	if (!name)
 		return 0;
 
 	if (*name == ':') {


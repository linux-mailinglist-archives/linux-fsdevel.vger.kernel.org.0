Return-Path: <linux-fsdevel+bounces-70065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F197CC8FB4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DC3ABA65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3362E92C0;
	Thu, 27 Nov 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ah1UktjJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYB/F8Gk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ah1UktjJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYB/F8Gk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74E2E22AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264668; cv=none; b=dKHeJw6wRr6ukcnxQw5hIBNdwGIAVshMJpFcFxPgSpL2THngD+5FWLT2smV5cWGUk/lfv3JdSm6lK0kDFF6LPavvkcjMqOLoviDxM5IYmsjqLlW67DwESULFy9C4pA1M0t1yhC78A+VIKdh58pSkDcvlwtagF9RWO/uINphQBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264668; c=relaxed/simple;
	bh=fv1zLTCC/KnC/RXhzmAj6xCA5h7I2SvUnI3/Sp30Xe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxZPhngtHcB3oRN1zPpa3ezeZlkwh2VrvwgUQhBSifNhwhXFuRHrn6p2WpbdpymZD2sf/vhkzx3JtqjiHtGrB7F3BB/BNbLGTJgE+LQRKRxC1d8Vefy4ubJ6Nb4kg0NpvxeQLxGqFBHEhe/kcpMdbBxdDZmCk19CroSM8zYkbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ah1UktjJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYB/F8Gk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ah1UktjJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYB/F8Gk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 391A733695;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWzuGSbyVqCPONfnw6HeuYj5gwljyj7DZe3dJsyBttk=;
	b=Ah1UktjJuU6yk7ONhiVXA2yfCt5etqJiq9Aboe8WOBA2+sPTbQhL/Ed7qb3s1rFzzJNg+b
	iS93SPxf+UebcLpPM/VjlhmeH2oSUIIvhac+nc3k0oMD9GQQT+VEANEjaWr/5VvM+puOD5
	GwQJ0/zn5h4KTVXaP5iAG8ui3jAvwf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWzuGSbyVqCPONfnw6HeuYj5gwljyj7DZe3dJsyBttk=;
	b=LYB/F8Gku8poZ1fIfOA6UAawrWpsng/a7/GIgG13bZUmbzPcHSSIhi2qRcp/tyvpa3V3fb
	XN0Kbe8QbFcaAQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWzuGSbyVqCPONfnw6HeuYj5gwljyj7DZe3dJsyBttk=;
	b=Ah1UktjJuU6yk7ONhiVXA2yfCt5etqJiq9Aboe8WOBA2+sPTbQhL/Ed7qb3s1rFzzJNg+b
	iS93SPxf+UebcLpPM/VjlhmeH2oSUIIvhac+nc3k0oMD9GQQT+VEANEjaWr/5VvM+puOD5
	GwQJ0/zn5h4KTVXaP5iAG8ui3jAvwf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWzuGSbyVqCPONfnw6HeuYj5gwljyj7DZe3dJsyBttk=;
	b=LYB/F8Gku8poZ1fIfOA6UAawrWpsng/a7/GIgG13bZUmbzPcHSSIhi2qRcp/tyvpa3V3fb
	XN0Kbe8QbFcaAQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F263EA69;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M+VdGbKKKGmLPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3146DA0CAC; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/13] isofs: Provide fsnotify inode mark connector
Date: Thu, 27 Nov 2025 18:30:13 +0100
Message-ID: <20251127173012.23500-19-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=jack@suse.cz; h=from:subject; bh=fv1zLTCC/KnC/RXhzmAj6xCA5h7I2SvUnI3/Sp30Xe8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqo3UQVY+wk2mUcVCE50cbPgye6okmpmXul2 r47+MOIsSWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKqAAKCRCcnaoHP2RA 2d4aB/9xhHCqwuayofKzDZUKnDhiJI9ieMXVM3HKCGLUXVVvViFzUbuiIvKxkSGK8t3F/OwW40d lMa79L23aSWO85DgxiVPK6EdE01lhtOBNrrppCWgzx36EyK08BoJ1x6ZBw5oVaC1RkK/lPRhmhm iI2mhSY22AxZi4iiEkwOGV0oFfTXdkJzBOl3Qf253bqeLsbH6fnkTC9I1TC47LbkwdGr4cXXZ3A Th8RyLLc5CfbzTbIqB84CrbETyAZKJnz5AQVQ+DOJXNXzfIcGsenMHzvtlDxKtSmiZ8J8nBr1Bt p5ywaibgptbiKk4qFAMiRyVD5yhT6UWRxMbRWSa/VQDvZKDN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

For isofs ino_t needn't be enough to identify an inode on 32-bit
platforms. Implement isofs variant of fsnotify inode mark connector so
that we can reliably match the connector to the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/inode.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..73ae9adf4161 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsnotify.h>
 
 #include "isofs.h"
 #include "zisofs.h"
@@ -288,6 +289,45 @@ isofs_dentry_cmpi_ms(const struct dentry *dentry,
 }
 #endif
 
+/* Structure for connecting fsnotify marks to isofs inodes */
+struct isofs_inode_fsnotify_connector {
+	struct fsnotify_mark_connector common;
+	struct rhash_head hash_list;
+	u32 block;
+	u32 offset;
+};
+
+static struct fsnotify_mark_connector *isofs_alloc_inode_connector(
+							struct inode *inode)
+{
+	struct isofs_inode_fsnotify_connector *iconn;
+	struct iso_inode_info *ei = ISOFS_I(inode);
+
+	iconn = kmalloc(sizeof(*iconn), GFP_KERNEL);
+	if (!iconn)
+		return NULL;
+
+	iconn->block = ei->i_iget5_block;
+	iconn->offset = ei->i_iget5_offset;
+	if (fsnotify_init_inode_connector(&iconn->common, inode)) {
+		kfree(iconn);
+		return NULL;
+	}
+
+	return &iconn->common;
+}
+
+static const struct rhashtable_params isofs_inode_conn_hash_params = {
+	.key_len = 8,
+	.key_offset = offsetof(struct isofs_inode_fsnotify_connector, block),
+	.head_offset = offsetof(struct isofs_inode_fsnotify_connector, hash_list),
+};
+
+static const struct fsnotify_sb_operations isofs_fsnotify_ops = {
+	.alloc_inode_connector = isofs_alloc_inode_connector,
+	.inode_conn_hash_params = isofs_inode_conn_hash_params,
+};
+
 enum {
 	Opt_block, Opt_check, Opt_cruft, Opt_gid, Opt_ignore, Opt_iocharset,
 	Opt_map, Opt_mode, Opt_nojoliet, Opt_norock, Opt_sb, Opt_session,
@@ -830,6 +870,7 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 #endif
 	s->s_op = &isofs_sops;
 	s->s_export_op = &isofs_export_ops;
+	s->s_fsnotify_op = &isofs_fsnotify_ops;
 	sbi->s_mapping = opt->map;
 	sbi->s_rock = (opt->rock ? 2 : 0);
 	sbi->s_rock_offset = -1; /* initial offset, will guess until SP is found*/
-- 
2.51.0



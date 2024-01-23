Return-Path: <linux-fsdevel+bounces-8593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C383929B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F53F1C26B04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891826027E;
	Tue, 23 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F0XCj4sn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Img9Ukus";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F0XCj4sn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Img9Ukus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF05FDA8;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=h+KRcmWIg/szh20slZz/At5Nk2Z1kj6w3NacSCmsdA71CYYxWRHbxhHAKViJUYQsO+R5nRBXF900C7vaQTPo9nxS2ozc6+j7mO+sy+OVZerBxmach2V+bogL4tP23SnlyLveX/18OGINFdjh4FfBOFLeYG0OzOCceZ9p4rUFBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=d1tqk9pM/ddtJvyj9S6dFod5AyFAwtJGbDdV1UWXreU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pz6InYsUZ/XEOSUO81QMyB4oBUiH+kWSCW59n7/lJKrZ+ct/4W4kykAEbI6pZ1rW7puQp2F1dlXNOxwPo4iqasffIBIJrLx5yH0aqOtdmyA9Xscf3KqsvtgDD+Zc3EXQ5YGvDCXMKdCuB7yEioF/w27PjZnPS6McEiKwuRwzw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F0XCj4sn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Img9Ukus; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F0XCj4sn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Img9Ukus; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88433222AE;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSaRDDQDwsiD1Y1foF20EzTyh/dfdKCx53Nrh9WiiTA=;
	b=F0XCj4snRe3c0hkpj+Q3uQmtJawfuvGiQ3V8pxM5ocvXPINeYPwMdbS75pJqAeOWDnCciF
	TEnNcnYF01JV/DkBenW3lRYs2N77zqRQEsboyfJfH3FAF4ZI7E3ob3EJcXva6m7d47nH2R
	poZMhpv7oaipi6hSHFqTIclhCvKOQ3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSaRDDQDwsiD1Y1foF20EzTyh/dfdKCx53Nrh9WiiTA=;
	b=Img9UkushSZCt4ySdZPIHADfAA8gGoo5Sjv4p9WA15SaH3vkZNRQgCRF4OLCjM8cwVH8GF
	ezqRfRTPE/RldJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSaRDDQDwsiD1Y1foF20EzTyh/dfdKCx53Nrh9WiiTA=;
	b=F0XCj4snRe3c0hkpj+Q3uQmtJawfuvGiQ3V8pxM5ocvXPINeYPwMdbS75pJqAeOWDnCciF
	TEnNcnYF01JV/DkBenW3lRYs2N77zqRQEsboyfJfH3FAF4ZI7E3ob3EJcXva6m7d47nH2R
	poZMhpv7oaipi6hSHFqTIclhCvKOQ3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSaRDDQDwsiD1Y1foF20EzTyh/dfdKCx53Nrh9WiiTA=;
	b=Img9UkushSZCt4ySdZPIHADfAA8gGoo5Sjv4p9WA15SaH3vkZNRQgCRF4OLCjM8cwVH8GF
	ezqRfRTPE/RldJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7563E139CB;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNUtHGXar2WddQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD6E1A0806; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/9] udf: Avoid GFP_NOFS allocation in udf_symlink()
Date: Tue, 23 Jan 2024 16:25:01 +0100
Message-Id: <20240123152520.4294-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=jack@suse.cz; h=from:subject; bh=d1tqk9pM/ddtJvyj9S6dFod5AyFAwtJGbDdV1UWXreU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pN1M/IoDrUnaLEy2dVLYKzQOGfyAWa7EzgmbM/ Dzkex1mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aTQAKCRCcnaoHP2RA2R0zCA C2vZ09if9/v0XAh0E9R8G1ImutG9EDcD8FdUfp8wP6fVOxaOmMsDuYvugXF6gHotOxnR+k7W+OTvGI 8b2HqX8cJ/vDEE9UG3LoOWeRYMkCh71TW58NycW/U9hQx6dN73jH7ml/pNZuwI5NMu3HRVKehXi3hi xM0ESE+37kGW0cRb0BE02iCgweQHA7s0d886yOGFk5jyc9KSUxNo4S5ZlrFNPovt+50X9cHd4zO3Zs 2EigiG9G3jW1H5HaQSqsvDiVQJox1RjAiFKI4kh2SzRd90euGiYssRNd6p5EkYhv+R1R+VlgoqrpEj e5biv5iptzxR/B8M1g40DYITSC5M2T
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The GFP_NOFS allocation in udf_symlink() is called only under
inode->i_rwsem and UDF_I(inode)->i_data_sem. The first is safe wrt
reclaim, the second should be as well but allocating unde this lock is
actually unnecessary. Move the allocation from under i_data_sem and
change it to GFP_KERNEL.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1f14a0621a91..1308109fd42d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -566,7 +566,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 static int udf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *symname)
 {
-	struct inode *inode = udf_new_inode(dir, S_IFLNK | 0777);
+	struct inode *inode;
 	struct pathComponent *pc;
 	const char *compstart;
 	struct extent_position epos = {};
@@ -579,17 +579,20 @@ static int udf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct udf_inode_info *iinfo;
 	struct super_block *sb = dir->i_sb;
 
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
-	iinfo = UDF_I(inode);
-	down_write(&iinfo->i_data_sem);
-	name = kmalloc(UDF_NAME_LEN_CS0, GFP_NOFS);
+	name = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
 	if (!name) {
 		err = -ENOMEM;
-		goto out_no_entry;
+		goto out;
+	}
+
+	inode = udf_new_inode(dir, S_IFLNK | 0777);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
+	iinfo = UDF_I(inode);
+	down_write(&iinfo->i_data_sem);
 	inode->i_data.a_ops = &udf_symlink_aops;
 	inode->i_op = &udf_symlink_inode_operations;
 	inode_nohighmem(inode);
-- 
2.35.3



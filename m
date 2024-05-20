Return-Path: <linux-fsdevel+bounces-19811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523FB8C9E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79ED01C21C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C032136678;
	Mon, 20 May 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7Ooqmgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paDS2/J1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7Ooqmgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paDS2/J1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EE136648
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213060; cv=none; b=SaEyIVYZ+hbSgGZQIA+FVzQlJX4yTQvJf7iWc54tu5BzXxEgyjl9Bv3xwKF6FZaPH6dGtaB68dZcQ3vCrS1ZpuTN7NCNo6wyhd5X8gNPY5t0V1uEEjAe0HJP7v/ilXaes9pCGsb0oktuZ5Wuf88lKhxnr/3QZL2PCBqHiVQ+ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213060; c=relaxed/simple;
	bh=cFCwoA4cD2JfC5pVpqsbe4smtKnwFOnWnBQcSQC2c7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZkIEYyLI1acz4uBqpickQSvXpSb2iOMxpUiHnxfZkVhS0MMS8R2FLWk6FkyNXkmVnKE7vMWInubzox35A+EjC0zYN0BQNLvKXe08Sb9U6zTCM0smsIZjKb5/+VYpsRA6rLm+s59fy7DAL7sS9OqSIXDs/ZUK1TvEaA2hEUT8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7Ooqmgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=paDS2/J1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7Ooqmgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=paDS2/J1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A226033B91;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T5JyYFIRKQPqz/PEmY13J+stVCnj8S6rcUKYmlBl3M=;
	b=n7Ooqmgw1EsE35T5Rn178/NRpUOXgmxaBTSiJDAN+PLRc5Jf2Pj6/Ml7v61PZSwbCShWHs
	nTPGNqor5THMmgauy0hvvdDZosact4HHFcs75K+Wggoa5ndJ8PkUj4tWfmkbWtJVbIQKpR
	Mu9yN5Hn+ZOwmdUAuPUptDBiYc3qdI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T5JyYFIRKQPqz/PEmY13J+stVCnj8S6rcUKYmlBl3M=;
	b=paDS2/J1qL7o/8zMebW21p6UXxcQLAu6zRnVm1zXYYIAG1FnJ3QYopE9ybdGIbzwIEj+tT
	5IsrcEZtoUo9kkBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n7Ooqmgw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="paDS2/J1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T5JyYFIRKQPqz/PEmY13J+stVCnj8S6rcUKYmlBl3M=;
	b=n7Ooqmgw1EsE35T5Rn178/NRpUOXgmxaBTSiJDAN+PLRc5Jf2Pj6/Ml7v61PZSwbCShWHs
	nTPGNqor5THMmgauy0hvvdDZosact4HHFcs75K+Wggoa5ndJ8PkUj4tWfmkbWtJVbIQKpR
	Mu9yN5Hn+ZOwmdUAuPUptDBiYc3qdI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T5JyYFIRKQPqz/PEmY13J+stVCnj8S6rcUKYmlBl3M=;
	b=paDS2/J1qL7o/8zMebW21p6UXxcQLAu6zRnVm1zXYYIAG1FnJ3QYopE9ybdGIbzwIEj+tT
	5IsrcEZtoUo9kkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 946FB13A73;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 79HjI0BVS2awCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 13:50:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F123A01D4; Mon, 20 May 2024 15:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] udf: Drop pointless IS_IMMUTABLE and IS_APPEND check
Date: Mon, 20 May 2024 15:50:49 +0200
Message-Id: <20240520135056.788-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240520134853.21305-1-jack@suse.cz>
References: <20240520134853.21305-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=jack@suse.cz; h=from:subject; bh=cFCwoA4cD2JfC5pVpqsbe4smtKnwFOnWnBQcSQC2c7w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmS1U4k3RebhU/SoN6MzOU0LFrUE2PRHmp/83ON+bQ gR9JM2GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZktVOAAKCRCcnaoHP2RA2VBhCA DLmp2LIf0HEKx/pfy0qeNK74weKwCNc4pFujD/EJLDacEyqrsl3dr+zYhUlipp7X3MVrfVMMhwBZEe a0m7NlKNI0SjQqJqg08pmluWhT6cdSQWJsWZYrmkayd4oPDsSfKsENsaq9PdClTg2DJy11MQZNMpYf 9DaM++isD71nPCUIbzB1K4nL/6Xb5gaITdMGvzBnzTQeEz03Vz5JnIj3/Fm6KZ5/oKAhCXkJIbm8V/ Kl/hEyI2Fro0a82A/DFmxWImUy7wNOzCEIvnSlHLeFvjTFKOFTCtEN+OejUlaYsFSyMiWYrCSDbkX9 NNpG5TK9WkWhNdWoTieXiRdoEoD2M4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.65
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A226033B91
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.65 / 50.00];
	BAYES_HAM(-2.64)[98.40%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]

udf_setsize() checks for IS_IMMUTABLE and IS_APPEND flags. This is
however pointless as UDF does not have capability to store these flags
and never allows to set them. Furthermore this is the only place in UDF
code that was actually checking these flags. Remove the pointless check.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 2f831a3a91af..04b0e62cf73f 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1248,8 +1248,6 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	      S_ISLNK(inode->i_mode)))
 		return -EINVAL;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return -EPERM;
 
 	filemap_invalidate_lock(inode->i_mapping);
 	iinfo = UDF_I(inode);
-- 
2.35.3



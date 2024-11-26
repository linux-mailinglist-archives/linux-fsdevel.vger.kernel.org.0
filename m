Return-Path: <linux-fsdevel+bounces-35898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E489D974F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F1165AAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAD1D1F6B;
	Tue, 26 Nov 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n72pUCAn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8bvr8Px";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n72pUCAn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8bvr8Px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AC18F2DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624441; cv=none; b=ixarP27lA+EK07S9Nr+w1tcfnGAshlAJS4WM5g+w16ioOlVxvLKS+llPoNsE/5BVNjCQqfZNVSAllMXxIOTdgkUKb7Gul7qgreM40MuMsuQHAaJGATrp6jwp/5M5jBNj2P8voMaOVKJdfpeePvrAc5G11ogUA1Ff1eQFvz14bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624441; c=relaxed/simple;
	bh=c843F4qLc8eeg+M4IQtcd79FGCDz6ZGoJtPZYEpL1uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMTQQ0L+SDsptem1Aex8pYEXgC0BgAAbPW/J2Kgkloib9sRSppnBvxeGPiVh7HgP5QnkDrwqbUJK52qGTvnCTNfJ7+E1Ljtc//iLSrEiwIQAUI/DbExlzwil9upuEGiHXSE1LhwG/vfcNjz2d4oFKFdcw/bHHK2N4Mjm8r0HWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n72pUCAn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8bvr8Px; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n72pUCAn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8bvr8Px; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D86D1F770;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0paHWaxrcwEjkb69+xpIhndjoU4T+YlqBfan0Ov50=;
	b=n72pUCAnhZ7wfxlvQgc1RpYw1kbcnqjLW7KQ4MkkyrY5JuZgsGjm5eTg7eTUC9i+4TQeqp
	UlSH82WsmYPyH0cLh0DONjE/DD39yJ3FzS/4dFID8k0hKJrzo9gsMJw/BikVeDlwtzvCCQ
	GXHY80J5dkKCKwtZe6VXti3kX2goKDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0paHWaxrcwEjkb69+xpIhndjoU4T+YlqBfan0Ov50=;
	b=m8bvr8Pxj8w0h1UZzCtsy2qxLxX95owaHa0L04nB82EuJADbU9nzrvq+WK6XM3g91tH+L0
	XU3pULmsxa/1r8Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n72pUCAn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m8bvr8Px
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0paHWaxrcwEjkb69+xpIhndjoU4T+YlqBfan0Ov50=;
	b=n72pUCAnhZ7wfxlvQgc1RpYw1kbcnqjLW7KQ4MkkyrY5JuZgsGjm5eTg7eTUC9i+4TQeqp
	UlSH82WsmYPyH0cLh0DONjE/DD39yJ3FzS/4dFID8k0hKJrzo9gsMJw/BikVeDlwtzvCCQ
	GXHY80J5dkKCKwtZe6VXti3kX2goKDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0paHWaxrcwEjkb69+xpIhndjoU4T+YlqBfan0Ov50=;
	b=m8bvr8Pxj8w0h1UZzCtsy2qxLxX95owaHa0L04nB82EuJADbU9nzrvq+WK6XM3g91tH+L0
	XU3pULmsxa/1r8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB6E13A6E;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /TcYCzbARWfMUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 12:33:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2238A08A6; Tue, 26 Nov 2024 13:33:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] udf: Skip parent dir link count update if corrupted
Date: Tue, 26 Nov 2024 13:33:48 +0100
Message-Id: <20241126123349.24798-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241126123349.24798-1-jack@suse.cz>
References: <20241126123349.24798-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=jack@suse.cz; h=from:subject; bh=c843F4qLc8eeg+M4IQtcd79FGCDz6ZGoJtPZYEpL1uw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnRcAs2/c3857qQsLysjC7VCaYp3xUo23Mszh4XXfP p6JH71GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ0XALAAKCRCcnaoHP2RA2eurB/ 9kP8XM+DfKzQfx3CscgpSap71L6odfMSZNcw0oSrwI0rCxcbs7LVfilldcoon3aIovwZzlh0q21pqz ZM2skKXxutyofIJB3cpUaFIvGPJ87BQy1yhOfEUNH6VGV/wYyaI7pg4waDGzQVMr3J6rnD50gAzUYC ojd24SfIvOu9jKQ4k5vPPOxR2mDo1LIvQBGzVGTGN2WCP9fknmQKVs4MHHswLcolnQMbBa4XYTtP9i CXRCzDnbZbt4DxA/hzduPllR3uFdNCpBRvHi6t4HeSWl6HjSywxmQrMy5/GXlBj4ZCZW8PXH32WRE9 pyJ9ejz/WDQ6YzAv3GoSn3L7bOuzyA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D86D1F770
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

If the parent directory link count is too low (likely directory inode
corruption), just skip updating its link count as if it goes to 0 too
early it can cause unexpected issues.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 78a603129dd5..2be775d30ac1 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -517,7 +517,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 			 inode->i_nlink);
 	clear_nlink(inode);
 	inode->i_size = 0;
-	inode_dec_link_count(dir);
+	if (dir->i_nlink >= 3)
+		inode_dec_link_count(dir);
+	else
+		udf_warn(inode->i_sb, "parent dir link count too low (%u)\n",
+			 dir->i_nlink);
 	udf_add_fid_counter(dir->i_sb, true, -1);
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-19812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180918C9E69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD51C21AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789513667D;
	Mon, 20 May 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynM9F8wX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+xwYiz5b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynM9F8wX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+xwYiz5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB313665B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213060; cv=none; b=HbDA9c5NU+CImGZRAljVvrGxYQM290IZuNcwgfyIFXeB8zHPek7Pc9pLdTFoMD6B8hCA9DMOYlB71CCXKqBFX1zUHb+9RkRQzQ/qCDpHKAMRAyASMb1AX65rzawwkoLxgNjWnVYMje+/cfCBh1dhE4bUxYh7vif1UWS1TnSxQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213060; c=relaxed/simple;
	bh=ued3WwZ+CCc+PuSGNf/JJirStUHAe5/Lr0Jnhpco/JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BF3FaDHM87Unrsa1iRwFrO5SBF0slkIulPgRdTFej00NXlii6qegFKE1RKgM8WmjPxjCLm3NJ6Fg1KXDwKXhBHE28WLAgRqbxB2iuMfn+CugEhKLEWeJ74uRDcgM1BTXLejTAI2NnmY4hPJCuH+TXKRPldD8vueh0Ah9lCR7G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynM9F8wX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+xwYiz5b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynM9F8wX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+xwYiz5b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB7C33B8B;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXAKMerWnn5qllMTnXsyzv71HgwvKlGqbn8wuzE6MFA=;
	b=ynM9F8wXuzY94yEmgwwLaLzKGRLAw+RgLCMT1deEKo16Fi65OGNm1XAr9g+as60NAJtzD4
	Gu9Eq98JbMeqssA5vk8yfQiwj/lcqSgf0ZkFkBiDAfECkjUsB+4qRSrB6u6xSjoylTiUdR
	oNRZE4JzW3RnJprgiJ68DAxmcQrLJtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXAKMerWnn5qllMTnXsyzv71HgwvKlGqbn8wuzE6MFA=;
	b=+xwYiz5b+tE+r9edvV2a92lixxVBJebLVI6PwRcOyOfr+mZGWsntUM8cFTTgRDqaKLhpFL
	tDRUaccSmvTBejDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ynM9F8wX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+xwYiz5b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXAKMerWnn5qllMTnXsyzv71HgwvKlGqbn8wuzE6MFA=;
	b=ynM9F8wXuzY94yEmgwwLaLzKGRLAw+RgLCMT1deEKo16Fi65OGNm1XAr9g+as60NAJtzD4
	Gu9Eq98JbMeqssA5vk8yfQiwj/lcqSgf0ZkFkBiDAfECkjUsB+4qRSrB6u6xSjoylTiUdR
	oNRZE4JzW3RnJprgiJ68DAxmcQrLJtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXAKMerWnn5qllMTnXsyzv71HgwvKlGqbn8wuzE6MFA=;
	b=+xwYiz5b+tE+r9edvV2a92lixxVBJebLVI6PwRcOyOfr+mZGWsntUM8cFTTgRDqaKLhpFL
	tDRUaccSmvTBejDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9054613A6B;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L6rRIkBVS2asCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 13:50:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4651DA08DA; Mon, 20 May 2024 15:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+0333a6f4b88bcd68a62f@syzkaller.appspotmail.com
Subject: [PATCH 2/2] udf: Fix lock ordering in udf_evict_inode()
Date: Mon, 20 May 2024 15:50:50 +0200
Message-Id: <20240520135056.788-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240520134853.21305-1-jack@suse.cz>
References: <20240520134853.21305-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=jack@suse.cz; h=from:subject; bh=ued3WwZ+CCc+PuSGNf/JJirStUHAe5/Lr0Jnhpco/JA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmS1U5d/rMM/bwX9OCRQTW1gPub4fJJJyy9pNhPbZB FiFEEPuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZktVOQAKCRCcnaoHP2RA2RWuCA DrtFl6lSRur80QOLGjlnnaomah6JF1zvrCC0AtfTd7K8do3niHXdZV2RIy4QsrAhAV2Ar3S2DBS7er NhdpGh/gSuVPmw+hRrYsSN4RtL+hspgggOEA47ofOI3XQxI4HPGcdV/rNGsPKVrVWso7MKfEIA/gBD 7F3vVfjSG9xu4qGBD1Dx0r9N9tjgsXGnfEMvAdJomWqtzJcLAqUQv8PZTQFQrBe47k2QAP6qviBL1W FIRDGwN+S9zk1m3o4YnF3m+tjCWVPkbaks4vVXiqZEpCuA4+kIPQBk+uv8d/BFEFPVFPPA1oPhH7zn dmqlRtwBeHH9EutAB9KzRTmDaOwSRR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[0333a6f4b88bcd68a62f];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9EB7C33B8B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

udf_evict_inode() calls udf_setsize() to truncate deleted inode.
However inode deletion through udf_evict_inode() can happen from inode
reclaim context and udf_setsize() grabs mapping->invalidate_lock which
isn't generally safe to acquire from fs reclaim context since we
allocate pages under mapping->invalidate_lock for example in a page
fault path.  This is however not a real deadlock possibility as by the
time udf_evict_inode() is called, nobody can be accessing the inode,
even less work with its page cache. So this is just a lockdep triggering
false positive. Fix the problem by moving mapping->invalidate_lock
locking outsize of udf_setsize() into udf_setattr() as grabbing
mapping->invalidate_lock from udf_evict_inode() is pointless.

Reported-by: syzbot+0333a6f4b88bcd68a62f@syzkaller.appspotmail.com
Fixes: b9a861fd527a ("udf: Protect truncate and file type conversion with invalidate_lock")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c  |  2 ++
 fs/udf/inode.c | 11 ++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0ceac4b5937c..94daaaf76f71 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -232,7 +232,9 @@ static int udf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    attr->ia_size != i_size_read(inode)) {
+		filemap_invalidate_lock(inode->i_mapping);
 		error = udf_setsize(inode, attr->ia_size);
+		filemap_invalidate_unlock(inode->i_mapping);
 		if (error)
 			return error;
 	}
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 04b0e62cf73f..87002ecd79df 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1249,7 +1249,6 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	      S_ISLNK(inode->i_mode)))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
 	iinfo = UDF_I(inode);
 	if (newsize > inode->i_size) {
 		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
@@ -1262,11 +1261,11 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 			}
 			err = udf_expand_file_adinicb(inode);
 			if (err)
-				goto out_unlock;
+				return err;
 		}
 		err = udf_extend_file(inode, newsize);
 		if (err)
-			goto out_unlock;
+			return err;
 set_size:
 		truncate_setsize(inode, newsize);
 	} else {
@@ -1284,14 +1283,14 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 		err = block_truncate_page(inode->i_mapping, newsize,
 					  udf_get_block);
 		if (err)
-			goto out_unlock;
+			return err;
 		truncate_setsize(inode, newsize);
 		down_write(&iinfo->i_data_sem);
 		udf_clear_extent_cache(inode);
 		err = udf_truncate_extents(inode);
 		up_write(&iinfo->i_data_sem);
 		if (err)
-			goto out_unlock;
+			return err;
 	}
 update_time:
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
@@ -1299,8 +1298,6 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 		udf_sync_inode(inode);
 	else
 		mark_inode_dirty(inode);
-out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
 }
 
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-79151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDqBIHm5pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:35:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 855161ECB79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F20F3020983
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47DC39B950;
	Tue,  3 Mar 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ByH8CAwW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmbLSVir";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ByH8CAwW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmbLSVir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D639890C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534119; cv=none; b=BkC6wPE8hpzErCNs4YsfQmRH8uyqvLY2Ernv9Vvx1DiXDoxTNmNXUrO5QnnyjiqMSi/K9hUS2MuneNrdli1cGSFJihr661M0hQgIc3oO2zCXFVS6aZ+fdVtCwgf7fCyWZeaOxbP2RvLR3OblndxLrxE5WaWuuI+IGDxJdF0IUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534119; c=relaxed/simple;
	bh=0Tf41qNynOHKl++Dc8Ys4dS/6PbXDeCtzOfQHkFchp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSZ4R6TQgQ9aYDTFQk1GP7vRxlJI/lukYl9BT3CDPio/ZcsYZlnNgWqX4eAdhTbMomDU5c2XTWwZn+weGy5NeIq0jQqQw1x12u8p5phK9xZ4qtHUS9TwhFb8xFTkRnRgM7wucrEn+nzEOS80GWAqV/OKjC2rTDOdjVpBXfhEBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ByH8CAwW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmbLSVir; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ByH8CAwW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmbLSVir; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07BC23F907;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ7zC/j7R3U6pbGqWS6D4Xl469nqbcAlVJWcqDjGzgM=;
	b=ByH8CAwWnnOP5zLPLhwBTrkHOVpGk1q3aRnxudTPADe8fEJM1IBAXgpCL/zZnMSm9CXKwG
	bTE9sPoNz/VGT76l3Z6cJm5GKtKEPmm64utTGn6Y3r0RAa076XHbCQsflSGUUbCM4ItQMQ
	vn3A/p2JfZQYrzt5i5RcPl3EO5U+zRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ7zC/j7R3U6pbGqWS6D4Xl469nqbcAlVJWcqDjGzgM=;
	b=ZmbLSVirQ59fjY/aQtX22KUaNpFPbChL91REC0+yBo42mUWKUSYXio9VesEbDKkPt7T+Zt
	6/LCQ3WWnUzVL+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ7zC/j7R3U6pbGqWS6D4Xl469nqbcAlVJWcqDjGzgM=;
	b=ByH8CAwWnnOP5zLPLhwBTrkHOVpGk1q3aRnxudTPADe8fEJM1IBAXgpCL/zZnMSm9CXKwG
	bTE9sPoNz/VGT76l3Z6cJm5GKtKEPmm64utTGn6Y3r0RAa076XHbCQsflSGUUbCM4ItQMQ
	vn3A/p2JfZQYrzt5i5RcPl3EO5U+zRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ7zC/j7R3U6pbGqWS6D4Xl469nqbcAlVJWcqDjGzgM=;
	b=ZmbLSVirQ59fjY/aQtX22KUaNpFPbChL91REC0+yBo42mUWKUSYXio9VesEbDKkPt7T+Zt
	6/LCQ3WWnUzVL+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0BEA3EA70;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /H3POkS5pmlwFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A999EA0A79; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/32] hugetlbfs: Stop using i_private_data
Date: Tue,  3 Mar 2026 11:34:01 +0100
Message-ID: <20260303103406.4355-44-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=jack@suse.cz; h=from:subject; bh=0Tf41qNynOHKl++Dc8Ys4dS/6PbXDeCtzOfQHkFchp0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkocjhNcBjeQBoJK+/oG+RPKznFY3ANKEkrw 7JMLSo6lVSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5KAAKCRCcnaoHP2RA 2RCeCADYnSWtfW84q5MK+DZ8tuZd1qK7zQCmmcgw+76u2f6KbmpC8RIoN4Tf/73mWwsDv6YPgmj zunEJYotmXAvAM2GI2VT5lUeDw3zAJDpHK/c08lGvzVmRvy0HL1+6CNSaBeM+HK4jD6iU6YCC7e 5rTcKhAMZzQ/pbn83ZE6p7W/oQbVEcd6d6DJJ3ezAut0+leirtnXqge0Clxj16glU9y/GTYuoh1 tTnhflaPAT4LbCWBPrnEi8jQi0TSNfAIxMeadmriYqBRZ0kFHbdSFSVUbFqIHJT2tKloc244C5e 4PolSoFOr/1rNc3+T2Z1Kl+4Gq8Vu3X2z+kRI0fc/aXysucO
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 855161ECB79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79151-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of using i_private_data for resv_map pointer add the pointer
into hugetlbfs private part of the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/hugetlbfs/inode.c    | 10 ++--------
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 10 +---------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f70c47981de..0496f2e6d177 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -622,13 +622,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
 	trace_hugetlbfs_evict_inode(inode);
 	remove_inode_hugepages(inode, 0, LLONG_MAX);
 
-	/*
-	 * Get the resv_map from the address space embedded in the inode.
-	 * This is the address space which points to any resv_map allocated
-	 * at inode creation time.  If this is a device special inode,
-	 * i_mapping may not point to the original address space.
-	 */
-	resv_map = (struct resv_map *)(&inode->i_data)->i_private_data;
+	resv_map = HUGETLBFS_I(inode)->resv_map;
 	/* Only regular and link inodes have associated reserve maps */
 	if (resv_map)
 		resv_map_release(&resv_map->refs);
@@ -950,7 +944,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		simple_inode_init_ts(inode);
-		inode->i_mapping->i_private_data = resv_map;
+		info->resv_map = resv_map;
 		info->seals = F_SEAL_SEAL;
 		switch (mode & S_IFMT) {
 		default:
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..fc5462fe943f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -518,6 +518,7 @@ static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 
 struct hugetlbfs_inode_info {
 	struct inode vfs_inode;
+	struct resv_map *resv_map;
 	unsigned int seals;
 };
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0beb6e22bc26..7ab5c724a711 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1157,15 +1157,7 @@ void resv_map_release(struct kref *ref)
 
 static inline struct resv_map *inode_resv_map(struct inode *inode)
 {
-	/*
-	 * At inode evict time, i_mapping may not point to the original
-	 * address space within the inode.  This original address space
-	 * contains the pointer to the resv_map.  So, always use the
-	 * address space embedded within the inode.
-	 * The VERY common case is inode->mapping == &inode->i_data but,
-	 * this may not be true for device special inodes.
-	 */
-	return (struct resv_map *)(&inode->i_data)->i_private_data;
+	return HUGETLBFS_I(inode)->resv_map;
 }
 
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
-- 
2.51.0



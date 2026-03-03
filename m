Return-Path: <linux-fsdevel+bounces-79146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPrjFES6pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09271ECCAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683C4314999E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15439D6CA;
	Tue,  3 Mar 2026 10:35:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A231B114
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534106; cv=none; b=OLECFTvpcVj1dgpkfbd5AM1qsR4kjByOvakIaOQjQGGaRBgusE1kGC+RLuoJ2jANIT7YZXWDXtmyTg9oZKlGla059XlQU0v6B4RrDtgACRFC/khBP6cLMacXUdC5ZVwHqSS9bVO4X3gFKaF2lkleKARuyzQxJDoAX/gq5S5zFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534106; c=relaxed/simple;
	bh=21rbptBohvHLbIzoeM8IfhTkwdubfon9k5dpdTlpgfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+zlF0NzLEdxkPFJCVasbF22lqcvzPAO4Of0BRxodAS+u3E0S3pTvZ8Un8EMOjA942gEra+R7F0Hs+2olSkZkCD8REinNUTk0DQ/Axex9BatJ38sVIShzccKg1FKPl4HE9btbiQBwi+nc9Bsbbzctn2+GrNeHLxH0jxrvC4qyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 121B75BE1D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00EB03EA71;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v5tsO0S5pmlxFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98C65A0B3F; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 10/32] fs: Stop using i_private_data for metadata bh tracking
Date: Tue,  3 Mar 2026 11:33:59 +0100
Message-ID: <20260303103406.4355-42-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=jack@suse.cz; h=from:subject; bh=21rbptBohvHLbIzoeM8IfhTkwdubfon9k5dpdTlpgfs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkmRXfvEFOavnw88KSkCELSYzUGb6FJxDza0 lFuc/BYWXOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5JgAKCRCcnaoHP2RA 2eF9B/sEW3OFX69Cefii5uJoJbX2MlFQ9v7XXSlUg4DiHPmiJ4YNVL9wzueyr+M9Xc3mCrZ04sp 3R4b5iAESEUkWT3/ReBfvXEhfXQQ4ynvWT3qqkz5cZI64xr7HLGHyS+QRHYxNPUeRL9zlgI2Doo Q/a4g1ACdCL4MzFZgGKeja2KlZ6EMnNYaliS8/2SKb6EjoaucHSGksgqpe2UH0SKJF+jp3QD+yE UfelQAhsh8WS8vs9O+tMNdFm3C39yJ2Dm0cbDl267sccawqPmR3MuohLONNUoojt/zTycdJ/f6i yj+urmXK9n4+ukLJcSUa+QuBKa4TqFGpUO3VG0tuNlO5maNm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: C09271ECCAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79146-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.859];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

All filesystem using generic metadata bh tracking are using bdev mapping
as a backing for these bhs. Stop using i_private_data for it and get to
bdev mapping directly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd48644e1bf8..c85ccfb1a4ec 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -574,9 +574,10 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
-	struct address_space *buffer_mapping = mapping->i_private_data;
+	struct address_space *buffer_mapping =
+				mapping->host->i_sb->s_bdev->bd_mapping;
 
-	if (buffer_mapping == NULL || list_empty(&mapping->i_private_list))
+	if (list_empty(&mapping->i_private_list))
 		return 0;
 
 	return fsync_buffers_list(&buffer_mapping->i_private_lock,
@@ -679,11 +680,6 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 	struct address_space *buffer_mapping = bh->b_folio->mapping;
 
 	mark_buffer_dirty(bh);
-	if (!mapping->i_private_data) {
-		mapping->i_private_data = buffer_mapping;
-	} else {
-		BUG_ON(mapping->i_private_data != buffer_mapping);
-	}
 	if (!bh->b_assoc_map) {
 		spin_lock(&buffer_mapping->i_private_lock);
 		list_move_tail(&bh->b_assoc_buffers,
@@ -868,7 +864,8 @@ void invalidate_inode_buffers(struct inode *inode)
 	if (inode_has_buffers(inode)) {
 		struct address_space *mapping = &inode->i_data;
 		struct list_head *list = &mapping->i_private_list;
-		struct address_space *buffer_mapping = mapping->i_private_data;
+		struct address_space *buffer_mapping =
+				mapping->host->i_sb->s_bdev->bd_mapping;
 
 		spin_lock(&buffer_mapping->i_private_lock);
 		while (!list_empty(list))
-- 
2.51.0



Return-Path: <linux-fsdevel+bounces-79148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI8bG1q6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0101ECCD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F221315128C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1539D6CA;
	Tue,  3 Mar 2026 10:35:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3539C623
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534112; cv=none; b=QuP4TPMgWdKk9K7/fikbdoqW0F8BR7P53YOq/DHymTjfPS+Z/k2IFgKOKkum1h9Yx7VRZJCnZL+j8mV87IqimFaoI0gio+YAz1erq7m69KaG2ZOp61eqknmDqtM0z8dyqcdSy1BqgGqdvptjJtBgCvzM1n4RPBSUKi2Xqpko5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534112; c=relaxed/simple;
	bh=p58QfOPdeBSF+GFT64AjIbjHzbd4gdcT7JjSAJNis4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srWo1D3A70ruklI87osiSgZ+HjUmkf+E9hwOA8F+rQX34hEaJ0LvcFhA7P8z7+RHijnCJdvyrVjqXodHbUoe3zSA+qTms1m4QgU6nCVrOcu0MSraKvbRSmWlZshHz20F8aVKcehfvLNWy6hkmpkohItA821vZi5HqQ4WgdQFtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18AEC5BE21;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0612E3EA72;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Zx0AUW5pml1FQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7201A0AAA; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 14/32] fs: Remove i_private_data
Date: Tue,  3 Mar 2026 11:34:03 +0100
Message-ID: <20260303103406.4355-46-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=jack@suse.cz; h=from:subject; bh=p58QfOPdeBSF+GFT64AjIbjHzbd4gdcT7JjSAJNis4Y=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDKX7dT065ga7rhq2VKrJX7nHe39/7zbtUahecZ7L+W2+ WeEtZOfdjIaszAwcjDIiimyrI68qH1tnlHX1lANGZhBrEwgUxi4OAVgIl5rOBg+2HvtSMtctuXI 5Y+JO5YV6J9vLV94yWqe7WObnA079NPfdna0eK+VOBstVSebEBa0WXabZKAGd6XCaeNK+Wifm/e d0sVlPzhnK1wzvbwl9Ul30QuGjxYJX3a/OXHQfckZs0OG/2aucGdtO3rOJeVI19b57uddrkgeqG +ubdZpFhb00zO+LButkJi9Q/PJHU2NsMlW+79HGqSssQq8KBmg8fkTa6rcnRRZ4UJHpizfGZ71w Stl5CQ2Srx2P3Te+Ukye0x9nnht1I6PLk4Bx26wvHh1tSiYa26i5bv6J5bfVO7whVlGbK6SbP1S +Ytne1aLzPKMZw7WbmF5va5BB7jVnxhMTlm+5uEOx+/JAA==
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
X-Rspamd-Queue-Id: 0D0101ECCD7
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
	TAGGED_FROM(0.00)[bounces-79148-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.870];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Nobody is using it anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c         | 1 -
 include/linux/fs.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4f98a5f04bbd..d5774e627a9c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -283,7 +283,6 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	atomic_set(&mapping->nr_thps, 0);
 #endif
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
-	mapping->i_private_data = NULL;
 	mapping->writeback_index = 0;
 	init_rwsem(&mapping->invalidate_lock);
 	lockdep_set_class_and_name(&mapping->invalidate_lock,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..10b96eb5391d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -465,7 +465,6 @@ extern const struct address_space_operations empty_aops;
  * @wb_err: The most recent error which has occurred.
  * @i_private_lock: For use by the owner of the address_space.
  * @i_private_list: For use by the owner of the address_space.
- * @i_private_data: For use by the owner of the address_space.
  */
 struct address_space {
 	struct inode		*host;
@@ -486,7 +485,6 @@ struct address_space {
 	spinlock_t		i_private_lock;
 	struct list_head	i_private_list;
 	struct rw_semaphore	i_mmap_rwsem;
-	void *			i_private_data;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
-- 
2.51.0



Return-Path: <linux-fsdevel+bounces-79143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHSEJya6pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B31ECC68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5EBF31402A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBD39B966;
	Tue,  3 Mar 2026 10:34:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4B39B965
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534095; cv=none; b=do1tnRa6DLKBohtkivOOgAUrlRYqJCUBBxZG2cXai6a12iYnf8vyqSynHlcB8WkxKl8BLRRPiPX4cjTO/kuEzVgARDFN7UVP/Ta1e9qOYurNuu9OYkzxPClbxNDGCnB7TTq93HqTi0sy3HSL+wB+nGYLoH1zstfG/4H0+mSRBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534095; c=relaxed/simple;
	bh=NSocyVgO/kQGAErs8cha/4S5lFQVkvyp5VDOz50TMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh7nbgtGJPlXE8vDqoL1JsSIeOYzgfMDZ+JshHM0iEtOs0Cw4OFrymuPWQEZvpKFqNK5bnegqf+w4dJ7ZkKyKRrvCdXrAdexz+5VzPshq6H8RbqvsDyb2/iiYy7M3507fkxabo8KA7FR22Frx8JpZCp9DBK3WVZ6TS6xQwCui6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E498C5BDF3;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D91923EA6C;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SG0ANUS5pmljFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 770BAA0AFF; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 06/32] ext4: Use inode_has_buffers()
Date: Tue,  3 Mar 2026 11:33:55 +0100
Message-ID: <20260303103406.4355-38-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=jack@suse.cz; h=from:subject; bh=NSocyVgO/kQGAErs8cha/4S5lFQVkvyp5VDOz50TMvM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkjDcPjRe968iOjtyTk4+S02xDNjEq4RENFS zbxRWwejuiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5IwAKCRCcnaoHP2RA 2QhkCACpRJHTWCgp3UVShmcjh3k1jfzIfqAWQr1o6ZxLfxYJPnN2AThktcbpTOawdqDzL8zNAF7 TPKXNMDZwSJ62WeoErOrqaZkd8I++A/Aed6Zptq4hY0qEUDYnW6DTw5jKyOwDIAih1w/EP1l4DA qWg7/PuX3cHPXX4FNRnBpnRQwfnGvN2qAEDR7Jn7X4tL2wltRxpcJyBuQYk5vwLLQnB45B44d3j SQAS12MqhIvj8PhOFpJV+6B/9DPL8lDLWvj1AniE9WlrsLtl+SiJBsplxP17ZztDbbVTfZppE5w KWfFd/pvRhppjHcrxes4jlejCtzwSOEMzyw48JePwQ1aXBuU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 295B31ECC68
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
	TAGGED_FROM(0.00)[bounces-79143-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.874];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of checking i_private_list directly use appropriate wrapper
inode_has_buffers(). Also delete stale comment.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c     | 1 +
 fs/ext4/inode.c | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 22b43642ba57..1bc0f22f3cc2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -524,6 +524,7 @@ int inode_has_buffers(struct inode *inode)
 {
 	return !list_empty(&inode->i_data.i_private_list);
 }
+EXPORT_SYMBOL_GPL(inode_has_buffers);
 
 /*
  * osync is designed to support O_SYNC io.  It waits synchronously for
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c2692b9c7123..6f892abef003 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1422,9 +1422,6 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 /*
  * We need to pick up the new inode size which generic_commit_write gave us
  * `iocb` can be NULL - eg, when called from page_symlink().
- *
- * ext4 never places buffers on inode->i_mapping->i_private_list.  metadata
- * buffers are managed internally.
  */
 static int ext4_write_end(const struct kiocb *iocb,
 			  struct address_space *mapping,
@@ -3439,7 +3436,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	}
 
 	/* Any metadata buffers to write? */
-	if (!list_empty(&inode->i_mapping->i_private_list))
+	if (inode_has_buffers(inode))
 		return true;
 	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
 }
-- 
2.51.0



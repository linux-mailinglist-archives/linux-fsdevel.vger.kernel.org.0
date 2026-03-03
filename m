Return-Path: <linux-fsdevel+bounces-79171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A1+IOm6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992C1ECD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2764B3180F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7D39B949;
	Tue,  3 Mar 2026 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDz6JRWj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gz7qITFv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDz6JRWj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gz7qITFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D3386437
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534199; cv=none; b=Gn632Iwm5A6/xvV8q7FKBP9YbVM/4yUI91X5mU/Zj9Ru9LflfscgRG8Y7YPTRJYBoECmL5POenBh89SFGIuFy5EFOyZev+oheg3WqKsm8chDJCN9mJO8g037Z+0DmU6KPh9t4QWujkI+AXPwG3fzv1onTpzXX7/sDwjPzbPg380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534199; c=relaxed/simple;
	bh=KGtDrC9rNzTK65SQ8Oe7H9Ud9xEAArRJg33A6iQt0U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+p3uYF2eTj2Q1wgnyb3OE7TK5Iv9gsTwYT6M7ZV/mOgqNB4+5oZyr3w90YxPK5zN//i+Sm92AJSlPLyZAzxpkXUhZs3NXxhrWf0XyWXMw+YgxWk/HdNQD151c2/ttSSVHktdVKdKpkfNQe14Rs51uymBOudIn8IMvQuI21rQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDz6JRWj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gz7qITFv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDz6JRWj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gz7qITFv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DDEA3F90D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJwm4fvAg3a1hOEhycwe2FUYXuHnKvYj9968NDPJOws=;
	b=PDz6JRWjSeQ890kGuvn9Ph3Oi9gtVV75wuen0eIC/mXNKQGoQxwSBjYdpl7p80YHjXOdCR
	QvAXuk3IkmlmHuPhyD4zb2nHhmjfM+eR+GE9hifa3adtlblT9qFmnPhqvjXVVG4l58jNyz
	VxHPfyz0cN5Wn2xVAqi+jo/jPSzHpGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJwm4fvAg3a1hOEhycwe2FUYXuHnKvYj9968NDPJOws=;
	b=Gz7qITFvIJY6misgdjIAVQ1WndNK0+d38+baDQ3JpzKnvkyCNN/CXIM+W3BWuPlCNupEuB
	lLHuW+/doPxx85CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJwm4fvAg3a1hOEhycwe2FUYXuHnKvYj9968NDPJOws=;
	b=PDz6JRWjSeQ890kGuvn9Ph3Oi9gtVV75wuen0eIC/mXNKQGoQxwSBjYdpl7p80YHjXOdCR
	QvAXuk3IkmlmHuPhyD4zb2nHhmjfM+eR+GE9hifa3adtlblT9qFmnPhqvjXVVG4l58jNyz
	VxHPfyz0cN5Wn2xVAqi+jo/jPSzHpGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJwm4fvAg3a1hOEhycwe2FUYXuHnKvYj9968NDPJOws=;
	b=Gz7qITFvIJY6misgdjIAVQ1WndNK0+d38+baDQ3JpzKnvkyCNN/CXIM+W3BWuPlCNupEuB
	lLHuW+/doPxx85CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74BE23EA6E;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DFGAHEW5pmmlFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59132A0B82; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 32/32] fs: Drop i_private_list from address_space
Date: Tue,  3 Mar 2026 11:34:21 +0100
Message-ID: <20260303103406.4355-64-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=jack@suse.cz; h=from:subject; bh=KGtDrC9rNzTK65SQ8Oe7H9Ud9xEAArRJg33A6iQt0U0=; b=kA0DAAgBnJ2qBz9kQNkByyZiAGmmuTmiwKupnqCllCbgGVKgOMHk8s5SOF8d/mNwYbZRpubyN okBMwQAAQgAHRYhBKtZ0SvWnjKKtVUoHJydqgc/ZEDZBQJpprk5AAoJEJydqgc/ZEDZAigIAPAg aLhOjvAkhogRp0PsPfiAlvNv8YRXMwIUjSIqMVAVwFc9REL4+R/6NFJ4gCRMGYFlHOC4aiMszpE UhueKj0QF0yqOeimbTOxxJ4HM3FWc2ur/GMmzFeJWrzhICzX09nA7/6Hprn8HNFifoXIakkxFc9 9twj3/r1SUkgyxIJp/2OBbYiE3rtCR+eEdZdPQ9H+4W2G6nh48oBHafwjhTisOiNQU7nNMUxk81 j4ACfRGlNgQs4+nSQK9oqCnaxhuwyww22NWbsYcINd7RbAgUaUDydVNDDXw6s0L4ZqXj57PIlyo XL4jg8Q4WkKImKMYn4iUBtJnDjfg0FkWiPEaVKw=
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 1992C1ECD95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79171-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Nobody is using i_private_list anymore. Remove it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c         | 2 --
 include/linux/fs.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d5774e627a9c..a8f019078fab 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -481,7 +481,6 @@ static void __address_space_init_once(struct address_space *mapping)
 {
 	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
 	init_rwsem(&mapping->i_mmap_rwsem);
-	INIT_LIST_HEAD(&mapping->i_private_list);
 	spin_lock_init(&mapping->i_private_lock);
 	mapping->i_mmap = RB_ROOT_CACHED;
 }
@@ -795,7 +794,6 @@ void clear_inode(struct inode *inode)
 	 * nor even WARN_ON(!mapping_empty).
 	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
-	BUG_ON(!list_empty(&inode->i_data.i_private_list));
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(inode_state_read_once(inode) & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1611d8ce4b66..adad21e31cfc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -470,7 +470,6 @@ struct mapping_metadata_bhs {
  * @flags: Error bits and flags (AS_*).
  * @wb_err: The most recent error which has occurred.
  * @i_private_lock: For use by the owner of the address_space.
- * @i_private_list: For use by the owner of the address_space.
  */
 struct address_space {
 	struct inode		*host;
@@ -489,7 +488,6 @@ struct address_space {
 	unsigned long		flags;
 	errseq_t		wb_err;
 	spinlock_t		i_private_lock;
-	struct list_head	i_private_list;
 	struct rw_semaphore	i_mmap_rwsem;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
-- 
2.51.0



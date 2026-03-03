Return-Path: <linux-fsdevel+bounces-79169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HCBLtS5pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A01ECBD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C1CF3026D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958439D6C9;
	Tue,  3 Mar 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="riRJ8NW+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f30DNEh2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="riRJ8NW+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f30DNEh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F63947A0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534189; cv=none; b=f8OFdeAQCxYXirIBwvYgWuuf32ZET8n722gp/hccqPBJhe1t2fsJG0rPjh5Vc5Kjmca9JnfOnWUbUzUYK5JIlYpLf4g1xH1IHn6OcODUBPOY2SOL/Isiew0HTKUmUI4PijRLniUlqcAXOzVMeRRx6ej9eioXvNRSJh6dKUn8eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534189; c=relaxed/simple;
	bh=w1z6jnxF8yDzKQW95qXVLGcI3yol4PvG2FoQtSuAD3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me/NZs+AWAdvBLxJ/XjU3diJTA9NP4TGOl6g+rAAsJIHgx56gckf6kFat4LKgvwozIrBnUQiJgcRjmOtn/mSC0FsuXdUsg07OXv4WUKii72vF9AEEp/Rr97x5HnUZQ/vSlSSq9avv2KDP2NFPB/HhEp2chgH632V2xKeS8D6Va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=riRJ8NW+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f30DNEh2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=riRJ8NW+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f30DNEh2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 649573F93D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8kyywLHolUFfflmeKoQmwdoShpEfRfGPbaWvTfEWyg=;
	b=riRJ8NW+V1zZx8cER/1x1sr8pnsKHIaIEIx/c05/7IhYddMIYhuBNB1YeexWxKoiQEsyD7
	mXtVQzMuEF4htuZU8Dv5ODkB5ct1+hD8cb1vr5ua86U8Vqc4Pszk3VqqOBLf/mGm3+/J9u
	5cUnoWpr+mXwJp46KaWZZY5yiKRosj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8kyywLHolUFfflmeKoQmwdoShpEfRfGPbaWvTfEWyg=;
	b=f30DNEh2hU2XMQ+xlXR4PJS2MO4i4h5WSF36OjO18kXAC9PPALuN454QGTgM9ci/Y2IZVF
	Z0KSrzaLupvc61CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8kyywLHolUFfflmeKoQmwdoShpEfRfGPbaWvTfEWyg=;
	b=riRJ8NW+V1zZx8cER/1x1sr8pnsKHIaIEIx/c05/7IhYddMIYhuBNB1YeexWxKoiQEsyD7
	mXtVQzMuEF4htuZU8Dv5ODkB5ct1+hD8cb1vr5ua86U8Vqc4Pszk3VqqOBLf/mGm3+/J9u
	5cUnoWpr+mXwJp46KaWZZY5yiKRosj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8kyywLHolUFfflmeKoQmwdoShpEfRfGPbaWvTfEWyg=;
	b=f30DNEh2hU2XMQ+xlXR4PJS2MO4i4h5WSF36OjO18kXAC9PPALuN454QGTgM9ci/Y2IZVF
	Z0KSrzaLupvc61CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59FC03EA6F;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VL3cFUW5pmmXFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 35DD4A0B7D; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 28/32] minix: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:17 +0100
Message-ID: <20260303103406.4355-60-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=jack@suse.cz; h=from:subject; bh=w1z6jnxF8yDzKQW95qXVLGcI3yol4PvG2FoQtSuAD3M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprk2v2FfAPa1w9f7A49GkDXcSeq/sH/iUnnvR jcCiWxatWiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5NgAKCRCcnaoHP2RA 2fMjCAC2dbhicKhyynE4JWWF61bmiCpPMpGAK4sf7cvJyVAxew2gXZFeKUCnksLJWiqIa2IcejS wrjZW+nVCA9RMis6u/+vQ9JVCdCcKDwwmlD2EBfj7TNmerBc9slRwdKESJrpOMXCh54ge6J8m2a chM5bCBeenSjKH+a6BpbBFoQIQNvG8xsu8m7q/S66uGG7MyXYxHTudyjoxrGO0huJ13UQd9jaZl DGhwTyyFI+fZZ7Mctuvij+ZdwlaUXK6CGjJTuZwE9yTjDpRNw6y5tl6HCayh8XW5NKwonRXfsM1 AMX68dkZN5OALYJfmcyZLrQ3/8X52nXd7TZwuSOb9+ZZVkRG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E43A01ECBD5
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
	TAGGED_FROM(0.00)[bounces-79169-lists,linux-fsdevel=lfdr.de];
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

Track metadata bhs for an inode in fs-private part of the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/minix/file.c  | 1 +
 fs/minix/inode.c | 8 ++++++++
 fs/minix/minix.h | 2 ++
 fs/minix/namei.c | 1 +
 4 files changed, 12 insertions(+)

diff --git a/fs/minix/file.c b/fs/minix/file.c
index dca7ac71f049..b3abe380634a 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -50,4 +50,5 @@ static int minix_setattr(struct mnt_idmap *idmap,
 const struct inode_operations minix_file_inode_operations = {
 	.setattr	= minix_setattr,
 	.getattr	= minix_getattr,
+	.get_metadata_bhs = minix_get_metadata_bhs,
 };
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index ab7c06efb139..20abbe21a632 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -85,6 +85,8 @@ static struct inode *minix_alloc_inode(struct super_block *sb)
 	ei = alloc_inode_sb(sb, minix_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
+	mmb_init(&ei->i_metadata_bhs);
+
 	return &ei->vfs_inode;
 }
 
@@ -122,6 +124,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(minix_inode_cachep);
 }
 
+struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode)
+{
+	return &minix_i(inode)->i_metadata_bhs;
+}
+
 static const struct super_operations minix_sops = {
 	.alloc_inode	= minix_alloc_inode,
 	.free_inode	= minix_free_in_core_inode,
@@ -502,6 +509,7 @@ static const struct address_space_operations minix_aops = {
 static const struct inode_operations minix_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= minix_getattr,
+	.get_metadata_bhs = minix_get_metadata_bhs,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 7e1f652f16d3..38981a30ac99 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -19,6 +19,7 @@ struct minix_inode_info {
 		__u16 i1_data[16];
 		__u32 i2_data[16];
 	} u;
+	struct mapping_metadata_bhs i_metadata_bhs;
 	struct inode vfs_inode;
 };
 
@@ -57,6 +58,7 @@ unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
 		struct kstat *, u32, unsigned int);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
+struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 
 extern void V1_minix_truncate(struct inode *);
 extern void V2_minix_truncate(struct inode *);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 263e4ba8b1c8..e31e84a677eb 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -288,4 +288,5 @@ const struct inode_operations minix_dir_inode_operations = {
 	.rename		= minix_rename,
 	.getattr	= minix_getattr,
 	.tmpfile	= minix_tmpfile,
+	.get_metadata_bhs = minix_get_metadata_bhs,
 };
-- 
2.51.0



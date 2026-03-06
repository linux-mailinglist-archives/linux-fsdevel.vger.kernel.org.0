Return-Path: <linux-fsdevel+bounces-79614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KrIKizXqmnmXgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 14:31:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4416A221AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2556B307BA87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377339A06F;
	Fri,  6 Mar 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Z2fwAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FF34D904;
	Fri,  6 Mar 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803633; cv=none; b=Ve/tDfttTZKycXrjXRHm395b2H2gt+1a4ZrmITtmAcNblw6V8urscC79eoECPOotHEhINc63eJfSd36iLCXHENzIcqFT6nkowGAUQOZky+UTG2WYXsRWNItFBcbALj+JRzws0S65d0UZoQJwHYYrGke+vqr3yga9QwVODVJK1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803633; c=relaxed/simple;
	bh=ScNo3TEUI1lhEFlhGH5rcOeDy331UodFOc8V1NNREkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ey2AXk7i+FTTxGQIoC+TXL/wUxNA1hlBqIu1lPGpLsF0qitvWi1WXPgjhI6TBEC8cYhVs/YmD/5T8EUSDR6URZyMpEoi0iu/lleUwx+DnGPDPd3gMEGdbF3LINNsR86dSQmyislWaUtFTC4O9kgizeH3F2OiiRd7OZ2QPImR9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Z2fwAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9508FC4CEF7;
	Fri,  6 Mar 2026 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803633;
	bh=ScNo3TEUI1lhEFlhGH5rcOeDy331UodFOc8V1NNREkQ=;
	h=From:Date:Subject:To:Cc:From;
	b=g3Z2fwAn2nIeD1zD3m1GQqK5/1SUTMnq2hAfT3O4CmlVRsj3uxp9Lyuc/VCYz8f3s
	 fEo2VAshMZ6SnfppOub9S+E0Fx1oBzwlayhF30uSYMJI/IYYWvXEBHmz75V0y6LYct
	 E1KBecFcNntj8AKc53bfQ9EoRyFTvplrCYE9TsMduaEDVSyTPXG+w2TuLdnSQtUh1v
	 BybMx0Z4LREw8TtczP5fI2UrAaXwwYLNCVyCxTck94DM6TOLYbkDUJCdeC4tJaj+LO
	 flfWNf07UPC0NspRpDNfJu0MMGMPRqrEA93ibmwhFZy7lK7Lxqp7HpZsfOX5E+nonU
	 n3Tf6AfnvKrfA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 06 Mar 2026 08:27:01 -0500
Subject: [PATCH] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3czMvHzdUjMTXUOLpEQDEzMzY6NEAyWg8oKi1LTMCrBR0bG1tQA
 zog4gWgAAAA==
X-Change-ID: 20260306-iino-u64-18ba046632a0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6132; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ScNo3TEUI1lhEFlhGH5rcOeDy331UodFOc8V1NNREkQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqtYsz0V0av4nReK7IVz+m8NB0a+bBRDPi/Sjl
 vq2mleFaVeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaarWLAAKCRAADmhBGVaC
 FVzVD/9tE8WddCNhH6nTS9ZkuFEL4cE+uHngtiI1qanMbMVKboM11GlaYEe7eFyfr39kzCmJtNg
 fPdcRzOrVsAQDXg7KXCqfh5mspWvSmD3zPS2ErSgaYIOzv89UaN2sAVKnXaRCIl+2V8cP+3VSHa
 M0oz1UniyBA+eHPAHpMGOxRlhNnfOkY1/lbUjBYWS6VzX4jpFe2XDguWBuzdy2zA9RaihhGxc8t
 J+kJZec1vQpYJ4ZATsiKYtdZwZD84Vk5I4lpv4cZXLof6MQGDzkJaMG9x1sPXlfoBXGhPsfqWgs
 zwQBBMXL0/AmT3xMFmJ1zPly+V88kNoHYgPhRiL2NOSozZH4HEImzFfzSVLMaUZsWLTSBQ6Wtya
 +iBxAYpSbgrNHry3RPBXpOcAxIavNCL79dEGh8K3yFztBM41Ac3wwsBV3fPiRXjP+zZApg4/XOQ
 LMMqC0RYyijqaeC124cuZhYFuOmN82Fr1Esy7InpoTnw5MXVrS1SNPPdzc7qt8bz2QuKyhKnre3
 ESEhNEUazebu9pYzZoZWyLTgpcSD2kN0tXx0vf5ASbljAKc4Gj3Ra0UGm96M5hbYmR4Ew2t0mry
 zTvTgfs/DvIW4UMzwjBGufnWWjnWkXj7gEiv9Lo1APfvXKp1+U3jIT0BDm0hUh/ZZiYIkn6YbqD
 kqb1LNtuvo28vQQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 4416A221AB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79614-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

Christoph says, in response to one of the patches in the i_ino widening
series, which changes the prototype of several functions in fs.h:

    "Can you please drop all these pointless externs while you're at it?"

Remove extern keyword from functions touched by that patch (and a few
that happened to be nearby).

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h | 58 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 097443bf12e289c347651e5f3da5b67eb6b53121..0c3ad6d7a20055b654b6d5087756f33d9e0fc4fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2912,36 +2912,36 @@ static inline bool name_contains_dotdot(const char *name)
 #include <linux/err.h>
 
 /* needed for stackable file system support */
-extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
+loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
-extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
+loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
 
-extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
+int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
 static inline int inode_init_always(struct super_block *sb, struct inode *inode)
 {
 	return inode_init_always_gfp(sb, inode, GFP_NOFS);
 }
 
-extern void inode_init_once(struct inode *);
-extern void address_space_init_once(struct address_space *mapping);
-extern struct inode * igrab(struct inode *);
-extern ino_t iunique(struct super_block *, ino_t);
-extern int inode_needs_sync(struct inode *inode);
-extern int inode_just_drop(struct inode *inode);
+void inode_init_once(struct inode *);
+void address_space_init_once(struct address_space *mapping);
+struct inode *igrab(struct inode *);
+ino_t iunique(struct super_block *, ino_t);
+int inode_needs_sync(struct inode *inode);
+int inode_just_drop(struct inode *inode);
 static inline int inode_generic_drop(struct inode *inode)
 {
 	return !inode->i_nlink || inode_unhashed(inode);
 }
-extern void d_mark_dontcache(struct inode *inode);
+void d_mark_dontcache(struct inode *inode);
 
-extern struct inode *ilookup5_nowait(struct super_block *sb,
+struct inode *ilookup5_nowait(struct super_block *sb,
 		u64 hashval, int (*test)(struct inode *, void *),
 		void *data, bool *isnew);
-extern struct inode *ilookup5(struct super_block *sb, u64 hashval,
+struct inode *ilookup5(struct super_block *sb, u64 hashval,
 		int (*test)(struct inode *, void *), void *data);
-extern struct inode *ilookup(struct super_block *sb, u64 ino);
+struct inode *ilookup(struct super_block *sb, u64 ino);
 
-extern struct inode *inode_insert5(struct inode *inode, u64 hashval,
+struct inode *inode_insert5(struct inode *inode, u64 hashval,
 		int (*test)(struct inode *, void *),
 		int (*set)(struct inode *, void *),
 		void *data);
@@ -2951,26 +2951,26 @@ struct inode *iget5_locked(struct super_block *, u64,
 struct inode *iget5_locked_rcu(struct super_block *, u64,
 			       int (*test)(struct inode *, void *),
 			       int (*set)(struct inode *, void *), void *);
-extern struct inode *iget_locked(struct super_block *, u64);
-extern struct inode *find_inode_nowait(struct super_block *,
+struct inode *iget_locked(struct super_block *, u64);
+struct inode *find_inode_nowait(struct super_block *,
 				       u64,
 				       int (*match)(struct inode *,
 						    u64, void *),
 				       void *data);
-extern struct inode *find_inode_rcu(struct super_block *, u64,
+struct inode *find_inode_rcu(struct super_block *, u64,
 				    int (*)(struct inode *, void *), void *);
-extern struct inode *find_inode_by_ino_rcu(struct super_block *, u64);
-extern int insert_inode_locked4(struct inode *, u64, int (*test)(struct inode *, void *), void *);
-extern int insert_inode_locked(struct inode *);
+struct inode *find_inode_by_ino_rcu(struct super_block *, u64);
+int insert_inode_locked4(struct inode *, u64, int (*test)(struct inode *, void *), void *);
+int insert_inode_locked(struct inode *);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern void lockdep_annotate_inode_mutex_key(struct inode *inode);
+void lockdep_annotate_inode_mutex_key(struct inode *inode);
 #else
 static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 #endif
-extern void unlock_new_inode(struct inode *);
-extern void discard_new_inode(struct inode *);
-extern unsigned int get_next_ino(void);
-extern void evict_inodes(struct super_block *sb);
+void unlock_new_inode(struct inode *);
+void discard_new_inode(struct inode *);
+unsigned int get_next_ino(void);
+void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
@@ -3015,21 +3015,21 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  */
 #define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
-extern void __insert_inode_hash(struct inode *, u64 hashval);
+void __insert_inode_hash(struct inode *, u64 hashval);
 static inline void insert_inode_hash(struct inode *inode)
 {
 	__insert_inode_hash(inode, inode->i_ino);
 }
 
-extern void __remove_inode_hash(struct inode *);
+void __remove_inode_hash(struct inode *);
 static inline void remove_inode_hash(struct inode *inode)
 {
 	if (!inode_unhashed(inode) && !hlist_fake(&inode->i_hash))
 		__remove_inode_hash(inode);
 }
 
-extern void inode_sb_list_add(struct inode *inode);
-extern void inode_lru_list_add(struct inode *inode);
+void inode_sb_list_add(struct inode *inode);
+void inode_lru_list_add(struct inode *inode);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);

---
base-commit: 1b626cfc5c2e16d02f0f7516b68b00aaa0a186cf
change-id: 20260306-iino-u64-18ba046632a0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



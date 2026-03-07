Return-Path: <linux-fsdevel+bounces-79705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB5FBkSDrGk1qQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 20:57:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7545322D6E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 20:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B3A3030B19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CA3A4F35;
	Sat,  7 Mar 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peiH4PxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B56292B44;
	Sat,  7 Mar 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913282; cv=none; b=fATlLhVQuprblAXX0mxhd6Ik1OB6u4OGAaJ4wanFNc+CfllEoq4Xim83ka5ibG0BVpT7oV36XwD2oe0vpTDQAGVn+CFUjridiheBcZH8B6yVsifQ41w5u0CydyPSHikmWn8ZzdeABhM3Ugef3CK2jtEmzZux1nSw3AVZxcJjbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913282; c=relaxed/simple;
	bh=0C5ENYp6Z6L2MI3V47o6LXpJ66JABmEWgqhX/tQ9T8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c6xlIcp+l7gsNR7OJSN3PNDJZBpbz9ScsOuY/zcLhngt6sJwcpn8kuYV+o8tdqsqYMBRuLzo0Kwz5/SkX1ZbL6kJ0M6MLYa8uPue1UjfIKnsQc2Tu4u66uYTP8UEDvKekGJkNyoNbkb27XFPZvL+1/SA/lwKe9PT1we100SV4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peiH4PxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2435CC19422;
	Sat,  7 Mar 2026 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913282;
	bh=0C5ENYp6Z6L2MI3V47o6LXpJ66JABmEWgqhX/tQ9T8s=;
	h=From:Date:Subject:To:Cc:From;
	b=peiH4PxWLZTYLVs1Ip753hlb0rlLzvrQMwsJgIokOrTJzIBuDqueji1ciaVeqAPtD
	 ebONpRsMl6ksGDBKoCqPCrpmm9XD5QZP+VNYlQLIMKVqDgzyEJgxieoFxd2IFuOUIn
	 YXLxQ9DAMGPo5f/d7NVKGGHNALHFFFEO3dhUIC20YpSaaYTqNGnIBstAKmXB8Nbx/B
	 XqAEl5odRKYjcaZXwv9UxtU7aKSNOGdVx2i05BuQvgs+kpUO2Utmo0mynj/xxNAlBT
	 vVeK2UcwXm0oKa6VmmoKAL9VcIVAnwxchuRWX1nvy3OU8MFzzyf3wn203n4KE6zK5v
	 RDFeXkl2elDXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 07 Mar 2026 14:54:31 -0500
Subject: [PATCH v2] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MywrCMBBFf6XM2kge7SCu/A/pIqljOyiJTDQoJ
 f9u7Fru6lwOZ4VMwpTh2K0gVDhzig3sroNp8XEmxZfGYLVF7TQq5pjUC3tlDsHrHtFZr6HpD6E
 rv7fUeWy8cH4m+WzlYn7vn0gxqs1gGFwYJt/b040k0n2fZIax1voFBmAm06EAAAA=
X-Change-ID: 20260306-iino-u64-18ba046632a0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7090; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0C5ENYp6Z6L2MI3V47o6LXpJ66JABmEWgqhX/tQ9T8s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBprIJ9slva1Cn7LTGyZELaCK2ZkwsJMy1PdeeRM
 r1psJJqbiKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaayCfQAKCRAADmhBGVaC
 FZejD/0TYwPyI4RV0ZfqNxY+EEdzsXtnrmeqhHWpoKNAfQ83NDxiPLXiwYnYKlBLfvLJ7u2rS02
 qEG5PyGuybLqXpbUH9Wvu8adK+ELgGCHhgK3WVAmMjwcTxJVv32S5f2llf19OhoUDWKau/Yvqn/
 +MfFrwCLebLGrNG1PFXIopx2tsgALCRnANjE31O6+kvsuPCtdsh3sJ2XU6dxeBKC3bBgYj6fjh3
 6UPBB3mC+3n0CcydIG7BjJFFMg0Rw38o0R/q/ktmguAhhfGba0ymne681DFsVwlmk1L2zB36m6l
 Q4j84fXXoqM2VpLfVEgqD4l+249TjADH24R2aXiNF0/5LsJ/Iu3dMHyuXYzkVAemGetxSjnepva
 9YrgY+ggy3R3Ujtl7O3Qd5ZDGKid/jYf/poO0cXA5Xbrr8THzh2+LPaQy7fchKVJOJ4My8DtQCq
 dQgkoXlVljGbVvaDb72ijlLQ5OpsZJMn6hNindPJHldPOUGV9sgOPTk7kX6+zjZLkz5qV3b/GFx
 yR3VZfJTsbE5sc4wJBagWYobZjIqnjfTQ3aT4kQVFVBPohz5DL1g+5GA6F9mPMDks6AIx7VUGpd
 MApd+65GKeE0Z01EAqUG4FuvZqC2KLzCo4tzjpxRsjpVVxRw6SYAaJAwonkrFoMzKREgrhpciDs
 wAKUwYNhAGVWSNQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 7545322D6E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79705-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

Christoph says, in response to one of the patches in the i_ino widening
series, which changes the prototype of several functions in fs.h:

    "Can you please drop all these pointless externs while you're at it?"

Remove extern keyword from functions touched by that patch (and a few
that happened to be nearby). Also add missing argument names to
declarations that lacked them.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add missing argument names to functions that lacked them
- Reflow some awkward indentation
- Link to v1: https://lore.kernel.org/r/20260306-iino-u64-v1-1-116b53b5ca42@kernel.org
---
 include/linux/fs.h | 78 ++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 097443bf12e289c347651e5f3da5b67eb6b53121..9be701267c3820b2a38fe8de27073c98b78c0d8e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2912,65 +2912,63 @@ static inline bool name_contains_dotdot(const char *name)
 #include <linux/err.h>
 
 /* needed for stackable file system support */
-extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
+loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
-extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
+loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
 
-extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
+int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp);
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
+void inode_init_once(struct inode *inode);
+void address_space_init_once(struct address_space *mapping);
+struct inode *igrab(struct inode *inode);
+ino_t iunique(struct super_block *sb, ino_t max_reserved);
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
-struct inode *iget5_locked(struct super_block *, u64,
-			   int (*test)(struct inode *, void *),
-			   int (*set)(struct inode *, void *), void *);
-struct inode *iget5_locked_rcu(struct super_block *, u64,
-			       int (*test)(struct inode *, void *),
-			       int (*set)(struct inode *, void *), void *);
-extern struct inode *iget_locked(struct super_block *, u64);
-extern struct inode *find_inode_nowait(struct super_block *,
-				       u64,
-				       int (*match)(struct inode *,
-						    u64, void *),
-				       void *data);
-extern struct inode *find_inode_rcu(struct super_block *, u64,
-				    int (*)(struct inode *, void *), void *);
-extern struct inode *find_inode_by_ino_rcu(struct super_block *, u64);
-extern int insert_inode_locked4(struct inode *, u64, int (*test)(struct inode *, void *), void *);
-extern int insert_inode_locked(struct inode *);
+struct inode *iget5_locked(struct super_block *sb, u64 hashval,
+		int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data);
+struct inode *iget5_locked_rcu(struct super_block *sb, u64 hashval,
+		int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data);
+struct inode *iget_locked(struct super_block *sb, u64 ino);
+struct inode *find_inode_nowait(struct super_block *sb, u64 hashval,
+				int (*match)(struct inode *, u64, void *), void *data);
+struct inode *find_inode_rcu(struct super_block *sb, u64 hashval,
+			     int (*test)(struct inode *, void *), void *data);
+struct inode *find_inode_by_ino_rcu(struct super_block *sb, u64 ino);
+int insert_inode_locked4(struct inode *inode, u64 hashval,
+			 int (*test)(struct inode *, void *), void *data);
+int insert_inode_locked(struct inode *inode);
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
+void unlock_new_inode(struct inode *inode);
+void discard_new_inode(struct inode *inode);
+unsigned int get_next_ino(void);
+void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
@@ -3015,21 +3013,21 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  */
 #define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
-extern void __insert_inode_hash(struct inode *, u64 hashval);
+void __insert_inode_hash(struct inode *inode, u64 hashval);
 static inline void insert_inode_hash(struct inode *inode)
 {
 	__insert_inode_hash(inode, inode->i_ino);
 }
 
-extern void __remove_inode_hash(struct inode *);
+void __remove_inode_hash(struct inode *inode);
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



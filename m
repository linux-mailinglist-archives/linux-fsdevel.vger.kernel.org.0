Return-Path: <linux-fsdevel+bounces-78477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGLmNchIoGkuhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:21:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C60731A651F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC76A3088704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2873246EB;
	Thu, 26 Feb 2026 13:19:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2371309F01
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111989; cv=none; b=B1zTdt1OKlRekysjScMA6tz+bppyvq7eRxV+z3QsDAj+/enuUpe1eFTl3GD7az0n5t297JsE8t74AJfiIVFZ2fNz6yeXyjcFGyJtQgh6B1tjv2XAU1At8o2KUUyOk7rhqZPsn5VubMXIlOmFA4Ekiwvh87xi5H4aSqiJrokra4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111989; c=relaxed/simple;
	bh=XyzgrBV3hEiFUoaMeYeoYmoUZu6QlGAqwjet4IR5u84=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XinhUgbcXIVO98G0wA6GqmIeTwZ5MTANXYbxJlRdMWSkY0agfB99YtwjsasU7bxwIK/9PmgDomuALoBczHiQFpcA70btqjSvmiZsyyqu26uCLnamA9AmH8epjy8Uck7e9SOyhfqVcKjk/I6j+BT3tmYi7htKXdgQCGCPDls1c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61QDJVSx006422;
	Thu, 26 Feb 2026 22:19:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61QDJVAP006414
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Feb 2026 22:19:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
Date: Thu, 26 Feb 2026 22:19:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] hpfs: obsolete check=none mount option
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-78477-lists,linux-fsdevel=lfdr.de];
	TO_DN_ALL(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: C60731A651F
X-Rspamd-Action: no action

syzbot is reporting use-after-free read problems when a crafted HPFS image
was mounted with "check=none" option.

The "check=none" option is intended for only users who want maximum speed
and use the filesystem only on trusted input. But fuzzers are for testing
the filesystem on untrusted input.

Mikulas Patocka (the HPFS maintainer) was thinking that there is no need to
add some middle ground where "check=none" would check some structures and
won't check others [1]. But now, Mikulas came to think that "check=none"
is not required at all because HPFS is not considered 'high-performance'
anymore [2].

This patch does not eliminate "check=none" option itself in order not to
break existing scripts or /etc/fstab configurations that people may have.

This patch instead eliminates sb_chk != 0 test that becomes redundant.
But in order to keep this patch minimal, this patch does not fix coding
style problems.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
Reported-by: syzbot+8debf4b3f7c7391cd8eb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8debf4b3f7c7391cd8eb
Link: https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com [1]
Link: https://lkml.kernel.org/r/31825fd6-45b8-928f-0022-0696202032ce@twibright.com [2]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hpfs/alloc.c |  4 ++--
 fs/hpfs/anode.c | 13 ++++---------
 fs/hpfs/dir.c   |  5 ++---
 fs/hpfs/dnode.c | 19 ++++---------------
 fs/hpfs/map.c   | 14 +++++++-------
 fs/hpfs/super.c | 12 +++++-------
 6 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/fs/hpfs/alloc.c b/fs/hpfs/alloc.c
index 66617b1557c6..a821dbd4e8cd 100644
--- a/fs/hpfs/alloc.c
+++ b/fs/hpfs/alloc.c
@@ -178,7 +178,7 @@ static secno alloc_in_bmp(struct super_block *s, secno near, unsigned n, unsigne
 	} while (i != nr);
 	rt:
 	if (ret) {
-		if (hpfs_sb(s)->sb_chk && ((ret >> 14) != (bs >> 14) || (le32_to_cpu(bmp[(ret & 0x3fff) >> 5]) | ~(((1 << n) - 1) << (ret & 0x1f))) != 0xffffffff)) {
+		if (((ret >> 14) != (bs >> 14) || (le32_to_cpu(bmp[(ret & 0x3fff) >> 5]) | ~(((1 << n) - 1) << (ret & 0x1f))) != 0xffffffff)) {
 			hpfs_error(s, "Allocation doesn't work! Wanted %d, allocated at %08x", n, ret);
 			ret = 0;
 			goto b;
@@ -404,7 +404,7 @@ int hpfs_check_free_dnodes(struct super_block *s, int n)
 
 void hpfs_free_dnode(struct super_block *s, dnode_secno dno)
 {
-	if (hpfs_sb(s)->sb_chk) if (dno & 3) {
+	if (dno & 3) {
 		hpfs_error(s, "hpfs_free_dnode: dnode %08x not aligned", dno);
 		return;
 	}
diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index a4f5321eafae..efa534cd7abc 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -20,7 +20,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
 	int i;
 	int c1, c2 = 0;
 	go_down:
-	if (hpfs_sb(s)->sb_chk) if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_bplus_lookup")) return -1;
+	if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_bplus_lookup")) return -1;
 	if (bp_internal(btree)) {
 		for (i = 0; i < btree->n_used_nodes; i++)
 			if (le32_to_cpu(btree->u.internal[i].file_secno) > sec) {
@@ -38,7 +38,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
 		if (le32_to_cpu(btree->u.external[i].file_secno) <= sec &&
 		    le32_to_cpu(btree->u.external[i].file_secno) + le32_to_cpu(btree->u.external[i].length) > sec) {
 			a = le32_to_cpu(btree->u.external[i].disk_secno) + sec - le32_to_cpu(btree->u.external[i].file_secno);
-			if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, a, 1, "data")) {
+			if (hpfs_chk_sectors(s, a, 1, "data")) {
 				brelse(bh);
 				return -1;
 			}
@@ -89,7 +89,6 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 		btree->u.internal[n].file_secno = cpu_to_le32(-1);
 		mark_buffer_dirty(bh);
 		brelse(bh);
-		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_add_sector_to_btree #1")) return -1;
 		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
 		btree = GET_BTREE_PTR(&anode->btree);
@@ -165,7 +164,6 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 	c2 = 0;
 	while (up != (anode_secno)-1) {
 		struct anode *new_anode;
-		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, up, &c1, &c2, "hpfs_add_sector_to_btree #2")) return -1;
 		if (up != node || !fnod) {
 			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
@@ -288,7 +286,6 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
 	while (bp_internal(btree1)) {
 		ano = le32_to_cpu(btree1->u.internal[pos].down);
 		if (level) brelse(bh);
-		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
 				return;
 		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
@@ -301,7 +298,6 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
 	go_up:
 	if (!level) return;
 	brelse(bh);
-	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
 	hpfs_free_sectors(s, ano, 1);
 	oano = ano;
@@ -348,7 +344,7 @@ int hpfs_ea_read(struct super_block *s, secno a, int ano, unsigned pos,
 			if ((sec = anode_lookup(s, a, pos >> 9)) == -1)
 				return -1;
 		} else sec = a + (pos >> 9);
-		if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #1")) return -1;
+		if (hpfs_chk_sectors(s, sec, 1, "ea #1")) return -1;
 		if (!(data = hpfs_map_sector(s, sec, &bh, (len - 1) >> 9)))
 			return -1;
 		l = 0x200 - (pos & 0x1ff); if (l > len) l = len;
@@ -371,7 +367,7 @@ int hpfs_ea_write(struct super_block *s, secno a, int ano, unsigned pos,
 			if ((sec = anode_lookup(s, a, pos >> 9)) == -1)
 				return -1;
 		} else sec = a + (pos >> 9);
-		if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, sec, 1, "ea #2")) return -1;
+		if (hpfs_chk_sectors(s, sec, 1, "ea #2")) return -1;
 		if (!(data = hpfs_map_sector(s, sec, &bh, (len - 1) >> 9)))
 			return -1;
 		l = 0x200 - (pos & 0x1ff); if (l > len) l = len;
@@ -445,7 +441,6 @@ void hpfs_truncate_btree(struct super_block *s, secno f, int fno, unsigned secs)
 		}
 		node = le32_to_cpu(btree->u.internal[i].down);
 		brelse(bh);
-		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, node, &c1, &c2, "hpfs_truncate_btree"))
 				return;
 		if (!(anode = hpfs_map_anode(s, node, &bh))) return;
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index ceb50b2dc91a..01ca66da2f50 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -76,7 +76,7 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 
 	hpfs_lock(inode->i_sb);
 
-	if (hpfs_sb(inode->i_sb)->sb_chk) {
+	{
 		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode")) {
 			ret = -EFSERROR;
 			goto out;
@@ -124,7 +124,6 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 		/* This won't work when cycle is longer than number of dirents
 		   accepted by filldir, but what can I do?
 		   maybe killall -9 ls helps */
-		if (hpfs_sb(inode->i_sb)->sb_chk)
 			if (hpfs_stop_cycles(inode->i_sb, ctx->pos, &c1, &c2, "hpfs_readdir")) {
 				ret = -EFSERROR;
 				goto out;
@@ -158,7 +157,7 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		if (de->first || de->last) {
-			if (hpfs_sb(inode->i_sb)->sb_chk) {
+			{
 				if (de->first && !de->last && (de->namelen != 2
 				    || de ->name[0] != 1 || de->name[1] != 1))
 					hpfs_error(inode->i_sb, "hpfs_readdir: bad ^A^A entry; pos = %08lx", (unsigned long)ctx->pos);
diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
index dde764ebe246..5a15b76d13eb 100644
--- a/fs/hpfs/dnode.c
+++ b/fs/hpfs/dnode.c
@@ -144,7 +144,7 @@ static void set_last_pointer(struct super_block *s, struct dnode *d, dnode_secno
 		hpfs_error(s, "set_last_pointer: empty dnode %08x", le32_to_cpu(d->self));
 		return;
 	}
-	if (hpfs_sb(s)->sb_chk) {
+	{
 		if (de->down) {
 			hpfs_error(s, "set_last_pointer: dnode %08x has already last pointer %08x",
 				le32_to_cpu(d->self), de_down_pointer(de));
@@ -266,7 +266,6 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 		return 1;
 	}
 	go_up_a:
-	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
 			kfree(nd);
@@ -397,7 +396,6 @@ int hpfs_add_dirent(struct inode *i,
 	int c1, c2 = 0;
 	dno = hpfs_inode->i_dno;
 	down:
-	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_dirent")) return 1;
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 1;
 	de_end = dnode_end_de(d);
@@ -442,11 +440,10 @@ static secno move_to_top(struct inode *i, dnode_secno from, dnode_secno to)
 	int c1, c2 = 0;
 	dno = from;
 	while (1) {
-		if (hpfs_sb(i->i_sb)->sb_chk)
 			if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "move_to_top"))
 				return 0;
 		if (!(dnode = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 0;
-		if (hpfs_sb(i->i_sb)->sb_chk) {
+		{
 			if (le32_to_cpu(dnode->up) != chk_up) {
 				hpfs_error(i->i_sb, "move_to_top: up pointer from %08x should be %08x, is %08x",
 					dno, chk_up, le32_to_cpu(dnode->up));
@@ -534,7 +531,7 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		up = le32_to_cpu(dnode->up);
 		de = dnode_first_de(dnode);
 		down = de->down ? de_down_pointer(de) : 0;
-		if (hpfs_sb(i->i_sb)->sb_chk) if (root && !down) {
+		if (root && !down) {
 			hpfs_error(i->i_sb, "delete_empty_dnode: root dnode %08x is empty", dno);
 			goto end;
 		}
@@ -547,7 +544,6 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			struct buffer_head *bh;
 			struct dnode *d1;
 			struct quad_buffer_head qbh1;
-			if (hpfs_sb(i->i_sb)->sb_chk)
 				if (up != i->i_ino) {
 					hpfs_error(i->i_sb,
 						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08lx",
@@ -751,12 +747,11 @@ void hpfs_count_dnodes(struct super_block *s, dnode_secno dno, int *n_dnodes,
 	int d1, d2 = 0;
 	go_down:
 	if (n_dnodes) (*n_dnodes)++;
-	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, dno, &c1, &c2, "hpfs_count_dnodes #1")) return;
 	ptr = 0;
 	go_up:
 	if (!(dnode = hpfs_map_dnode(s, dno, &qbh))) return;
-	if (hpfs_sb(s)->sb_chk) if (odno && odno != -1 && le32_to_cpu(dnode->up) != odno)
+	if (odno && odno != -1 && le32_to_cpu(dnode->up) != odno)
 		hpfs_error(s, "hpfs_count_dnodes: bad up pointer; dnode %08x, down %08x points to %08x", odno, dno, le32_to_cpu(dnode->up));
 	de = dnode_first_de(dnode);
 	if (ptr) while(1) {
@@ -787,7 +782,6 @@ void hpfs_count_dnodes(struct super_block *s, dnode_secno dno, int *n_dnodes,
 		return;
 	}
 	hpfs_brelse4(&qbh);
-	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, ptr, &d1, &d2, "hpfs_count_dnodes #2")) return;
 	odno = -1;
 	goto go_up;
@@ -824,11 +818,9 @@ dnode_secno hpfs_de_as_down_as_possible(struct super_block *s, dnode_secno dno)
 	int c1, c2 = 0;
 
 	again:
-	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, d, &c1, &c2, "hpfs_de_as_down_as_possible"))
 			return d;
 	if (!(de = map_nth_dirent(s, d, 1, &qbh, NULL))) return dno;
-	if (hpfs_sb(s)->sb_chk)
 		if (up && le32_to_cpu(((struct dnode *)qbh.data)->up) != up)
 			hpfs_error(s, "hpfs_de_as_down_as_possible: bad up pointer; dnode %08x, down %08x points to %08x", up, d, le32_to_cpu(((struct dnode *)qbh.data)->up));
 	if (!de->down) {
@@ -917,7 +909,6 @@ struct hpfs_dirent *map_dirent(struct inode *inode, dnode_secno dno,
 
 	if (!S_ISDIR(inode->i_mode)) hpfs_error(inode->i_sb, "map_dirent: not a directory\n");
 	again:
-	if (hpfs_sb(inode->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(inode->i_sb, dno, &c1, &c2, "map_dirent")) return NULL;
 	if (!(dnode = hpfs_map_dnode(inode->i_sb, dno, qbh))) return NULL;
 	
@@ -1062,7 +1053,6 @@ struct hpfs_dirent *map_fnode_dirent(struct super_block *s, fnode_secno fno,
 	if (c < 0 && de->down) {
 		dno = de_down_pointer(de);
 		hpfs_brelse4(qbh);
-		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, dno, &c1, &c2, "map_fnode_dirent #1")) {
 				kfree(name2);
 				return NULL;
@@ -1081,7 +1071,6 @@ struct hpfs_dirent *map_fnode_dirent(struct super_block *s, fnode_secno fno,
 	downd = dno;
 	dno = le32_to_cpu(d->up);
 	hpfs_brelse4(qbh);
-	if (hpfs_sb(s)->sb_chk)
 		if (hpfs_stop_cycles(s, downd, &d1, &d2, "map_fnode_dirent #2")) {
 			kfree(name2);
 			return NULL;
diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index be73233502f8..eeb8ff9b34bb 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -20,7 +20,7 @@ __le32 *hpfs_map_bitmap(struct super_block *s, unsigned bmp_block,
 	secno sec;
 	__le32 *ret;
 	unsigned n_bands = (hpfs_sb(s)->sb_fs_size + 0x3fff) >> 14;
-	if (hpfs_sb(s)->sb_chk) if (bmp_block >= n_bands) {
+	if (bmp_block >= n_bands) {
 		hpfs_error(s, "hpfs_map_bitmap called with bad parameter: %08x at %s", bmp_block, id);
 		return NULL;
 	}
@@ -164,11 +164,11 @@ void hpfs_load_hotfix_map(struct super_block *s, struct hpfs_spare_block *spareb
 struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_head **bhp)
 {
 	struct fnode *fnode;
-	if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, ino, 1, "fnode")) {
+	if (hpfs_chk_sectors(s, ino, 1, "fnode")) {
 		return NULL;
 	}
 	if ((fnode = hpfs_map_sector(s, ino, bhp, FNODE_RD_AHEAD))) {
-		if (hpfs_sb(s)->sb_chk) {
+		{
 			struct extended_attribute *ea;
 			struct extended_attribute *ea_end;
 			if (le32_to_cpu(fnode->magic) != FNODE_MAGIC) {
@@ -221,9 +221,9 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 struct anode *hpfs_map_anode(struct super_block *s, anode_secno ano, struct buffer_head **bhp)
 {
 	struct anode *anode;
-	if (hpfs_sb(s)->sb_chk) if (hpfs_chk_sectors(s, ano, 1, "anode")) return NULL;
+	if (hpfs_chk_sectors(s, ano, 1, "anode")) return NULL;
 	if ((anode = hpfs_map_sector(s, ano, bhp, ANODE_RD_AHEAD)))
-		if (hpfs_sb(s)->sb_chk) {
+		{
 			if (le32_to_cpu(anode->magic) != ANODE_MAGIC) {
 				hpfs_error(s, "bad magic on anode %08x", ano);
 				goto bail;
@@ -257,7 +257,7 @@ struct dnode *hpfs_map_dnode(struct super_block *s, unsigned secno,
 			     struct quad_buffer_head *qbh)
 {
 	struct dnode *dnode;
-	if (hpfs_sb(s)->sb_chk) {
+	{
 		if (hpfs_chk_sectors(s, secno, 4, "dnode")) return NULL;
 		if (secno & 3) {
 			hpfs_error(s, "dnode %08x not byte-aligned", secno);
@@ -265,7 +265,7 @@ struct dnode *hpfs_map_dnode(struct super_block *s, unsigned secno,
 		}	
 	}
 	if ((dnode = hpfs_map_4sectors(s, secno, qbh, DNODE_RD_AHEAD)))
-		if (hpfs_sb(s)->sb_chk) {
+		{
 			unsigned p, pp = 0;
 			unsigned char *d = (unsigned char *)dnode;
 			int b = 0;
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index c16d5d4caead..a6efb723f7d5 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -349,8 +349,7 @@ HPFS filesystem options:\n\
       umask=xxx         set mode of files that don't have mode specified in eas\n\
       case=lower        lowercase all files\n\
       case=asis         do not lowercase files (default)\n\
-      check=none        no fs checks - kernel may crash on corrupted filesystem\n\
-      check=normal      do some checks - it should not crash (default)\n\
+      check=normal      do some checks - kernel should not crash (default)\n\
       check=strict      do extra time-consuming checks, used for debugging\n\
       errors=continue   continue on errors\n\
       errors=remount-ro remount read-only if errors found (default)\n\
@@ -465,8 +464,6 @@ static int hpfs_show_options(struct seq_file *seq, struct dentry *root)
 	seq_printf(seq, ",umask=%03o", (~sbi->sb_mode & 0777));
 	if (sbi->sb_lowercase)
 		seq_printf(seq, ",case=lower");
-	if (!sbi->sb_chk)
-		seq_printf(seq, ",check=none");
 	if (sbi->sb_chk == 2)
 		seq_printf(seq, ",check=strict");
 	if (!sbi->sb_err)
@@ -615,7 +612,9 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 		if (sbi->sb_err == 0)
 			pr_err("Proceeding, but your filesystem could be corrupted if you delete files or directories\n");
 	}
-	if (sbi->sb_chk) {
+	if (!ctx->chk)
+		pr_info_once("check=none was obsoleted. Treating as check=normal.\n");
+	{
 		unsigned a;
 		if (le32_to_cpu(superblock->dir_band_end) - le32_to_cpu(superblock->dir_band_start) + 1 != le32_to_cpu(superblock->n_dir_band) ||
 		    le32_to_cpu(superblock->dir_band_end) < le32_to_cpu(superblock->dir_band_start) || le32_to_cpu(superblock->n_dir_band) > 0x4000) {
@@ -632,8 +631,7 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 			goto bail4;
 		}
 		sbi->sb_dirband_size = a;
-	} else
-		pr_err("You really don't want any checks? You are crazy...\n");
+	}
 
 	/* Load code page table */
 	if (le32_to_cpu(spareblock->n_code_pages))
-- 
2.53.0



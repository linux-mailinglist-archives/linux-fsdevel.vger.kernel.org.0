Return-Path: <linux-fsdevel+bounces-76933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DY2JRtbjGkmlwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:34:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834461236AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BAD302A6B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B163502A9;
	Wed, 11 Feb 2026 10:30:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40011367F4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805816; cv=none; b=K/qlPmSr0tLqCFXggZar9SSCG0nS8Z1vrQwWeVpO5mJpi1f0gHZFB8SJoTEe/s/khtPyQs615EFgnuneNWm6jKMFHwNHr1Isujp2MEmINZNxpCCI/cEZ/T4hb6tDBHcxqzoReBOii8ywziCbRponLpYKqlffNJpRL/h/VCq23vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805816; c=relaxed/simple;
	bh=6Svp2yakS4ISlSmYeVfCWOnhOVOb5kEc4Wzio/ROhBw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YVYqdfWrsNkcBRuM6rC7AegdvM8WBW62fyiUSgXTSi1QcHl+JZVdpccHSAkuFD2wpAFI8nAaoigHSIWWRNWs6OkcgAO/8k708DfIkRNpu0UD0AzTZMqcf49eG4gzYncWW2e6s5h/kubnb9Hzaf9/ui6yUN/d06OwThen4zzAR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61BATwZT065526;
	Wed, 11 Feb 2026 19:29:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61BATwoH065523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Feb 2026 19:29:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
Date: Wed, 11 Feb 2026 19:29:59 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jori Koolstra <jkoolstra@xs4all.nl>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-76933-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,dubeyko.com,physik.fu-berlin.de,vivo.com];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 834461236AC
X-Rspamd-Action: no action

Commit b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID
count checks") replaced BUG_ON() with "atomic64_inc_return() => check for
overflow => atomic64_dec() if overflowed" pattern. That approach works
because the 64bits signed variable is initialized using a 32bits unsigned
variable, making sure that the initial value is in [0, U32_MAX] range.

However, if HFS_SB(sb)->file_count is smaller than number of file inodes
that actually exists due to filesystem corruption, calling
atomic64_dec(&HFS_SB(sb)->file_count) from hfs_delete_inode() can make
HFS_SB(sb)->file_count < 0.

As a result, "atomic64_read(&sbi->file_count) > U32_MAX" comparison in
is_hfs_cnid_counts_valid() fails to detect overflow when
HFS_SB(sb)->file_count < 0, for this is a comparison between signed
64bits and unsigned 32bits. Evaluate the upper 32bits of the 64bits
variable for detecting overflow.

Fixes: b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID count checks")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Only compile tested.

 fs/hfs/inode.c | 6 +++---
 fs/hfs/mdb.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..7b5a4686aa79 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -199,7 +199,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	if (next_id > U32_MAX) {
+	if (next_id >> 32) {
 		atomic64_dec(&HFS_SB(sb)->next_id);
 		pr_err("cannot create new inode: next CNID exceeds limit\n");
 		goto out_discard;
@@ -217,7 +217,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		if (folder_count> U32_MAX) {
+		if (folder_count >> 32) {
 			atomic64_dec(&HFS_SB(sb)->folder_count);
 			pr_err("cannot create new inode: folder count exceeds limit\n");
 			goto out_discard;
@@ -231,7 +231,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		if (file_count > U32_MAX) {
+		if (file_count >> 32) {
 			atomic64_dec(&HFS_SB(sb)->file_count);
 			pr_err("cannot create new inode: file count exceeds limit\n");
 			goto out_discard;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..68d3c0714057 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -69,15 +69,15 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 	struct hfs_sb_info *sbi = HFS_SB(sb);
 	bool corrupted = false;
 
-	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->next_id) >> 32)) {
 		pr_warn("next CNID exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->file_count) >> 32)) {
 		pr_warn("file count exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->folder_count) >> 32)) {
 		pr_warn("folder count exceeds limit\n");
 		corrupted = true;
 	}
-- 
2.53.0



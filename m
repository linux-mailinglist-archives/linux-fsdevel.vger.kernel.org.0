Return-Path: <linux-fsdevel+bounces-52017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D6ADE49D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D70918865EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5627E1AC;
	Wed, 18 Jun 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jIq0kT5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83612747B;
	Wed, 18 Jun 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750231952; cv=none; b=LAmNBQTQkGqTp/kekxK7+EE9LZnMUVUuaXDXMtHVBexZT/GxkDrReJdPseWe8pTSlk/WYKOUhZXhjDGFcfgPDP3VGK/OhZqpgISYmkgekICpV3WaUcbO5yygTkYso/G//oY2eTa67HGOzMioDj7A2ktJAFJTWvmP9ZdLMYsPjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750231952; c=relaxed/simple;
	bh=CZrw0hZVLufcRQ6KoDBlKtf6z36AOGiH0czbmOejAnk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mMMYoQfWCHlQQRkWeEEf5KN521G430kY8bRijP/ekGTbu/P4n8cJjGP69Ydff+hr67H1GRHRy/ceY9ypoqCVJr3vUhibUxyqszMVMby84eUL7a6hh945oC6+K2t1bCpKO/PgOheHd8wDeMcsfG7oNR4qrXyzlt9eHYbIJdLXmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jIq0kT5i; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750231940; bh=EoJMe+ER56WT5YjRS7gq69hy5cAQHbjgmBK4fFHg+nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jIq0kT5iTx1FnN7zLgYI58v4ja7USdKVHBh9uE9U6iHjw+HuZLTh8xK+/AAWCoP2P
	 na8vaz1VTrA2dn2XggmgJ+KWdm/zWih+7NhjK/VQFLL54LkYorzBISTlBvnW8ZLaUJ
	 +1FgFOHKe6MI9axvMGwSSFeMHxrxnHysIlNS/50I=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 7F90DCF0; Wed, 18 Jun 2025 15:31:57 +0800
X-QQ-mid: xmsmtpt1750231917tbrnaiawa
Message-ID: <tencent_BCCDAC7BEE6CFC2DD96CF095ACE9F2EDDE0A@qq.com>
X-QQ-XMAILINFO: MMjT29R4j27sXFE3NKwoHLC8DvsZ4Jv5IActATCYwpf3tAxhSzhL/tqE9agTvH
	 V74mDl35LGrRG/d7mtA+zPEFtxNVPQDF4J8NTPPAyUnGpvQTk2mTGklDNxn+U15SDCoMZVUBUK6W
	 qkOVEb91RfBejla5/DRFODUEM7RrTHp11DIiwFgIIZkF2IbE9Br3beG0KPZU7v7oDfCJnRKCN6xZ
	 LLYiUMSHcMsbSiUKnOHBypNrLEJbDeEZ/1bcth94nmC33xFFhbJN6mdEIi8tqffFIIMuxGFTwdXn
	 MOFcLVtSW+ym/7nDVRRSD8zg5Qv8tkOZ/bhSZq1EBKJKoCkHK60UJv51CxFmWwWZ707KnujTVnry
	 UmL8v/S6818VaUlbvKPghkUVvlcIAcQek0h9+SxYiBgOnzaOj1FzLlD/gEQSnFzWBw+KgJFWtg0j
	 VRWRzglYTFx3pouctpCqWdsX4PvP7IkE0TWwXJNkWJCkc0y4jgyC5Grgjnhes+Q+SDjyb5M7/zyb
	 v9ra63K8Ebg/07CDK7enV2icfRULPubQe/ks0YvdB36Rjpe+qfhY8251yVwJ8M9XfyNzUpnCey6I
	 WtDSPK06sk7fJNso+iUsVlcY7nW1wMTqg/yN/R1rWe/ZKrCgfUYmGglco5eO91mjlFN4fi9cRULb
	 WSjLyrIRFNcHXNINZ4bMxcBFVoBlzHwncS1cSR/N9A1rjHTcFynwPBdW3K+hVGzzNtWTM9lJ5WSC
	 DqCYeMt+T+4NjxRQXkRLSguMgYFbxajnb2RyTBkpsJRaFafpZegr7915uXdR+3ABdAAhrdGmiOVD
	 eDZOH6xcHLdt5IA3N23S6GJVn3v3Bz1/MnI8hYuEjsoq+p0WL+eyEspgzUMqT7WQyhz2Hg6l3Poj
	 L/2zrmtvr+mfcjwUUe/oSr7oVOgOkmCoMod2lWLrm7cKeLTywisJy6JfVh5MgZFzVZRLrKtSbeRZ
	 TSsCZ3yEHGqUMTvEoUbFWZQ7l/r8bSwjrsPccY4ZzrRziYjW9BnhuojXH0K/j2k15Caq8TikO/ql
	 DNpjVFACbfLjGybk3VSbYVY3xAL1Q=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH V2] fs/ntfs3: cancle set bad inode after removing name fails
Date: Wed, 18 Jun 2025 15:31:57 +0800
X-OQ-MSGID: <20250618073156.1363455-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_ED33789EDE1B3B4BB21B4325EDBA10BB7F08@qq.com>
References: <tencent_ED33789EDE1B3B4BB21B4325EDBA10BB7F08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reproducer uses a file0 on a ntfs3 file system with a corrupted i_link.
When renaming, the file0's inode is marked as a bad inode because the file
name cannot be deleted.

The underlying bug is that make_bad_inode() is called on a live inode.
In some cases it's "icache lookup finds a normal inode, d_splice_alias()
is called to attach it to dentry, while another thread decides to call
make_bad_inode() on it - that would evict it from icache, but we'd already
found it there earlier".
In some it's outright "we have an inode attached to dentry - that's how we
got it in the first place; let's call make_bad_inode() on it just for shits
and giggles".

Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
Reported-by: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1aa90f0eb1fc3e77d969
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: fix it by removing set bad inode

 fs/ntfs3/frecord.c |  7 +++----
 fs/ntfs3/namei.c   | 10 +++-------
 fs/ntfs3/ntfs_fs.h |  3 +--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 756e1306fe6c..7afbb4418eb2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3003,8 +3003,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  * ni_rename - Remove one name and insert new name.
  */
 int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
-	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
-	      bool *is_bad)
+	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de)
 {
 	int err;
 	struct NTFS_DE *de2 = NULL;
@@ -3027,8 +3026,8 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	err = ni_add_name(new_dir_ni, ni, new_de);
 	if (!err) {
 		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
-		if (err && ni_remove_name(new_dir_ni, ni, new_de, &de2, &undo))
-			*is_bad = true;
+		WARN_ON(err && ni_remove_name(new_dir_ni, ni, new_de, &de2,
+			&undo));
 	}
 
 	/*
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b807744fc6a9..0db7ca3b64ea 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -244,7 +244,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct NTFS_DE *de, *new_de;
-	bool is_same, is_bad;
+	bool is_same;
 	/*
 	 * de		- memory of PATH_MAX bytes:
 	 * [0-1024)	- original name (dentry->d_name)
@@ -313,12 +313,8 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	if (dir_ni != new_dir_ni)
 		ni_lock_dir2(new_dir_ni);
 
-	is_bad = false;
-	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de, &is_bad);
-	if (is_bad) {
-		/* Restore after failed rename failed too. */
-		_ntfs_bad_inode(inode);
-	} else if (!err) {
+	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de);
+	if (!err) {
 		simple_rename_timestamp(dir, dentry, new_dir, new_dentry);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 36b8052660d5..f54635df18fa 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -577,8 +577,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		struct NTFS_DE *de);
 
 int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
-	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
-	      bool *is_bad);
+	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de);
 
 bool ni_is_dirty(struct inode *inode);
 
-- 
2.43.0



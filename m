Return-Path: <linux-fsdevel+bounces-14763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E187EFBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D741F23CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAE56441;
	Mon, 18 Mar 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxieFLyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B855C07;
	Mon, 18 Mar 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786553; cv=none; b=HEhc/HPyfDtzMPoKq62otdwBBzg1I2FVXUE/wRGvr/bNd2UbRgiLEhHW6VdmKx/Ac9jT7JXOc+zOJgrK9rPMGds1sWaMfaUwMueLvmeLX+JyObbdxZw4vzGfhFH+azjBOYLUqKpSxxYJX8REFR7PcTvVWeH15lQFh4RjaRw1ZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786553; c=relaxed/simple;
	bh=4BiSnBXF2XntdujNulUT7s4tD/RrjPjxiNCH97QXwF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rqfPOvb8r4uv5uvzA+VHajZ9W5kmWhq3Uk2PiITfRgu0R1AXk4x+aDKWDybw2HT9GoZ4ggin8YXDHsbr46nLRD75Yu3iC2AvDeJX2r+xDTxgVC392eUpv1rVvjqyxi8u3YGFeMIn3fcvszANWa1JHtgwIhllrfhzSNZITyNDKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxieFLyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1689FC433F1;
	Mon, 18 Mar 2024 18:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710786552;
	bh=4BiSnBXF2XntdujNulUT7s4tD/RrjPjxiNCH97QXwF4=;
	h=From:Date:Subject:To:Cc:From;
	b=rxieFLyGRT76cOB5hREmWHq0exWv5OwSlzGrKK5pMe3PZjAu6CbZjnRHQK20eL3di
	 1r8T5wJ/UYZ2+fEBtir0gbCgsIs1JlI9mno8d0rpCIDTEv1DUzsEGPQjBLgF+i50ke
	 witk82ptXef2U4o8mVt+g0MoCnii8ghNuVEea3KacErBxdqoMDD0W1P2szHwTRT1oL
	 5meV8a1N0/3vO+nsZfkmOVe+nEERtEN1MYu5yOTxdoz94RhsOtiN0n01cbAXdqhd1h
	 kbVwOKkjYpHCKw+wGLYTAvg5lMovBKBGo/QpPsh/Y9ajmV0R/+oZky0q4ZFaaDExh5
	 0diPrkn3HtYVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 18 Mar 2024 14:28:50 -0400
Subject: [PATCH RFC] ntfs3: remove atomic_open
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-ntfs3-atomic-open-v1-1-57afed48fe86@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOKH+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3byStGJj3cSS/NzMZN38gtQ8XYPkZEtzyxTzZKASJaC+gqLUtMw
 KsJnRSkFuzkqxtbUAMe9nWmgAAAA=
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4BiSnBXF2XntdujNulUT7s4tD/RrjPjxiNCH97QXwF4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl+Ify5+ag2l9CjEgDqMW/OZyFDhQDA+SVLVzKv
 p5Fta4VoIyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfiH8gAKCRAADmhBGVaC
 FY7wD/0XW6LwAkm0hdlpMO20mie+EqZnQNvNoXjZWMXJcV+rYPS1oWHc3eRlh3aseEGkXSWBJ3r
 djujh2o+yWLj2axMk+k9ZEdxRaEMgh0dnsrgdOi0Ot+GqNUZih24E7slSwm+5eE0oz40J3LjNm5
 Y2uj4pD7FdrrXf0CVLQpV7O02nLIw9/dQLAuSs0vQUZYxx+OaW+r9DeJXblaCDcrKqHsJKF07v5
 f6Stqsen8Fi6XVGOCdwgF2FyEVBwn+nexirtbYcLlpibP6/WKEqkIn7ZlyPLf0IYz5NXRKua4z5
 hgJgC0yyi/W0RMoN6/pUDhOocROGouEbSEFulzhp+yP01aQbEfE2Ceh1E/BHyyUrmzp4NcvRvUS
 tejN9LIXJzCeswyo1Sj/CKhZ0Z2MQPVjEhBVFRm0uZTUSE3WBUM9bLtTSFKmF6fNDeMApGogdmr
 5TTQNh8cDhDk0F+XHoGiaiLj6kvWW05XuWzrEsUHi6MIOFriHIh2KkdjXJsmK7VX4vbsSB0IdNg
 CtrQIqQmdt34q4LvHnCP1WvuFC7WCzLc94j8tNl4X5metw9u8MpcWzDVAi/1ny/8wL7Lp2RLM0q
 iu/Aff89joy1pkWwcUP7ygjyucknK4AerThCyPAAHc34bFZg0lBebP32+XVidJbikmX6/Pn0kzg
 p1YxMrzKOZLj92Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

atomic_open is an optional VFS operation, and is primarily for network
filesystems. NFS (for instance) can just send an open call for the last
path component rather than doing a lookup and then having to follow that
up with an open when it doesn't have a dentry in cache.

ntfs3 is a local filesystem however, and its atomic_open just does a
typical lookup + open, but in a convoluted way. atomic_open will also
make directory leases more difficult to implement on the filesystem.

Remove ntfs_atomic_open.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Am I missing something about why ntfs3 requires an atomic_open op? In
any case, this is only lightly tested, but it seems to work.
---
 fs/ntfs3/namei.c | 90 --------------------------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 084d19d78397..edb6a7141246 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -358,95 +358,6 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-/*
- * ntfs_atomic_open
- *
- * inode_operations::atomic_open
- */
-static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
-			    struct file *file, u32 flags, umode_t mode)
-{
-	int err;
-	struct inode *inode;
-	struct ntfs_fnd *fnd = NULL;
-	struct ntfs_inode *ni = ntfs_i(dir);
-	struct dentry *d = NULL;
-	struct cpu_str *uni = __getname();
-	bool locked = false;
-
-	if (!uni)
-		return -ENOMEM;
-
-	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
-				dentry->d_name.len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
-	if (err < 0)
-		goto out;
-
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	if (IS_POSIXACL(dir)) {
-		/*
-		 * Load in cache current acl to avoid ni_lock(dir):
-		 * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
-		 * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
-		 */
-		struct posix_acl *p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
-
-		if (IS_ERR(p)) {
-			err = PTR_ERR(p);
-			goto out;
-		}
-		posix_acl_release(p);
-	}
-#endif
-
-	if (d_in_lookup(dentry)) {
-		ni_lock_dir(ni);
-		locked = true;
-		fnd = fnd_get();
-		if (!fnd) {
-			err = -ENOMEM;
-			goto out1;
-		}
-
-		d = d_splice_alias(dir_search_u(dir, uni, fnd), dentry);
-		if (IS_ERR(d)) {
-			err = PTR_ERR(d);
-			d = NULL;
-			goto out2;
-		}
-
-		if (d)
-			dentry = d;
-	}
-
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry)) {
-		err = finish_no_open(file, d);
-		goto out2;
-	}
-
-	file->f_mode |= FMODE_CREATED;
-
-	/*
-	 * fnd contains tree's path to insert to.
-	 * If fnd is not NULL then dir is locked.
-	 */
-	inode = ntfs_create_inode(file_mnt_idmap(file), dir, dentry, uni,
-				  mode, 0, NULL, 0, fnd);
-	err = IS_ERR(inode) ? PTR_ERR(inode) :
-			      finish_open(file, dentry, ntfs_file_open);
-	dput(d);
-
-out2:
-	fnd_put(fnd);
-out1:
-	if (locked)
-		ni_unlock(ni);
-out:
-	__putname(uni);
-	return err;
-}
-
 struct dentry *ntfs3_get_parent(struct dentry *child)
 {
 	struct inode *inode = d_inode(child);
@@ -612,7 +523,6 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.setattr	= ntfs3_setattr,
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
-	.atomic_open	= ntfs_atomic_open,
 	.fiemap		= ntfs_fiemap,
 };
 

---
base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
change-id: 20240318-ntfs3-atomic-open-0cc979d7c024

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



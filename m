Return-Path: <linux-fsdevel+bounces-62293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462A9B8C293
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A173A161D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B772EBB80;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S0IOCIyb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D827A44A;
	Sat, 20 Sep 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354487; cv=none; b=KTgV+VIkdW/I6eg/1j6RugQjpcwoVTBb7sW5MaXWM3ovhFkH3i1p8Eg/qvkxgUFpBOOJ6uwIWb6xYUhYQjxWwZYvIEJrqbxhd8k44YjcTCmHmW/+hBZ9jVYUq7QfBMmCk5IE0a7rGaptU/bMe8XKxYwcWaoaY9atTnhB/eIbh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354487; c=relaxed/simple;
	bh=qfuLhIA6twD3xl2N8d89X0vW/fwx5ljo5AQMr8fFiuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFh/1vtrhpoQVZrtQasiBl2jOKKE2k8sGZEovEnCHT/UzIZ7IfCAnhyVqnyPj0sQ+wOHYjYyqLM3U0fzB2Y+dZtKweIKZuosKMdM6hszZM75VlKzxImyPwhNoR9XMWeyhBc8Sp8jWWfFznnsyCKtDqGDY/zmO12aTzrcoK2WjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S0IOCIyb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SHYH+cQVsm2L8KWlz63sd1N3QvfADJqbUf5fBvo0O9M=; b=S0IOCIybhpDVg55/sRTdTvowJ5
	klRE1xB/CDgAo2525KwT7F4L0heh7aXP7QN9Eh12RzsOJSHr1U27GatydApDoFWj72MXBXbhxUXEf
	mKDsQxDn4x2CPSC/RKYKCMeL/Kfm00JGEz52JxOZqSu09iztJptYnjDZ4G0ikALQ038MOm7LTwe7a
	ti/N6mdMrkwP6Go0mw2F7M2B/Z6cSx+Jm1o7bsBLLeGoM5s9BkeD5paoujT0kKglwj0OjDrGKTujh
	UE3q0/hIelsAycZGrSHLv0H8+7Ec0Dads2v9xZr/aqB1YnfGQ2hp1xxIp6tdYUzNFV7ycRMe8nwtB
	MCHBD53g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKB-0000000ExFR-0vOu;
	Sat, 20 Sep 2025 07:48:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 20/39] convert efivarfs
Date: Sat, 20 Sep 2025 08:47:39 +0100
Message-ID: <20250920074759.3564072-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Initially filesystem is populated with d_alloc_name() + d_add().
That becomes d_alloc_name() + d_make_persistent() + dput().
Dynamic creation is switched to d_make_persistent();
removal - to simple_unlink() (no point open-coding it in
efivarfs_unlink(), better call it there)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/efivarfs/inode.c | 7 ++-----
 fs/efivarfs/super.c | 5 +++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 2891614abf8d..95dcad83da11 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -113,8 +113,7 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode->i_private = var;
 
-	d_instantiate(dentry, inode);
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 
 	return 0;
 }
@@ -126,9 +125,7 @@ static int efivarfs_unlink(struct inode *dir, struct dentry *dentry)
 	if (efivar_entry_delete(var))
 		return -EINVAL;
 
-	drop_nlink(d_inode(dentry));
-	dput(dentry);
-	return 0;
+	return simple_unlink(dir, dentry);
 };
 
 const struct inode_operations efivarfs_dir_inode_operations = {
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 4bb4002e3cdf..21208660bfe2 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -278,7 +278,8 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	inode->i_private = entry;
 	i_size_write(inode, size + sizeof(__u32)); /* attributes + data */
 	inode_unlock(inode);
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 
 	return 0;
 
@@ -522,7 +523,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 
 	kfree(sfi);
 }
-- 
2.47.3



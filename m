Return-Path: <linux-fsdevel+bounces-39451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56125A1446A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53823A0602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32722BAC1;
	Thu, 16 Jan 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ud9rr7/h";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ud9rr7/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172D155756;
	Thu, 16 Jan 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065597; cv=none; b=S4QCcmFg5Hz4YhOrreHktKxNiogb7BrUVAHlD4PK6N3dodmFa9ys8lznOR/sauEp8UTzG0iKnNJhlThevEFxPmh37WMSeMSv4BMgUE942lneAt8H/Z18qp43ULDhpiY0nYozL6UbIpbeygmp3zkzLLCg9Zjyr8iJZI/JT9txyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065597; c=relaxed/simple;
	bh=+R4t70xPWTSWdWWwI1JX1eVV0ZMqytdF7J5GxxAwIes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXpOjOkRubz7yQImXLrgLdPzKk4K76PbdrDyKLWYHeVf73Jg8G8CXyHAUhx4LEvU6L0Mp3NKKMd47DbRRbL1FCbkwyTfBueFrhqldX0fEiXHmTWzefEB3TCEoPySERtBef9WzwlDnagBs4KhSGomFEXi5XnBIaJaVZc5xKNOXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ud9rr7/h; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ud9rr7/h; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737065587;
	bh=+R4t70xPWTSWdWWwI1JX1eVV0ZMqytdF7J5GxxAwIes=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ud9rr7/hS/vbpw6vjuK5dek+5XroiSY9xWdZ9vFbjkicUAD8CsJTrAeTTkzCqvY5E
	 mfV2mQj2ed7A7OA6U0fQ2za7rXY3KYJeJUni8iqIqlNzE/xLJd+glAEAqzSitE5Niy
	 E23KTIZMMBVZjbASlKKIvcSCVlmNY/vxrrsfg1EI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CDAC312818D9;
	Thu, 16 Jan 2025 17:13:07 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ReIesVbPk4oS; Thu, 16 Jan 2025 17:13:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737065587;
	bh=+R4t70xPWTSWdWWwI1JX1eVV0ZMqytdF7J5GxxAwIes=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ud9rr7/hS/vbpw6vjuK5dek+5XroiSY9xWdZ9vFbjkicUAD8CsJTrAeTTkzCqvY5E
	 mfV2mQj2ed7A7OA6U0fQ2za7rXY3KYJeJUni8iqIqlNzE/xLJd+glAEAqzSitE5Niy
	 E23KTIZMMBVZjbASlKKIvcSCVlmNY/vxrrsfg1EI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 05D89128179E;
	Thu, 16 Jan 2025 17:13:06 -0500 (EST)
Message-ID: <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into
 evict_inode
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Thu, 16 Jan 2025 17:13:05 -0500
In-Reply-To: <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
	 <20250116183643.GI1977892@ZenIV>
	 <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-01-16 at 14:05 -0500, James Bottomley wrote:
> On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> > On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley wrote:
> > > Make the inodes the default management vehicle for struct
> > > efivar_entry, so they are now all freed automatically if the file
> > > is removed and on unmount in kill_litter_super().  Remove the now
> > > superfluous iterator to free the entries after
> > > kill_litter_super().
> > > 
> > > Also fixes a bug where some entry freeing was missing causing
> > > efivarfs to leak memory.
> > 
> > Umm...  I'd rather coallocate struct inode and struct efivar_entry;
> > that way once you get rid of the list you don't need -
> > >evict_inode()
> > anymore.
> > 
> > It's pretty easy - see e.g.
> > https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> > for recent example of such conversion.
> 
> OK, I can do that.  Although I think since the number of variables is
> usually around 150, it would probably be overkill to give it its own
> inode cache allocator.

OK, this is what I've got.  As you can see from the diffstat it's about
10 lines more than the previous; mostly because of the new allocation
routine, the fact that the root inode has to be special cased for the
list and the guid has to be parsed in efivarfs_create before we have
the inode.

Regards,

James

---

 fs/efivarfs/file.c     |  6 +++---
 fs/efivarfs/inode.c    | 27 +++++++++++----------------
 fs/efivarfs/internal.h |  6 ++++++
 fs/efivarfs/super.c    | 45 ++++++++++++++++++++++++++----------------
---
 4 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..176362b73d38 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -15,10 +15,10 @@
 static ssize_t efivarfs_file_write(struct file *file,
 		const char __user *userbuf, size_t count, loff_t
*ppos)
 {
-	struct efivar_entry *var = file->private_data;
 	void *data;
 	u32 attributes;
 	struct inode *inode = file->f_mapping->host;
+	struct efivar_entry *var = efivar_entry(inode);
 	unsigned long datasize = count - sizeof(attributes);
 	ssize_t bytes;
 	bool set = false;
@@ -66,7 +66,8 @@ static ssize_t efivarfs_file_write(struct file *file,
 static ssize_t efivarfs_file_read(struct file *file, char __user
*userbuf,
 		size_t count, loff_t *ppos)
 {
-	struct efivar_entry *var = file->private_data;
+	struct inode *inode = file->f_mapping->host;
+	struct efivar_entry *var = efivar_entry(inode);
 	unsigned long datasize = 0;
 	u32 attributes;
 	void *data;
@@ -107,7 +108,6 @@ static ssize_t efivarfs_file_read(struct file
*file, char __user *userbuf,
 }
 
 const struct file_operations efivarfs_file_operations = {
-	.open	= simple_open,
 	.read	= efivarfs_file_read,
 	.write	= efivarfs_file_write,
 };
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index ec23da8405ff..a13ffb01e149 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -82,26 +82,23 @@ static int efivarfs_create(struct mnt_idmap *idmap,
struct inode *dir,
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
 	bool is_removable = false;
+	efi_guid_t vendor;
 
 	if (!efivarfs_valid_name(dentry->d_name.name, dentry-
>d_name.len))
 		return -EINVAL;
 
-	var = kzalloc(sizeof(struct efivar_entry), GFP_KERNEL);
-	if (!var)
-		return -ENOMEM;
-
 	/* length of the variable name itself: remove GUID and
separator */
 	namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;
 
-	err = guid_parse(dentry->d_name.name + namelen + 1, &var-
>var.VendorGuid);
+	err = guid_parse(dentry->d_name.name + namelen + 1, &vendor);
 	if (err)
 		goto out;
-	if (guid_equal(&var->var.VendorGuid,
&LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
 		err = -EPERM;
 		goto out;
 	}
 
-	if (efivar_variable_is_removable(var->var.VendorGuid,
+	if (efivar_variable_is_removable(vendor,
 					 dentry->d_name.name,
namelen))
 		is_removable = true;
 
@@ -110,15 +107,15 @@ static int efivarfs_create(struct mnt_idmap
*idmap, struct inode *dir,
 		err = -ENOMEM;
 		goto out;
 	}
+	var = efivar_entry(inode);
+
+	var->var.VendorGuid = vendor;
 
 	for (i = 0; i < namelen; i++)
 		var->var.VariableName[i] = dentry->d_name.name[i];
 
 	var->var.VariableName[i] = '\0';
 
-	inode->i_private = var;
-	kmemleak_ignore(var);
-
 	err = efivar_entry_add(var, &info->efivarfs_list);
 	if (err)
 		goto out;
@@ -126,17 +123,15 @@ static int efivarfs_create(struct mnt_idmap
*idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 out:
-	if (err) {
-		kfree(var);
-		if (inode)
-			iput(inode);
-	}
+	if (err && inode)
+		iput(inode);
+
 	return err;
 }
 
 static int efivarfs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct efivar_entry *var = d_inode(dentry)->i_private;
+	struct efivar_entry *var = efivar_entry(d_inode(dentry));
 
 	if (efivar_entry_delete(var))
 		return -EINVAL;
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 8d82fc8bca31..fce7d5e5c763 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -29,8 +29,14 @@ struct efi_variable {
 struct efivar_entry {
 	struct efi_variable var;
 	struct list_head list;
+	struct inode vfs_inode;
 };
 
+static inline struct efivar_entry *efivar_entry(struct inode *inode)
+{
+	return container_of(inode, struct efivar_entry, vfs_inode);
+}
+
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long,
void *,
 			    struct list_head *),
 		void *data, struct list_head *head);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index d7facc99b745..cfead280534c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -39,15 +39,25 @@ static int efivarfs_ops_notifier(struct
notifier_block *nb, unsigned long event,
 	return NOTIFY_OK;
 }
 
-static void efivarfs_evict_inode(struct inode *inode)
+static struct inode *efivarfs_alloc_inode(struct super_block *sb)
 {
-	struct efivar_entry *entry = inode->i_private;
+	struct efivar_entry *entry = kzalloc(sizeof(*entry),
GFP_KERNEL);
 
-	if (entry)  {
+	if (!entry)
+		return NULL;
+
+	inode_init_once(&entry->vfs_inode);
+
+	return &entry->vfs_inode;
+}
+
+static void efivarfs_free_inode(struct inode *inode)
+{
+	struct efivar_entry *entry = efivar_entry(inode);
+
+	if (!is_root_inode(inode))
 		list_del(&entry->list);
-		kfree(entry);
-	}
-	clear_inode(inode);
+	kfree(entry);
 }
 
 static int efivarfs_show_options(struct seq_file *m, struct dentry
*root)
@@ -112,7 +122,8 @@ static int efivarfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
-	.evict_inode = efivarfs_evict_inode,
+	.alloc_inode = efivarfs_alloc_inode,
+	.free_inode = efivarfs_free_inode,
 	.show_options = efivarfs_show_options,
 };
 
@@ -233,21 +244,14 @@ static int efivarfs_callback(efi_char16_t
*name16, efi_guid_t vendor,
 	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
 		return 0;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return err;
-
-	memcpy(entry->var.VariableName, name16, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
 	name = efivar_get_utf8name(name16, &vendor);
 	if (!name)
-		goto fail;
+		return err;
 
 	/* length of the variable name itself: remove GUID and
separator */
 	len = strlen(name) - EFI_VARIABLE_GUID_LEN - 1;
 
-	if (efivar_variable_is_removable(entry->var.VendorGuid, name,
len))
+	if (efivar_variable_is_removable(vendor, name, len))
 		is_removable = true;
 
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644,
0,
@@ -255,6 +259,11 @@ static int efivarfs_callback(efi_char16_t *name16,
efi_guid_t vendor,
 	if (!inode)
 		goto fail_name;
 
+	entry = efivar_entry(inode);
+
+	memcpy(entry->var.VariableName, name16, name_size);
+	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
+
 	dentry = efivarfs_alloc_dentry(root, name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -268,7 +277,6 @@ static int efivarfs_callback(efi_char16_t *name16,
efi_guid_t vendor,
 	kfree(name);
 
 	inode_lock(inode);
-	inode->i_private = entry;
 	i_size_write(inode, size + sizeof(__u32)); /* attributes +
data */
 	inode_unlock(inode);
 	d_add(dentry, inode);
@@ -279,8 +287,7 @@ static int efivarfs_callback(efi_char16_t *name16,
efi_guid_t vendor,
 	iput(inode);
 fail_name:
 	kfree(name);
-fail:
-	kfree(entry);
+
 	return err;
 }
 



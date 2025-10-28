Return-Path: <linux-fsdevel+bounces-65953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781AC16E19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 22:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AFF3ADCA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58416350A0D;
	Tue, 28 Oct 2025 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ksb5g8Zr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22512DCF4C;
	Tue, 28 Oct 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685695; cv=none; b=eFvZVMgQW12wdtDKHR3o71VNB7jiLT4I9TzxyDiuHaP73pylx+PUsGuWFIOAIfpxmFC8/PGj6K0p+/iQj4waRnG0PnYdiuwpRsx4i+Jc+WAibFQr6EBfWNH8gIi13Sbh764j1ZSH/P/O4PFlplUH5Akbb2aA3xROJUYPyUwNcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685695; c=relaxed/simple;
	bh=yUSHQgos7Kh9J6Gv2qFGOCJHSJ6+VHnfECGLT/kKGiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyJSJ3ZPGbZ7vFev8oBDyU+NLL8US1TGGNgkgqhtAmwOYVRt3OEu//eniriWfFLilO39no3VrQsK3W9CZwKAr+kfygDXVcuQ19a57dK+oIqaRP62yvj39iT9DE9iPkjMuIfuAPVAe3kjMmTBcc9ytt56xWDjVx1Aqxs3HKUtuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ksb5g8Zr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KlTwB+1F+PugnwlBKmbzqaDoi+J+L/6Td5vFafDz7aQ=; b=Ksb5g8ZrVafnbFuTRxbUrPhDBj
	VSOMEinbRhfNMqbf8zNwa4y+4w91yeN1ZkolOTq7QHfZv9jbf9wzwIgjoyGXNTLzmtCmiuSlsuFQY
	I2duEP0tPN70bNXR+5LqqotswpJ2viRu62H7osNC8PUSJSrQulUJeNM/ANyqo1gLANZ82mjExXHlj
	1F+kesXVgTzno6Sx7Se5kMbenDUUhlD1xSwZGEI1aNvuxQWH0jGuFuiDJKw286315kfeqCsz/8rE+
	ioRQsGUqL6ZTFGl0vQ2Ve+T2xs0+XXea6lOfg9yJCHsRQXsmQJWUMV9NmpQEVchINZrcmNhueZ2ko
	8V7lMBVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDqvF-0000000FqQ8-4BSQ;
	Tue, 28 Oct 2025 21:08:06 +0000
Date: Tue, 28 Oct 2025 21:08:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251028210805.GP2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028174540.GN2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 05:45:40PM +0000, Al Viro wrote:

> FWIW, having a special path for "we are in foofs_fill_super(), fuck
> the locking - nobody's going to access it anyway" is not a great
> idea, simply because the helpers tend to get reused on codepaths
> where we can't cut corners that way.

	BTW, looking through efivarfs codebase now... *both* callers
of efivarfs_create_dentry() end up doing dcache lookups, with variously
convoluted call chains.  Look: efivarfs_check_missing() has an explicit
try_lookup_noperm() before the call of efivarfs_create_dentry().
efivarfs_callback() doesn't, but it's called via
	efivar_init(efivarfs_callback, sb, true)
and with the last argument being true efivar_init() will precede the call
of the callback with efivarfs_variable_is_present().  Guess what does that
thing (never used anywhere else) do?  Right, the call of try_lookup_noperm().

Why do we bother with that?  What's wrong with having efivarfs_create_dentry()
returning -EEXIST in case of dentry already being there and turning the
chunk in efivar_init() into
			err = func(variable_name, vendor_guid,
				   variable_name_size, data);
			if (err == -EEXIST) {
				if (duplicate_check)
					dup_variable_bug(variable_name,
							 &vendor_guid,
							 variable_name_size);
				else
					err = 0;
			}
			if (err)
				status = EFI_NOT_FOUND;
Note that both possible callbacks become almost identical and I wouldn't
be surprised if that "almost" is actually "completely"...  <checks> yep.

So I'm not sure we want that callback to be an argument, but that's
a separate followup.  For now, do you see any problems with the following
patch?  [Completely untested, on top of the posted series]

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index f913b6824289..045d53fd0f3c 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -55,8 +55,6 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 char *efivar_get_utf8name(const efi_char16_t *name16, efi_guid_t *vendor);
-bool efivarfs_variable_is_present(efi_char16_t *variable_name,
-				  efi_guid_t *vendor, void *data);
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 298ab3c929eb..80ed81bbd4a5 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -189,52 +189,6 @@ static const struct dentry_operations efivarfs_d_ops = {
 	.d_hash = efivarfs_d_hash,
 };
 
-static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
-{
-	struct dentry *d;
-	struct qstr q;
-	int err;
-
-	q.name = name;
-	q.len = strlen(name);
-
-	err = efivarfs_d_hash(parent, &q);
-	if (err)
-		return ERR_PTR(err);
-
-	d = d_alloc(parent, &q);
-	if (d)
-		return d;
-
-	return ERR_PTR(-ENOMEM);
-}
-
-bool efivarfs_variable_is_present(efi_char16_t *variable_name,
-				  efi_guid_t *vendor, void *data)
-{
-	char *name = efivar_get_utf8name(variable_name, vendor);
-	struct super_block *sb = data;
-	struct dentry *dentry;
-
-	if (!name)
-		/*
-		 * If the allocation failed there'll already be an
-		 * error in the log (and likely a huge and growing
-		 * number of them since they system will be under
-		 * extreme memory pressure), so simply assume
-		 * collision for safety but don't add to the log
-		 * flood.
-		 */
-		return true;
-
-	dentry = try_lookup_noperm(&QSTR(name), sb->s_root);
-	kfree(name);
-	if (!IS_ERR_OR_NULL(dentry))
-		dput(dentry);
-
-	return dentry != NULL;
-}
-
 static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 				  unsigned long name_size, efi_guid_t vendor,
 				  char *name)
@@ -244,7 +198,7 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	struct dentry *dentry, *root = sb->s_root;
 	unsigned long size = 0;
 	int len;
-	int err = -ENOMEM;
+	int err = 0;
 	bool is_removable = false;
 
 	/* length of the variable name itself: remove GUID and separator */
@@ -253,41 +207,36 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	if (efivar_variable_is_removable(vendor, name, len))
 		is_removable = true;
 
+	dentry = simple_start_creating(root, name);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out_name;
+	}
+
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
-	if (!inode)
-		goto fail_name;
+	if (unlikely(!inode)) {
+		err = -ENOMEM;
+		goto out_dentry;
+	}
 
 	entry = efivar_entry(inode);
 
 	memcpy(entry->var.VariableName, name16, name_size);
 	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
 
-	dentry = efivarfs_alloc_dentry(root, name);
-	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
-		goto fail_inode;
-	}
-
 	__efivar_entry_get(entry, NULL, &size, NULL);
 
-	/* copied by the above to local storage in the dentry. */
-	kfree(name);
-
 	inode_lock(inode);
 	inode->i_private = entry;
 	i_size_write(inode, size + sizeof(__u32)); /* attributes + data */
 	inode_unlock(inode);
 	d_make_persistent(dentry, inode);
-	dput(dentry);
-
-	return 0;
 
-fail_inode:
-	iput(inode);
-fail_name:
+out_dentry:
+	simple_done_creating(dentry);
+out_name:
 	kfree(name);
-
 	return err;
 }
 
@@ -407,42 +356,6 @@ static const struct fs_context_operations efivarfs_context_ops = {
 	.free		= efivarfs_free,
 };
 
-static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
-				  unsigned long name_size, void *data)
-{
-	char *name;
-	struct super_block *sb = data;
-	struct dentry *dentry;
-	int err;
-
-	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
-		return 0;
-
-	name = efivar_get_utf8name(name16, &vendor);
-	if (!name)
-		return -ENOMEM;
-
-	dentry = try_lookup_noperm(&QSTR(name), sb->s_root);
-	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
-		goto out;
-	}
-
-	if (!dentry) {
-		/* found missing entry */
-		pr_info("efivarfs: creating variable %s\n", name);
-		return efivarfs_create_dentry(sb, name16, name_size, vendor, name);
-	}
-
-	dput(dentry);
-	err = 0;
-
- out:
-	kfree(name);
-
-	return err;
-}
-
 static struct file_system_type efivarfs_type;
 
 static int efivarfs_freeze_fs(struct super_block *sb)
@@ -493,7 +406,7 @@ static int efivarfs_unfreeze_fs(struct super_block *sb)
 		}
 	}
 
-	efivar_init(efivarfs_check_missing, sb, false);
+	efivar_init(efivarfs_callback, sb, false);
 	pr_info("efivarfs: finished resyncing variable state\n");
 	return 0;
 }
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 6edc10958ecf..d893e928891a 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -407,6 +407,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		case EFI_SUCCESS:
 			variable_name_size = var_name_strnsize(variable_name,
 							       variable_name_size);
+			err = func(variable_name, vendor_guid,
+				   variable_name_size, data);
 
 			/*
 			 * Some firmware implementations return the
@@ -416,18 +418,16 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 			 * we'll ever see a different variable name,
 			 * and may end up looping here forever.
 			 */
-			if (duplicate_check &&
-			    efivarfs_variable_is_present(variable_name,
-							 &vendor_guid, data)) {
-				dup_variable_bug(variable_name, &vendor_guid,
-						 variable_name_size);
-				status = EFI_NOT_FOUND;
-			} else {
-				err = func(variable_name, vendor_guid,
-					   variable_name_size, data);
-				if (err)
-					status = EFI_NOT_FOUND;
+			if (err == -EEXIST) {
+				if (duplicate_check)
+					dup_variable_bug(variable_name,
+							 &vendor_guid,
+							 variable_name_size);
+				else
+					err = 0;
 			}
+			if (err)
+				status = EFI_NOT_FOUND;
 			break;
 		case EFI_UNSUPPORTED:
 			err = -EOPNOTSUPP;


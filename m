Return-Path: <linux-fsdevel+bounces-38087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C259FB912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AEF165151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3747DA95;
	Tue, 24 Dec 2024 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HcwtCYcv";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HcwtCYcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C558442C;
	Tue, 24 Dec 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013104; cv=none; b=mXY6xtH2cv0n2KGDF3XcZoJvmbAkKhfTt/+yJ1CkWdUH9Q7U1VTJzcMzn3t0UoJk6NDau+F4YX5/z2PUWGOsnNvvBsfsTIPBdBImPTMDj5IVCnfC4R5UOgNdirYlFnsbVT4A7APurv+70PvAL7UXc3GXMDPdlGhXyzgRFtJKGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013104; c=relaxed/simple;
	bh=MfOLkJPwCOs2uTuF4yOW27AD93N3RLE2TLRIsHp4KOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIuVYHeUnBK/xQYzYiozhaAlI6PQ9/f3siUt1n+1TPrhgPxVqBMhDxuECNpJjoQuVHh60+1olVCjPstdzwfnTo93NhVlq9C9n9JzEKByDTvdBddGw+ekuw/NZKckjGWkXBWf4GRrVyL3BiJ7RM7gLjp8HLt6Yu/EDY20x9u8iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HcwtCYcv; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HcwtCYcv; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735013101;
	bh=MfOLkJPwCOs2uTuF4yOW27AD93N3RLE2TLRIsHp4KOc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=HcwtCYcvV8fBrRimEi5aiyszOxLCwN+bsgSuqPSDFVF+t9yYVIREebrYU0MocCCcY
	 8f/ns4LOv87BAygK5tv7OTPcOJAS3q3UQ4rMVFkaoIpyrKLxdXRZXFFGcPesGy7fo/
	 ME06NNpCXBAVRqUyVQnAHfWUiCMDlZedNoDzKRXk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C766C1286465;
	Mon, 23 Dec 2024 23:05:01 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dIQZlNWgqb6p; Mon, 23 Dec 2024 23:05:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735013101;
	bh=MfOLkJPwCOs2uTuF4yOW27AD93N3RLE2TLRIsHp4KOc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=HcwtCYcvV8fBrRimEi5aiyszOxLCwN+bsgSuqPSDFVF+t9yYVIREebrYU0MocCCcY
	 8f/ns4LOv87BAygK5tv7OTPcOJAS3q3UQ4rMVFkaoIpyrKLxdXRZXFFGcPesGy7fo/
	 ME06NNpCXBAVRqUyVQnAHfWUiCMDlZedNoDzKRXk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EE658128645C;
	Mon, 23 Dec 2024 23:05:00 -0500 (EST)
Message-ID: <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Mon, 23 Dec 2024 23:04:58 -0500
In-Reply-To: <20241223231218.GQ1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
	 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
	 <20241223231218.GQ1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-23 at 23:12 +0000, Al Viro wrote:
> On Mon, Dec 23, 2024 at 05:56:04PM -0500, James Bottomley wrote:
> > > Let me look into that area...
> > 
> > I thought about this some more.  I could see a twisted container
> > use case where something like this might happen (expose some but
> > not all efi variables to the container).
> > 
> > So, help me understand the subtleties here.  If it's the target of
> > a bind mount, that's all OK, because you are allowed to delete the
> > target.  If something is bind mounted on to an efivarfs object, the
> > is_local_mountpoint() check in vfs_unlink would usually trip and
> > prevent deletion (so the subtree doesn't become unreachable).  If I
> > were to duplicate that, I think the best way would be simply to do
> > a d_put() in the file->release function and implement drop_nlink()
> > in d_prune (since last put will always call __dentry_kill)?
> 
> Refcounting is not an issue.  At all.
> 
> Inability to find and evict the mount, OTOH, very much is.  And after
> your blind d_delete() that's precisely what will happen.
> 
> You are steadily moving towards more and more convoluted crap, in
> places where it really does not belong.
> 
> If anything, simple_recursive_removal() should be used for that,
> instead of trying to open-code bizarre subsets of its
> functionality...

OK, so like the below?

In my defence, simple_recursive_removal() isn't mentioned in
Documentation/filesystems and the function itself also has no
documentation, so even if I had stumbled across it in libfs.c the
recursive in the name would have lead me to believe it wasn't for
single dentry removal.

Regards,

James

---8>8>8><8<8<8---

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] efivarfs: fix error on write to new variable leaving remnants

Make variable cleanup go through the fops release mechanism and use
zero inode size as the indicator to delete the file.  Since all EFI
variables must have an initial u32 attribute, zero size occurs either
because the update deleted the variable or because an unsuccessful
write after create caused the size never to be set in the first place.

Even though this fixes the bug that a create either not followed by a
write or followed by a write that errored would leave a remnant file
for the variable, the file will appear momentarily globally visible
until the close of the fd deletes it.  This is safe because the normal
filesystem operations will mediate any races; however, it is still
possible for a directory listing at that instant between create and
close contain a variable that doesn't exist in the EFI table.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/file.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..0e545c8be173 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -36,28 +36,41 @@ static ssize_t efivarfs_file_write(struct file *file,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	inode_lock(inode);
+	if (d_unhashed(file->f_path.dentry)) {
+		/*
+		 * file got removed; don't allow a set.  Caused by an
+		 * unsuccessful create or successful delete write
+		 * racing with us.
+		 */
+		bytes = -EIO;
+		goto out;
+	}
+
 	bytes = efivar_entry_set_get_size(var, attributes, &datasize,
 					  data, &set);
-	if (!set && bytes) {
+	if (!set) {
 		if (bytes == -ENOENT)
 			bytes = -EIO;
 		goto out;
 	}
 
 	if (bytes == -ENOENT) {
-		drop_nlink(inode);
-		d_delete(file->f_path.dentry);
-		dput(file->f_path.dentry);
+		/*
+		 * zero size signals to release that the write deleted
+		 * the variable
+		 */
+		i_size_write(inode, 0);
 	} else {
-		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		inode_unlock(inode);
 	}
 
 	bytes = count;
 
 out:
+	inode_unlock(inode);
+
 	kfree(data);
 
 	return bytes;
@@ -106,8 +119,17 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
+static int efivarfs_file_release(struct inode *inode, struct file *file)
+{
+	if (i_size_read(inode) == 0)
+		simple_recursive_removal(file->f_path.dentry, NULL);
+
+	return 0;
+}
+
 const struct file_operations efivarfs_file_operations = {
-	.open	= simple_open,
-	.read	= efivarfs_file_read,
-	.write	= efivarfs_file_write,
+	.open		= simple_open,
+	.read		= efivarfs_file_read,
+	.write		= efivarfs_file_write,
+	.release	= efivarfs_file_release,
 };
-- 
2.35.3




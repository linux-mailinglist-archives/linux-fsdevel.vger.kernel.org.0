Return-Path: <linux-fsdevel+bounces-38069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C829FB4C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CAD166410
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA41C3C1C;
	Mon, 23 Dec 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VqmoYX/u";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UKI4Qz+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE31B4141;
	Mon, 23 Dec 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983537; cv=none; b=aW7lqvghzqlNqR1eLO/LIuZzsvQxU6li+6+FCrQc6pDOOGTlLL23Y6dVQpE2B2Zci3OwKKiwpWnjdq+0bP1D2aB1EFovYCDmizY5FtuyfIcRtC6vzKXGHERV5sIe47H1Vl8MscKuUC7+QMDh6xEvdK7t5Pl3P2g5ZbLXpGAozeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983537; c=relaxed/simple;
	bh=pmwY3xoFeUDjGIxRvDGkhqGGvaILGW2zC6lEcdnC3c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcF9+4Lti2ZxHZFcNpxBWVGDaKKV2GMKnCRGd5z4QmuU7fPJN6QkZRWUajz/WSoVjncPLasXDpiztnIk5u/v5wL2mjGtxD8dc1FeW6tT0R97bEmniiYTAMR1kijLBrhg82/ZiWDLxwdqH8o19eBV3vj1V0IHQNziV9MFyjqdsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VqmoYX/u; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UKI4Qz+J; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734983535;
	bh=pmwY3xoFeUDjGIxRvDGkhqGGvaILGW2zC6lEcdnC3c0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VqmoYX/up9IaYAt3Zh51eBwODkYXXGm/it2p4qZ6yVs11mypFQVQtzLjpkEcHQDfR
	 byEN7GVblBhfW0+2Gsg1FXR55Jd4uPexJ2RX7yzjMZQn5fHrfHShm3yceZJ+imDzhQ
	 xTGU9v6ECOJv8dpht1oTuAMoT4v7Qn5A7tQQ5Cqs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CC531286A3D;
	Mon, 23 Dec 2024 14:52:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id mOiCX2wco8X6; Mon, 23 Dec 2024 14:52:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734983534;
	bh=pmwY3xoFeUDjGIxRvDGkhqGGvaILGW2zC6lEcdnC3c0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UKI4Qz+J13YTjDPQqNq8aYSHETTgxV2PyfLkByJw8JcHJZpu8W2qhCNwR23B6E+B8
	 jiDOCY/2fF7ZuoTgpPL5yUfDsaD1ywGN4ann9NrmeF5PwGJXPmPjWnjqnUvcXtqCKe
	 mjN5kDV7WLKpBxK5/5xVa/6jvRefvNRsiTNTeVcw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 741DE1286A1E;
	Mon, 23 Dec 2024 14:52:14 -0500 (EST)
Message-ID: <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 23 Dec 2024 14:52:12 -0500
In-Reply-To: <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-11 at 07:39 -0500, James Bottomley wrote:
> On Wed, 2024-12-11 at 12:16 +0100, Christian Brauner wrote:
> > On Tue, Dec 10, 2024 at 12:02:24PM -0500, James Bottomley wrote:
> [...]
> > > +static int efivarfs_file_release(struct inode *inode, struct
> > > file
> > > *file)
> > > +{
> > > +       if (i_size_read(inode) == 0) {
> > > +               drop_nlink(inode);
> > > +               d_delete(file->f_path.dentry);
> > > +               dput(file->f_path.dentry);
> > > +       }
> > 
> > Without wider context the dput() looks UAF-y as __fput() will do:
> > 
> > struct dentry *dentry = file->f_path.dentry;
> > if (file->f_op->release)
> >         file->f_op->release(inode, file);
> > dput(dentry);
> > 
> > Is there an extra reference on file->f_path.dentry taken somewhere?
> 
> Heh, well, this is why I cc'd fsdevel to make sure I got all the fs
> bits I used to be familiar with, but knowledge of which has
> atrophied, correct.
> 
> I think it's paired with the extra dget() just after d_instantiate()
> in fs/efivarfs/inode.c:efivarfs_create().  The reason being this is a
> pseudo-filesystem so all the dentries representing objects have to be
> born with a positive reference count to prevent them being reclaimed
> under memory pressure.

Actually on further testing, this did turn out to be a use after free.
Not because of the dput, but because file->release is called for every
closed filehandle, so if you open the file for creation more than once,
both closes will try to delete it and ... oops.

The way I thought of mediating this is to check d_hashed in the file-
>release to see if the file has already been deleted.  That also means
we need a d_hashed() check in write because we can't resurrect the now
deleted file.  And finally something needs to mediate the check and
remove or check and add, so I used the inode semaphore for that.  The
updated patch is below and now passes the concurrency tests.

Regards,

James

------8>8>8><8<8<8-------------
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 6/6] efivarfs: fix error on write to new variable leaving remnants

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
 fs/efivarfs/file.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..70a673e7fda3 100644
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
@@ -106,8 +119,21 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
+static int efivarfs_file_release(struct inode *inode, struct file *file)
+{
+	inode_lock(inode);
+	if (i_size_read(inode) == 0 && !d_unhashed(file->f_path.dentry)) {
+		drop_nlink(inode);
+		d_delete(file->f_path.dentry);
+		dput(file->f_path.dentry);
+	}
+	inode_unlock(inode);
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




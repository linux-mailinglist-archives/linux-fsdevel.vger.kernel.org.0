Return-Path: <linux-fsdevel+bounces-60732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A807FB50CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190BD7B54FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 04:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45382773D2;
	Wed, 10 Sep 2025 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LkE72BY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF634CDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477575; cv=none; b=gK25wd9MBgkII2gMjT8TiyaxhH1zSHlyEoyVLPAnjdOSOarXXWZo7oGOjrKs7JgVX0966Jb3wsRldSCczUCaOGCRQTG9M5qNtDwecwL6Q2sMGCaLxG8GfYJ+d4iK3PL45T/BcB5sT8Z/jU2YXjtZhbdz0gNgjc4UPTBLV9ncXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477575; c=relaxed/simple;
	bh=jUv9eYvjxK+mGe3f2eRmNulEybAATOHsPKQKcXh5fb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp6yNoQY7i61rz/Rd9CZVRiCyjC6ZP28BWE0mjGkU+LfggfFKtQRU5S6cn16ylrfW3NbLH7PO8nuJPiuLuiaIwyF4PI8z6Zp11XoMX41sxRcrAgwrRfITaoA0ybB5DRJLCEfnSL/MZMUcgPHwi9WAsJwIP1z0FqaI2o50e3FXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LkE72BY4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rpQXThTt8jruxHk4PQ93J3fKFnA6EIBUY/S1GAWgeCQ=; b=LkE72BY446/LMxS6bv7UZH9g2C
	98XLoap5Dnjn1NjuetWPeAlo+n1h2TBlBnuvr8/oHh7JSj28olkuPs9S9o+8ro5M0blg+3Iy+iMSO
	zQELiN/Hvj3SU5QaVmlfCRZHLAg1Io8ORHfD2iTCImG2Jx1A9b1ZrYi/Y74CSEmFOTB3EcBCUVuvA
	D4On1VFLWfiogG3SBcBPy2iFIF+3/c/JtdORMwLWW0kdW8YvSbgKuYuBAd3Wls/NMDjrDcUlG5/EO
	UcTrcf/d79hK/Skg5Lck17i9ZXsy0AZ6hM2a2aUZl+nJHUqYe1oQwtTljqCrclFdcLCXA34jSmdiJ
	PjjEfSXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwCCP-0000000EF7h-3Yfe;
	Wed, 10 Sep 2025 04:12:49 +0000
Date: Wed, 10 Sep 2025 05:12:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
Message-ID: <20250910041249.GP31600@ZenIV>
References: <>
 <20250909081949.GM31600@ZenIV>
 <175747330917.2850467.10031339002768914482@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175747330917.2850467.10031339002768914482@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 10, 2025 at 01:01:49PM +1000, NeilBrown wrote:
> On Tue, 09 Sep 2025, Al Viro wrote:
> > On Tue, Sep 09, 2025 at 02:43:21PM +1000, NeilBrown wrote:
> > 
> > >  	d_instantiate(dentry, inode);
> > > -	dget(dentry);
> > > -fail:
> > > -	inode_unlock(d_inode(parent));
> > > -	return dentry;
> > > +	return simple_end_creating(dentry);
> > 
> > No.  This is the wrong model - dget() belongs with d_instantiate()
> > here; your simple_end_creating() calling conventions are wrong.
> 
> I can see that I shouldn't have removed the dget() there - thanks.
> It is not entirely clear why hypfs_create_file() returns with two
> references held to the dentry....
> I see now one is added either to ->update_file or the list at
> hypfs_last_dentry, and the other is disposed of by kill_litter_super().
> 
> But apart from that one error is there something broader wrong with the
> patch?  You say "the wrong model" but I don't see it.

See below for hypfs:

commit c0c58d3cadfcefcf25f4885b47c47d6e6a3f9aee
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu May 9 16:00:48 2024 -0400

    hypfs: don't pin dentries twice
    
    hypfs dentries end up with refcount 2 when they are not busy.
    Refcount 1 is enough to keep them pinned, and going that way
    allows to simplify things nicely:
            * don't need to drop an extra reference before the
    call of kill_litter_super() in ->kill_sb(); all we need
    there is to reset the cleanup list - everything on it will
    be taken out automatically.
            * we can make use of simple_recursive_removal() on
    tree rebuilds; just make sure that only children of root
    end up in the cleanup list and hypfs_delete_tree() becomes
    much simpler
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 96409573c75d..a4dc8e13d999 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -61,33 +61,17 @@ static void hypfs_update_update(struct super_block *sb)
 
 static void hypfs_add_dentry(struct dentry *dentry)
 {
-	dentry->d_fsdata = hypfs_last_dentry;
-	hypfs_last_dentry = dentry;
-}
-
-static void hypfs_remove(struct dentry *dentry)
-{
-	struct dentry *parent;
-
-	parent = dentry->d_parent;
-	inode_lock(d_inode(parent));
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(d_inode(parent), dentry);
-		else
-			simple_unlink(d_inode(parent), dentry);
+	if (IS_ROOT(dentry->d_parent)) {
+		dentry->d_fsdata = hypfs_last_dentry;
+		hypfs_last_dentry = dentry;
 	}
-	d_drop(dentry);
-	dput(dentry);
-	inode_unlock(d_inode(parent));
 }
 
-static void hypfs_delete_tree(struct dentry *root)
+static void hypfs_delete_tree(void)
 {
 	while (hypfs_last_dentry) {
-		struct dentry *next_dentry;
-		next_dentry = hypfs_last_dentry->d_fsdata;
-		hypfs_remove(hypfs_last_dentry);
+		struct dentry *next_dentry = hypfs_last_dentry->d_fsdata;
+		simple_recursive_removal(hypfs_last_dentry, NULL);
 		hypfs_last_dentry = next_dentry;
 	}
 }
@@ -184,14 +168,14 @@ static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		rc = -EBUSY;
 		goto out;
 	}
-	hypfs_delete_tree(sb->s_root);
+	hypfs_delete_tree();
 	if (machine_is_vm())
 		rc = hypfs_vm_create_files(sb->s_root);
 	else
 		rc = hypfs_diag_create_files(sb->s_root);
 	if (rc) {
 		pr_err("Updating the hypfs tree failed\n");
-		hypfs_delete_tree(sb->s_root);
+		hypfs_delete_tree();
 		goto out;
 	}
 	hypfs_update_update(sb);
@@ -326,13 +310,9 @@ static void hypfs_kill_super(struct super_block *sb)
 {
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 
-	if (sb->s_root)
-		hypfs_delete_tree(sb->s_root);
-	if (sb_info && sb_info->update_file)
-		hypfs_remove(sb_info->update_file);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	hypfs_last_dentry = NULL;
 	kill_litter_super(sb);
+	kfree(sb_info);
 }
 
 static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
@@ -367,7 +347,6 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 		BUG();
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
-	dget(dentry);
 fail:
 	inode_unlock(d_inode(parent));
 	return dentry;


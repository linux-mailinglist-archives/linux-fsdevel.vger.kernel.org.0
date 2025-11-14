Return-Path: <linux-fsdevel+bounces-68426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91AC5BD5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFBD3B9F93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BC2F7453;
	Fri, 14 Nov 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RmwmpcQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C915E8B;
	Fri, 14 Nov 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106384; cv=none; b=q8iW3Y/gkbTdNfLc6/x48nMs+0vWNuZfIAnaklwd0yv9z72uiJgCQ97hJiMHQ94rxBn5zlrOoNIbJMjbllISeWzFF1itBLDXwv9FvDzc6/hL+mXRSZwCGXBS1i1Bo9feOjBLt/D3wTtm8tTfWc2Zwm9MFQ+n1PXqY/YEb57IDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106384; c=relaxed/simple;
	bh=DOt8m4QkM9hQecTG/tA7QUOrlG38OhFmoW+w88nXRAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2wHVEACjtQ1JzJXJPVN2kX+PsARg0nAyeYR0ZgsH2UlMZvoLIvUSRIATlNObTTDraznI1WSvPbr9qOJqsoCh9NMXgoBklqL5BsVSS7h9shGD2hDkCiXAoH7i1JL1TjjhfIltNd0kVJrpw5ymfXxest0UldNEBCL1U3m5hOjNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RmwmpcQV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h+GY3DA2a89Ro6bK+Ny9JBXd1oGc4240hj01Ocp0k3I=; b=RmwmpcQVdyxseRwak/qof99plg
	19GIkQZH7ChhzOiG3uz8dg2HkAA5N+5/V1UIxXkDLDUEZCoKXkHmJU2jU1s+Q0xxu/tK+e7sPtX1g
	p9WnhHDcBBVa4n8KLpZIKcLWl1vD6DcEr3NuPGBC/3lFrFbZqBzzS93Vmonf4mXY1YBnwXFMeqSOq
	0VjFZh3Nht/9wWMlfASZ7/M0BXd2QaeBC84W+1f0gTGtGlmpUd/NgvFb/SFB2rT88CqI0WGcOH1cX
	adF7Nl5bHG2kHMKYO15y03X/mRHcKujBsb/+YppfEkDblFYHA+Zfb/PsC9CidjgprrT4VBcTnotMR
	Z1lBwfCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJoVa-00000009Pew-1WxF;
	Fri, 14 Nov 2025 07:46:14 +0000
Date: Fri, 14 Nov 2025 07:46:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <20251114074614.GY2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111316-cornfield-sphinx-ba89@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 13, 2025 at 04:20:08PM -0500, Greg Kroah-Hartman wrote:

> Sorry for the delay.  Yes, we should be grabing the mutex in there, good
> catch.  There's been more issues pointed out with the gadget code in the
> past year or so as more people are starting to actually use it and
> stress it more.  So if you have a patch for this, I'll gladly take it :)

How about the following?

commit 330837c8101578438f64cfaec3fb85521d668e56
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Nov 14 02:18:22 2025 -0500

    functionfs: fix the open/removal races
    
    ffs_epfile_open() can race with removal, ending up with file->private_data
    pointing to freed object.
    
    There is a total count of opened files on functionfs (both ep0 and
    dynamic ones) and when it hits zero, dynamic files get removed.
    Unfortunately, that removal can happen while another thread is
    in ffs_epfile_open(), but has not incremented the count yet.
    In that case open will succeed, leaving us with UAF on any subsequent
    read() or write().
    
    The root cause is that ffs->opened is misused; atomic_dec_and_test() vs.
    atomic_add_return() is not a good idea, when object remains visible all
    along.
    
    To untangle that
            * serialize openers on ffs->mutex (both for ep0 and for dynamic files)
            * have dynamic ones use atomic_inc_not_zero() and fail if we had
    zero ->opened; in that case the file we are opening is doomed.
            * have the inodes of dynamic files marked on removal (from the
    callback of simple_recursive_removal()) - clear ->i_private there.
            * have open of dynamic ones verify they hadn't been already removed,
    along with checking that state is FFS_ACTIVE.
    
    Fix another abuse of ->opened, while we are at it - it starts equal to 0,
    is incremented on opens and decremented on ->release()... *and* decremented
    (always from 0 to -1) in ->kill_sb().  Handling that case has no business
    in ffs_data_closed() (or to ->opened); just have ffs_kill_sb() do what
    ffs_data_closed() would in case of decrement to negative rather than
    calling ffs_data_closed() there.
    
    And don't bother with bumping ffs->ref when opening a file - superblock
    already holds the reference and it won't go away while there are any opened
    files on the filesystem.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 47cfbe41fdff..ed7fa869ea77 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -640,13 +640,22 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 static int ffs_ep0_open(struct inode *inode, struct file *file)
 {
-	struct ffs_data *ffs = inode->i_private;
+	struct ffs_data *ffs = inode->i_sb->s_fs_info;
+	int ret;
 
-	if (ffs->state == FFS_CLOSING)
-		return -EBUSY;
+	/* Acquire mutex */
+	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
+	if (ret < 0)
+		return ret;
 
-	file->private_data = ffs;
 	ffs_data_opened(ffs);
+	if (ffs->state == FFS_CLOSING) {
+		ffs_data_closed(ffs);
+		mutex_unlock(&ffs->mutex);
+		return -EBUSY;
+	}
+	mutex_unlock(&ffs->mutex);
+	file->private_data = ffs;
 
 	return stream_open(inode, file);
 }
@@ -1193,14 +1202,33 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 static int
 ffs_epfile_open(struct inode *inode, struct file *file)
 {
-	struct ffs_epfile *epfile = inode->i_private;
+	struct ffs_data *ffs = inode->i_sb->s_fs_info;
+	struct ffs_epfile *epfile;
+	int ret;
 
-	if (WARN_ON(epfile->ffs->state != FFS_ACTIVE))
+	/* Acquire mutex */
+	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
+	if (ret < 0)
+		return ret;
+
+	if (!atomic_inc_not_zero(&ffs->opened)) {
+		mutex_unlock(&ffs->mutex);
 		return -ENODEV;
+	}
+	/*
+	 * we want the state to be FFS_ACTIVE; FFS_ACTIVE alone is
+	 * not enough, though - we might have been through FFS_CLOSING
+	 * and back to FFS_ACTIVE, with our file already removed.
+	 */
+	epfile = smp_load_acquire(&inode->i_private);
+	if (unlikely(ffs->state != FFS_ACTIVE || !epfile)) {
+		mutex_unlock(&ffs->mutex);
+		ffs_data_closed(ffs);
+		return -ENODEV;
+	}
+	mutex_unlock(&ffs->mutex);
 
 	file->private_data = epfile;
-	ffs_data_opened(epfile->ffs);
-
 	return stream_open(inode, file);
 }
 
@@ -1332,7 +1360,7 @@ static void ffs_dmabuf_put(struct dma_buf_attachment *attach)
 static int
 ffs_epfile_release(struct inode *inode, struct file *file)
 {
-	struct ffs_epfile *epfile = inode->i_private;
+	struct ffs_epfile *epfile = file->private_data;
 	struct ffs_dmabuf_priv *priv, *tmp;
 	struct ffs_data *ffs = epfile->ffs;
 
@@ -2071,12 +2099,18 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void ffs_data_reset(struct ffs_data *ffs);
+
 static void
 ffs_fs_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
-	if (sb->s_fs_info)
-		ffs_data_closed(sb->s_fs_info);
+	if (sb->s_fs_info) {
+		struct ffs_data *ffs = sb->s_fs_info;
+		ffs->state = FFS_CLOSING;
+		ffs_data_reset(ffs);
+		ffs_data_put(ffs);
+	}
 }
 
 static struct file_system_type ffs_fs_type = {
@@ -2114,7 +2148,6 @@ static void functionfs_cleanup(void)
 /* ffs_data and ffs_function construction and destruction code **************/
 
 static void ffs_data_clear(struct ffs_data *ffs);
-static void ffs_data_reset(struct ffs_data *ffs);
 
 static void ffs_data_get(struct ffs_data *ffs)
 {
@@ -2123,7 +2156,6 @@ static void ffs_data_get(struct ffs_data *ffs)
 
 static void ffs_data_opened(struct ffs_data *ffs)
 {
-	refcount_inc(&ffs->ref);
 	if (atomic_add_return(1, &ffs->opened) == 1 &&
 			ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
@@ -2148,11 +2180,11 @@ static void ffs_data_put(struct ffs_data *ffs)
 
 static void ffs_data_closed(struct ffs_data *ffs)
 {
-	struct ffs_epfile *epfiles;
-	unsigned long flags;
-
 	if (atomic_dec_and_test(&ffs->opened)) {
 		if (ffs->no_disconnect) {
+			struct ffs_epfile *epfiles;
+			unsigned long flags;
+
 			ffs->state = FFS_DEACTIVATED;
 			spin_lock_irqsave(&ffs->eps_lock, flags);
 			epfiles = ffs->epfiles;
@@ -2171,12 +2203,6 @@ static void ffs_data_closed(struct ffs_data *ffs)
 			ffs_data_reset(ffs);
 		}
 	}
-	if (atomic_read(&ffs->opened) < 0) {
-		ffs->state = FFS_CLOSING;
-		ffs_data_reset(ffs);
-	}
-
-	ffs_data_put(ffs);
 }
 
 static struct ffs_data *ffs_data_new(const char *dev_name)
@@ -2352,6 +2378,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 	return 0;
 }
 
+static void clear_one(struct dentry *dentry)
+{
+	smp_store_release(&dentry->d_inode->i_private, NULL);
+}
+
 static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 {
 	struct ffs_epfile *epfile = epfiles;
@@ -2359,7 +2390,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
 		if (epfile->dentry) {
-			simple_recursive_removal(epfile->dentry, NULL);
+			simple_recursive_removal(epfile->dentry, clear_one);
 			epfile->dentry = NULL;
 		}
 	}


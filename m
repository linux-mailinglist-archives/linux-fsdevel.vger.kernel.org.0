Return-Path: <linux-fsdevel+bounces-68796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D1C66678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7C56524182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206734C121;
	Mon, 17 Nov 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LGGTxIiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832C303C94;
	Mon, 17 Nov 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417199; cv=none; b=VRvNYjTYTIFRFt3j4u1A8DTBhhkPpwN83WbE2/QGdElB4aJKzjbsGFmP/i5qsyZtc8bldSdTNysx6/xSEwhsowh2aH9zB3H+ebbJ/HiS10eaoQ9frr0ktnriLg6e1Kbp/PYaAbmFSoe3RE2a1dwTw00Pb26wdcZaQYI+/bttles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417199; c=relaxed/simple;
	bh=8yP6iHjMbYUYXNRM4tJJ2f1dQnWttvZa3M/tHFD+o00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoRSF0ihe0y0mUhrNmP7TspL2OE3jSUTukDNOrdJyEg4Sj8p+QMsZAkYbym4Rnq4+Tp1p7izARaImPjK67A6UkVKmRFYLh+PTIfjkne8RqDJ5aM7NaBT8D7Mp7b/2DwiFG5/+WbnSAYbLcpOs1vcod64jWX9dnbOEZH3gpUM8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LGGTxIiN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pa8Bj6Fizee8bOJm05tNzfmFor9U/R6BxTW6KbLJQb8=; b=LGGTxIiNBdrbm5G2I+cWguzNzA
	zWVvjmo7bkADIlhFP685l1lN8nMOPePMcXYA8HPiQkfsCX2eaHsBhgEmqSlkey+XkLqDp4jvYvvYP
	bjcDbMo44o50n24abxn38PZ0pyf+c868M7DhFitlxq19WV5vC1nlrn867TlFaLsqi96LU2NDUpWkc
	phrUaYp+rXDBb16CZ1LpweTW6OlKcN47whnhIVrsAbduMu+37YeWV/ant1bEjxIR2f4ZgJYP/VAPL
	XTMw5jekKcQsFuy69b1FFiXLw2cnuLnT1rHFocNvmgCtp4kCKDeEKPFGnl6w8KeV7mLyTvQTa8nKd
	NA3ikdXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7Mp-00000007N36-2ZO2;
	Mon, 17 Nov 2025 22:06:35 +0000
Date: Mon, 17 Nov 2025 22:06:35 +0000
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
Subject: [PATCH 4/4] functionfs: fix the open/removal races
Message-ID: <20251117220635.GD1745314@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
 <20251117220415.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117220415.GB2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 53 ++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 27860fc0fd7d..c7cb23a15fd0 100644
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
+		return -ENODEV;
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
 		return -ENODEV;
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
 
@@ -2353,6 +2381,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
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
@@ -2360,7 +2393,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
 		if (epfile->dentry) {
-			simple_recursive_removal(epfile->dentry, NULL);
+			simple_recursive_removal(epfile->dentry, clear_one);
 			epfile->dentry = NULL;
 		}
 	}
-- 
2.47.3



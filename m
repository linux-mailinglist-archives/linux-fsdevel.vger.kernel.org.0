Return-Path: <linux-fsdevel+bounces-75986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KheGQBsfWlxSAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 03:42:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BBC052D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 03:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5893E30214D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C331352D;
	Sat, 31 Jan 2026 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qWC3w5CK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF22FE579;
	Sat, 31 Jan 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827299; cv=none; b=N/AhEThyIvjEl2LXiuMfcdEiDbVA3AAG6QmgRjj6Xa5a1hUaN3zUVyvW9DuMj3mqgYiOsdW+fj+9MG7ap9r63lwoWSA9e7RvIuP0aAF3tyjaG4PCw6TkoNg0E24wNCGIuhAEDJ7scEVDUFY+md1oCFtBl1otA3+LQG/sxTY4+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827299; c=relaxed/simple;
	bh=pI1w99DiegL7fQtn08iKnOa6BIT4KtgFtIW06bF689U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/NSkodQ/kevEGDD1dj5UPubwUuI8V9WVw3viykaMve7h3BdfmG1gc3Q90pZLyRmKrofsOJ9iU6eFnAIoQxxqIFGVkkdiTncmJIdDEh+ArI+HSAMoBfZjA1+Vb0CqeMR0CIX3F5iy97UNEefJxq3PDyMGYgwA4TWg/kgvXBHhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qWC3w5CK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=D3+SZjilbeej82D6cZd1fnlpNeQE0EQG9Sk/0nsOkcI=; b=qWC3w5CKXv3HugEtDLi+gWk6Te
	Hc8cao6e2I9WgDwxI4vEw6/OOMZ0qMbMvoRPxa0zfL889Znbb9v+o6mkUi4R9tqX1mLpzhvD0xoHu
	A1FS75JfMHJT8e1fluxMg79bZ5p2V1SLvWIdPEt+DUYwGQhnCTlCyw5eUykIzMp/SyA3Dg82fzRkd
	W4aq3clE4iJumyrtoBDrf1fy8Q10XImeg/Di9PUsmvPZitiMMiGJVNI5QSEEiTAlGnVVLtoyz8fzu
	SNrXZtDVIbbwXXxKzFeQigWkSVz6jmd8pu1W41IeFVPnRHqFHxaQZ5Lb0Bhj4mQ7n5mCHIm+p4gtY
	REVLuqEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vm0xI-0000000E6WY-2rbV;
	Sat, 31 Jan 2026 02:43:24 +0000
Date: Sat, 31 Jan 2026 02:43:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260131024324.GA3183987@ZenIV>
References: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
 <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV>
 <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75986-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C41BBC052D
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:09:00PM -0800, Samuel Wu wrote:
> On Fri, Jan 30, 2026 at 5:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
> >
> > > > How lovely...  Could you slap
> > > >         WARN_ON(ret == -EAGAIN);
> > > > right before that
> > > >         if (ret < 0)
> > > >                 return ret;
> > >
> > > Surprisingly ret == 0 every time, so no difference in dmesg logs with
> > > this addition.
> >
> > What the hell?  Other than that mutex_lock(), the only change in there
> > is the order of store to file->private_data and call of ffs_data_opened();
> > that struct file pointer is not visible to anyone at that point...
> 
> Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
> is quite straightforward. Not familiar with this code path so just
> speculating, but is there any interaction with previous patches (e.g.
> refcounting)?
> 
> > Wait, it also brings ffs_data_reset() on that transition under ffs->mutex...
> > For a quick check: does
> > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-wsamuel2
> > git switch --detach FETCH_HEAD
> > demonstrate the same breakage?
> 
> Had to adjust forward declaration of ffs_data_reset() to build, but
> unfortunately same breakage.

That really looks like a badly racy userland on top of everything else...
I mean, it smells like userland open() from one process while another
is in the middle of configuring that stuff getting delayed too much
for the entire thing to work.  Bloody wonderful...

OK, let's see if a variant with serialization on spinlock works - how does
the following do on top of mainline?

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 05c6750702b6..fa467a40949d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -59,7 +59,6 @@ static struct ffs_data *__must_check ffs_data_new(const char *dev_name)
 	__attribute__((malloc));
 
 /* Opened counter handling. */
-static void ffs_data_opened(struct ffs_data *ffs);
 static void ffs_data_closed(struct ffs_data *ffs);
 
 /* Called with ffs->mutex held; take over ownership of data. */
@@ -636,23 +635,25 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+
+static void ffs_data_reset(struct ffs_data *ffs);
+
 static int ffs_ep0_open(struct inode *inode, struct file *file)
 {
 	struct ffs_data *ffs = inode->i_sb->s_fs_info;
-	int ret;
 
-	/* Acquire mutex */
-	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
-	if (ret < 0)
-		return ret;
-
-	ffs_data_opened(ffs);
+	spin_lock_irq(&ffs->eps_lock);
 	if (ffs->state == FFS_CLOSING) {
-		ffs_data_closed(ffs);
-		mutex_unlock(&ffs->mutex);
+		spin_unlock_irq(&ffs->eps_lock);
 		return -EBUSY;
 	}
-	mutex_unlock(&ffs->mutex);
+	if (!ffs->opened++ && ffs->state == FFS_DEACTIVATED) {
+		ffs->state = FFS_CLOSING;
+		spin_unlock_irq(&ffs->eps_lock);
+		ffs_data_reset(ffs);
+	} else {
+		spin_unlock_irq(&ffs->eps_lock);
+	}
 	file->private_data = ffs;
 
 	return stream_open(inode, file);
@@ -1202,15 +1203,10 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 {
 	struct ffs_data *ffs = inode->i_sb->s_fs_info;
 	struct ffs_epfile *epfile;
-	int ret;
-
-	/* Acquire mutex */
-	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
-	if (ret < 0)
-		return ret;
 
-	if (!atomic_inc_not_zero(&ffs->opened)) {
-		mutex_unlock(&ffs->mutex);
+	spin_lock_irq(&ffs->eps_lock);
+	if (!ffs->opened) {
+		spin_unlock_irq(&ffs->eps_lock);
 		return -ENODEV;
 	}
 	/*
@@ -1220,11 +1216,11 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	 */
 	epfile = smp_load_acquire(&inode->i_private);
 	if (unlikely(ffs->state != FFS_ACTIVE || !epfile)) {
-		mutex_unlock(&ffs->mutex);
-		ffs_data_closed(ffs);
+		spin_unlock_irq(&ffs->eps_lock);
 		return -ENODEV;
 	}
-	mutex_unlock(&ffs->mutex);
+	ffs->opened++;
+	spin_unlock_irq(&ffs->eps_lock);
 
 	file->private_data = epfile;
 	return stream_open(inode, file);
@@ -2092,8 +2088,6 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void ffs_data_reset(struct ffs_data *ffs);
-
 static void
 ffs_fs_kill_sb(struct super_block *sb)
 {
@@ -2150,15 +2144,6 @@ static void ffs_data_get(struct ffs_data *ffs)
 	refcount_inc(&ffs->ref);
 }
 
-static void ffs_data_opened(struct ffs_data *ffs)
-{
-	if (atomic_add_return(1, &ffs->opened) == 1 &&
-			ffs->state == FFS_DEACTIVATED) {
-		ffs->state = FFS_CLOSING;
-		ffs_data_reset(ffs);
-	}
-}
-
 static void ffs_data_put(struct ffs_data *ffs)
 {
 	if (refcount_dec_and_test(&ffs->ref)) {
@@ -2176,28 +2161,29 @@ static void ffs_data_put(struct ffs_data *ffs)
 
 static void ffs_data_closed(struct ffs_data *ffs)
 {
-	if (atomic_dec_and_test(&ffs->opened)) {
-		if (ffs->no_disconnect) {
-			struct ffs_epfile *epfiles;
-			unsigned long flags;
-
-			ffs->state = FFS_DEACTIVATED;
-			spin_lock_irqsave(&ffs->eps_lock, flags);
-			epfiles = ffs->epfiles;
-			ffs->epfiles = NULL;
-			spin_unlock_irqrestore(&ffs->eps_lock,
-							flags);
-
-			if (epfiles)
-				ffs_epfiles_destroy(ffs->sb, epfiles,
-						 ffs->eps_count);
-
-			if (ffs->setup_state == FFS_SETUP_PENDING)
-				__ffs_ep0_stall(ffs);
-		} else {
-			ffs->state = FFS_CLOSING;
-			ffs_data_reset(ffs);
-		}
+	spin_lock_irq(&ffs->eps_lock);
+	if (--ffs->opened) {	// not the last opener?
+		spin_unlock_irq(&ffs->eps_lock);
+		return;
+	}
+	if (ffs->no_disconnect) {
+		struct ffs_epfile *epfiles;
+
+		ffs->state = FFS_DEACTIVATED;
+		epfiles = ffs->epfiles;
+		ffs->epfiles = NULL;
+		spin_unlock_irq(&ffs->eps_lock);
+
+		if (epfiles)
+			ffs_epfiles_destroy(ffs->sb, epfiles,
+					 ffs->eps_count);
+
+		if (ffs->setup_state == FFS_SETUP_PENDING)
+			__ffs_ep0_stall(ffs);
+	} else {
+		ffs->state = FFS_CLOSING;
+		spin_unlock_irq(&ffs->eps_lock);
+		ffs_data_reset(ffs);
 	}
 }
 
@@ -2214,7 +2200,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	}
 
 	refcount_set(&ffs->ref, 1);
-	atomic_set(&ffs->opened, 0);
+	ffs->opened = 0;
 	ffs->state = FFS_READ_DESCRIPTORS;
 	mutex_init(&ffs->mutex);
 	spin_lock_init(&ffs->eps_lock);
@@ -2266,6 +2252,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
 {
 	ffs_data_clear(ffs);
 
+	spin_lock_irq(&ffs->eps_lock);
 	ffs->raw_descs_data = NULL;
 	ffs->raw_descs = NULL;
 	ffs->raw_strings = NULL;
@@ -2289,6 +2276,7 @@ static void ffs_data_reset(struct ffs_data *ffs)
 	ffs->ms_os_descs_ext_prop_count = 0;
 	ffs->ms_os_descs_ext_prop_name_len = 0;
 	ffs->ms_os_descs_ext_prop_data_len = 0;
+	spin_unlock_irq(&ffs->eps_lock);
 }
 
 
@@ -3756,6 +3744,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 {
 	struct ffs_function *func = ffs_func_from_usb(f);
 	struct ffs_data *ffs = func->ffs;
+	unsigned long flags;
 	int ret = 0, intf;
 
 	if (alt > MAX_ALT_SETTINGS)
@@ -3768,12 +3757,15 @@ static int ffs_func_set_alt(struct usb_function *f,
 	if (ffs->func)
 		ffs_func_eps_disable(ffs->func);
 
+	spin_lock_irqsave(&ffs->eps_lock, flags);
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
+	spin_unlock_irqrestore(&ffs->eps_lock, flags);
 
 	if (ffs->state != FFS_ACTIVE)
 		return -ENODEV;
@@ -3791,16 +3783,20 @@ static void ffs_func_disable(struct usb_function *f)
 {
 	struct ffs_function *func = ffs_func_from_usb(f);
 	struct ffs_data *ffs = func->ffs;
+	unsigned long flags;
 
 	if (ffs->func)
 		ffs_func_eps_disable(ffs->func);
 
+	spin_lock_irqsave(&ffs->eps_lock, flags);
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return;
 	}
+	spin_unlock_irqrestore(&ffs->eps_lock, flags);
 
 	if (ffs->state == FFS_ACTIVE) {
 		ffs->func = NULL;
diff --git a/drivers/usb/gadget/function/u_fs.h b/drivers/usb/gadget/function/u_fs.h
index 4b3365f23fd7..6a80182aadd7 100644
--- a/drivers/usb/gadget/function/u_fs.h
+++ b/drivers/usb/gadget/function/u_fs.h
@@ -176,7 +176,7 @@ struct ffs_data {
 	/* reference counter */
 	refcount_t			ref;
 	/* how many files are opened (EP0 and others) */
-	atomic_t			opened;
+	int				opened;
 
 	/* EP0 state */
 	enum ffs_state			state;


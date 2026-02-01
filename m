Return-Path: <linux-fsdevel+bounces-75999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK6pFtqZfmmLbQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 01:10:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032C5C4754
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 01:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670EA3029E43
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919D27453;
	Sun,  1 Feb 2026 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="um/7tYvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3364A21;
	Sun,  1 Feb 2026 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904584; cv=none; b=BvF4olWqjZbGf/6sVDJIgcl9zhAhpQIW0QlMAZuk9QmRp1IIgBARWPOfiA/sOK3Hh4a/CEgSTbBvXuC2Trjw2XhkRw/2P/cIFG5/d400AZ5q3Qc/GMfcfkyJF7gfHGIagZeWOmwufcni19qmRLFIPB8g5aR0DMuv9VoJE01amdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904584; c=relaxed/simple;
	bh=eaUptfjlR98TtZApFXatUBjI0moteCvv+6FMPOqsJUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmis74TiD1vWu/jyWJ2FI3zmKpPVupeIqzN/+j9c2tmQJRDCtD5UpD0Yww44SncdGwWSvGpUiNjufs/TXXL3tmu8wsltWfEMOt4f7IlqXftbw4wtRacDryzSrk883rxnQlEuIrUu/66OG1tAauv1Ref/iMnLU1uz2+sV3yud/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=um/7tYvp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ee6tnw7Bye5CGO63GyRbRK+g1RsPEEK7xU3KsikleH8=; b=um/7tYvp1GwLTW+4jRFFt6i8Lh
	43+Al7pZaW8xn1fwVBPpbz7wu/Qa0kqfQL3yLfYZjWpvUebDL6v1WuuYzgLT5w/sIHpyv3RP8j3Kp
	N9llJmy6Lkpvli4Hp7vFM+wjNB6whhI64AS2pDbFpn4N9zZsW+AusmBuL48iVTxuJAUCVaakYKofV
	1XwFvR+XGpvEMS645jPz7tx5kf5bMRoG5DFmrpYbhwSHQeFs4PJlwyszIEYMXAzd6Nu+TsJP67x/m
	hdO5SxFSlZQlDmnN2Z4gVsMIRpKMJXa8o+DQCKtQF7JJjLgnNFe4Rn2ou7zF7kgHnOMVJWn8+TDON
	24jRK0YQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vmL3p-0000000218W-0fSi;
	Sun, 01 Feb 2026 00:11:29 +0000
Date: Sun, 1 Feb 2026 00:11:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
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
Message-ID: <20260201001129.GB3183987@ZenIV>
References: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
 <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
 <20260131010821.GY3183987@ZenIV>
 <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75999-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 032C5C4754
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:11:39PM -0800, Linus Torvalds wrote:
> On Fri, 30 Jan 2026 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I'd rather go for a spinlock there, protecting these FFS_DEACTIVATED
> > transitions;
> 
> Yes, that's the much better solution.  The locking in this thing is horrendous.
> 
> But judging by Samuel's recent email, there's something else than the
> open locking thing going on.

I've put the following into viro/vfs.git#fixes; diff is identical to the
one that is reported to fix things on top of -rc7...

Objections?

commit 99a706fa47949ece1fb02b5b1206efd4fb031d25
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jan 31 18:24:41 2026 -0500

functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions
    
When all files are closed, functionfs needs ffs_data_reset() to be
done before any further opens are allowed.

During that time we have ffs->state set to FFS_CLOSING; that makes
->open() fail with -EBUSY.  Once ffs_data_reset() is done, it
switches state (to FFS_READ_DESCRIPTORS) indicating that opening
that thing is allowed again.  There's a couple of additional twists:
	* mounting with -o no_disconnect delays ffs_data_reset()
from doing that at the final ->release() to the first subsequent
open().  That's indicated by ffs->state set to FFS_DEACTIVATED;
if open() sees that, it immediately switches to FFS_CLOSING and
proceeds with doing ffs_data_reset() before returning to userland.
	* a couple of usb callbacks need to force the delayed
transition; unfortunately, they are done in locking environment
that does not allow blocking and ffs_data_reset() can block.
As the result, if these callbacks see FFS_DEACTIVATED, they change
state to FFS_CLOSING and use schedule_work() to get ffs_data_reset()
executed asynchronously.

Unfortunately, the locking is rather insufficient.  A fix attempted
in e5bf5ee26663 ("functionfs: fix the open/removal races") had closed
a bunch of UAF, but it didn't do anything to the callbacks, lacked
barriers in transition from FFS_CLOSING to FFS_READ_DESCRIPTORS
_and_ it had been too heavy-handed in open()/open() serialization -
I've used ffs->mutex for that, and it's being held over actual IO on
ep0, complete with copy_from_user(), etc.

Even more unfortunately, the userland side is apparently racy enough
to have the resulting timing changes (no failures, just a delayed
return of open(2)) disrupt the things quite badly.  Userland bugs
or not, it's a clear regression that needs to be dealt with.

Solution is to use a spinlock for serializing these state checks and
transitions - unlike ffs->mutex it can be taken in these callbacks
and it doesn't disrupt the timings in open().

We could introduce a new spinlock, but it's easier to use the one
that is already there (ffs->eps_lock) instead - the locking
environment is safe for it in all affected places.

Since now it is held over all places that alter or check the
open count (ffs->opened), there's no need to keep that atomic_t -
int would serve just fine and it's simpler that way.

Fixes: e5bf5ee26663 ("functionfs: fix the open/removal races")
Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode") # v4.0
Tested-by: Samuel Wu <wusamuel@google.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
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


Return-Path: <linux-fsdevel+bounces-40331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6FA22483
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EC4188561E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C306A33F;
	Wed, 29 Jan 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ROvPplTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C62C9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178383; cv=none; b=CACK3FUiQb3qRY65qYVlRIcHhbBv89al3Z2w9lcsk9AW65w1y1V5ZQYEM9pYe8DCPKAPVZiHnWq+GuBwjJYhh7m6flUVK0hyeWeUY0B7YtEqS8HlqG8XEclGh9DDc1Uemtu/2dhjjv3y1iUh7qyIUZkF2lTUFOMalBo9h/wt6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178383; c=relaxed/simple;
	bh=S8//TAOe3H0vcqzKL5fY4w1LX3WFVqyeGRavVXutHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKzM7AfeDnZDRdi5xoKU3CNL2N/vpO//ddQz3nDmYnrwRUBrxWcUl+MV+v9FzAHODGlTiA+fCbRUr8e5w3MasRPyQNoIC62VMbqL2teYEaJJamsVLGCbEfsWmnY5gsHodDS2lhJW+ydu9LEFMYekx15/l7dvcfe60qqNsH/E7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ROvPplTy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bThvo/EiGZ8aTUzk1TuKwifd2aexUrzUY8HyPKaM+UQ=; b=ROvPplTy8EDmNeoblpewkXKoUh
	Zn8rKnyaw7qCMLGgNyidNiz6xQbwkBTTqBod8nTvEbP/WS5iVk9BFToeW8M8/hnrRlKabSh79mjNq
	MSaGmqZOBGOyUPPZFxGpASFKSf3dawH101x2H0hQ/EFi2AUBWJTzjbIrou3dh/kZMB5OnggX4cCQv
	zqzG4k569cMc9kznlh+XkTGHrqB6IzDXXQx0497Dhl5/WPESo/YiQ+dchIUdV4vZriZPTBCv2cnLp
	PXpMeEbhsBA71rjt4TQpYG3qJdc9dubseHb16o7i+ILCZPc2BBqsQJrujvc3UmO8X92TeLFPmvhkD
	fnezl+TQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDb7-0000000FWKg-0PGA;
	Wed, 29 Jan 2025 19:19:37 +0000
Date: Wed, 29 Jan 2025 19:19:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <20250129191937.GR1977892@ZenIV>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250129043712.GQ1977892@ZenIV>
 <2025012939-mashing-carport-53bd@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012939-mashing-carport-53bd@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 29, 2025 at 08:13:02AM +0100, Greg Kroah-Hartman wrote:

> > Both are needed, actually.  Slightly longer term I would rather
> > split full_proxy_{read,write,lseek}() into short and full variant,
> > getting rid of the "check which pointer is non-NULL" and killed
> > the two remaining users of debugfs_real_fops() outside of
> > fs/debugfs/file.c; then we could union these ->..._fops pointers,
> > but until then they need to be initialized.
> > 
> > And yes, ->methods obviously needs to be initialized.
> > 
> > Al, bloody embarrassed ;-/
> 
> No worries, want to send a patch to fix both of these up so we can fix
> up Linus's tree now?

[PATCH] Fix the missing initializations in __debugfs_file_get()
    
both method table pointers in debugfs_fsdata need to be initialized,
obviously, and calculating the bitmap of present methods would also
go better if we start with initialized state.
    
Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_ops"
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e33cc77699cd..69e9ddcb113d 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -94,6 +94,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 		fsd = d_fsd;
 	} else {
 		struct inode *inode = dentry->d_inode;
+		unsigned int methods = 0;
 
 		if (WARN_ON(mode == DBGFS_GET_ALREADY))
 			return -EINVAL;
@@ -106,25 +107,28 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 			const struct debugfs_short_fops *ops;
 			ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;
 			if (ops->llseek)
-				fsd->methods |= HAS_LSEEK;
+				methods |= HAS_LSEEK;
 			if (ops->read)
-				fsd->methods |= HAS_READ;
+				methods |= HAS_READ;
 			if (ops->write)
-				fsd->methods |= HAS_WRITE;
+				methods |= HAS_WRITE;
+			fsd->real_fops = NULL;
 		} else {
 			const struct file_operations *ops;
 			ops = fsd->real_fops = DEBUGFS_I(inode)->real_fops;
 			if (ops->llseek)
-				fsd->methods |= HAS_LSEEK;
+				methods |= HAS_LSEEK;
 			if (ops->read)
-				fsd->methods |= HAS_READ;
+				methods |= HAS_READ;
 			if (ops->write)
-				fsd->methods |= HAS_WRITE;
+				methods |= HAS_WRITE;
 			if (ops->unlocked_ioctl)
-				fsd->methods |= HAS_IOCTL;
+				methods |= HAS_IOCTL;
 			if (ops->poll)
-				fsd->methods |= HAS_POLL;
+				methods |= HAS_POLL;
+			fsd->short_fops = NULL;
 		}
+		fsd->methods = methods;
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);
 		INIT_LIST_HEAD(&fsd->cancellations);


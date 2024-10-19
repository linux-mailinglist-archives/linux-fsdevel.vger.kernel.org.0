Return-Path: <linux-fsdevel+bounces-32408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED09A4B3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 07:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7C01C216EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D761D2785;
	Sat, 19 Oct 2024 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XmoY6nWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773A3207
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729314211; cv=none; b=tCeb5fw9UeXHOySaKmGz/ck4DfIEwtG2M0Ys8kZKVWnb0QNkmguCUQKbKva8Z9Vv93AFC+RBzzlV8h6e6Gj+e8h81t1h9PGIa0MnPKBFb3nvlTcHZLIe14JwoifCpfGKZfgI/BUu0sxxG8h0GgLOxfc6UxuCfAzLOPwQsUTI1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729314211; c=relaxed/simple;
	bh=0yPYtMd5/FcAHa6MKEsmZVgKvx4cMUFJNFOsQSqAkh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEhg+fc4WiXepY5ezFKv+rBe+pC2KXPr/xrfmR4pR+lETN8iL9+4flcDll0/umtP4tEICsfDTE2MzUbftOzGCaatYSR8TCp/mtwhPepXt17IGO6bqMBTW8p/jLj35LDq9Pjbc+uCVmAP1eOHZQnAO5y4/WI5xWss/Lg/jwUudk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XmoY6nWR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aHZbXZCvc6OMZayj9x0ImY4H6Uow7eXPOhnoAWwHrC8=; b=XmoY6nWRqmX2NRI1/5vxtZeTmM
	mmTMSsRzUuEbh2AjPaiX6yHhuSMaLNOx7aabq+9AukK41zS2aL85/wKbtNO5ur/c7dDDuBGqLmVf7
	Ih1s/Hu/lXPrHduWFuvSqK1/1a8vef6jfg/xp1Xw8FRo87mZ/clP9elm5t2XtI9YHFWT5HnO+R0h/
	sfs7T40RAB4aJRPzGYNoj6P62tAu+0QF5pV6EEcFDMNBnQRY0v5QCpetjTmLiqme6CMQxq2Xf8Iww
	WfURA+MQf+0YEQPlS+hDkkZV3FWO5i8qIH4YMaFMtehRe1Y8CcE9/sC7hIDyj1g+4/1Gr3OpwCfD/
	XrQeweSw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t21cY-00000005INY-1Yqz;
	Sat, 19 Oct 2024 05:03:22 +0000
Date: Sat, 19 Oct 2024 06:03:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241019050322.GD1172273@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018193822.GB1172273@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 18, 2024 at 08:38:22PM +0100, Al Viro wrote:
> On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:
> 
> > Extra cycles where?  If anything, I'd expect a too-small-to-measure
> > speedup due to dereference shifted from path_init() to __set_nameidata().
> > Below is literally all it takes to make filename_lookup() treat NULL
> > as empty-string name.
> > 
> > NOTE: I'm not talking about forcing the pure by-descriptor case through
> > the dfd+pathname codepath; not without serious profiling.  But treating
> > AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> > filename_lookup()?  Where do you expect to have the lost cycles on that?
> 
> [snip]
> 
> BTW, could you give me a reference to the mail with those objections?
> I don't see anything in my mailbox, but...
> 
> Or was that in one of those AT_EMPTY_PATH_NOCHECK (IIRC?) threads?
> 
> Anyway, what I'm suggesting is
> 
> 1) teach filename_lookup() to handle NULL struct filename * argument, treating
> it as "".  Trivial and does not impose any overhead on the normal cases.
> 
> 2) have statx try to recognize AT_EMPTY_PATH, "" and AT_EMPTY_PATH, NULL.
> If we have that and dfd is *NOT* AT_FDCWD, we have a nice descriptor-based
> case and can deal with it.
> If the name is not empty, we have to go for dfd+filename path.  Also obvious.
> Where we get trouble is AT_FDCWD, NULL case.  But with (1) we can simply
> route that to the same dfd+filename path, just passing it NULL for filename.
> 
> That handles the currently broken case, with very little disruption to
> anything else.

See #getname.fixup; on top of #base.getname and IMO worth folding into it.
I don't believe that it's going to give any measurable slowdown compared to
mainline.  Again, if the concerns about wasted cycles had been about routing
the dfd,"" and dfd,NULL cases through the filename_lookup(), this does *NOT*
happen with that patch.  Christian, Linus?

commit 9fb26eb324d9aa9e6889f181f1683e710946258f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Oct 19 00:57:14 2024 -0400

    fix statx(2) regression on AT_FDCWD,"" and AT_FDCWD,NULL
    
    teach filename_lookup() et.al. to handle NULL struct filename reference
    as ""; make AT_FDCWD,"" (but _NOT_ the normal dfd,"") case in statx(2)
    fall back to path-based variant.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namei.c b/fs/namei.c
index 27eb0a81d9b8..2bfe476c3bd0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
-	if (IS_ERR(name))
+	if (IS_ERR_OR_NULL(name))
 		return;
 
 	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
@@ -604,6 +604,7 @@ struct nameidata {
 		unsigned seq;
 	} *stack, internal[EMBEDDED_LEVELS];
 	struct filename	*name;
+	const char *pathname;
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
@@ -622,6 +623,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->depth = 0;
 	p->dfd = dfd;
 	p->name = name;
+	p->pathname = likely(name) ? name->name : "";
 	p->path.mnt = NULL;
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
@@ -2455,7 +2457,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
 	int error;
-	const char *s = nd->name->name;
+	const char *s = nd->pathname;
 
 	/* LOOKUP_CACHED requires RCU, ask caller to retry */
 	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
diff --git a/fs/stat.c b/fs/stat.c
index d0d82efd44d6..b74831dc7ae6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -328,7 +328,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	int statx_flags = flags | AT_NO_AUTOMOUNT;
 	struct filename *name = getname_maybe_null(filename, flags);
 
-	if (!name)
+	if (!name && dfd >= 0)
 		return vfs_fstat(dfd, stat);
 
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
@@ -769,7 +769,7 @@ SYSCALL_DEFINE5(statx,
 	int ret;
 	struct filename *name = getname_maybe_null(filename, flags);
 
-	if (!name)
+	if (!name && dfd >= 0)
 		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
 
 	ret = do_statx(dfd, name, flags, mask, buffer);


Return-Path: <linux-fsdevel+bounces-62802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E4ABA11EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5792A7BE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6631AF1F;
	Thu, 25 Sep 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="As6QhTNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002D23A9B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827389; cv=none; b=e2NXPp5+xpNpO7zZhnp4TWas3twsZq7SevwtIaZy2QCU7Mh0VVJL9zwMjSTnt/0xm4Rs4Po0pvSsc435Ih9OdJzPLpqIRhdcGgc8DCtC8KeN34RAVO38lwdAeSym8l8VyaSL9EmUTyMV647iXezVpoyWVNDUBn+3Z7pNYfAIz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827389; c=relaxed/simple;
	bh=KtumJgUnYRvu8n3cfnuLbT8a6QzaxrLVr3bf66ymrwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3W6my7DMDp52WyBfI6ELHQPXRCdgs2HBRzx66WFf0VBvZWYrftLDFOnsncdwesZBIJS6auWL15jfyQAB9/xL6p5xNrcegxDjMl9MavOEq28lpGv6pKiaNfC1dmK/fsWvXcPmGwZsUHsC9pnQfNxTea1/FyXAwc5lEUk6fSDIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=As6QhTNP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wzFQN6J3dgr6UNXYiPbBN37Tlk6eroTAdPERoAaZ/Xc=; b=As6QhTNPduRONfAxPG5NruavyQ
	ggGpM4WzILjC9buBXL0WHUyiyDimLn+nyTd1ZG6sPUq/YWKQ9Qn+y/N5LTX5xWyekwpB2n73M+yuq
	nAMGQ5hTWKYOlyxZCa/Z+QJeXxY1UgAOKyjpPA1NKWtGgNjFZFItrQpkcdYzvJFCwQybMk89p8Mli
	3jeyQNqgXu9wi55VwALYZxCbT7prmCa14I/LmeYZ7lOuDZkN1ZX+JXH/JM4LLch0+vYt2QBAqLD18
	ZmYCJDdeOLbcBH1Zg9pbMiUHAC2NvRV8CTfy97ZQZCRky+3G5RMMrAUEIiSG50cruLXqj3jK0Hp32
	KjuandZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1rLc-0000000A35t-06wZ;
	Thu, 25 Sep 2025 19:09:44 +0000
Date: Thu, 25 Sep 2025 20:09:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <20250925190944.GA39973@ZenIV>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
 <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
 <20250925185630.GZ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925185630.GZ39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 25, 2025 at 07:56:30PM +0100, Al Viro wrote:
> On Thu, Sep 25, 2025 at 02:28:16PM +0200, Jan Kara wrote:
> 
> > This is mostly harmless (just the returned error code changed) but it is a
> > side effect of one thing I'd like to discuss: The original code uses
> > file_open_name(O_WRONLY|O_APPEND|O_LARGEFILE) to open the file to write
> > data to. The new code uses dentry_open() for that. Now one important
> > difference between these two is that dentry_open() doesn't end up calling
> > may_open() on the path and hence now acct_on() fails to check file
> > permissions which looks like a bug? Am I missing something Al?
> 
> You are not; a bug it is.  FWIW, I suspect that the right approach would
> be to keep file_open_name(), do all checks on result of that, then use
> 	mnt = mnt_clone_internal(&original_file->f_path);
> and from that point on same as now - opening the file to be used with
> dentry_open(), etc.  Original file would get dropped in the end of acct_on().
> I'll put together something along those lines and post it.

Something like this for incremental (completely untested at that point):

diff --git a/kernel/acct.c b/kernel/acct.c
index 30ae403ee322..61630110e29d 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -218,19 +218,21 @@ static int acct_on(const char __user *name)
 	/* Difference from BSD - they don't do O_APPEND */
 	const int open_flags = O_WRONLY|O_APPEND|O_LARGEFILE;
 	struct pid_namespace *ns = task_active_pid_ns(current);
-	struct path path __free(path_put) = {};		// in that order
+	struct filename *pathname __free(putname) = getname(name);
+	struct file *original_file __free(fput) = NULL;	// in that order
 	struct path internal __free(path_put) = {};	// in that order
 	struct file *file __free(fput_sync) = NULL;	// in that order
 	struct bsd_acct_struct *acct;
 	struct vfsmount *mnt;
 	struct fs_pin *old;
-	int err;
 
-	err = user_path_at(AT_FDCWD, name, LOOKUP_FOLLOW, &path);
-	if (err)
-		return err;
+	if (IS_ERR(pathname))
+		return PTR_ERR(pathname);
+	original_file = file_open_name(pathname, open_flags, 0);
+	if (IS_ERR(original_file))
+		return PTR_ERR(original_file);
 
-	mnt = mnt_clone_internal(&path);
+	mnt = mnt_clone_internal(&original_file->f_path);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
@@ -268,7 +270,7 @@ static int acct_on(const char __user *name)
 	INIT_WORK(&acct->work, close_work);
 	init_completion(&acct->done);
 	mutex_lock_nested(&acct->lock, 1);	/* nobody has seen it yet */
-	pin_insert(&acct->pin, path.mnt);
+	pin_insert(&acct->pin, original_file->f_path.mnt);
 
 	rcu_read_lock();
 	old = xchg(&ns->bacct, &acct->pin);


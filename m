Return-Path: <linux-fsdevel+bounces-53871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0CAF850D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 03:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C627543655
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2D481B6;
	Fri,  4 Jul 2025 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rUUzFsMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CD1367;
	Fri,  4 Jul 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751590955; cv=none; b=XkIoTmqGx/OuDFSm1INXxHKGcRRXc/saHoi5go5YTtR4gg8YSd3C94Zn+L1y1us7OSL2M0r/QbrMSO5gO61sIKisOs5u+WQrYpJKYb9SxHeOFkin5X6wHP8NVaKAGS5NZiSb1ty4KfheFZ9pWpN6OCSBejnv/JmrUrdjhyuIbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751590955; c=relaxed/simple;
	bh=4yM9H18WKb8ZQoai1J+dXO7Gqdgx9RawE/f2J7Fq7ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzGxf0VSbwYi2clBBL1DtgizmmIAe/c66Ylk0zwml6vTWPkTNA4RjjCUcH0fds5s49K0ux/q+Fy5SrofYovwnmZAsu0iSKVo0/Nqd1m5JTfp6vXIkqmW6dZGNGYTXnfVQb9xUGSKeoU6nSPkJLvimiIbK9ys5oyAgKT0w+ocYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rUUzFsMD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8AXJg1tKSMX9yM/D1GDp09pdz1kDnJW5g7KxaXavI4=; b=rUUzFsMDuM6jDKn/65069gKDKj
	QpK2jPDELrkp8ER4J89aukeSAyCupy2fmMEWi+pyIJs9Qffp09oC97c2yNXoOR/xEN8qLRx8i0zBq
	LMYcfMcnOU9rJtVCvc5dkIM7Ih+aTiJZ8hBtIq9QoMgAyHps7pcPwUTmG/Kvt8p3elzPGrhVz7MeD
	jp3KK4D0dlyBgjpO3DplsaBUzV/VUrkmfgDQSfEH0vXrpT7KyCm/R7MCSuNfTuTkpRvXZ9Z4ghwm9
	J4GvP3r4xdXdMScTc0sneu1xYB7xOVVaUt8nqXRTIgByxTtOGnOJaXwk3r4EthbLPSmzfinVutXRI
	grWHlCPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXUow-00000007qiP-0bZx;
	Fri, 04 Jul 2025 01:02:30 +0000
Date: Fri, 4 Jul 2025 02:02:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing
 ->sysctl
Message-ID: <20250704010230.GA1868876@ZenIV>
References: <175002843966.608730.14640390628578526912@noble.neil.brown.name>
 <20250615235714.GG1880847@ZenIV>
 <175004219130.608730.907040844486871388@noble.neil.brown.name>
 <20250703234313.GM1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703234313.GM1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 12:43:13AM +0100, Al Viro wrote:

> I would rather *not* leave a dangling pointer there, and yes, it can
> end up being dangling.  kfree_rcu() from inside the ->evict_inode()
> may very well happen earlier than (also RCU-delayed) freeing of struct
> inode itself.
> 
> What we can do is WRITE_ONCE() to set it to NULL on the evict_inode
> side and READ_ONCE() in the proc_sys_compare().
> 
> The reason why the latter is memory-safe is that ->d_compare() for
> non-in-lookup dentries is called either under rcu_read_lock() (in which
> case observing non-NULL means that kfree_rcu() couldn't have gotten to
> freeing the sucker) *or* under ->d_lock, in which case the inode can't
> reach ->evict_inode() until we are done.
> 
> So this predicate is very much relevant.  Have that fucker called with
> neither rcu_read_lock() nor ->d_lock, and you might very well end up
> with dereferencing an already freed ctl_table_header.

IOW, I would prefer to do this:

[PATCH] fix proc_sys_compare() handling of in-lookup dentries

There's one case where ->d_compare() can be called for an in-lookup
dentry; usually that's nothing special from ->d_compare() point of
view, but... proc_sys_compare() is weird.

The thing is, /proc/sys subdirectories can look differently for
different processes.  Up to and including having the same name
resolve to different dentries - all of them hashed.

The way it's done is ->d_compare() refusing to admit a match unless
this dentry is supposed to be visible to this caller.  The information
needed to discriminate between them is stored in inode; it is set
during proc_sys_lookup() and until it's done d_splice_alias() we really
can't tell who should that dentry be visible for.

Normally there's no negative dentries in /proc/sys; we can run into
a dying dentry in RCU dcache lookup, but those can be safely rejected.

However, ->d_compare() is also called for in-lookup dentries, before
they get positive - or hashed, for that matter.  In case of match
we will wait until dentry leaves in-lookup state and repeat ->d_compare()
afterwards.  In other words, the right behaviour is to treat the
name match as sufficient for in-lookup dentries; if dentry is not
for us, we'll see that when we recheck once proc_sys_lookup() is
done with it.
    
While we are at it, fix the misspelled READ_ONCE and WRITE_ONCE there.

Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
Reported-by: NeilBrown <neilb@brown.name>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..3604b616311c 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -42,7 +42,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		WRITE_ONCE(ei->sysctl, NULL);
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..08b78150cdde 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -918,17 +918,21 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
+	head = READ_ONCE(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }
 


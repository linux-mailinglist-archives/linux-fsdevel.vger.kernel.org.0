Return-Path: <linux-fsdevel+bounces-11016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27D84FD48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849921F291F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEC8612E;
	Fri,  9 Feb 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NE6hE3i7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A61272C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508893; cv=none; b=uHf/XQ8HuAvSWjcvsPpO0wBG3MXXYRznLmdv2jUnMNgAYTq6bwfDdHM420GwGgIl1kAvMPlSiZfWLTXILA/L8BuEF09QQK2H96TfD21zSVi3oQkeOkhad9uY1OQkRVLjchP/2/22D/Aw/0m0emKMgnpSTw+vAToDHkElRBwcOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508893; c=relaxed/simple;
	bh=vWpRyKkF5MDxCM0qrcDXcDf/w+SAvekP47U7aGPSmOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r92BvvTIuj0yrfxUD4uiF6L8CNqm6Sfytben/eqXwZ7wQp5HKHeuZah9xoUwoAVTcz6jycGxiLTa/QtaVPg/R1K7k6qkugGLUJdx1l7bBy5gGs+aP1AAwVo1q6LhdLmchKuYpnP68fSkJ6ONlmT+VHuK4XMnBapblTajUtr6B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NE6hE3i7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iGkeIFgL1kSCm/JWgJHujmkMae6ELHaSwYiG93PV0F4=; b=NE6hE3i7FqaWDU9W37APLyAPVh
	6FvARu9en96UvtavAhyYNvnKcZZkPiwtzkodX1XOnYlawfJPOSalXNR6qsMb9xS8cU3JHRovHl8J0
	uH03kGomFhHN+pgCu4IPRSA08oWjKk1OOcZQXD9fDTIulERnqytZjjAVSsnL909h/cY/wN15W3haK
	b7OzGWSFklb+VIhS7SBwIJaY3eEHijkmmepK76Wm5zv8T6C6jAKIID+35g5uRHripKHP72B1zZINT
	zZNSfQCZRNO0j/jNxl7/7TAIzezYhdmoeCLWL+o+7Aud4vNHwMOdmpQUCUFGNi7Ib+RpL7oM76PUe
	yjENbyXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rYX3v-004Pzr-1h;
	Fri, 09 Feb 2024 20:01:27 +0000
Date: Fri, 9 Feb 2024 20:01:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [RFC] ->d_name accesses
Message-ID: <20240209200127.GE608142@ZenIV>
References: <20240207222248.GB608142@ZenIV>
 <ZcQKYydYzCT04AyT@casper.infradead.org>
 <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 09, 2024 at 11:10:10AM -0800, Nick Desaulniers wrote:
 
> I have 100% observed llvm throw out writes to objects declared as
> const where folks tried to write via "casting away the const" (since
> that's UB) which resulted in boot failures in the Linux kernel
> affecting android devices.  I can't find the commit in question at the
> moment, but seemed to have made some kind of note in it in 2020.
> https://android-review.git.corp.google.com/c/platform/prebuilts/clang/host/linux-x86/+/1201901/1/RELEASE_NOTES.md
> 
> That said, I just tried Al's union, and don't observe such optimizations.
> https://godbolt.org/z/zrj71E8W5

FWIW, see #work.qstr in git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git

First 4 commits are constifying the arguments that get &dentry->d_inode
passed into, followed by the patch below.  __d_alloc(), swap_names(), copy_name()
and d_mark_tmpfile() - no other writers...

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..d21df0fb967d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1651,13 +1651,13 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		dname = dentry->d_iname;
 	}	
 
-	dentry->d_name.len = name->len;
-	dentry->d_name.hash = name->hash;
+	dentry->__d_name.len = name->len;
+	dentry->__d_name.hash = name->hash;
 	memcpy(dname, name->name, name->len);
 	dname[name->len] = 0;
 
 	/* Make sure we always see the terminating NUL character */
-	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
+	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
 
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
@@ -2695,16 +2695,16 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			/*
 			 * Both external: swap the pointers
 			 */
-			swap(target->d_name.name, dentry->d_name.name);
+			swap(target->__d_name.name, dentry->__d_name.name);
 		} else {
 			/*
 			 * dentry:internal, target:external.  Steal target's
 			 * storage and make target internal.
 			 */
-			memcpy(target->d_iname, dentry->d_name.name,
-					dentry->d_name.len + 1);
-			dentry->d_name.name = target->d_name.name;
-			target->d_name.name = target->d_iname;
+			memcpy(target->d_iname, dentry->__d_name.name,
+					dentry->__d_name.len + 1);
+			dentry->__d_name.name = target->__d_name.name;
+			target->__d_name.name = target->d_iname;
 		}
 	} else {
 		if (unlikely(dname_external(dentry))) {
@@ -2712,10 +2712,10 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:external, target:internal.  Give dentry's
 			 * storage to target and make dentry internal
 			 */
-			memcpy(dentry->d_iname, target->d_name.name,
-					target->d_name.len + 1);
-			target->d_name.name = dentry->d_name.name;
-			dentry->d_name.name = dentry->d_iname;
+			memcpy(dentry->d_iname, target->__d_name.name,
+					target->__d_name.len + 1);
+			target->__d_name.name = dentry->__d_name.name;
+			dentry->__d_name.name = dentry->d_iname;
 		} else {
 			/*
 			 * Both are internal.
@@ -2728,7 +2728,7 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			}
 		}
 	}
-	swap(dentry->d_name.hash_len, target->d_name.hash_len);
+	swap(dentry->__d_name.hash_len, target->__d_name.hash_len);
 }
 
 static void copy_name(struct dentry *dentry, struct dentry *target)
@@ -2738,12 +2738,12 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
 		atomic_inc(&external_name(target)->u.count);
-		dentry->d_name = target->d_name;
+		dentry->__d_name = target->__d_name;
 	} else {
-		memcpy(dentry->d_iname, target->d_name.name,
-				target->d_name.len + 1);
-		dentry->d_name.name = dentry->d_iname;
-		dentry->d_name.hash_len = target->d_name.hash_len;
+		memcpy(dentry->d_iname, target->__d_name.name,
+				target->__d_name.len + 1);
+		dentry->__d_name.name = dentry->d_iname;
+		dentry->__d_name.hash_len = target->__d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
 		kfree_rcu(old_name, u.head);
@@ -3080,7 +3080,7 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	dentry->d_name.len = sprintf(dentry->d_iname, "#%llu",
+	dentry->__d_name.len = sprintf(dentry->d_iname, "#%llu",
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index eb4ca8a1d948..a74370b1fe31 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -85,7 +85,10 @@ struct dentry {
 	seqcount_spinlock_t d_seq;	/* per dentry seqlock */
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
-	struct qstr d_name;
+	union {
+	struct qstr __d_name;
+	const struct qstr d_name;
+	};
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
 	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */


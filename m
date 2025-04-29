Return-Path: <linux-fsdevel+bounces-47552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7253AA010D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 06:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4193A87BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2B270542;
	Tue, 29 Apr 2025 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TATZcP8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79F27470
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899443; cv=none; b=SUHmjg3EP811yFWJSjDl7KSeQMC6DOeqDwy2qfJllh6VNgjH7CJmUUHpRD/wVfrb7/GTby7r1yWuzRgkyTIjywcYqQUznhkH1R5wIXNcPcxYx5rWZ712O9sjHymBjq4A/0icIrmX+yPRjXU7EHCuN8nt/wC8wp/+sES8cMzcDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899443; c=relaxed/simple;
	bh=jfVuEFYw48i9g/pLirtd93ZVER91WYlOCMoaMREOxLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdkd19ZVMp9HbXR1bdoeZuJxxDRfMHovRw8iBhhAruYc3MgLL6MyPnoWTa8Cne2yMlAIIOou9VY3hq3M5f7oNrpdaetRy+PwkWjBlOruDWnEhzXG8enCpjAm7VKTbqX8KPg13UZnoHPwAPeDejMyVyipYZDARiX7ZVUpm20WEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TATZcP8E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fJs0XYFmBywDUQ8uJRDTkgF6MqAqkZ5wHgeXFp/UZ5o=; b=TATZcP8EcyF64jCIVY6qQqkb+Q
	g3rmnSZcE9zJ+Jarty1CkquVn78Ao8b3SIR7mQ9FXsrdVQlxDSPldDu5lXSPVj/97WppZIM/ADo0L
	RtsAtaOU5nJWT+3Q4i4hq6Cxh15a5EHxdpePN3+cpiauBYTADB4TlBfDXwtQy64M/dElPQk2Ndeit
	/QUdxAMKzTyLUvDyc2fBlfj8WxecSI3cxNCJWR406xDE1kE1nhyLMTjxrElj0caEhJzgeRerKVI8h
	jquhR9rLugqcQRBfWGkim2UC33W9zJk8XeLQ6sbK6GbYVXr029JvH5ZIsLrPT+ilCqUPswgD5cf7k
	dlBhfZEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cCM-0000000CmvR-1aqS;
	Tue, 29 Apr 2025 04:03:58 +0000
Date: Tue, 29 Apr 2025 05:03:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429040358.GO2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428185318.GN2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:

> FWIW, I've a series of cleanups falling out of audit of struct mount
> handling; it's still growing, but I'll post the stable parts for review
> tonight or tomorrow...

_Another_ fun one, this time around do_umount().  Take a look
at this chunk in mntput_no_expire():
        lock_mount_hash();
	/*
	 * make sure that if __legitimize_mnt() has not seen us grab
	 * mount_lock, we'll see their refcount increment here.
	 */
	smp_mb();
	mnt_add_count(mnt, -1);
	count = mnt_get_count(mnt);

... and note that we do *not* have such a barrier in do_umount(), between
        lock_mount_hash();
and
                shrink_submounts(mnt);
		retval = -EBUSY;
		if (!propagate_mount_busy(mnt, 2)) {
making it possible to __legitimize_mnt() fail to see lock_mount_hash() in
do_umount(), with do_umount() not noticing the increment of refcount done
by __legitimize_mnt().  It is considerably harder to hit, but I wouldn't
bet on it being impossible...

The sky is not falling (the worst we'll get is a successful sync umount(2)
ending up like a lazy one would; sucks if you see that umount(2) has succeeded
and e.g. pull a USB stick out, of course, but...)

But AFAICS we need a barrier here, to make sure that either legitimize_mnt()
fails seqcount check, grabs mount_lock, sees MNT_SYNC_UMOUNT and quitely
decrements refcount and buggers off or umount(2) sees the increment in
legitimize_mnt() and fails with -EBUSY.

It's really the same situation as with mntput_no_expire(), except that
there the corresponding flag is MNT_DOOMED...

[PATCH] do_umount(): add missing barrier before refcount checks in sync case
    
do_umount() analogue of the race fixed in 119e1ef80ecf "fix
__legitimize_mnt()/mntput() race".  Here we want to make sure that
if __legitimize_mnt() doesn't notice our lock_mount_hash(), we will
notice their refcount increment.  Harder to hit than mntput_no_expire()
one, fortunately, and consequences are milder (sync umount acting
like umount -l on a rare race with RCU pathwalk hitting at just the
wrong time instead of use-after-free galore mntput_no_expire()
counterpart used to be hit).  Still a bug...
 
Fixes: 48a066e72d97 ("RCU'd vsfmounts")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index eba4748388b1..d8a344d0a80a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -787,7 +787,7 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 		return 0;
 	mnt = real_mount(bastard);
 	mnt_add_count(mnt, 1);
-	smp_mb();			// see mntput_no_expire()
+	smp_mb();		// see mntput_no_expire() and do_umount()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
 	lock_mount_hash();
@@ -2044,6 +2044,7 @@ static int do_umount(struct mount *mnt, int flags)
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
+		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {


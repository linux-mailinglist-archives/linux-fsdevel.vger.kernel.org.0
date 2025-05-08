Return-Path: <linux-fsdevel+bounces-48507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FBAB0449
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635E798242D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA958221DB9;
	Thu,  8 May 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RI1Ec3oz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6F29A0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734501; cv=none; b=DObX/tRfRP4SVNRw6S9yGQClnQG7rymcf+4C2fmUC0YbrBuVij85Q2WB54QFfvtOQDCcMMwZfQoSrHFN+M7W+MMn8yiYphdHKsnD5u0UyQzS+6OhCDAplRnKvK2RlkwFUbdjzQm13c5aG9+kbb62pT9r5iVWfZJ32SOUignLXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734501; c=relaxed/simple;
	bh=hW4O3hdi6Yl2Chox9CD5td+pk04/f5h3tFUu+plwvyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGh0POJJqs9nSqeAA//Z4SgkI49vXjlZKVxjttk30DCH4DtB9ZW8lZu9YmhLNBv/DT4a++BZvLajYXs78A14edZTP2S8eAOPUJGrtCmyXmmMYtEAurfhkoydcSph0ATld+ZrKfH0rfTTZGNgEf9g97ixthGA90/poNSlUjjH/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RI1Ec3oz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NU71+mZn3F5DI0I7iyQ/ngPRv52VWnhhkTCvkz+N3xA=; b=RI1Ec3ozhifExrXdffUR69IsZ8
	lDyU0VRJ2gaDBy1sqFkUgx/qUQGSQk+bcz0lDmlPuPF2Pfeq4A2VYMpiWIbKQtCcwvb+CUcQhx7XT
	pNWvz1bnOZkLFcfEw9JwgdU0g128z8D3ayliPUGpgltfw96X9bRTjQe/e4w2nlPy5SDxYsIPuYIyv
	nhOujQT5mKaMNi6Vj0TtDVUhUeQ2RfwbkRoQlm46aVuAypF9L+wRBYb/S6fh6TYKzjesmUY9MrD+s
	iAe1cXTt1+DAb1li9t61f2oeL5VMBJEgkIDVw/nVBOgSWLhk1aXQTJr+kjj/SkCPA/pRhLd+g3B6k
	NUSLX3Kw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7R3-00000007q8A-43MI;
	Thu, 08 May 2025 20:01:38 +0000
Date: Thu, 8 May 2025 21:01:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/4] do_umount(): add missing barrier before refcount checks
 in sync case
Message-ID: <20250508200137.GE2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508195916.GC2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

do_umount() analogue of the race fixed in 119e1ef80ecf "fix
__legitimize_mnt()/mntput() race".  Here we want to make sure that
if __legitimize_mnt() doesn't notice our lock_mount_hash(), we will
notice their refcount increment.  Harder to hit than mntput_no_expire()
one, fortunately, and consequences are milder (sync umount acting
like umount -l on a rare race with RCU pathwalk hitting at just the
wrong time instead of use-after-free galore mntput_no_expire()
counterpart used to be hit).  Still a bug...

Fixes: 48a066e72d97 ("RCU'd vfsmounts")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.39.5



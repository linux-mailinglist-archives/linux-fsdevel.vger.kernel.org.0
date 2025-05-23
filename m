Return-Path: <linux-fsdevel+bounces-49799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7AAC2B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 23:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95CE189750A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0C1FDA94;
	Fri, 23 May 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CsCzSyo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC182DCBE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036259; cv=none; b=PbzCHQZDA7IcpkcBF3I1oIz4IRvnP4Qkuskeytr3IO5Rq4oRk8VvBosx4pEattqxmqv8udiI1IICf+TrYt8mpfilAjufUOL7yP/ZpsX/QrHSb4cPOkNt0/z/JTAzD8jgT5QRJ+LyVIZP8MSO8y0E2KNutjWaSA6vuB0/eEMnxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036259; c=relaxed/simple;
	bh=9mfVthuhOZyQgFwstQRbk5lkQ3Wxk2ZNUjgj1jgC7T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZtyPLskY5r0YIZAh+P8PbI1PZWlEOL9kDnJBj57SjKtGEOt4pZsJ+X+gBUFwdEinOP/PSyrJYloGRNfjD5nMZo95jSAP/fIFqdCwXwjekLFEShOKrjWvbSWvxzB35CXsVTlq7Nu69a/SQl8AntNY87gMbw/K1IktdEdSAQbN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CsCzSyo2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8mDsncBT1Ss/MbqeStStX9hKJS9UrgTd6OZFjhwTkZI=; b=CsCzSyo2AMVYZ8vhyqjhC+jIzi
	a77dvYolQ/MSLEG9OZTeXAj/Kfsug1jeOaTxt6+0i8EfB3aOalswmCHuWU9sKGWvK5+0u+80zjVwE
	qtKQPPmCmmLU3TKNk684xIT/LJSC3N9aV8EvTVBUvoigbvdXI/c+p/A+l1g0ao+Uq1M2YqSb5ybev
	AT0Sj7Q9Nj6LsSo75Yf+wxMmrZUZwVbproDWo2yt7sDwK4yYk2+O9bZlbrga2rqxtM+uB2rLdHNcO
	i7GsVgztGElQQGew45YzOZVo7F5y40PqZYDhfVPF/aQ0HlT1nFH171hO0KGIxEIH4/abcSMvewZH5
	WRb9VwQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIa59-0000000FMQo-3kUj;
	Fri, 23 May 2025 21:37:35 +0000
Date: Fri, 23 May 2025 22:37:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250523213735.GK2023217@ZenIV>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
 <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
 <20250523212958.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523212958.GJ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 23, 2025 at 10:29:58PM +0100, Al Viro wrote:

> This is bogus, IMO.  I'm perfectly fine with propagate_one() returning 0
> on anon_ns(m->mnt); that would refuse to propagate into *any* anon ns,
> but won't screw the propagation between the mounts that are in normal, non-anon
> namespaces.

IOW, I mean this variant - the only difference from what you've posted is
the location of is_anon_ns() test; you do it in IS_MNT_NEW(), this variant
has it in propagate_one().  Does the variant below fix regression?


diff --git a/fs/mount.h b/fs/mount.h
index 7aecf2a60472..ad7173037924 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -7,10 +7,6 @@
 
 extern struct list_head notify_list;
 
-typedef __u32 __bitwise mntns_flags_t;
-
-#define MNTNS_PROPAGATING	((__force mntns_flags_t)(1 << 0))
-
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -37,7 +33,6 @@ struct mnt_namespace {
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
 	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
 	refcount_t		passive; /* number references not pinning @mounts */
-	mntns_flags_t		mntns_flags;
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index 1b466c54a357..623cd110076d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3648,7 +3648,7 @@ static int do_move_mount(struct path *old_path,
 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
 		goto out;
 
-	if (is_anon_ns(ns)) {
+	if (is_anon_ns(ns) && ns == p->mnt_ns) {
 		/*
 		 * Ending up with two files referring to the root of the
 		 * same anonymous mount namespace would cause an error
@@ -3656,16 +3656,7 @@ static int do_move_mount(struct path *old_path,
 		 * twice into the mount tree which would be rejected
 		 * later. But be explicit about it right here.
 		 */
-		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
-			goto out;
-
-		/*
-		 * If this is an anonymous mount tree ensure that mount
-		 * propagation can detect mounts that were just
-		 * propagated to the target mount tree so we don't
-		 * propagate onto them.
-		 */
-		ns->mntns_flags |= MNTNS_PROPAGATING;
+		goto out;
 	} else if (is_anon_ns(p->mnt_ns)) {
 		/*
 		 * Don't allow moving an attached mount tree to an
@@ -3722,8 +3713,6 @@ static int do_move_mount(struct path *old_path,
 	if (attached)
 		put_mountpoint(old_mp);
 out:
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
 	unlock_mount(mp);
 	if (!err) {
 		if (attached) {
diff --git a/fs/pnode.c b/fs/pnode.c
index fb77427df39e..ffd429b760d5 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -231,8 +231,8 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	/* skip if mountpoint isn't visible in m */
 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
 		return 0;
-	/* skip if m is in the anon_ns we are emptying */
-	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
+	/* skip if m is in the anon_ns */
+	if (is_anon_ns(m->mnt_ns))
 		return 0;
 
 	if (peers(m, last_dest)) {


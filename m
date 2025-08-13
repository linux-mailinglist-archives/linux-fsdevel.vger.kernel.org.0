Return-Path: <linux-fsdevel+bounces-57782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB96B2537A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CD61C8637C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E2305E2C;
	Wed, 13 Aug 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="w0i5Dd/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21482302CCC;
	Wed, 13 Aug 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111368; cv=none; b=RJBhvqlm0p+xsiiJLLqib+8WqIgXONs5zP7aDcKkMCFyGOEmZvUJ7OgHLAC+Oumz2eEvaNobP4l8SxiGQ73BQ2xdUiHOA4eHvWluGg2O36u9xm3v+pxHPatUjRlPyNVKkoHKtJ5bMkfF6u5BgDa0Wkld8mDmqO0pl+RUZp5N/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111368; c=relaxed/simple;
	bh=Fe19/ip8+CVxXl2aEKak9LtudYaMiDlEcAjExYvKYTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfpowyCzyzn6FmXQtENFNq1SkbRDEJFowX5UqvflcflM7gRUv9j3sxGa4oFxiMcofOnHt1fa1LWW9HFmLLVMFbMkw6weaVrw9kn7V1qL0jwcwJro6bGmr2+LWEHO8vS8EzoomhWFvwD1gibCjTJ48tXjeB3NPO4ybLE6bhMk24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=w0i5Dd/Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5lpkJos7qWPnLKHUIhAIUhJWzGvW6Gy5HTrpgDY7qFs=; b=w0i5Dd/QeMZm9yCMAj4ji+KQB4
	hwaBPlNk992pRnUJXE8xcTRUBKlwpyVCXGGvQBjfsxUENoHMpscRc9L0Z4xYrhA29/BZCxR7u39yw
	JONiv5w6hqmajGUsgftfEWBIxUNBjc9qrtij6s4ljff/rsbHC8W78GrpTtUbwB/RxSISLb9iDeXn9
	GN/bMDaj/B3GX0S7OEds2zY2TdIPqLtdXVy2cFvSt4SXYnYYHmlPrAJ47TVFpDgFnVnQqts5LDTzi
	4WJiaXKIeRdx59rrlKgpUUk797RMFE+lXFx1tKjj8e9f/JISGEFMjl1CO7ybKN3WiKAUOXRhFsFR6
	6sD5MWBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umGdl-0000000CPrt-1AOC;
	Wed, 13 Aug 2025 18:56:01 +0000
Date: Wed, 13 Aug 2025 19:56:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrei Vagin <avagin@google.com>
Cc: Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250813185601.GJ222315@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 26, 2025 at 02:01:20PM -0700, Andrei Vagin wrote:

> > For a very mild example of fun to be had there:
> >         mount("none", "/mnt", "tmpfs", 0, "");
> >         chdir("/mnt");
> >         umount2(".", MNT_DETACH);
> >         mount(NULL, ".", NULL, MS_SHARED, NULL);
> > Repeat in a loop, watch mount group id leak.  That's a trivial example
> > of violating the assertion ("a mount that had been through umount_tree()
> > is out of propagation graph and related data structures for good").
> 
> I wasn't referring to detached mounts. CRIU modifies mounts from
> non-current namespaces.
> 
> >
> > As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> > userns do you have in mind?
> >
> 
> The user namespace of the target mount:
> ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)

To bring that thread back: how about the following?  If nobody objects,
I'm going to throw it into viro/vfs.git #fixes...

[PATCH] use uniform permission checks for all mount propagation changes

do_change_type() and do_set_group() are operating on different
aspects of the same thing - propagation graph.  The latter
asks for mounts involved to be mounted in namespace(s) the caller
has CAP_SYS_ADMIN for.  The former is a mess - originally it
didn't even check that mount *is* mounted.  That got fixed,
but the resulting check turns out to be too strict for userland -
in effect, we check that mount is in our namespace, having already
checked that we have CAP_SYS_ADMIN there.

What we really need (in both cases) is
	* we only touch mounts that are mounted.  Hard requirement,
data corruption if that's get violated.
	* we don't allow to mess with a namespace unless you already
have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).

That's an equivalent of what do_set_group() does; let's extract that
into a helper (may_change_propagation()) and use it in both
do_set_group() and do_change_type().

Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not ours mounts"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..e7d9b23f1e9e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2862,6 +2862,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2898,10 +2911,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -3347,18 +3360,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	namespace_lock();
 
-	err = -EINVAL;
-	/* To and From must be mounted */
-	if (!is_mounted(&from->mnt))
-		goto out;
-	if (!is_mounted(&to->mnt))
-		goto out;
-
-	err = -EPERM;
-	/* We should be allowed to modify mount namespaces of both mounts */
-	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
-	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
 
 	err = -EINVAL;


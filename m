Return-Path: <linux-fsdevel+bounces-50817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB76ACFD2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820FD1893F2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18224E4C6;
	Fri,  6 Jun 2025 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dsxWDmKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7C1BF58
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749193292; cv=none; b=uKgRFw8gP7RQsJoQKxPAfUU7R9EbaJg6f8jse1JrMw0pZ9kS3qFHyZIp0OyuZU3gfgiSjHbc45aopo1Q07kVxv6UeNt5X+Kb+hNIzR/CkAqTuuW9pp0x9ZrBj0x49PZUa3anh+yYFsFFyI2G9nlYxy+ZFkwttrCyaJdxMcGt8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749193292; c=relaxed/simple;
	bh=bQ9LxBRaUhBB2SosF6QxHDgWg/G/bzRf+gPy45YS/Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkHezVrjOkFyixBqJt01qz1l4DCopOYN9K7+SHf/M2cMww18CMDjl+cwGQE5PyQ5LrsFvh1LnmKdWuUyhuatcgVXA52ZCUHXervdpJoV6AQUcnLXn/pwtd0tSNCknpYNBHQuwRWtOsnCxG6xGrrkOX0jUfq7VW2mjhCZ57AMHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dsxWDmKa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gMec/KGTVm/1saxkXFSSTCaxN2CDo7TATNudbJ0+aXs=; b=dsxWDmKaZX3D4KXlE+UDMDntD0
	glphm3EbthOkhAcBGgXW+xbCFU4g/yBbNU7p5HPsNDBmUbdrJCxZZ6UWmxgHMg19C9ni3jH/OLD+4
	5+7r0PyyT6faOzQZ4TrQ7N1DvQSkkBxjxgBpv2dxAUThcIF4cABs49gCgWdVMehWilFacboZH4wnt
	ZL4B4twzO+EN8FyrZtv1xeBWf+C7mErXI01AApRQV3LIqJqdwywwXWAVG8esut3l3sCyYGdqCivql
	2micxncBihQ97+4RiprdLh8vNFBZ9O2vv0cUWnHpEhIWrSutXGhTtZyGw40/8UNj959p7D2gmuHWz
	zJLKAFJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNR4x-0000000DBuo-1SqY;
	Fri, 06 Jun 2025 07:01:27 +0000
Date: Fri, 6 Jun 2025 08:01:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250606070127.GU299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606051428.GT299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

	Folks, could you check the following, on top of viro/vfs.git#fixes?

do_move_mount(): split the checks in subtree-of-our-ns and entire-anon cases

... and fix the breakage in anon-to-anon case.  There are two cases
acceptable for do_move_mount() and mixing checks for those is making
things hard to follow.

One case is move of a subtree in caller's namespace.
	* source and destination must be in caller's namespace
	* source must be detachable from parent
Another is moving the entire anon namespace elsewhere
	* source must be the root of anon namespace
	* target must either in caller's namespace or in a suitable
	  anon namespace (see may_use_mount() for details).
	* target must not be in the same namespace as source.

It's really easier to follow if tests are *not* mixed together...

[[
This should be equivalent to what Christian has posted last night;
please test on whatever tests you've got.
]]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 854099aafed5..59197109e6b9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3656,37 +3656,29 @@ static int do_move_mount(struct path *old_path,
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	if (!may_use_mount(p))
-		goto out;
-
 	/* The thing moved must be mounted... */
 	if (!is_mounted(&old->mnt))
 		goto out;
 
 	/* ... and either ours or the root of anon namespace */
-	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
-		goto out;
-
-	if (is_anon_ns(ns) && ns == p->mnt_ns) {
-		/*
-		 * Ending up with two files referring to the root of the
-		 * same anonymous mount namespace would cause an error
-		 * as this would mean trying to move the same mount
-		 * twice into the mount tree which would be rejected
-		 * later. But be explicit about it right here.
-		 */
-		goto out;
-	} else if (is_anon_ns(p->mnt_ns)) {
-		/*
-		 * Don't allow moving an attached mount tree to an
-		 * anonymous mount tree.
-		 */
-		goto out;
+	if (check_mnt(old)) {
+		/* should be detachable from parent */
+		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
+			goto out;
+		/* target should be ours */
+		if (!check_mnt(p))
+			goto out;
+	} else {
+		if (!is_anon_ns(ns) || mnt_has_parent(old))
+			goto out;
+		/* not into the same anon ns - bail early in that case */
+		if (ns == p->mnt_ns)
+			goto out;
+		/* target should be ours or in an acceptable anon ns */
+		if (!may_use_mount(p))
+			goto out;
 	}
 
-	if (old->mnt.mnt_flags & MNT_LOCKED)
-		goto out;
-
 	if (!path_mounted(old_path))
 		goto out;
 


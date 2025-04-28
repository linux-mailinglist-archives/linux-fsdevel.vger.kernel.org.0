Return-Path: <linux-fsdevel+bounces-47532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6046A9F8E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404CF174644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669A294A12;
	Mon, 28 Apr 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Mb30apUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFA26F478
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866404; cv=none; b=QyPzKtTGw/NBfZnSeDlldjHrklJjhENp5X0atu/AtT78PHLECEPrcCLSL8cBY4zxVCScGoEo6ghgyEGfxarMS3VP/QpLTbXRGgzibvFAKg400pOL2ErxyzBP2PF3q1o0PkuvJJBrtZXGXDPeKTAe7JBjKo6/2MBa/l0HEGfaPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866404; c=relaxed/simple;
	bh=+zykcGvuNlbDhIWh4gqIxxI9Wdg4nMOovzMbgLjQay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1IuIburGpRi1TW99b7d6Hu682nt9fVNOxrdHONgOL5yJRH/41h2tnOi3wHzMAvWjMGXt6u8dBD3fNPtcbxpJLeWS7a95fu4kDMS/m6HUFmKGwVJWkVzbFF/I0NZRJ0ss8z1KdKaU2IreLHtgTCQZUtmwyT9Gw7HSl/AtHeditU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Mb30apUe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iHOHO9xic4QGidHGqICPqNpkmUdnEjBRrcsGPmAHW2M=; b=Mb30apUetW5jMqgxAzwfQguzGR
	0wEJoxGT7kJAjtZWQE7ucXJC5f9JdKyrM5Dj7OsYv+yQ/nOQDX8VF6RZSx24vUWYSdiAiPjGISvCo
	3MnrGdBMW3XxFeNlEjxN5FMl2vIbu3ecieP4sYv76ERJPbiyL4wyed0HGoBpPZXzxxiQFbR0zoUS8
	HUQVkho+KKhMmYTAvxHT2TSv8pqlxot5c/nkp7nlm0w50M74c5wmF1AKtv7mZptB8GTsbg5BBfCvs
	dGJql9t3lEDNjQthZwNNs7EI9F7lLt0MIPedsIwd9oYMH/gmjaEN1KRNQtLjk7XFP+ANbCS3ATzN4
	ao/0rzgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9TbS-0000000A9dO-2ltK;
	Mon, 28 Apr 2025 18:53:18 +0000
Date: Mon, 28 Apr 2025 19:53:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250428185318.GN2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-wortkarg-krabben-8692c5782475@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 28, 2025 at 10:50:53AM +0200, Christian Brauner wrote:

> I'm not fond of the global variable. I would generally agree with you if
> that were really performance sensitive but this really isn't.

Up to you; propagation calculations *are* hard-serialized (on namespace_sem)
and changing that is too much pain to consider, so I have no problem with
globals in that specific case (note several such in propagate_mnt()
machinery; that was a deliberate decision to avoid shitloads of arguments
that would have to be passed around otherwise), but...

Anyway, minimal fix is to shift clearing the flag, as below.
Longer term I'd rather shift setting and clearing it down into
propagate_mnt() (and dropped check from propagation_would_overmount(),
with corresponding change to can_move_mount_beneath()).

It's really "for the purposes of this mount propagation event treat all
mounts in that namespace as 'new'", so the smaller scope that thing has
the easier it is to reason about...

> I'll have more uses for the flags member very soon as I will make it
> possible to list mounts in anonymous mount namespaces because it
> confuses userspace to no end that they can't list detached mount trees.
> 
> So anonymous mount namespaces will simply get a mount namespace id just
> like any other mount namespace and simply be discerned by a flag.
> 
> Thanks for going through this. I appreciate it.
> 
> The check_mnt() simplification is good though.

FWIW, I've a series of cleanups falling out of audit of struct mount
handling; it's still growing, but I'll post the stable parts for review
tonight or tomorrow...

--------
[PATCH] do_move_mount(): don't leak MNTNS_PROPAGATING on failures

as it is, a failed move_mount(2) from anon namespace breaks
all further propagation into that namespace, including normal
mounts in non-anon namespaces that would otherwise propagate
there.

Fixes: 064fe6e233e8 "mount: handle mount propagation for detached mount trees" v6.15+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index eba4748388b1..8b8348ee5a55 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3714,15 +3714,14 @@ static int do_move_mount(struct path *old_path,
 	if (err)
 		goto out;
 
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
-
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
 	if (attached)
 		put_mountpoint(old_mp);
 out:
+	if (is_anon_ns(ns))
+		ns->mntns_flags &= ~MNTNS_PROPAGATING;
 	unlock_mount(mp);
 	if (!err) {
 		if (attached) {


Return-Path: <linux-fsdevel+bounces-59598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF598B3AE7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21941C8545D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3280226F28A;
	Thu, 28 Aug 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MHgoxPAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC53FC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424368; cv=none; b=DTNuUZFOs7yYsWF7Gc5xiahUy/uIi6DL2MPFDR0RLqgeM1zL4eu0ebuIdJsUHE+5TLOH3pfE4p8Owjg6iOCxWVUxiYapB/xO+8in2F5Zr4Tn7GcmQzjHJycfaaF4OdC3TumWQVQTfSctvIE5WjLOc3t12GgjgVR328iHlbmNRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424368; c=relaxed/simple;
	bh=2MD/veIbvEQU4WZ5JVWVLmFriQDy0kgegZ1NYpUTj2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKRU2cn5Zg5eRP6TQI/M6uX/vMQeQHk9DG4/dBe+8Ylc4W4f16AwPkYLuiWyCBmHC7UGu+h8+jZuffi7NxuYZQzS5tTsrS55+k2Eyf+TV8rsoUc/ix8DUv6UZUBhYygqJGc8HlULtbNHAo+CFkrpjefBnB3/8xDjhtlQOfvFi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MHgoxPAP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CZu30ppbQMhC/hcn3Gd9/oXw8oxiXjxhodcgjlP0DdM=; b=MHgoxPAPSk5o99SZnjgyTi1bh9
	R7AQB7rV4Me4axRR7SAg1MlNAcc6/xSsXaxe70cetQqrG77V8JscsYVT1yVpKXsm1RT9B4F0ucCdO
	j4sh1RrNc0upEp3sdGwuyfHPu3t3DCkvJmquUSLufNA0mvX2vmpGIFrLf+paXKCidyDGESGOxMe1a
	LruC9H9kBB4/ap/RHWbr/Qbtj+CcUl15j2i63lF2wT7zxULManWbu8c9cHm9RRdzeYC6kYfZmji4e
	WwzBNpyVNn3Kqes472093KDZRdMJXxIEJIos05RZ3qvXtVRSUVPoDTIm50C6FcQQVT9OxmzmlDF6e
	oQF5uvWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urmDE-0000000FRX6-1ip2;
	Thu, 28 Aug 2025 23:39:24 +0000
Date: Fri, 29 Aug 2025 00:39:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 33/63] don't bother passing new_path->dentry to
 can_move_mount_beneath()
Message-ID: <20250828233924.GA39973@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-33-viro@zeniv.linux.org.uk>
 <CAHk-=wi2=v4cV6=jaxjA6ymaadxiWRRNdfzPa==EY6RQxWni3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2=v4cV6=jaxjA6ymaadxiWRRNdfzPa==EY6RQxWni3w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 28, 2025 at 04:20:56PM -0700, Linus Torvalds wrote:

> (I'll have a separate comment on 61/63)
> 
> I certainly agree with the intent of the patch, but that
> can_move_mount_beneath() call line is now rather hard to read. It
> looked simpler before.
> 
> Maybe you could just split it into two lines, and write it as
> 
>         if (beneath) {
>                 struct mount *new_mnt = real_mount(new_path->mnt);
>                 err = can_move_mount_beneath(old, new_mnt, mp.mp);
>                 if (err)
>                         return err;
>         }
> 
> which makes slightly less happen in that one line (and it fits in 80
> columns too - not a requirement, but still "good taste")
> 
> Long lines are better than randomly splitting lines unreadably into
> multiple lines, but short lines that are logically split are still
> preferred, I would say..

FWIW, if you look at #35, you'll see this:

-		err = can_move_mount_beneath(old, real_mount(new_path->mnt), mp.mp);
+		struct mount *over = real_mount(new_path->mnt);
+
+		if (mp.parent != over->mnt_parent)
+			over = mp.parent->overmount;
+		err = can_move_mount_beneath(old, over, mp.mp);

So... might as well introduce the variable in this one.
Then this chunk becomes
@@ -3618,7 +3617,9 @@ static int do_move_mount(struct path *old_path,
 	}
 
 	if (beneath) {
-		err = can_move_mount_beneath(old, new_path, mp.mp);
+		struct mount *over = real_mount(new_path->mnt);
+
+		err = can_move_mount_beneath(old, over, mp.mp);
 		if (err)
 			return err;
 	}
and the corresponding one in #35 
@@ -3618,6 +3624,8 @@ static int do_move_mount(struct path *old_path,
 	if (beneath) {
 		struct mount *over = real_mount(new_path->mnt);
 
+		if (mp.parent != over->mnt_parent)
+			over = mp.parent->overmount;
 		err = can_move_mount_beneath(old, over, mp.mp);
 		if (err)
 			return err;

OK, done - both certainly look better that way.


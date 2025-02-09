Return-Path: <linux-fsdevel+bounces-41343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42597A2E17C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 00:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D2C7A273C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2C241C8B;
	Sun,  9 Feb 2025 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oTNjs8lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDE1119A;
	Sun,  9 Feb 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144031; cv=none; b=fJoe0rFxNzVC3myTBxNl8BrNSk2XgHmkXExWV1QMDrAI4i+ZisjNm9axLoF+cV1QimpKc1Ddr5q3plvUd2LEclY0bnJSBMDI47T1hZei3Z5mudhroE0WaBligQV0w6qZqxOn9lwS54cbRNXnpz3C7jL/KqrSoJYIy4gYW1V6U6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144031; c=relaxed/simple;
	bh=uJoZ8UA1/IE7V+tg/lvWJYZc90fncoV7XgnqRsA54Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfQeUJDiExMXul31y7I5Qy3Zw9je7V/ruUDnHw8Mh1SyQKkEvZHqLNE4JcxjGo6yPfU/xbVjYSWYBcf21zHnYMSuGpxCCYCgz+aNVfnGVkQmITwcZvNBrW4KDAso7sMgU+is35c3hCQCs5WxVdSXxedm8+zisC2aavbt7cgou1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oTNjs8lI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7UZyeCVg3IGpepmIgEmJqrZNVaxK6J0XdMcnDXEOrCI=; b=oTNjs8lIjH/cftwlndAvKxzwbo
	2MbUwd0PcTakaKTiSYIb75O9iwwnPBIQD26ZcyOH+eLJrXH8l89nEzKHQ6AtxgBbRsDzh8ykVRvUX
	TPGiaOSoJJTTBcTyOFUbG2R+tOn1hXV6AHoc7j8otT+nx8GorLE/xaJQVBZUQgx/AbHBp2g7JeKOB
	LGru9cjfTPrlBJ+VsgUZVYSuWuRLMHF1i16B7zECpw8Ke18kgwPY1iwKRDK+T3CoIR/HfvsW3vJxr
	USe1rm0kSjWLEYvy7KuAKDTqTKH2U4fND4mxiKzmv9D9Sz54eZDBvdJXV9iYcoUKTrzh4Txo42jeP
	/bDcH57Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thGo1-00000008ofT-3wh4;
	Sun, 09 Feb 2025 23:33:41 +0000
Date: Sun, 9 Feb 2025 23:33:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19 v7?] RFC: Allow concurrent and async changes in a
 directory
Message-ID: <20250209233341.GX1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:37PM +1100, NeilBrown wrote:

> The idea behind the async support is to eventually connect this to
> io_uring so that one process can launch several concurrent directory
> operations.  I have not looked deeply into io_uring and cannot be
> certain that the interface I've provided will be able to be used.  I
> would welcome any advice on that matter, though I hope to find time to
> explore myself.  For now if any _async op returns -EINPROGRESS we simply
> wait for the callback to indicate completion.

OK, after looking through that and playing around with the locking
scheme of yours:

Separating directory rwsem for reads/modifications from locking of
individual dentries may be feasible, but it needs to be a lot more
careful about the states it sleeps in.  Your current variant is rife
with deadlocks; for the "wait on dentry itself" it's probably possible
to avoid, with some care; for "wait on parent" it's really not an option.

Quite a bit of headache comes from the fact that NFS et.al. are playing
silly buggers with "OK, we see that lookup is for <operation>; skip it,
the call of actual method will do the right thing".  The trouble is,
d_lookup_done() of not-really-looked-up is fine under exclusive lock on
parent, but only because there won't be d_alloc_parallel() on the same
name until we drop that exclusive lock.

Your scheme, OTOH, has hard dependency upon those suckers staying visible
to d_alloc_parallel() until the actual operation is done.  Which means
that this code, including the methods, is exposed to in-lookup dentries.

What's more, similar dependency is there for dentries getting unhashed
between the lookup and the end of operation - something which NFS
cheerfully violates.  If method's argument gets hit with d_drop() and
d_rehash(), there's a window where it won't be found in dcache, leaving
no indication that it's being operated upon.  Currently we are fine -
exclusive lock on parent means that on dcache miss we try to grab
the parent shared and repeat dcache lookup when we get that.

Your variant does not have such exclusion - parent is held shared and
child dentry involved is not there to be found during d_drop()/d_rehash()
window.

IOW, your in-update state might make sense, but not in the way it's done
at the moment - it's too brittle.

And the part about async tree topology modifications are bloody insane,
IMO.  I won't believe that to be feasible until I see the algorithm and
proof of correctness; preferably _before_ the actual code.


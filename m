Return-Path: <linux-fsdevel+bounces-21276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E17900D55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 23:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B5B287505
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7B1552EB;
	Fri,  7 Jun 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="istYwmeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559014D6F6
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794499; cv=none; b=AWP2Wr1KYWzNt4UQ7ydpeia1gMF5ssw0vKGT1arVvuXYNRK42wIMCrzuQn9xJIPaXhYUh65CzayMHQ9us0aZ5JeTL+XBq1mXCbS11wwP6O7PqB3xR7OLfMEfK8lgPJkbQZBUjiLG4ZW6IM6rR1cfz3BnI1paWmpBa50w8SxuA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794499; c=relaxed/simple;
	bh=XfKJc2v4uV6CSMS5DDLvI6rMGOxXNJRMLO4YY0OiGiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvRGGcZpGxT58w7K/Rg+sHWoXQZinc1UFFQ/icJwvR5TqU52B1rWyPetoKliM4ptSiWVEJK0WGz9F3UlEcUXYg9ZkYSAZUPPRxqwsJWB3ja0y/xqF89YGf9WP5J2Py4dV4pWlkxsmanXXrq9cYrnr4gEL+IPsw8lxFdhDoUDTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=istYwmeK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aAtuF7nd27M/2p7LLmgLXs48JJYP+6ww5y/wjBzN3lg=; b=istYwmeKc8PHI8XNDj+SKdbVh5
	m6KdLhC7zLsGx5HW87qQGkAz47KGpGfjAsvGJmrMnU3vck9xtDgjpojHwY6YGD6Myfgt5ulIfqCS1
	oUzGrcXkuGnX8Ab30PZ1NU6heVUruoqJEzu89wMWOkXY4BtI0sVXOj7og/jNE8tHsLfFdtN/WzVEQ
	4McPpq0UB0gX7nbPSR+4NPCJKiQdz7UO2ic5rnq4YQOd+DeJWHMnlBmdIdM9ZlBUxWVGztlCGfIcQ
	ZBpDStWqivBfnrZycfUM4RrVozhgnoGfsDzsNaST0HyDI0qZhz/yKRzpOV8eE3a7HntREWLNrlaZQ
	ioorcb5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFgoo-00E9ru-2G;
	Fri, 07 Jun 2024 21:08:14 +0000
Date: Fri, 7 Jun 2024 22:08:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...)
Message-ID: <20240607210814.GC1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607161043.GZ1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 05:10:43PM +0100, Al Viro wrote:
> On Fri, Jun 07, 2024 at 05:26:53PM +0200, Christian Brauner wrote:
> > On Fri, Jun 07, 2024 at 02:59:49AM +0100, Al Viro wrote:
> > > low-hanging fruit; that's another likely source of conflicts
> > > over the cycle and it might make a lot of sense to split;
> > > fortunately, it can be split pretty much on per-function
> > > basis - chunks are independent from each other.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > I can pick conversions from you for files where I already have changes
> > in the tree anyway or already have done conversion as part of other
> > patches.
> 
> Some notes:
> 
> 	This kind of conversions depends upon fdput(empty) being not just
> a no-op, but a no-op visible to compiler.  Representation change arranges
> for that.
> 
> 	CLASS(...) has some misfeatures or nearly C++ level of tastelessness;
> for this series I decided to try it and see how it goes, but... AFAICS in
> a lot of cases it's the wrong answer.
> 
> 	1.  Variable declarations belong in the beginning of block.
> CLASS use invites violating that; to make things worse, in-block goto
> bypassing such declaration is only caught by current clang.  Two
> examples got caught by Intel buildbot in this patch, actually - one
> in fs/select.c, another in ocfs2.

Considerably more than two, actually.  For example, this
        inode_lock(inode);
        /* Update mode */
        ovl_copyattr(inode);
        ret = file_remove_privs(file);
        if (ret)
                goto out_unlock;

        CLASS(fd_real, real)(file);
        if (fd_empty(real)) {
                ret = fd_error(real);
                goto out_unlock;
        }

        old_cred = ovl_override_creds(file_inode(file)->i_sb);
        ret = vfs_fallocate(fd_file(real), mode, offset, len);
        revert_creds(old_cred);

        /* Update size */
        ovl_file_modified(file);

out_unlock:
        inode_unlock(inode);

steps into the same problem.

Hell knows - it feels like mixing __cleanup-based stuff with anything
explicit leads to massive headache.  And I *really* hate to have
e.g. inode_unlock() hidden in __cleanup in a random subset of places.
Unlike dropping file references (if we do that a bit later, nothing
would really care), the loss of explicit control over the places where
inode lock is dropped is asking for serious trouble.

Any suggestions?  Linus, what's your opinion on the use of CLASS...
stuff?


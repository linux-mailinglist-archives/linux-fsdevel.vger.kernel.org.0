Return-Path: <linux-fsdevel+bounces-45929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3BCA7F73B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828C43AD41A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF494263C84;
	Tue,  8 Apr 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+l49Ad1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548C202996;
	Tue,  8 Apr 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099523; cv=none; b=HXjKJQPvYFYrC5rqkvJ6c663wTQ3h72U/WuxFY0vAskOlpphYElYnNUhcQqdkhSDT8HjK5n5WlLq0ZqbRt2tYpij3oZumhovgdvR3/bYIFrhXE7zSdjBeYDoGagsNSctKG3nJk2bONvMnk4XRf7AsHpbQ9XMNbuqsauxxjO3cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099523; c=relaxed/simple;
	bh=yeJ5Lab9tWLRKPloPFY4ioCGI82IURnAJ9FlA0hr9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhfesCqdW49Qk8Z0/K0nb3qGettQoZQNlCDqVtKRxyWW2pjMzcULksfsY8cuOP1N+UUJ7XKrjqi0VocvLdCDKLoPRbqX7fh7xksiPfkAhkRjztn3MENWtyooYvAZ7jBdzq1SdKaQFzyXZuuEXOeEoMYuoyMl9Di/QqjJXcbxqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+l49Ad1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47952C4CEE5;
	Tue,  8 Apr 2025 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744099522;
	bh=yeJ5Lab9tWLRKPloPFY4ioCGI82IURnAJ9FlA0hr9wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+l49Ad1DesnHBe0imd7XRlS5oJGkuoArtJdPjqMxx5/Z5K4TYwlYxmZLwHmkTGwF
	 55CUzIzfm3+9DFRghWh5teA9+udDd9zevONTnJR4lHR//NFtdiHicHTUObSpzwOQaO
	 10mtxdofsxLbdzocSjI667M3jTnBsAQPS8+iE7uQ=
Date: Tue, 8 Apr 2025 10:03:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>, cve@kernel.org
Cc: Cengiz Can <cengiz.can@canonical.com>,
	Attila Szasz <szasza.contact@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <2025040801-finalize-headlock-669d@gregkh>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-biegung-furor-e7313ca9d712@brauner>

On Mon, Apr 07, 2025 at 12:59:18PM +0200, Christian Brauner wrote:
> On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
> > On 24-03-25 11:53:51, Greg KH wrote:
> > > On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
> > > > In the meantime, can we get this fix applied?
> > > 
> > > Please work with the filesystem maintainers to do so.
> > 
> > Hello Christian, hello Alexander
> > 
> > Can you help us with this?
> > 
> > Thanks in advance!
> 
> Filesystem bugs due to corrupt images are not considered a CVE for any
> filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
> namespace. That includes delegated mounting.

Thank you for the concise summary of this.  We (i.e. the kernel CVE
team) will try to not assign CVEs going forward that can only be
triggered in this way.

> The blogpost is aware that the VFS maintainers don't accept CVEs like
> this. Yet a CVE was still filed against the upstream kernel. IOW,
> someone abused the fact that a distro chose to allow mounting arbitrary
> filesystems including orphaned ones by unprivileged user as an argument
> to gain a kernel CVE.

Yes, Canonical abused their role as a CNA and created this CVE without
going through the proper processes.  kernel.org is now in charge of this
CVE, and:

> Revoke that CVE against the upstream kernel. This is a CVE against a
> distro. There's zero reason for us to hurry with any fix.

I will go reject this now.

Note, there might be some older CVEs that we have accidentally assigned
that can only be triggered by hand-crafted filesystem images.  If anyone
wants to dig through the 5000+ different ones we have, we will be glad
to reject them as well.

thanks,

greg k-h


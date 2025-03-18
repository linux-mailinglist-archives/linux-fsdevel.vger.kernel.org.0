Return-Path: <linux-fsdevel+bounces-44285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF12A66CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B9A7AD308
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4991EF387;
	Tue, 18 Mar 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l31KXGVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13291EF39B;
	Tue, 18 Mar 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284168; cv=none; b=rSGxXjxsZwi4fbmnOYR1Q28ErIqpo+FsZxsE5B1XF2K+3ZE/9z3PYAyUCeqyKQ4x48h/B/dpqOQCo1RdHhgr+yXwCrFd9zFOKJPt2KO9WJohpVSWJBoCWtfc5uA3FVRAGP91glY0oGJNqOLAuDEuV9peKkhlUZXFleL2Yi/ueDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284168; c=relaxed/simple;
	bh=Y6RdoGCNCPbWSGXi/T72o28pM9Gq7gZPH7wZZD0d4jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbSRJut6Ob0Z/Ll3Q/vjVOCAcz0B56hO44JmwCu4xjIAJAn3Y5pLflCdAcGE5M4SQzst30x8ZK+w1TZT38kQSpFSFvubSnAx2idlwNS4N/eUVa7LHWQTQmCvZ8xtglvNnOQJq6tURmtInTMjXEvMsVxLBDs38JD+gBDLZpeOGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l31KXGVe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c+fTThbaba4IfiJ9ksjfwJ6NxRjEzbsQT04jzMLLOfA=; b=l31KXGVe4ffoSUWX/gblJAd56S
	bQLFi/OlU4vcbUYTErp3HTKhmcuA8bUnAI6LKfVcPUK4MtiOL2xOl4jsEtLNMTjyBML5xHi1fVSft
	aeFTnGVqZ0ww/OsT89TFLH5AwiH8be6uLuaSuForS/H4rDWx6U49CgaIfJKUBW8z276v6cutWn0uW
	5kSBu5BTYRCJqJx5r3HhbLKY9iI3305Xdhjk0cGmYo7q/3tL8KjFiWKTBdCFzzwEYTfAv82flDSkI
	29zu2xuTeQlGT5uTqTtFxKZnBRPAgrNXFuU/TvPtAgVey2xc8G/BUw1VflyIgHRqEo6z10eoOBVNt
	fIPoPRlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tuRhS-0000000F0ct-3ng4;
	Tue, 18 Mar 2025 07:49:23 +0000
Date: Tue, 18 Mar 2025 07:49:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ryan Lee <ryan.lee@canonical.com>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] efivarfs: fix NULL dereference on resume
Message-ID: <20250318074922.GX2023217@ZenIV>
References: <3e998bf87638a442cbc6864cdcd3d8d9e08ce3e3.camel@HansenPartnership.com>
 <20250318033738.GV2023217@ZenIV>
 <CAMj1kXHOqzvpUOMTpfQfny10B7M3WnwPYdm1jVX7saP4cy2F=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHOqzvpUOMTpfQfny10B7M3WnwPYdm1jVX7saP4cy2F=A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 18, 2025 at 08:04:59AM +0100, Ard Biesheuvel wrote:

> the latter is only needed when it is mounted to begin with, and as a
> VFS non-expert, I struggle to understand why it is a) ok and b)
> preferred to create a new mount to pass to kernel_file_open(). Could
> we add a paragraph to the commit log that explains this?

I'm not at all convinced that iterate_dir() is the right thing to use
there, but *IF* we go that way, yes, we need a reference to struct
mount.  We are not going to introduce a very special kind of struct
file, along with the arseloads of checking for that crap all over the
place - not for the sake of one weird case in one weird filesystem.

file->f_path is a valid struct path, which means that ->mnt->mnt_sb == ->dentry->d_sb
and refcount of ->mnt is positive as long as struct file exists.

Keeping a persistent internal struct mount is, of course, possible,
but it will make the damn thing impossible to rmmod, etc. - it will
remain in place until the reboot.

It might be possible to put together something like "grab a reference
to superblock and allocate a temporary struct mount refering to it"
(which is what that vfs_kern_mount() boils down to).  But I would
very much prefer to have it go over the list of children of ->s_root
manually, instead of playing silly buggers with iterate_dir().

And yes, it would require exclusion with dissolving dentry tree on
umount, for obvious reasons.  Which might be done with ->s_active
or simply by unregistering that notifier chain as the very first step
in ->kill_sb() there.


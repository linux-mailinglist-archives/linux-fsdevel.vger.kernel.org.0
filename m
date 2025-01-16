Return-Path: <linux-fsdevel+bounces-39395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE7A13838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A745C1885BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FE51DE2C1;
	Thu, 16 Jan 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7WMWJ3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557E192598
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024379; cv=none; b=FViV+HqNgVjXpnqxt30s5i++vcCoNot65noxst6HAq0OwXvvvq27eb01dli85ixNewEMbzWp9Vx8LxnuPcK/DnPx68UxPtc/VxTcbwBIzp8iTurWDZAN15+HU+EC15AsO8Ap854nhdYGjaAob1UE8GEyz011kWwiq3pLxOUMI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024379; c=relaxed/simple;
	bh=xNCqUeTOjkkz42A8NgpKowh84bSdOD64kR75mRv+k3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2qjXAhJhbF2pC1WMp5j6A3deie2QC160P+/ZEb06OXn0FxbNwJllevA35GChlD9Hb35P8Gk2mp196fuG7GxOVeRIEKE5AK00HCdlqgTofdkvnQz+cY5fQsMsmbbf5lpF49HsvHaZHq1rRS0CePkZYK/hkFWQcNBhZqXIUPjdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7WMWJ3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8905C4CED6;
	Thu, 16 Jan 2025 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737024376;
	bh=xNCqUeTOjkkz42A8NgpKowh84bSdOD64kR75mRv+k3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7WMWJ3VQV86IV1z4d+TN5spH9ZO7YrqqNMzjDdtoC4urkQZUoXHFu1msThqqXlCg
	 N3WZlWK+DszbQvZxUsGjxuP6M63TN17qHBdtf7elFG43rYgvwDo6WLHqPicplk6VDU
	 4jXKLtLYptlLmiHMbReu4LScKXFb8qDSK57kbc5q6mhqEKZOitHZBB4vSA97YCxk/x
	 rmkm6pDnt9FXJhuFh97bdbJavZNBZc9jBUcx2BOS63TvQmM3GlBfqEjSEeELGjvXSg
	 H/036/nXQ2Zd0l9Dt9993UPLNwp4xUxAFfMXQHcKBtFRvL0Xiou6UipwKat3NsfIp+
	 tQHXENNZrr7FA==
Date: Thu, 16 Jan 2025 11:46:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
References: <20250115185608.GA2223535@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115185608.GA2223535@zen.localdomain>

On Wed, Jan 15, 2025 at 10:56:08AM -0800, Boris Burkov wrote:
> Hello,
> 
> If we run the following C code:
> 
> unshare(CLONE_NEWNS);
> int fd = open("/dev/loop0", O_RDONLY)
> unshare(CLONE_NEWNS);
> 
> Then after the second unshare, the mount hierarchy created by the first
> unshare is fully dereferenced and gets torn down, leaving the file
> pointed to by fd with a broken dentry.
> 
> Specifically, subsequent calls to d_path on its path resolve to
> "/loop0". I was able to confirm this with drgn, and it has caused an
> unexpected failure in mkosi/systemd-repart attempting to mount a btrfs
> filesystem through such an fd, since btrfs uses d_path to resolve the
> source device file path fully.
> 
> I confirmed that this is definitely due to the first unshare mount
> namespace going away by:
> 1. printks/bpftrace the copy_root path in the kernel
> 2. rewriting my test program to fork after the first unshare to keep
> that namespace referenced. In this case, the fd is not broken after the
> second unshare.
> 
> 
> My question is:
> Is this expected behavior with respect to mount reference counts and
> namespace teardown?
> 
> If I mount a filesystem and have a running program with an open file
> descriptor in that filesystem, I would expect unmounting that filesystem
> to fail with EBUSY, so it stands to reason that the automatic unmount
> that happens from tearing down the mount namespace of the first unshare
> should respect similar semantics and either return EBUSY or at least
> have the lazy umount behavior and not wreck the still referenced mount
> objects.
> 
> If this behavior seems like a bug to people better versed in the
> expected behavior of namespaces, I would be happy to work on a fix.

It's expected as Al already said. And is_good_dev_path()
looks pretty hacky...

Wouldn't something like:

bool is_devtmpfs(const struct super_block *sb)
{
        return sb->s_type == &dev_fs_type;
}

and then:

        ret = kern_path(dev_path, 0, &path);
        if (ret)
                goto out;

	if (is_devtmpfs(path->mnt->mnt_sb))
		// something something

be enough? Or do you specifically need to care where devtmpfs is
mounted? The current check means that anything that mounts devtmpfs
somewhere other than /dev would fail that check.

Of course, any standard Linux distribution will mount devtmpfs at /dev
so it probably won't matter in practice. And contains may make /dev a
tmpfs mount and bind-mount device nodes in from the host's devtmpfs so
that would work too with this check.

In other words, I don't get why the /dev prefix check gets you anything?
If you just verify that the device node is located on devtmpfs you
should be good.


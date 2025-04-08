Return-Path: <linux-fsdevel+bounces-45977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530DA801ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A691895321
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A20216E30;
	Tue,  8 Apr 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY9O8gY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547C19AD5C
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112372; cv=none; b=iZCJM+zSXllayayaO1Yl1PVUHOv6Lu+nJxjAAmq6UYJShHStoOOMZFNSZ4NvxgMygg3heAXggTAoEWgEiA8mYKiulhvDtkmiPCdhs3xG7R8wtTY2nY+NBQFv/YHxGKYuw6Zkh/fuiVkwxYMgKUwrDOVhfJVr6gIf7UirBu5DDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112372; c=relaxed/simple;
	bh=aYYb2CpUcY5DHp8etznxi9zPvdsWQSK34XxGKHq6K3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wek4rvVsaTgoHNZCiIsguL9d7oZP5lMhSL1hbNls5DTtW7HNxzrHMXaPrsnaQNKV8f1RNflK1K/r7m8luTEgbrKFl6CGWx0yAWQUN8ZXkCQalC56yql5KAldMbOVnM6yYt0VTCpr2dcuWkJHzBd93PeLTKpjbqAvUn4Abxu6zGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY9O8gY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C1EC4CEE5;
	Tue,  8 Apr 2025 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744112371;
	bh=aYYb2CpUcY5DHp8etznxi9zPvdsWQSK34XxGKHq6K3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SY9O8gY3AeGJ0h5vxRdYPv4eaOfS3/0vl8vs0zTok/Ac2lfAuXSiVLrBPGZiUkfB0
	 Av1Y7MpOGctnciCDPwkuSrhjclWbs7RWyvLTXQhZ614kKWE59jypa/vZffjKVZ18BC
	 vbEfUeAUbpM7EnVMSOD/5DqWAHKd1SvhtUap0aeJ5xKyI9JUimrO+xKVC/a2CeTz0D
	 bFZ5Tg95i515GCXPmU5bL9/ZlsPbH7x8yNQnVqeh0j9V19RSqpFlhdaUKFOvaGLao5
	 AN0OFSyMcjmzgGOJqHKVqN6D6A8ThCdlsrHQHdFmyrT6pP/uo63bWIvK+6+87xfyp1
	 RRwL2HlSOkB3g==
Date: Tue, 8 Apr 2025 13:39:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, mkoutny@suse.cz
Subject: Re: d_path() results in presence of detached mounts
Message-ID: <20250408-nachverfolgen-deftig-19199bfc1801@brauner>
References: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>
 <20250408-ungebeten-auskommen-5a2aaab8e23d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408-ungebeten-auskommen-5a2aaab8e23d@brauner>

On Tue, Apr 08, 2025 at 10:55:07AM +0200, Christian Brauner wrote:
> On Mon, Apr 07, 2025 at 06:00:07PM +0200, Jan Kara wrote:
> > Hello!
> > 
> > Recently I've got a question from a user about the following:
> > 
> > # unshare --mount swapon /dev/sda3
> > # cat /proc/swaps
> > Filename                                Type            Size            Used            Priority
> > /sda3                                   partition       2098152         0               -2
> > 
> > Now everything works as expected here AFAICS. When namespace gets created
> > /dev mount is cloned into it. When swapon exits, the namespace is
> > destroyed and /dev mount clone is detached (no parent, namespace NULL).

That's not the issue you're seeing here though

> > Hence when d_path() crawls the path it stops at the mountpoint root and
> > exits. There's not much we can do about this but when discussing the
> > situation internally, Michal proposed that d_path() could append something
> > like "(detached)" to the path string - similarly to "(deleted)". That could
> > somewhat reduce the confusion about such paths? What do people think about
> > this?
> 
> You can get into this situation in plenty of other ways. For example by
> using detached mount via open_tree(OPEN_TREE_CLONE) as layers in
> overlayfs. Or simply:
> 
>         int fd;
>         char dpath[PATH_MAX];
> 
>         fd = open_tree(-EBADF, "/var/lib/fwupd", OPEN_TREE_CLONE);
>         dup2(fd, 500);
>         close(fd);
>         readlink("/proc/self/fd/500", dpath, sizeof(dpath));
>         printf("dpath = %s\n", dpath);
> 
> Showing "(detached)" will be ambiguous just like "(deleted)" is. If that
> doesn't matter and it's clearly documented then it's probably fine. But
> note that this will also affect /proc/<pid>/fd/ as can be seen from the
> above example.

The other downside is that it will still be quite opaque because the
user will have to be aware of the concept of a detached mount. So it's
mostly useful for administrators tbh.

In general, I think it needs to be made clear to userspace that paths
shown in such tables are open()-able in the best case and decorative or
even misleading in the worst case.

The swap case is particularly ugly because it's a kernel-internal open
so in essence you might be located in a namespace where you can't even
even possibly reach that path.

In the

	unshare --mount swapon /dev/sda3
	exit

example you're lucky. If you're on the host then you can reasonably
guess and go "Oh, this is probably a fscked path we could look at /dev"
and parse through /dev/ to find "sda3" but that's a risky game even in
that case.

If you're in a container however that /proc/swaps output is completely
useless as there surely (unless you have a very broken container) won't
be a devtmpfs mount in there at all so that device isn't reachable at
all. Same for files.

In short, that output is purely diagnostic at best.


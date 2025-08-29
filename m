Return-Path: <linux-fsdevel+bounces-59645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708EB3B9AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D9818879D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF53128BA;
	Fri, 29 Aug 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzQqbAeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53E28369A;
	Fri, 29 Aug 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465654; cv=none; b=feYjCRCV87pGqLjbHSXn1broc7+pFzxK7cu/NynbQKPy50W/mY7vkuhTTtJNwU1w9QHaTeeFnnaDbcD9lzIG443Wb54A/n6ZrzXstmPR9mYQJqqSFeOKDfloQg4+hY3zdkTs/x/b2TsrJM+ImndCurjOxML5EahkaZMrhdla2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465654; c=relaxed/simple;
	bh=tdiHDNhAuabJGWlbSj7OkMRwE5xqpQHriiYisVKS9UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spfiGLbL7vlz062/Blljyv8quEe94N0XaZWn/i5KUSjP4G3Vr8UJ5/hQF/lJgG+lt0dgxukAebda6GJ/nYzkVucjGt+JxM9L/hM/z9FPfrC6iGyTv/BPSBuZ1dqmS3YOdxxnhdyOws+/TV8qVdlQzZmbZssyap/5OPN8IHXU0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzQqbAeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004EBC4CEF4;
	Fri, 29 Aug 2025 11:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756465654;
	bh=tdiHDNhAuabJGWlbSj7OkMRwE5xqpQHriiYisVKS9UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzQqbAeE4CcR/8lZGwBIYHuqOwfgPiUQ+XOvT4313uPRvHL1adlwBXbxe6FGSSp3d
	 um75FS6MbON1SsZAjR5Bn+USa9sD9r22rhVW1tHO3zby0qCz34Shc15uOsQ+bYJgqP
	 dxh/oss/y0lopV/gN/CGiQjAvYe0G1iEvLGRYUl+iLk/T0/CEYxOHhVZZOrtzf9+KT
	 N54flhMrCzgllaf6ZruJEXfSL6d8/jT27FvNxDvm8zHzEPcIVYRbx0CtXEXyLSJVPM
	 pLfwOlO3/9V8nczDNjvph+MPyZVbtqhBVpZ8DLrBVWhn5fcbgmGejFauLbNLoIh3FB
	 2At9wWUDpw6xw==
Date: Fri, 29 Aug 2025 13:07:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250829-therapieren-datteln-13c31741c856@brauner>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>
 <20250829-diskette-landbrot-aa01bc844435@brauner>
 <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>

On Fri, Aug 29, 2025 at 01:17:16PM +0300, Alexander Monakov wrote:
> 
> On Fri, 29 Aug 2025, Christian Brauner wrote:
> 
> > On Fri, Aug 29, 2025 at 10:21:35AM +0300, Alexander Monakov wrote:
> > > 
> > > On Wed, 27 Aug 2025, Alexander Monakov wrote:
> > > 
> > > > Dear fs hackers,
> > > > 
> > > > I suspect there's an unfortunate race window in __fput where file locks are
> > > > dropped (locks_remove_file) prior to decreasing writer refcount
> > > > (put_file_access). If I'm not mistaken, this window is observable and it
> > > > breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> > > > in more detail below.
> > > 
> > > The race in __fput is a problem irrespective of how the testcase triggers it,
> > > right? It's just showing a real-world scenario. But the issue can be
> > > demonstrated without a multithreaded fork: imagine one process placing an
> > > exclusive lock on a file and writing to it, another process waiting on that
> > > lock and immediately execve'ing when the lock is released.
> > > 
> > > Can put_file_access be moved prior to locks_remove_file in __fput?
> > 
> > Even if we fix this there's no guarantee that the kernel will give that
> > letting the close() of a writably opened file race against a concurrent
> > exec of the same file will not result in EBUSY in some arcane way
> > currently or in the future.
> 
> Forget Go and execve. Take the two-process scenario from my last email.
> The program waiting on flock shouldn't be able to observe elevated
> refcounts on the file after the lock is released. It matters not only
> for execve, but also for unmounting the underlying filesystem, right?

What? No. How?: with details, please.

> And maybe other things too. So why not fix the ordering issue in __fput
> and if there are other bugs breaking valid uses of flock, fix them too?

For locks_remove_file() to be movable after put_file_access() we'd have
to prove that no filesystem implementing f_op->lock() doesn't rely on
f_op->release() to not have run. It is fundamentally backwards to have
run f_ops after f_op->release() ran.

Random quick look into 9pfs:

static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
{
	struct p9_flock flock;
	struct p9_fid *fid;
	uint8_t status = P9_LOCK_ERROR;
	int res = 0;
	struct v9fs_session_info *v9ses;

	fid = filp->private_data;
	BUG_ON(fid == NULL);

This relies on filp->private_data to be valid which it wouldn't be
anymore after f_op->release().

Moving put_file_access() before f_op->release() is also wrong and would
require to prove that no filesystem depends on file access not having
changed before f_op->release() has run. So no, not a trivial thing to
move around.

And you are explicitly advertising this as a fix to the go execve
problem; both in the bugtracker and here. And it's simply not a good
solution. The problem remains exec's deny-write mechanism. But hooking
into file locks to serialize exec against writable openers isn't a good
solution. It surely is creative though.

We can give userspace a simple way to sidestep this problem though as I
tried to show.


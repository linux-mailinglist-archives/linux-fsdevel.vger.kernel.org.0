Return-Path: <linux-fsdevel+bounces-71261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3ECBB604
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287D1300EE62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5329BDB1;
	Sun, 14 Dec 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WE7qSunw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661ED1A3160;
	Sun, 14 Dec 2025 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765679236; cv=none; b=QTw6dnlnH2Z1UnUyHK7Mc2XoU/hCIXhXL9dBDsF5PIHhujqHSdFCrWnE70Rx7/mq9VmxgRmZVjdNBywCiFJfHq4NIM2fPxxcvaWMh+zMqrK0cMvJCuZ3h+QHV1hUDi9Kdg7fyP277Lb9zDLYQhghi8RHOTGJUE/cLYhpUQK+o+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765679236; c=relaxed/simple;
	bh=OpAWcmEgxWUrV4zOZQXGCRQx7KO2B8ir0OyL8PgjPhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unp7CQsLDQK7x4c1emkE8Ox0qPLmoPJKdz5+B+AbFB96y2O9D9wIl1vKBpExwwuaMNDtKpNt7VTv2i5szK1wkF7kYFjgEVLYppP4cSslYYhKTqvuCIix+SaPZzLbqZBLg9yDHZ8tmg11yjKuoCXw+K5qjwi4PcIJfbs7r9/7TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WE7qSunw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qKoXM0Oo1LxjniI2xLos9hOKVQHq6LwZ4b9t7IxOwYU=; b=WE7qSunwhUjblJ7OK7ITmOA1kx
	/Fish8IppoqsRnVCiOJQ4kQIyDbDvJNT+eTZd5lwoUxBXE4uPvPPi7oT3Q24omKEJ6AP0pLVJFcpH
	LqEiHxAa6+IlNwiyr3vLGgYm3N93XCq5yXLTTszRmeHpFR1EiBVTIAJN2eV6ki4h8IeWALsiCxj0S
	F6g28z9vFQNtjVOtozQYL076Qo02vPp2BIP9BuXoKPRdAOEg+nAi3EpCaGfDA184gSyRpTfsxJv5T
	jAnnnyTEX7hvHPsA34s8hZzd7odAYrhMzeAMFiqnHzxrEEQm6J5+8TCMTP/TSxHlRVPhoTfi86Kwo
	DBa/Y+RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUbpp-00000001GNV-0GiX;
	Sun, 14 Dec 2025 02:27:45 +0000
Date: Sun, 14 Dec 2025 02:27:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: Re: [PATCH] adfs: fix memory leak in sb->s_fs_info
Message-ID: <20251214022745.GK1712166@ZenIV>
References: <20251213233621.151496-2-eraykrdg1@gmail.com>
 <20251214013249.GI1712166@ZenIV>
 <20251214020212.GJ1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214020212.GJ1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 14, 2025 at 02:02:12AM +0000, Al Viro wrote:

> IOW, there's our double-free.  For extra fun, it's not just kfree() + kfree(),
> it's kfree_rcu() + kfree().

[sorry, accidentally sent halfway through writing a reply; continued below]

So after successful mount, it gets freed (RCU-delayed) from ->kill_sb() called
at fs shutdown.

On adfs_fill_super() failure (hit #2) it is freed on failure exit - with non-delayed
kfree().

In case we never got to superblock allocation, the thing gets freed by adfs_free_fc()
(also non-delayed).

The gap is between a successful call of sget_fc() and call of adfs_fill_super()
(in get_tree_bdev(), which is where adfs_fill_super() is passed as a callback).
If setup_bdev_super() fails, we will
	* transfer it from fs_context to super_block, so the fs_context destruction
won't have anything to free
	* won't free it in never-called adfs_fill_super()
	* won't free it in ->kill_sb(), since ->s_root remains NULL and ->put_super()
is never called.

A leak is real, IOW.

Getting ->kill_sb() to do freeing unconditionally would cover the gap.  However,
to do that, we need to _move_ freeing (RCU-delayed) from adfs_put_super() to
adfs_kill_sb(), not just add kfree() in the latter.

What's more, that allows to simplify adfs_fill_super() failure exit: we can leave
freeing asb (and clearing ->s_fs_info, of course) to ->kill_sb() - the latter is
called on any superblock destruction, including that after failing fill_super()
callback.  Almost the first thing done by deactivate_locked_super() called in
that case is
                fs->kill_sb(s);

So if we go with "have it freed in ->kill_sb()" approach, the solution would be

1) adfs_kill_sb() calling kfree_rcu(asb, rcu) instead of kfree(asb)
2) call of kfree_rcu() removed from adfs_put_super()
3) all goto error; in adfs_fill_super() becoming return ret; (and error:
getting removed, that is)


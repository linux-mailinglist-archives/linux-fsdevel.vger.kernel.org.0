Return-Path: <linux-fsdevel+bounces-48733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3CAB3408
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D73A8C2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306C25F7AE;
	Mon, 12 May 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urDd84rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E586256C85;
	Mon, 12 May 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043540; cv=none; b=gN4vKCXVEgQUeBP1ydBqWkhVy5kqhZOl4NG79fTz0OzdN+bcbJ4B0P6NpAtwsH6uRJQ5kQ6KFSG8/xgLFK11lcOyql5cy5mdRSHzA9+nIXU7jiQVWm/TANTQ1+044AZW7oQuY+QqZkwsV+AWo2HQROZp1y1U+M5YwwPzwmjCBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043540; c=relaxed/simple;
	bh=UsAP5U6i/JZ+e0RZb/59AdOFAkskPO65BJbs+hpWXlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDDJrc2iqVV/uXHQTQp917/b0NMjOTSARi2ZVw9Mluj8Y3ZQNgqF1KQhQjgVgIZNJFMl8aeYYQOjWMMhQtd4m/x/w9MHZiYgsMzCsSMo0p6+VFBunwoBqm6nNGMFJLuUtvsTpghCab82tvm2xnuTZMLkJY+nSk96v6hK+9BOzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urDd84rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55E7C4CEE7;
	Mon, 12 May 2025 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747043538;
	bh=UsAP5U6i/JZ+e0RZb/59AdOFAkskPO65BJbs+hpWXlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urDd84rhNLx2aspoq4TzDyklNIY4+L0k+2CUr8B1yBEh5IMAHpHTjV8b5f2qBzPV6
	 U1v7kwXqW7zfeKSbNIKtOUjlpcarrFKJTShN4aTl9wcDgd4PQ+iUTyBWtHFUpYfqaz
	 zoYGMAOzGL4GPGjllx4SegQYR05O400D7EopqIdV1tezQVnyzcWTtahJRZ28LMtkWI
	 dUuTqQ5sDecBPPmvz8YbjaAxnSMBnFqAX9dJ9n58yHbw1TSXxgYoRYob85Ep48AWrI
	 VRltdUvZtvDiVY+LVQxtnH7hhyVA6DBLjcsAelDv9+glS71lcoDCSBNJK1frl/sz1O
	 8pLRz3h0swjGA==
Date: Mon, 12 May 2025 11:52:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>, jack@suse.cz
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: make several inode lock operations killable
Message-ID: <20250512-unrat-kapital-2122d3777c5d@brauner>
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
 <20250429094644.3501450-2-max.kellermann@ionos.com>
 <20250429-anpassen-exkremente-98686d53a021@brauner>
 <CAKPOu+8H11mcMEn5gQYcJs5BhTt8J8Cypz73Vdp_tTHZRXgOKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8H11mcMEn5gQYcJs5BhTt8J8Cypz73Vdp_tTHZRXgOKg@mail.gmail.com>

Sorry, coming back to this now. I lost sight of this patch.

On Tue, Apr 29, 2025 at 01:28:49PM +0200, Max Kellermann wrote:
> On Tue, Apr 29, 2025 at 1:12 PM Christian Brauner <brauner@kernel.org> wrote:
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
> > >       struct inode *inode = file_inode(file);
> > >       loff_t retval;
> > >
> > > -     inode_lock(inode);
> > > +     retval = inode_lock_killable(inode);
> >
> > That change doesn't seem so obviously fine to me.
> 
> Why do you think so? And how is this different than the other two.

chown_common() and chmod_common() are very close to the syscall boundary
so it's very unlikely that we run into weird issues apart from userspace
regression when they suddenly fail a change for new unexpected reasons.

But just look at default_llseek():

    > git grep default_llseek | wc -l
    461

That is a lot of stuff and it's not immediately clear how deeply or
nested they are called. For example from overlayfs in stacked
callchains. Who knows what strange assumptions some of the callers have
including the possible return values from that helper.

> 
> > Either way I'd like to see this split in three patches and some
> > reasoning why it's safe and some justification why it's wanted...
> 
> Sure I can split this patch, but before I spend the time, I'd like us
> first to agree that the patch is useful.

This is difficult to answer. Yes, on the face of it it seems useful to
be able to kill various operations that sleep on inode lock but who
knows what implicit guarantees/expectations we're going to break if we
do it. Maybe @Jan has some thoughts here as well.

> I wrote this while debugging lots of netfs/nfs/ceph bugs; even without
> these bugs, I/O operations on netfs can take a looong time (if the
> server is slow) and the inode is locked during the whole operation.
> That can cause lots of other processes to go stuck, and my patch
> allows these operations to be canceled. Without this, the processes
> not only remain stuck until the inode is unlocked, but all stuck
> processes have to finish all their I/O before anything can continue.
> I'd like to be able to "kill -9" stuck processes.
> 
> A similar NFS-specific patch I wrote was merged last year:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=38a125b31504f91bf6fdd3cfc3a3e9a721e6c97a
> The same patch for Ceph was never merged (but not explicitly
> rejected): https://lore.kernel.org/lkml/20241206165014.165614-1-max.kellermann@ionos.com/
> Prior to my work, several NFS operations were already killable.


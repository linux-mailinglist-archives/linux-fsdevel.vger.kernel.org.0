Return-Path: <linux-fsdevel+bounces-67130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5BC35EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFDBC4F43EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD515325482;
	Wed,  5 Nov 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShpmD5CE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22268227B95;
	Wed,  5 Nov 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350376; cv=none; b=DMP36Pur5Bma9I2sDiP8D3RJlw6jRzzb2Mt+Iy+TXQ98B20BBzCtSvWLE6dJ4vX4TNl0vhztyTzWHPYIboqu0MqYOZsYrZfvaXDQK6+D19Y+HCUyqGLkor0so+1zW48T4BLdaeRXn0YPAsyARrhBsg6L8D9+7D3TVq23YAOT90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350376; c=relaxed/simple;
	bh=PBw6f127nni3oALBZyW0JgdvwP5qSqzJy9SAmndAriA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIQnFZnUxzMxd62Lx7WfEzL8sUHdUGsgGZKfJttTy0tWoFbj130IvXA7HFj4EClzABkJ7o+uYsDpbmVtnGhH3nVL7MXg6VX44mK7a/xeUt/ff/s2Pbryp7bO2zCZDfhRYqFHbEycWoVll7l+SpvuGzRLbM1uU0uxs3TOAtv7ZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShpmD5CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88442C4CEF8;
	Wed,  5 Nov 2025 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762350375;
	bh=PBw6f127nni3oALBZyW0JgdvwP5qSqzJy9SAmndAriA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShpmD5CEr+JOX/hdyLmwbKn+7N/84QMIjLE9j2cZcrRvpVVQ75tjvns2y5AtNRjNB
	 Yz/cddtecY9g6c5niROEmlZIGG5XZUkdnkP1ukuBnc6gReYjrQWthxBdx6AWzSPCto
	 H5T2MJQ6JwDB5soUuJR37OivkZPbAKj+jm3MbBvvRUCLje5nBaF8qyof8/avmrOrQo
	 AetMggcJiBTqXIIqRYQO2peEzYuk6WbKzeJQmuHBsuyC0xrt8ateYNVpRjsDJ2WscG
	 uhaFUjmftREcVGApZjqCE58fnFSyfg3U6HCIwJGFbq7P1TvBbf4A89/uShbWcEdej8
	 m/GMvmV69qEFQ==
Date: Wed, 5 Nov 2025 14:46:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, 
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251105-ausfiel-klopapier-599213591ad2@brauner>
References: <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
 <305ff01c159993d8124ae3125f7dacf6b61fa933.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <305ff01c159993d8124ae3125f7dacf6b61fa933.camel@HansenPartnership.com>

On Wed, Nov 05, 2025 at 08:33:10AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 14:16 +0100, Christian Brauner wrote:
> > On Wed, Nov 05, 2025 at 08:09:03AM -0500, James Bottomley wrote:
> > > On Wed, 2025-11-05 at 12:47 +0100, Christian Brauner wrote:
> [...]
> > > > And suspend/resume works just fine with freeze/thaw. See commit
> > > > eacfbf74196f ("power: freeze filesystems during suspend/resume")
> > > > which implements exactly that.
> > > > 
> > > > The reason this didn't work for you is very likely:
> > > > 
> > > > cat /sys/power/freeze_filesystems
> > > > 0
> > > > 
> > > > which you must set to 1.
> > > 
> > > Actually, no, that's not correct.  The efivarfs freeze/thaw logic
> > > must run unconditionally regardless of this setting to fix the
> > > systemd bug, so all the variable resyncing is done in the thaw
> > > call, which isn't conditioned on the above (or at least it
> > > shouldn't be).
> > 
> > It is conditioned on the above currently but we can certainly fix it
> > easily to not be.
> 
> It still seems to be unconditional in upstream 6.18-rc4
> kernel/power/hibernate.c with only freeze being conditioned on the

I'm honestly not sure how efivarfs would be frozen if
filesystems_freeze() isn't called... Maybe I missed that memo though.
In any case I just sent you...

> setting of the filesystem_freeze variable but I haven't checked -next.
> 
> However, if there's anything in the works to change that we would need
> an exception for efivarfs, please ... we can't have a bug fix
> conditioned on a user setting.

... a patch in another mail.

Sorry in case I misunderstood that you _always_ wanted that sync
regardless of userspace enabling it.


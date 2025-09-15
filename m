Return-Path: <linux-fsdevel+bounces-61419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C30B57EB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35DA1A25491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B631D722;
	Mon, 15 Sep 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+bqU/Do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CB202F70;
	Mon, 15 Sep 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945787; cv=none; b=qMS2iFHmyEo54WgLOoi7fOpw7aASyDNOxSn3If4+dSOv1zhTa89/EOgHTBL3vVgqL6b0Vpzqxf6SRhzL4wAkUUg77dsjkgcQeku5N0TkpLuTaYG4PeDLu72kM6066DaWbIBauuQ1UceFHT5peMbnxa8xk2zAOxlq9Yvb70y/VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945787; c=relaxed/simple;
	bh=375vrJnuhArZHx8LwQ+Xj/EZHelElcdhjqklqPfxGQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4ke+CvloIFMZP/XQRngHvZUqsvdfpq4kBn8W38FCKzFNU8qOKSXH9tOdZbX38Rs490YOnMkEeUQpCrPM5vFZsct0Uq6oRFkCOc+8Zvu20JdPl6zpziwpUiVChGaeGpWSZUCfpPNBJPMFDavUT9JRC1+Ae2p8Qw7ALoBm2exLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+bqU/Do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33626C4CEF1;
	Mon, 15 Sep 2025 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945786;
	bh=375vrJnuhArZHx8LwQ+Xj/EZHelElcdhjqklqPfxGQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+bqU/DovpD+6zwqc3EBHNvup8SLG0XJY5F/PxifROMh/B3w4z8HmOU73Dnu66g4L
	 /db6k93F+MsKAx9Icdya6yZjTvsNEIGK9Dn+xllzQiQmTk+KwCCVxPcb/Gfe2YEHz8
	 ellg9+Gae13XCGjMjayrAKkZ5XhOjMEREhmTw+xO3zuOCnkZIFjRi1j+YYWqbSTo7F
	 Mi8b4tP+CFiWWmx7kdR2DA+fXyDjqBxb++E62g8YhZRNqNDlxUR5KYHctkB9L1gIPY
	 AHCLEt2/v4WSMIEpRL60Lg2twaqR5yuDp+L5KbIag9PpLvflan6c3YQoMujpIuSGdx
	 3JIwaupI464ig==
Date: Mon, 15 Sep 2025 16:16:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/4] fs: hide ->i_state handling behind accessors
Message-ID: <20250915-geowissenschaften-euphorie-3413b3f9fedd@brauner>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-3-mjguzik@gmail.com>
 <20250915-erstflug-kassieren-37e5b3f5b998@brauner>
 <CAGudoHG7uPDFH9K9sjnEZxZ_DtXC-ZqSkwzCJUmw1yKAzEA+dQ@mail.gmail.com>
 <20250915-tricksen-militant-406d4cb8ebda@brauner>
 <CAGudoHETnk1NJe_7TAsweokKia2xtKH0bLn-V7+hcE1voiqrhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHETnk1NJe_7TAsweokKia2xtKH0bLn-V7+hcE1voiqrhw@mail.gmail.com>

On Mon, Sep 15, 2025 at 03:48:29PM +0200, Mateusz Guzik wrote:
> On Mon, Sep 15, 2025 at 3:41 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Sep 15, 2025 at 03:27:16PM +0200, Mateusz Guzik wrote:
> > > On Mon, Sep 15, 2025 at 2:41 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 11, 2025 at 06:55:55AM +0200, Mateusz Guzik wrote:
> > > > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > > > ---
> > > >
> > > > I would do:
> > > >
> > > > inode_state()
> > > > inode_state_raw()
> > > >
> > > > Similar to
> > > >
> > > > rcu_derefence()
> > > > rcu_dereference_raw()
> > > >
> > >
> > > I don't follow how to fit this in here.
> > >
> > > Here is the complete list:
> > > inode_state_read
> > > inode_state_read_unstable
> > >
> > > first is a plain read + lockdep assert, second is a READ_ONCE
> > >
> > > inode_state_add
> > > inode_state_add_unchecked
> > > inode_state_del
> > > inode_state_del_unchecked
> > > inode_state_set_unchecked
> > >
> > > Routine with _unchecked forego asserts, otherwise the op checks lockdep.
> > >
> > > I guess _unchecked could be _raw, but I don't see how to fit this into
> > > the read thing.
> >
> > _raw() is adapted from rcu which is why I'm very familiar with what it
> > means: rcu_dereference() performs checks and rcu_dereference_raw()
> > doesn't. It's just a naming convention that we already have and are
> > accustomed to.
> >
> > >
> > > Can you just spell out the names you want for all of these?
> >
> > just use _raw() imho
> >
> 
> For these no problem:
> inode_state_add
> inode_state_add_raw
> inode_state_del
> inode_state_del_raw
> inode_state_set_raw
> 
> But for the read side:
> inode_state_read
> inode_state_read_unstable
> 
> The _unstable thing makes sure to prevent surprise re-reads
> specifically because the lock is not expected to be held.
> Giving it the _raw suffix would suggest it is plain inode_state_read
> without lockdep, which is imo misleading.
> 
> But I'm not going to die on this hill.

Ok.


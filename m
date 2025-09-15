Return-Path: <linux-fsdevel+bounces-61402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48184B57DA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224C63ADAB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2B31D75F;
	Mon, 15 Sep 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTVCKsBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C731986F;
	Mon, 15 Sep 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943667; cv=none; b=e7OK11f+Hdlfv1bT9i8QLJNMfrKrcxemYBwTNNMvSj2cMYm+CaCBF0V6nxK+OCaumzenuClUXspYFcMvrL7dSLEHglWZrZM9DDzYjCLGOhWAD9MWskhcLNC1ZPaW4m0pKLvlzbbzlfWT2YeibeL9gUNrKdr4Ek9sZcpxvjNu80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943667; c=relaxed/simple;
	bh=VDLORfLKka5X/8PhdR6E7ilqkJcXYuBbGf75wpi+r+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI2eWZK/qzMHa4qqGZ0fQs0Bb3wWnEPA78yQFJ3LRuWAS8Z4Y4AaZF31zvPbEC7pBfMErTXHgHcnHnqP1WKQ4mmBsqgJEXCg4i7VwZJvD3U/7KVUNOBQpcZgblKj946GxaZ572ApXu1iv6ZZk3iJ8/WC3+14U7SMJCM/X9ged1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTVCKsBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA215C4CEF5;
	Mon, 15 Sep 2025 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943667;
	bh=VDLORfLKka5X/8PhdR6E7ilqkJcXYuBbGf75wpi+r+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTVCKsBSCbnc2DScS5sG9dC7zfwep0s3pxzrPi3qgLq/idFr0YOlHS+XFqsVdjK9r
	 lpc1mHs571V8SRqJTAnfaN1D1X+CbboBKQXBXHamDkBTIjj5tz8bJQELVflMbgehzf
	 a9raZrsOaOi7Wc5cA9TD/PROoxV1WBDXhYPgayF85sMbGt1vwMOACrahqRCoVl6Lk7
	 ypgPSNqZRx5BYBe2bYMKplLtCXzGAYX6L0mfS1s0P0IeG9FtgH0QjkNVkLpFB2+o43
	 zlulvGNMM2+LVDMEDpatNlUtx06Ryq4VoVnO8OU4HQScVHJgJ5Z0BlTMU6LvUiIqHe
	 nSTJ13a40aN3g==
Date: Mon, 15 Sep 2025 15:41:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/4] fs: hide ->i_state handling behind accessors
Message-ID: <20250915-tricksen-militant-406d4cb8ebda@brauner>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-3-mjguzik@gmail.com>
 <20250915-erstflug-kassieren-37e5b3f5b998@brauner>
 <CAGudoHG7uPDFH9K9sjnEZxZ_DtXC-ZqSkwzCJUmw1yKAzEA+dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHG7uPDFH9K9sjnEZxZ_DtXC-ZqSkwzCJUmw1yKAzEA+dQ@mail.gmail.com>

On Mon, Sep 15, 2025 at 03:27:16PM +0200, Mateusz Guzik wrote:
> On Mon, Sep 15, 2025 at 2:41 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Sep 11, 2025 at 06:55:55AM +0200, Mateusz Guzik wrote:
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> >
> > I would do:
> >
> > inode_state()
> > inode_state_raw()
> >
> > Similar to
> >
> > rcu_derefence()
> > rcu_dereference_raw()
> >
> 
> I don't follow how to fit this in here.
> 
> Here is the complete list:
> inode_state_read
> inode_state_read_unstable
> 
> first is a plain read + lockdep assert, second is a READ_ONCE
> 
> inode_state_add
> inode_state_add_unchecked
> inode_state_del
> inode_state_del_unchecked
> inode_state_set_unchecked
> 
> Routine with _unchecked forego asserts, otherwise the op checks lockdep.
> 
> I guess _unchecked could be _raw, but I don't see how to fit this into
> the read thing.

_raw() is adapted from rcu which is why I'm very familiar with what it
means: rcu_dereference() performs checks and rcu_dereference_raw()
doesn't. It's just a naming convention that we already have and are
accustomed to.

> 
> Can you just spell out the names you want for all of these?

just use _raw() imho

> 
> > But you need some actual commit messages etc...
> >
> 
> Ye and I need to runtime test at least with xfs and btrfs.

Something I plan to do soon is more automated testing as soon as patch
series are pulled into one of the VFS trees. And by that I mean visible
to the author of the series. It'll be a while though unless we get
manpower for that.


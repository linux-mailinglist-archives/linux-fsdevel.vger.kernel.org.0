Return-Path: <linux-fsdevel+bounces-24238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891993C074
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 12:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0F1C219B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFE1991A7;
	Thu, 25 Jul 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDAK1yrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83D196DA2;
	Thu, 25 Jul 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904754; cv=none; b=uZ/RxuKlPTrPcUjZuOi4M+x50FMZJ0e2Tia2c3qN5St+dOG6D/4/KMcJPlxTxjw2dZFlcnSSsMjFSgHJsDLQm9tTKeICwUpbNY6TYvDuAKbj4S5JbdIAuXoendQqxkAsqqNcFwQ3EMbdzQLIkdVesvg/2dKZRM47ETzDoLsPQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904754; c=relaxed/simple;
	bh=orI0y/Mhi6lniFE6Cm8wx3n7KGGIG+Ptki0lBsAGo7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZUe+iyZkehClW7X6gurXLYbGIImz8G6LP1skceLkDdsTWzrf6cJo9NDEBZRQ8Ftj2VYfBj/Pz5Ik2zZLlehdB+vhbWTFHgxjVMgvDJGSYvmpAFzmImh5OVcd0E5w/1M9m91l1Pb5Ny7BAsJb1gjIKP2bfjjywsIHxUmw1XiE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDAK1yrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A42C32786;
	Thu, 25 Jul 2024 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721904754;
	bh=orI0y/Mhi6lniFE6Cm8wx3n7KGGIG+Ptki0lBsAGo7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDAK1yrGcI7P9621NOblM06XqR+5bPdaBprhpbKXsOTiTasppP37INvd9f44zTz0w
	 xY3apxLo5rUjb78IsAqsHtqbzN/hhlFtGE3ULNo5TuNTvreG/bGbm1319pvGrLRZCs
	 8/rfb4slxOZoc+xf9tzVHHM8mHlmMLFjuQN4E8DWCBL95XuQ/8KRX2AOPyIYNDuNnh
	 VKcWol3GMuqbixYrJQ7FH/OzDT/BbZQ5axVlzRpM975iDyqIq8fByXaP1LzmkxZ/+V
	 vTaaVfhOaCH+YYwPOhFw24HZFy1YmSqnpBIRzvJrOANGVLvF3loF9feBD2tR8HxpJQ
	 j5OII3aZo8DBA==
Date: Thu, 25 Jul 2024 12:52:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Paul Moore <paul@paul-moore.com>, Matus Jokay <matus.jokay@stuba.sk>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240725-normung-benzinkanister-0383a2f69b43@brauner>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <Zp8k1H/qeaVZOXF5@dread.disaster.area>
 <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>
 <ZqA6CeCSXwIyNDMm@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqA6CeCSXwIyNDMm@dread.disaster.area>

> The problem isn't the call into the filesystem - it's may_lookup()
> passing the inode to security modules where we dereference
> inode->i_security and assume that it is valid for the life of the
> object access being made.
> 
> That's my point - if we have a lookup race and the inode is being
> destroyed at this point (i.e. I_FREEING is set) inode->i_security
> *is not valid* and should not be accessed by *anyone*.

It's valid. The inode_free_security hooks unlist or deregister the
context as e.g., selinux_inode_free_security() does. It's fine to access
inode->i_security after the individual hooks have been called; before or
within the delayed freeing of i_security. And selinux and bpf are the
only cases where deregistration happens while also implementing or in
the case of bpf allowing to implement security_inode_permission().

> If we decide that every pathwalk accessed object attached to the
> inode needs to be RCU freed, then __destroy_inode() is the wrong
> place to be freeing them - i_callback() (the call_rcu() inode

The superblock might already be gone by the time free_inode() is called.
And stuff like selinux accesses the superblock from inode->i_sb during
security_inode_free_security(). So moving it in there isn't an option.
It needs to be called before. If one wanted it in there the obvious way
to do it would be to split deregistration and freeing into two hooks
security_inode_deregister() and then move the rcu part of
security_inode_free() into i_callback so it gets wasted together with
the inode. But i_callback() isn't called for xfs and so the way it's
currently done is so far the best.


Return-Path: <linux-fsdevel+bounces-40261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E795A214A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C845E1667D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECE1DED59;
	Tue, 28 Jan 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIlnSYgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CF199239
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104709; cv=none; b=gli0Sc1OKsTLuaQvdXgvNXrg521XKu/mCZj4wYVlTyL/68yLc591mYNfE58K2D4YSrx9n3NzOFnJMwdZnp1sJU4vgFgHK3w9Ed+MyTDejRFOrwrc/+Mt5hzolecr/EBBW/F0UKXG1gug4s9ZXKC42L/EjTTkgTSG8Gh2/G18BZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104709; c=relaxed/simple;
	bh=zXjJHcxFVOoZkyPB4wwcpDsE/5Gl/z3VJObqbqpiVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ7EbFLmY6EYcWdNDUtdOq6pzES1PQOAgqebKXfz4rmFnE/qxOTMGtvqFdviEXTgl78X9eSi+0IK1LcZ2UM0IsKsUnYh3VE9TRAgwIzMaOEd06tB4M6h1UavXczQfgstH+DjL8BH+dHT1WKepY0rpW1f/UZocegnA4xVRbe7CFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIlnSYgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB1BC4CED3;
	Tue, 28 Jan 2025 22:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738104708;
	bh=zXjJHcxFVOoZkyPB4wwcpDsE/5Gl/z3VJObqbqpiVtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIlnSYgvQYeaf8z5sIZkt2GbN2mlzUsOxtCYM6B0FLlDlaM3z1o5JuidvglilULCO
	 BMx3u5HBI9GbEJ548hm1BCGr5+W5Bepyzb/QDtJt8UjTtK7kGKSs9urj21yn9GSnPT
	 dutFgnMjxaEdVQUnAWtftb/gtEZ82GFoshVk7XnozMOesXaUydgvFQ8b+hWAD4Xa1C
	 jn4t5e8nvyJqWCJPb4xAKJ4bC1e9Q1FI4VbXS5jAbxuvEaOlQFga2XU3if/8dwMtvw
	 Ok+Sh8p1wUNGmAZeepk4xOMAO6pfXhfuVn4WMa0781Ba6S0L9dByxKfUITcE93P/q/
	 VUu2tr3rPy2xQ==
Date: Tue, 28 Jan 2025 12:51:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Reaver <me@davidreaver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
References: <20250121153646.37895-1-me@davidreaver.com>
 <Z5h0Xf-6s_7AH8tf@infradead.org>
 <20250128102744.1b94a789@gandalf.local.home>
 <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
 <20250128174257.1e20c80f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128174257.1e20c80f@gandalf.local.home>

On Tue, Jan 28, 2025 at 05:42:57PM -0500, Steven Rostedt wrote:
...
> I believe kernfs is to cover control interfaces like sysfs and debugfs,
> that actually changes kernel behavior when their files are written to. It's
> also likely why procfs is such a mess because that too is a control
> interface.

Just for context, kernfs is factored out from sysfs. One of the factors
which drove the design was memory overhead. On large systems (IIRC
especially with iSCSI), there can be a huge number of sysfs nodes and
allocating a dentry and inode pair for each file made some machines run out
of memory during boot, so sysfs implemented memory-backed filesystem store
which then made its interface to its users to depart from the VFS layer.
This requirement holds for cgroup too - there are systems with a *lot* of
cgroups and the associated interface files and we don't want to pin a dentry
and inode for all of them.

Thanks.

-- 
tejun


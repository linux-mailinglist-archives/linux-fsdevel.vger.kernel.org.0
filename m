Return-Path: <linux-fsdevel+bounces-70277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8FC94BC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 07:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA0A74E1AE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3CC230264;
	Sun, 30 Nov 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BSODyhYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CC36D508;
	Sun, 30 Nov 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485172; cv=none; b=Yvm09zVIwYWNK23ps3WCy9N+N05nnGRcOiLG94tsBr/yuCEOE/Qlf9E9tISZGROyTjLQg6XWR0SVzHhLbwRpKP70/DUzz4PkA8oPk5kSpg6CAfMDqs9bGaFQ6XOIUP6PCsT3tAWt5PZgourN2ZFivj4tgIN05f27SXHJZYxA/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485172; c=relaxed/simple;
	bh=LeY9Dynhstx6xrhZVJcp/0P0j/QNf3ZX0H2Fvwv5Bfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZhxRodhN0eZAFtrEOFBLPkJdEUoNuOjGe7X8hzCBxnxhcMaFFw2adwipkHva7d65tZ+PY2NPL/vieqFUCfpMWM0E9gGazkobEJJE1N9U6ckZpkEu6VZ5UFx7L1b/xLTUTFcYPJxANOmBWLrydZjJL5ppiJhj23sJI3jcnFhBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BSODyhYt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0+RutjHJF6IAz0/l+k9W8uM3IopTQJImTqgJ3gMylAk=; b=BSODyhYtOm0S0z1H257JHzpGTf
	ns6f4ewERKLIgugIT/WI57IJoZPLZAg4IUtPyGG4SyGRz3lVEr+6GNQGOH6hZm7oWr7+R/RyGHljW
	nlfBRCogd+AKjZ6dwdwBuNNJqbpuTl6IeL/J9Od/XYlzZNr90EbX3sTUAGfZMsxGbUM5RbqqHB54Q
	9On347zzql5gy4mchFtI68O1obIBOiwCPiDuir2POqEql26YLkdu4BMa2U2M0GHbyA/bjK3G/PUyC
	FLQVQBvFKE1RhGrNj0tutm49OX8fqIJf+uv8G4U1Gc2Fqu0G4+aX1EafU+2OeZOnLmwZ/otZbL3/0
	lty6rfAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPbCD-0000000Gdtg-11jx;
	Sun, 30 Nov 2025 06:46:09 +0000
Date: Sun, 30 Nov 2025 06:46:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com,
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	Shervin Oloumi <enlightened@chromium.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_kern_path and bpf_path_put
 kfuncs
Message-ID: <20251130064609.GR3538@ZenIV>
References: <20251127005011.1872209-1-song@kernel.org>
 <20251127005011.1872209-3-song@kernel.org>
 <20251130042357.GP3538@ZenIV>
 <CAPhsuW69nUeMf+89vwsBrwo4sv3P8xOypSfhafEu12HJKqAb+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW69nUeMf+89vwsBrwo4sv3P8xOypSfhafEu12HJKqAb+w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 29, 2025 at 09:57:43PM -0800, Song Liu wrote:

> > Your primitive is a walking TOCTOU bug - it's impossible to use safely.
> 
> Good point. AFAICT, the sample TOCTOU bug applies to other LSMs that
> care about dev_name in sb_mount, namely, aa_bind_mount() for apparmor
> and tomoyo_mount_acl() for tomoyo.

sb_mount needs to be taken out of its misery; it makes very little sense
and it's certainly rife with TOCTOU issues.

What to replace it with is an interesting question, especially considering
how easy it is to bypass the damn thing with fsopen(), open_tree() and friends.

It certainly won't be a single hook; multiplexing thing aside, if
you look at e.g. loopback you'll see that there are two separate
operations involved - one is cloning a tree (that's where dev_name is
parsed in old API; the corresponding spot in the new one is open_tree()
with OPEN_TREE_CLONE in flags) and another - attaching that tree to
destination (move_mount(2) in the new API).

The former is "what", the latter - "where".  And in open_tree()/move_mount()
it literally could be done by different processes - there's no problem
with open_tree() in one process, passing the resulting descriptor to
another process that will attach it.

Any checks you do sb_mount (or in your mount_loopback) would have
to have equivalent counterparts in those, or you get an easy way to
bypass them.

That's a very unpleasant can of worms; if you want to open it, be my
guest, but I would seriously suggest doing that after the end of merge
window - and going over the existing LSMs to see what they are trying to
do in that area before starting that thread.  And yes, that's an example
of the reasons why I'm very sceptical about out-of-tree modules in
that area - with API in that state, we have no realistic way to promise
any kind of stability, with obvious consequences for everyone we can't
even see.


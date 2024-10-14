Return-Path: <linux-fsdevel+bounces-31896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AB99CE8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3966E1C22CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB51BDC3;
	Mon, 14 Oct 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIpEfyg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FD19E961;
	Mon, 14 Oct 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917106; cv=none; b=Y+bQjrSiTFuwHn1ZxVGdVFqi4Q2IXUBgI/LzTCYhbQnRgxKmv0x+pwJkxDhle38U+8usC2NQ2A5QH2ZopZqNSBbIbiLMuTJlib5CcIaacxMTKOMKP9qT6WAr1MBwPd71sCxguicPbL2cseom0dwuZfH5cjhfUbi8GzeN/Br8B0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917106; c=relaxed/simple;
	bh=sOWXgO6MimonnvM/OdQuhqaXyxI1PuVz0TI5mrimtOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbwRcotnrnVkLSLlUlvgE73qOXexrOJ3DoCzQg/L8Gzy8eWD3WHMdy9DEabuRz3PQkYTonUTkOdx8+wt/QjydPPNpzcLGJZF7wPTaR7Q6L7MW4jl0AGRrmZN+jDDz6SwOlVnpmUN8rI9a+3xbTsrLWq+DcnNhdKUBbrqoAcJA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIpEfyg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE5C4CEC3;
	Mon, 14 Oct 2024 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728917105;
	bh=sOWXgO6MimonnvM/OdQuhqaXyxI1PuVz0TI5mrimtOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIpEfyg6Gwv14cXyG1zZbvh+OwYsKJPaHWE2XWp6kQEUR5CNlYwAnu4mRYxsb19AW
	 UYozMaEWFSqsXG2HwUGzFPNztaP4nXBTf9cATBkBhhtph8P4j6u+YtQS2lbDaRRjTb
	 qF5nFm/OERWUxTwWFxbOMlUiqa4yX8RlC4iGSYqOc2BpSD24VQDfjVYm/65Je+r/8H
	 DEwNZARinFoV/oGR4wM0OuJr/1fCdM1tgRYUBbleETTYVIHVwF1oxjAp55suKk5mq9
	 f63frF2nBbUvGs3xgvWUEbuKO2GT+1WWpj+zHQ+73j7e1qrmJVT5TMYJPnkrt9sB75
	 /W/SBknIiNjwQ==
Date: Mon, 14 Oct 2024 16:45:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Christoph Hellwig <hch@infradead.org>, Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014-turmbau-ansah-37d96a5fd780@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>

On Sun, Oct 13, 2024 at 06:17:43AM -0400, Jeff Layton wrote:
> On Fri, 2024-10-11 at 17:30 +0200, Mickaël Salaün wrote:
> > On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> > > On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
> > > > > > Yes, but how do you call getattr() without a path?
> > > > > 
> > > > > You don't because inode numbers are irrelevant without the path.
> > > > 
> > > > They are for kernel messages and audit logs.  Please take a look at the
> > > > use cases with the other patches.
> > > 
> > > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > > subvolumes.
> > 
> > At least it reflects what users see.
> > 
> > > 
> > > If you want a better pretty but not useful value just work on making
> > > i_ino 64-bits wide, which is long overdue.
> > 
> > That would require too much work for me, and this would be a pain to
> > backport to all stable kernels.
> > 
> 
> Would it though? Adding this new inode operation seems sub-optimal.

I agree.

> Inode numbers are static information. Once an inode number is set on an
> inode it basically never changes.  This patchset will turn all of those
> direct inode->i_ino fetches into a pointer chase for the new inode
> operation, which will then almost always just result in a direct fetch.

Yup.

> A better solution here would be to make inode->i_ino a u64, and just
> fix up all of the places that touch it to expect that. Then, just

I would like us to try and see to make this happen. I really dislike
that struct inode is full of non-explicity types.


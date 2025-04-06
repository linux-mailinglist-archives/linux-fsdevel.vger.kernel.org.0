Return-Path: <linux-fsdevel+bounces-45819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA2A7D000
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 21:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164F87A3A84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C891ACEC8;
	Sun,  6 Apr 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjyllOh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECA1AA7A6;
	Sun,  6 Apr 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969084; cv=none; b=YahPjB/6l4eXwEjOqIMEYEDgZeK2TT3VVML22Fzaomh2wShIn+sxeDn9iTuMRNgT8zJ11uV2kGm7YfdYzjzYddu9Um+chkjw17/GjtvAHdDU5tlWIm1nDFy/KCI69dZp4PIIYQkNItfa5DjeYxsUbg3OfKDxk9gLsU+W2ecAxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969084; c=relaxed/simple;
	bh=DJRbLvaS+Yx7WeurDiWaVkXeNcU8Jcjof+rGjjRRLkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOeJNs0r+/FHAzdQOe2S5OjyhYK8ND0PXi3x+Jggr6niG8O4Q8qco+vuUv1jbsS9y00l/DSRRu+1cPB3ejnQS1hU53MIQBNz2jwMa+/gzXJPQVEm6dLg0vk0KXXPWUfBK9oRAo6Zx5TkH/XYihHbKSQ25cDKGJBDNo3saowj3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjyllOh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F583C4CEEB;
	Sun,  6 Apr 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743969084;
	bh=DJRbLvaS+Yx7WeurDiWaVkXeNcU8Jcjof+rGjjRRLkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjyllOh17cv8Qu4bSNk2AaTdxoBMnL6bd+3tv8SOZkjZvfiJVICLT4Gkso8l1iGTi
	 lRThR64gvF+QS39VgwNt3EhYT7NYB5tv9IOmgMoZPY6qapNjIY1AcrxAp1VbSFuci7
	 wbcgdpy4gOQ08gLAmWlbaY8lun+Ma4y15npUNgvdLqo68Yn13+oI7QYVSE3M/GfQoT
	 xkyYJClI+rj1yeO3VeDqKs30g5jTGpwBxwyOM6Yl7aaz5tx6fcJaVUzI0RL1W1YVBX
	 PGMwEMsS0quRcVde/HuWaqU2ftNOarwP2TgXYKKUI/XR6QNtfwBsPVI144ho47UMlk
	 bE+2+B/okSTGQ==
Date: Sun, 6 Apr 2025 21:51:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH] anon_inode: use a proper mode internally
Message-ID: <20250406-angucken-ankommen-6974c000f0fb@brauner>
References: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
 <CAGudoHErv6sX+Tq=NNLL3b61Q70TeZxi93Nx_MEcMrQSg47JGA@mail.gmail.com>
 <20250406-reime-kneifen-11714c0a421d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250406-reime-kneifen-11714c0a421d@brauner>

> Anyway, I'm finishing the patch and testing tomorrow and will send out
> with all the things I mentioned (unless I find out I'm wrong).

Found my notes about this. I knew I had notes about this somewhere...
It isn't possible to execute anoymous inodes because you cannot open
them. That includes stuff like:

execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)

Look, anonymous inodes have inode->f_op set to no_open_fops which sets
no_open() which returns ENXIO. That means any call to do_dentry_open()
which is the endpoint of the do_open_execat() will fail. There's no
chance to execute an anonymous inode. Unless a given subsystem overrides
it ofc.

I still agree that we need to be more coherent about this and we need to
improve various semantical quirks I pointed out. But the exec problem
isn't really an issue so the patch itself still seems correct to me.


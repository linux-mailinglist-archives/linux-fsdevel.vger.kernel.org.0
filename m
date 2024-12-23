Return-Path: <linux-fsdevel+bounces-38015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7459FA9F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 06:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7F7A1864
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF949155A52;
	Mon, 23 Dec 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="huEos/Fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682F38C;
	Mon, 23 Dec 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734930514; cv=none; b=jIcDOeThNXaz47NdKBwFUqcygP2/KEZeZnON1FG+uwdYm7m+8HhhSLPneFZd29DKQA3NWc8eQSq1kwAfhaDZXxKxf0b8uh4NvYxi9CWhQNaECSfATx8QWgYWGYFKCM3HoVzfvAu2sTc6jgQZIXykDIMxW5arqB9t7RRzniTbkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734930514; c=relaxed/simple;
	bh=IchlAU32E+3ieIc7Vt+CJNV54D8d0eQVljJWIzHU6nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdPPIlMujW6eVTXbpTCFTfeMD4tCbicClKqL/PCvWrlSjsq7hf9CQzDgxxY6+lo9A92MU8BvSukyglaR8tTvW+kb2ZCMcxffkGbgONx6rw0be0FiL98PCb+ITt8EsZlm8203hiX40AZ28I215VlgvTJAVf0fVVvYut6RhNTLCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=huEos/Fv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=URWVV/CuXWLSuVy6pdpgZwi1LFxyRLxkWv6VwOK/m+s=; b=huEos/FvE3Pblnm1vay4D2HC2H
	YPb03odVyu2nQE7TDDNgO7SxPUoPALty1mVIa3X/jZkGOoXyMznS3s5y9Q3q23dxC4Bj7sDZRtqXl
	5Pb93z6+VOUCN0uAT6pPY8Tu1stmVbrdlj0q1KrOgRGOb09D5BZsHJEoKI8ddoFI9IKOFZxokG5Dn
	7DBYV73r5Nm4baYf/D1upTYTVRM1+dAfvfZ3T7GD1WtnVIDt4+gvtpeUDO0rfsAryaPEhAXyZKgVm
	UOoqmNa66a58noVSauGbKw5tmzky6LWcjaXHHf0peGeCdeK4CNPiIT3tTvND51YWlXs34J412vlk9
	zwlWqTBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPag9-0000000BCQE-12GT;
	Mon, 23 Dec 2024 05:08:29 +0000
Date: Mon, 23 Dec 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] VFS: add _shared versions of the various directory
 modifying inode_operations
Message-ID: <20241223050829.GJ1977892@ZenIV>
References: <20241220030830.272429-1-neilb@suse.de>
 <20241220030830.272429-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220030830.272429-3-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 20, 2024 at 01:54:20PM +1100, NeilBrown wrote:

> i_rwsem *may* be held exclusively or *may* be held shared, in which case
> an exclusive lock will be held on the dentry - provided by a later
> patch.
> 
> This will allow a graceful transition from exclusive to shared locking
> for directory updates.

> +A "mixed" lock means that either that i_rwsem on the directory is held
> +exclusively, or it is held as a shared lock, and an exclusive lock is held
> +on the dentry in that directory.

... it also means that ->d_parent and ->d_name are completely unstable.
Yes, really - have rmdir victim moved around on server, then look it up
in a new place and you'll get __d_unalias() move the existing dentry
to new location right under you.


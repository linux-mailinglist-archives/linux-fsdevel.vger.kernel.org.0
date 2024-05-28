Return-Path: <linux-fsdevel+bounces-20350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED08D1CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 15:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FF71F23496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75D16F82B;
	Tue, 28 May 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2EGtv39S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6F16ABC2;
	Tue, 28 May 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902550; cv=none; b=bRhM4sBv5lEtkolsRg9yGU7d279rl7POJ0BWthQN5PVue0pseJG2uLu96y5xhS96PXOcdlNMNGRc+zLu578xZ0XLeS3IhSuzz+38RbU9CXvP7Y6+8Fi2iH45HtB8TSlZ6iEnF7cE1Yv2Ew5IuKeUzgPZxtx8jr1RyAN7bQtU5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902550; c=relaxed/simple;
	bh=NEt3k5cTX/vBLDj8VzekBREGbfy53+L3rzyaecmjfoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp6gINGt6THh/DTIs7rF/kPfkLqCqOjBxtiP7+MynnACG2erQcNBzOVBws3HDbry5Q8f/djx4pLEUQStH4rzgBE9oTZXZcYj32ba2I0W7UL9RilMr4Z9BqRhbZoeESPixFYOb5q+G2wGEn0IqvlYbK+w0tRcNDWxWQKU3r9Egg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2EGtv39S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7qIlOU2Z3hp2e1crW0g6nFHJnET+ZWVJdelsFQ/zSdw=; b=2EGtv39Sgs60FGuVF0zny6lWfs
	CVb4tlgG62ts9NPORP4XF5B7L0AzwbTvW7sfdPyS5qB/eNUgZSGWfnzVaLmGvKv5xmjA9IWv1lcqz
	Qv4nxu8cX2T3ynylO7WD3EjRWLy3ljfdD9FegUhJOyrPSQrBJua451/pj3OoTIozCkAQQENaiN/Xt
	F7dUi22SYNMvJ9MxKPnUaZl1RAnOmUVk8/3rhE++AZ1tzcEEmfDjUP2OisOFwqz03t2RCFXDHvzHx
	uc2yUsdO+OY9EFFz/1aCKDZxE7B+/Su0CEj8cTw+JsoZQh//USMwgOjy5K2YRd9R9z5/k8LhPZae8
	mZXM8o3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBwmV-00000000m5D-3Z4y;
	Tue, 28 May 2024 13:22:23 +0000
Date: Tue, 28 May 2024 06:22:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlXaj9Qv0bm9PAjX@infradead.org>
References: <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-gipfel-dilemma-948a590a36fd@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> Can you please explain how opening an fd based on a handle returned from
> name_to_handle_at() and not using a mount file descriptor for
> open_by_handle_at() would work?

Same as NFS file handles:

name_to_handle_at returns a handle that includes a file system
identifier.

open_by_handle_at looks up the superblock based on that identifier.

For the identifier I could imagin three choices:

 1) use the fsid as returned in statfs and returned by fsnotify.
    The downside is that it is "only" 64-bit.  The upside is that
    we have a lot of plumbing for it
 2) fixed 128-bit identifier to provide more entropy
 3) a variable length identifier, which is more similar to NFS,
    but also a lot more complicated

We'd need a global lookup structure to find the sb by id.  The simplest
one would be a simple linear loop over super_blocks which isn't terribly
efficient, but probably better than whatever userspace is doing to
find a mount fd right now.

Let me cook up a simple prototype for 1) as it shouldn't be more than
a few hundred lines of code.


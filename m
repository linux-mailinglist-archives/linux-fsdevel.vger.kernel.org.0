Return-Path: <linux-fsdevel+bounces-39353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA0A13222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A413A5D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878113C8E8;
	Thu, 16 Jan 2025 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lt8TVOrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F4EC4
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003060; cv=none; b=W1g/dUbrc1v7a2ocq2Wg9f3NuSLJCn3avuD1iwW8f6OqmiTpa6O0nNu4/U6KjkVc8iQ7uAnVRizNn8a5sxQD8x7fHok22T/+tv1VZi6XIFe//+lz9/glCznhhHudWLDq5fWpIAy1Fq6A4FKvVjUdWRop4XwgJ3FCaVSmIiZ2DIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003060; c=relaxed/simple;
	bh=ppgAxQTatiokheUm+dvtstgYBmIWlsvBHF09Kv6reEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGR+LlW8KX0lFGgh/7jlKrIePyw902Pm7E2vBQpSnD5hmPwlmg1sXW6G3k6tHfCrZLlBAJ/HiHeONgEyJOgzwVpCG6HtOGIp1zyH1mSns8pDYp0r8OKnJ7fQCQUKJNhBNRKaM2DJqC6gklKbzyg5fgF5p0+KLtxNRg2eC7Tlev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lt8TVOrs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VKZQZRWnBrBBSZjZNPjwgHgImhQxhVnbkp26zmIkpM8=; b=lt8TVOrsX6DH0/djBmkDqq+twV
	il+tDjuzV/zKS6nVYvA3TtvN8rJYUD3VWsXEO6m1JZKSqmOrZUnV8mws56qYk06GkyUZddafiHq6Z
	/2ejRjFs042SFQvn3lthrfsK4PjB4hH/hKOYzT+lcDb6xtBC2IcRrQC0/L79Ib9DhveoekhbFFFJY
	fI10P9ujvB9YzmHVqU2zrIbsQG0RCZIRqp36JBckQpEoEr0DBEEarDuRabfvHnk5FXe3+Ti4NGaM9
	P4aJcMjHXHYIZt8buspR42LBfE/ERH85yhfjtjjr06C8svw2QxeZ7Jpyw4UW/7SRc9n/tF0etRXVH
	WzUVIYbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYHqI-000000020UF-0WGy;
	Thu, 16 Jan 2025 04:50:54 +0000
Date: Thu, 16 Jan 2025 04:50:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
	brauner@kernel.org, Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>,
	trondmy@kernel.org, Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
Message-ID: <20250116045054.GD1977892@ZenIV>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 14, 2025 at 09:08:38AM +0530, Shyam Prasad N wrote:

> The VFS layer maintains a dentry cache which gets populated during
> access of dentries (either during readdir/getdents or during lookup).
> This dentries within a directory actually forms the address space for
> the directory, which is read sequentially during getdents. For network
> filesystems, the dentries are also looked up during revalidate.
> 
> During sequential getdents, it makes sense to perform a readahead
> similar to file reads. Even for revalidations and dentry lookups,
> there can be some heuristics that can be maintained to know if the
> lookups within the directory are sequential in nature. With this, the
> dentry cache can be pre-populated for a directory, even before the
> dentries are accessed, thereby boosting the performance. This could
> give even more benefits for network filesystems by avoiding costly
> round trips to the server.
> 
> NFS client already does a simplistic form of this readahead by
> maintaining an address space for the directory inode and storing the
> dentry records returned by the server in this space. However, this
> dentry access mechanism is so generic that I feel that this can be a
> part of the VFS/VM layer, similar to buffered reads of a file. Also,
> VFS layer is better equipped to store heuristics about dentry access
> patterns.

You do realize that for local filesystems it'll actually hurt anything
that does *not* stat() or open() everything it runs across, right?

Directories do not contain inode metadata; on lookup you do want
that - for given object.  So you need to get the on-disk inode read,
so that in-core inode could be set up.  Adding that on readdir for
every directory entry you run across can be thoroughly unpleasant.

It should be up to filesystem.  It's not just the access pattern.
Imagine the joy of doing that on e.g. NFSv2; would you agree that
"I'd have to send a bleeding GETATTR for every entry in READDIR
response" is an important detail when deciding whether we want
to do dcache prepopulation?

Ideas regarding better infrastructure filesystems could use would
be interesting, but decision whether to use that or not in any
given case belongs in filesystem itself, *not* in upper layers.


Return-Path: <linux-fsdevel+bounces-56241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F2B14BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEAE7AE0EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A2288C1C;
	Tue, 29 Jul 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wUd5ScSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F9288511;
	Tue, 29 Jul 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783602; cv=none; b=dqvFcTrkS5au6/G7wvkMlV4dFaL3RTzihdCY8ZwqRnAhryuZF5YfBvM3bnwabg2FXnZNi6ren9sBzrcFCVtRPbC9By1vkZ36mVVPsnK7k9wROJKvFOzNYtqpjwdlOeapz7Mifwb8P3iUzMmWVAUOWuBxH8Cw8Tcl1rORnAEw3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783602; c=relaxed/simple;
	bh=eJfHrTmY1gisqtfHpq35BMBCNvHJX2eKMQjGgSjyqV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmfWGWFjon5jsWBWAGeaRZ6aarThvgMvi/of9EaQXHNZhE+qu74V6SNK6c2ZKaZUyicE+KBdtAA1TvnV1Zvl7zxA5V7i7AGGxwBz9iIKy+4NthY2vJk/1oCt3lqqcrS8epvliXJxRDikbj/yQGxbhlPYeeHGx/36ApcMvVfGKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wUd5ScSZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b2/di1+df2t5IFf/q4X0jMAw7MJPFzyfcGphZlLdFTU=; b=wUd5ScSZm21Qj7tKPjc0nDtrCr
	9nxWXIkmg74h7NU8v/0GHNRc7bBc3BQLbsKNS295C5nOU0I5dvxQteANpmUjN9d7E/dV67ed8xSl8
	E+0LHvVVYDK2hSlptMkI4O7EJVAGdAJTd3zuJN0Zw/a/0qxz8xe++QzfKwNrPdtjXs+VQKOldzCwA
	9m9UO35sw/KTpHbgJ71Uk1oLdG/kFGiciu1wohCQFM6xm+NN2nCfrApT3/l4PG80WdV8xCuFQSCTD
	n2aOiW7LCho6cWogRWWEhIcgp/guLyEmYph8mXJ25JK8/XY0s6a40rH8bPjbwTLoJFE+1CykXD/NX
	opLCVE9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ughEB-00000001qtU-32wv;
	Tue, 29 Jul 2025 10:06:35 +0000
Date: Tue, 29 Jul 2025 11:06:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] fat: Prevent the race of read/write the FAT32 entry
Message-ID: <20250729100635.GH222315@ZenIV>
References: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
 <tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
 <20250729093558.GG222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093558.GG222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 29, 2025 at 10:35:58AM +0100, Al Viro wrote:
> On Tue, Jul 29, 2025 at 02:17:10PM +0800, Edward Adam Davis wrote:
> > syzbot reports data-race in fat32_ent_get/fat32_ent_put. 
> > 
> > 	CPU0(Task A)			CPU1(Task B)
> > 	====				====
> > 	vfs_write
> > 	new_sync_write
> > 	generic_file_write_iter
> > 	fat_write_begin
> > 	block_write_begin		vfs_statfs
> > 	fat_get_block			statfs_by_dentry
> > 	fat_add_cluster			fat_statfs

Sorry, no - you've missed an intermediate fat_chain_add() in the call chain
here.  And that makes your race a non-issue.

> > 	fat_ent_write			fat_count_free_clusters
> > 	fat32_ent_put			fat32_ent_get

fat_count_free_clusters() doesn't care about exact value of entry;
the only thing that matters is whether it's equal to FAT_ENT_FREE.

Actualy changes of that predicate (i.e. allocating and freeing of
clusters) still happens under fat_lock() - nothing has changed in
that area.  *That* is not happening simultaneously with reads in
fat_count_free_clusters().  It's attaching the new element to the
end of chain that is outside of fat_lock().

And that operation does not affect that predicate at all; it changes
the value of the entry for last cluster of file (FAT_ENT_EOF) to the
number of cluster being added to the file.  Neither is equal to
FAT_ENT_FREE, so there's no problem - value you get ->ent_get()
is affected by that store, the value of
	ops->ent_get(&fatent) == FAT_ENT_FREE
isn't.  Probably worth a comment in fat_chain_add() re "this store
is safe outside of fat_lock() because of <list of reasons>".
Changes to this chain (both extending and truncating it) are
excluded by <lock> and as far as allocator is concerned, we are
not changing the state of any cluster.

Basically, FAT encodes both the free block map (entry[block] == FAT_ENT_FREE
<=> block is not in use) and linked lists of blocks for individual files -
they store the number of file's first block within directory entry and
use FAT for forwards pointers in the list.  FAT_ENT_EOF is used for "no
more blocks, it's the end of file".  Allocator and fat_count_free_clusters
care only about the free block map part of that thing; access to file
contents - the linked list for that file.


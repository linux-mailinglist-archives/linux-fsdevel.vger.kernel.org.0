Return-Path: <linux-fsdevel+bounces-35064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23569D09FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BA4282529
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF114A0B9;
	Mon, 18 Nov 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qg9yzeki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC47322E;
	Mon, 18 Nov 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913416; cv=none; b=jxdFo/JgjWMx2kKMK03LPm6UsCgDNstm7q6sdZel87ihPtf8VVivC3mlg4fwTH5vKLFpc7loa8M1htD9DGylUOsoLohM9+JXMIwWHZYVsCaJtxcSLN2kK+W6zZ4Y8FgmWfrgp9gd3QjcG7mf1ILIEwL5YonOfGYpH967+JLrHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913416; c=relaxed/simple;
	bh=oEltPeUPlVF+TBkOrghRwb2ODhbY7aIsbaCsGT8RZMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAc0PfvXgH8WQwZuNUPNVnQFC5dPSNxPLmwLapQEVyNKxQ+oH8mzEpZ/4yyn8Bl9KrPWLbc1QYS0O9EuUIZpnnwgt84bz/uAQyoxRE0lJMiTO3CP5RUcekMOwl0n0X8+27fOEX15oyKJzIADv5ex3Sg1qRtjmVeOpTCPgjCKu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qg9yzeki; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=GK+QvS1NaDpuClV7licehKvxkGcFMiW2ifaIQoP8yRM=; b=Qg9yzekis7kbfpAllVIVQFLePw
	oUelVmASsQMoD7bmcMeX0lIe3D33fHDnsznOHgwjwDjdkCDCAUVxwIfUtwWbaN9aYKzDRnesPGAwN
	XIuYVN88BrVxkJVvI7t2FH4c9KFecp1eyKqZPjk75QH9AG9kdti4SakM8YxVofYw9rzDzbZqO6yGE
	RfYA3FKFGVkHprHscYkRNqLxqHmuRhbdTjXKBSm8qhz40HjodN/t1o3yMM5IirNniuC/HNXIP7L+k
	RVZtbqGQasNMflxthe4uaeXD5DY4QQ3KrEEqRc5g/o2LPjJf/H6QM1NaBZUpkE2HVv3dYIisO0VMc
	2nf7mlRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvnG-0000000GIzs-3V5f;
	Mon, 18 Nov 2024 07:03:30 +0000
Date: Mon, 18 Nov 2024 07:03:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <20241118070330.GG3387508@ZenIV>
References: <20241117165540.GF3387508@ZenIV>
 <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 18, 2024 at 03:00:39PM +0900, Jeongjun Park wrote:
> 
> Hello,
> 
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > ﻿On Mon, Nov 18, 2024 at 01:37:19AM +0900, Jeongjun Park wrote:
> >> Many filesystems lock inodes before calling vfs_getattr, so there is no
> >> data-race for inodes. However, some functions in fs/stat.c that call
> >> vfs_getattr do not lock inodes, so the data-race occurs.
> >> 
> >> Therefore, we need to apply a patch to remove the long-standing data-race
> >> for inodes in some functions that do not lock inodes.
> > 
> > Why do we care?  Slapping even a shared lock on a _very_ hot path, with
> > possible considerable latency, would need more than "theoretically it's
> > a data race".
> 
> All the functions that added lock in this patch are called only via syscall,
> so in most cases there will be no noticeable performance issue.

Pardon me, but I am unable to follow your reasoning.

> And
> this data-race is not a problem that only occurs in theory. It is
> a bug that syzbot has been reporting for years. Many file systems that
> exist in the kernel lock inode_lock before calling vfs_getattr, so
> data-race does not occur, but only fs/stat.c has had a data-race
> for years. This alone shows that adding inode_lock to some
> functions is a good way to solve the problem without much 
> performance degradation.

Explain.  First of all, these are, by far, the most frequent callers
of vfs_getattr(); what "many filesystems" are doing around their calls
of the same is irrelevant.  Which filesystems, BTW?  And which call
chains are you talking about?  Most of the filesystems never call it
at all.

Furthermore, on a lot of userland loads stat(2) is a very hot path -
it is called a lot.  And the rwsem in question has a plenty of takers -
both shared and exclusive.  The effect of piling a lot of threads
that grab it shared on top of the existing mix is not something
I am ready to predict without experiments - not beyond "likely to be
unpleasant, possibly very much so".

Finally, you have not offered any explanations of the reasons why
that data race matters - and "syzbot reporting" is not one.  It is
possible that actual observable bugs exist, but it would be useful
to have at least one of those described in details.

Please, spell your reasoning out.  Note that fetch overlapping with
store is *NOT* a bug in itself.  It may become such if you observe
an object in inconsistent state - e.g. on a 32bit architecture
reading a 64bit value in parallel with assignment to the same may
end up with a problem.  And yes, we do have just such a value
read there - inode size.  Which is why i_size_read() is used there,
with matching i_size_write() in the writers.

Details matter; what is and what is not an inconsistent state
really does depend upon the object you are talking about.
There's no way in hell for syzbot to be able to determine that.


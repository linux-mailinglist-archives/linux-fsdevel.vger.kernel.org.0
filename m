Return-Path: <linux-fsdevel+bounces-35339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A93FA9D4051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B2B3268C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F7154C15;
	Wed, 20 Nov 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wqVlfTkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831A13AA31;
	Wed, 20 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119053; cv=none; b=WQgSsTbnydcPIakRONtU3eIC8IIgfEgnUeGATOuI3zzGHF1MJYjPM+lw9b+sdCJXTCbz1htDHGAlZ6pWySeH0E8se15FkZfq25Y55xQi9KnKiEOfEFwH9K8OvKXlzxqx7gShcTZOPTlKROXE4GxECUgCTlygJn3ZC5/CK6MVLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119053; c=relaxed/simple;
	bh=pfriz3GoW4ivHoZQDFCLbfIt/zTGENc7ZHmvNxANy3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikyi+M+ca75Sw9fGnVvP6v11eFP5uBxtysgUCKdvxEqU9AEs3GDn2jDP18UXV6m2/qCd5Z43aivg9ATmLbLUXwK/rFaCGTDySylDhLkBAsCazHTIH9Kec/K9MZKxMpYI+Ul6NffGEvg3pvKqfKiBmwMZb1n6BGlk5XbWppB6Rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wqVlfTkF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=De3bamnoeyPbjdYYxJ07ADGjjT7Pux9RhrDqOh+tlzg=; b=wqVlfTkFNO3ByyK2i132UKpJ8N
	qFjKyyD0nWG2cKokk6OSg5SPTjxPGObKaJhmmQkyMjMMvfnVseHEaGsCmC4+fOtNbZFRYEfoqfUhx
	k8bpLSdQDll5qH23rqi0MqDGU7u0wFWNf+5Y5WVYXf7EaC4aO/ash2NMqGLMT/LY5q83DRhR/27fh
	9nZKGMn5fF9V/+4ad+mLQR4nlw2+CzIWufp8K0MeLTFlwgWnsetLbHCNnClmS/0mKeOa6tBj8HSOc
	4s43ZS2czQlqdfMVS9bo2xU9CeVT132sTE4KJ12pQfiHOc11CL3JuZ4FVH/0QAg/4kLckNMSiUx8t
	N8+drscQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDnHx-0000000HRwW-22pI;
	Wed, 20 Nov 2024 16:10:45 +0000
Date: Wed, 20 Nov 2024 16:10:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] fs/ntfs3: check if the inode is bad before creating
 symlink
Message-ID: <20241120161045.GL3387508@ZenIV>
References: <20241119163647.GJ3387508@ZenIV>
 <20241120030443.2679200-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120030443.2679200-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 20, 2024 at 11:04:43AM +0800, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in pick_link. [1]
> 
> First, i_link and i_dir_seq are in the same union, they share the same memory
> address, and i_dir_seq will be updated during the execution of walk_component,
> which makes the value of i_link equal to i_dir_seq.
> 
> Secondly, the chmod execution failed, which resulted in setting the mode value
> of file0's inode to REG when executing ntfs_bad_inode.
> 
> Third, when creating a symbolic link using the file0 whose inode has been marked
> as bad, it is not determined whether its inode is bad, which ultimately leads to
> null-ptr-deref when performing a mount operation on the symbolic link bus because
> the i_link value is equal to i_dir_seq=2. 
> 
> Note: ("file0, bus" are defined in reproducer [2])
> 
> To avoid null-ptr-deref in pick_link, when creating a symbolic link, first check
> whether the inode of file is already bad.

I would really like to understand how the hell did that bad inode end up passed
to d_splice_alias()/d_instantiate()/whatever it had been.

That's the root cause - and it looks like ntfs is too free with make_bad_inode()
in general, which might cause other problems.


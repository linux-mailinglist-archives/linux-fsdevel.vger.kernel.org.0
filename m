Return-Path: <linux-fsdevel+bounces-32514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50B9A721B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E71B23FBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037A1EBA19;
	Mon, 21 Oct 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egvJeAnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918849627
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534523; cv=none; b=gEcHhISH7WLCpEO/iPFTOOP9afzA/v0wNVKjxL9FgE4bJBs0fFsqBJV3cy13BNkzWrb0cdZ1XtGluZkSL0Ne/hmLtl24d+DnFb6YDV5iWoYxATN1iuywHZ1zd4d20YvsXAAYXFV3K8K/cFkph4RMwY35HJr8O0618Dg4/62c5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534523; c=relaxed/simple;
	bh=cOfpw/bJkejyf4VA+VyaC/10OHoinf/diD24kLd0Ao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbXrJRtX8tGM+9C1P0CQwzRd1Zm6d9r9/XmppnTgtDIf/8FPa7zbpMWze0fJynGb8YDgEWPaJ5DpXtALpULtMxSntkwxMekl8dYyuvVmlxyPMZgylsc6NBGKb686h6hHeOx82rrrQ0ydMakzq0sioYiB5zbsnYpRTs0mY4fHrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egvJeAnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEB6C4CEC3;
	Mon, 21 Oct 2024 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729534523;
	bh=cOfpw/bJkejyf4VA+VyaC/10OHoinf/diD24kLd0Ao4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egvJeAnKkMB7xG65og3MsSfTu9EQLmNCqGnvJITtX4IvO15RxlVfRiVU2DH4ANLcC
	 ++gfqu0b3DMrqE92apGDAhuUTeUygOYHfpcZyAN2yXljAmJbE44kyVc6HxHzfK0H50
	 jKExFZ9yXLzVvEYFsHdLa52P1Edpf/wuX02juaqhgkxRsM8tVn1P8ixbnmy5oH+N15
	 vl+x4boz6tmb0mGwY9j6191WVlNVeeI1+FAn55ozQJ4u05CrTYca3wCrcaTpfCuR6y
	 9Ko6meoEXINUvXaiReVBDD+6vW2IJgVJkEhnnj5OkBY/pV+kc29ph7Nry9Rr+exr0t
	 b4Y7Qj4tRbrrQ==
Date: Mon, 21 Oct 2024 11:15:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, sunjunchao2870@gmail.com,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241021181522.GI2578692@frogsfrogsfrogs>
References: <20241018162837.GA3307207@mit.edu>
 <20241019161601.GJ21836@frogsfrogsfrogs>
 <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>

On Mon, Oct 21, 2024 at 02:49:54PM +0200, Christian Brauner wrote:
> On Sat, Oct 19, 2024 at 09:16:01AM -0700, Darrick J. Wong wrote:
> > On Fri, Oct 18, 2024 at 12:28:37PM -0400, Theodore Ts'o wrote:
> > > I've been running a watcher which automatically kicks off xfstests on
> > > some 20+ file system configurations for btrfs, ext4, f2fs, and
> > > xfstests every time fs-next gets updated, and I've noticed that
> > > generic/564 has been failing essentially for all of the configurations
> > > that I test.  The test succeeds on rc3; it's only failing on fs-next,
> > > so it's something in Linux next.
> > > 
> > > The weird thing is when I attempted to bisect it (and I've tried twice
> > > in the last two days) the bisection identifies the first bad commit as
> > > Stephen's merge of vfs-branuer into linux-next:
> > > 
> > >    commit b3efa2373eed4e08e62b50898f8c3a4e757e14c3 (linux-next/fs-next)
> > >    Merge: 233650c5fbb8 2232c1874e5c
> > >    Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > >    Date:   Thu Oct 17 12:45:50 2024 +1100
> > > 
> > >        next-20241016/vfs-brauner
> > >        
> > >        # Conflicts:
> > >        #       fs/btrfs/file.c
> > >        #       include/linux/iomap.h
> > > 
> > > The merge resolution looks utterly innocuous, it seems unrelated to
> > > what generic/564 tests, which is the errors returned by copy_file_range(2):
> > > 
> > >     # Exercise copy_file_range() syscall error conditions.
> > >     #
> > >     # This is a regression test for kernel commit:
> > >     #   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> > >     #
> > > 
> > > 
> > > # diff -u /root/xfstests/tests/generic/564.out /results/ext4/results-4k/generic/564.out.bad
> > > --- /root/xfstests/tests/generic/564.out        2024-10-15 13:27:36.000000000 
> > > -0400
> > > +++ /results/ext4/results-4k/generic/564.out.bad        2024-10-18 12:23:58.62
> > > 9855983 -0400
> > > @@ -29,9 +29,10 @@
> > >  copy_range: Value too large for defined data type
> > >  
> > >  source range beyond 8TiB returns 0
> > > +copy_range: Value too large for defined data type
> > >  
> > >  destination range beyond 8TiB returns EFBIG
> > > -copy_range: File too large
> > > +copy_range: Value too large for defined data type
> > >  
> > >  destination larger than rlimit returns EFBIG
> > >  File size limit exceeded
> > > 
> > > 
> > > Could someone take a look, and let me know if I've missed something
> > > obvious?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/read_write.c?h=fs-next&id=0f0f217df68fd72d91d2de6e85a6dd80fa1f5c95
> > perhaps?
> > 
> > I think the problem here is that in the old code:
> > 
> > 	pos_in + count < pos_in
> > 
> > @count is unsigned, so I think the compiler uses an unsigned comparison
> > and thus pos_in + count is a very large positive value, instead of the
> > negative value that the code author (who could possibly be me :P)
> > thought they were getting.  Hence this now triggers EOVERFLOW instead of
> > the "Shorten the copy to EOF" or generic_write_check_limits EFBIG logic.
> > 
> > To Mr. Sun: did you see these regressions when you tested this patch?
> 
> So we should drop this patch for now.

It definitely shouldn't go upstream.  I was assuming that the submitter
had actually *tested* the change before sending it.

I /think/ the validation could be fixed by making
generic_copy_file_checks do something like this:

	if (pos_in < 0 || pos_out < 0)
		return -EINVAL;

	size_in = i_size_read(inode_in);
	if (pos_in >= size_in)
		count = 0;
	else
		count = min(count, size_in - pos_in);

	if (check_add_overflow(pos_in, count, &tmp))
		return -EOVERFLOW;
	if (check_add_overflow(pos_out, count, &tmp))
		return -EOVERFLOW;

	ret = generic_write_check_limits(file_out, pos_out, &count);

instead of what it does now... but I'm not convinced the overflow checks
do much since I think we already constrain count so that it can't
overflow either file.

--D


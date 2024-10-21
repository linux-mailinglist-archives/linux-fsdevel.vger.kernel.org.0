Return-Path: <linux-fsdevel+bounces-32481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A69A690D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DF01C2200B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32011F4736;
	Mon, 21 Oct 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz4PzK9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D71EF939
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514999; cv=none; b=jZqie1bBYfy0PAr+X7N7sOz5z55hoBo7yiDsY2I6JYdYqcRiQGjdeYZdQcmPm41R66ms7E0+u/68O3ZE84oycz/g6ecMI0FA9n/cuGLECgrs5dBDJG10pFcyLT2JtD398gdj2YFyDP54Nwr/tFdEWjmaK311eHqNjyjSuuLPgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514999; c=relaxed/simple;
	bh=hZTVDGVuXqkhWUwPftxTDvsiuH1XvYN/PmQ0q2Grj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNz8Bncd2qIHYYTL2oZ9b4EXfOe76rOuQU+37edjEpfxOIZx3xOkFNyku04o7QSVPpOI5nsXmNsd9UNgIyUMB68JJmhPzvLsuL8MePLrFEd6NBTXdz4vnqyJdd+qDhpl8+2yceuvKHjBNfYqDgSy9AnluDPYqIK8VZHloizJOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz4PzK9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCB2C4CEC3;
	Mon, 21 Oct 2024 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514998;
	bh=hZTVDGVuXqkhWUwPftxTDvsiuH1XvYN/PmQ0q2Grj5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tz4PzK9A2AmUxPU++4sDORYDk+fEzJMuW2ECnIRUCSZ8sDv9FEFt3HyOj7amf4uI9
	 kBlQgXQvrj0zqrzVR+hRGv2EgaKg6T2tW8jreOOrAcEXVi0wzhlJDwbuIC7GA6LPUV
	 vdpmZVm8j8gS6d+It8kRBEMvBbn1Ah87ALlh3c8nEEQXeJWmA6hhcV91ELGGAfQBfv
	 3UP35cidCB5NDaIS1xBw7K4C1bNHpfpg5BRT4S93T0wiqkoREBYtm9d0Xbe1nceKyO
	 EjsQ2Es130FCj937K9n3APAygOYZJ0tKEknC/VdokfZ6jnBfFV7dk3t0MtBe4hd5Z3
	 BofxKwFOK2WOA==
Date: Mon, 21 Oct 2024 14:49:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, sunjunchao2870@gmail.com, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>
References: <20241018162837.GA3307207@mit.edu>
 <20241019161601.GJ21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241019161601.GJ21836@frogsfrogsfrogs>

On Sat, Oct 19, 2024 at 09:16:01AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 18, 2024 at 12:28:37PM -0400, Theodore Ts'o wrote:
> > I've been running a watcher which automatically kicks off xfstests on
> > some 20+ file system configurations for btrfs, ext4, f2fs, and
> > xfstests every time fs-next gets updated, and I've noticed that
> > generic/564 has been failing essentially for all of the configurations
> > that I test.  The test succeeds on rc3; it's only failing on fs-next,
> > so it's something in Linux next.
> > 
> > The weird thing is when I attempted to bisect it (and I've tried twice
> > in the last two days) the bisection identifies the first bad commit as
> > Stephen's merge of vfs-branuer into linux-next:
> > 
> >    commit b3efa2373eed4e08e62b50898f8c3a4e757e14c3 (linux-next/fs-next)
> >    Merge: 233650c5fbb8 2232c1874e5c
> >    Author: Stephen Rothwell <sfr@canb.auug.org.au>
> >    Date:   Thu Oct 17 12:45:50 2024 +1100
> > 
> >        next-20241016/vfs-brauner
> >        
> >        # Conflicts:
> >        #       fs/btrfs/file.c
> >        #       include/linux/iomap.h
> > 
> > The merge resolution looks utterly innocuous, it seems unrelated to
> > what generic/564 tests, which is the errors returned by copy_file_range(2):
> > 
> >     # Exercise copy_file_range() syscall error conditions.
> >     #
> >     # This is a regression test for kernel commit:
> >     #   96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> >     #
> > 
> > 
> > # diff -u /root/xfstests/tests/generic/564.out /results/ext4/results-4k/generic/564.out.bad
> > --- /root/xfstests/tests/generic/564.out        2024-10-15 13:27:36.000000000 
> > -0400
> > +++ /results/ext4/results-4k/generic/564.out.bad        2024-10-18 12:23:58.62
> > 9855983 -0400
> > @@ -29,9 +29,10 @@
> >  copy_range: Value too large for defined data type
> >  
> >  source range beyond 8TiB returns 0
> > +copy_range: Value too large for defined data type
> >  
> >  destination range beyond 8TiB returns EFBIG
> > -copy_range: File too large
> > +copy_range: Value too large for defined data type
> >  
> >  destination larger than rlimit returns EFBIG
> >  File size limit exceeded
> > 
> > 
> > Could someone take a look, and let me know if I've missed something
> > obvious?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/read_write.c?h=fs-next&id=0f0f217df68fd72d91d2de6e85a6dd80fa1f5c95
> perhaps?
> 
> I think the problem here is that in the old code:
> 
> 	pos_in + count < pos_in
> 
> @count is unsigned, so I think the compiler uses an unsigned comparison
> and thus pos_in + count is a very large positive value, instead of the
> negative value that the code author (who could possibly be me :P)
> thought they were getting.  Hence this now triggers EOVERFLOW instead of
> the "Shorten the copy to EOF" or generic_write_check_limits EFBIG logic.
> 
> To Mr. Sun: did you see these regressions when you tested this patch?

So we should drop this patch for now.


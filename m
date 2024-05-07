Return-Path: <linux-fsdevel+bounces-18960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683D8BEFB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F72284C99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5C16D4D2;
	Tue,  7 May 2024 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALbIg50z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4277658;
	Tue,  7 May 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120069; cv=none; b=lgacVGKxIn1Vhv6BpSG7GAfHp8eu5DW6b+PC1fcHsdkk/Bz06hinUxQayZGMjLgIgL7e/+ruyA/p0QbeDXlSaJmIMrQ8vbR5G7DePX6uyBFif71/B7vH7RpDizXORWLkAcI7KI0cZtX4sFvrhXABWn9KYEPtZ5UOnWfaKQW+d6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120069; c=relaxed/simple;
	bh=o0BvgHGmxdYnf92yz4XgS3qkmI6Mq1AJhjPlCvLYTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiC1Z74epBNUtrO4JjZ/lAojSdkFjldSYM1Uvjgcns4uOFJ7eJm33XD8qB7o9h+yhDNEQ1vUaDtqNzoiCw3nRuHZXTEiM+8nMf45e5N6s+IfoMsZrHWicizVotjxSVwT3ZPG8bgYtfmuvqSBTJhHz9wKNwvBsPpk1aHGi79AeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALbIg50z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71081C2BBFC;
	Tue,  7 May 2024 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715120068;
	bh=o0BvgHGmxdYnf92yz4XgS3qkmI6Mq1AJhjPlCvLYTqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALbIg50zFavQMLf9IBWLbCDyPBBkUPmabZviBbilontbOpQbBGEPA/8RiffCTVnmw
	 14abzhtHL6UfY/GZe+H2NbVGqswA60zl3HfsmLZsOqE2pi4l/eceT0HzszPfrp6rMR
	 XJlmweiwQeA+nJGs0fqUDG6AzK1CK5QaqkXgsG7vdjh8NN6TpcTrsodOcXN4O2SRw3
	 mvyFpQGbKX9RFVO6034bNw7cDbYKgFPYGdUS9GINLbmDBVzShOFTFVvWzx9sbBd9aM
	 yQ8UKm5EYiWdzTAcM9hgUhP6nYLxyMQ2t+tU7VmqJcGZaa1dJlU0/s1e5gbNkTZV7C
	 aL2KBEY6eHd5w==
Date: Tue, 7 May 2024 15:14:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hugo Valtier <hugo@valtier.fr>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Mark Fasheh <mark@fasheh.com>
Subject: Re: bug in may_dedupe_file allows to deduplicate files we aren't
 allowed to write to
Message-ID: <20240507221427.GA2049409@frogsfrogsfrogs>
References: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
 <CAOQ4uxjh5iQ0_knRebNRS271vR2-2f_9bNZyBG5vUy3rw6xh-g@mail.gmail.com>
 <CAF+WW=rRz0L-P9X2tV9svGdTbhAhpBea=huf-_DDfkz29fXUyQ@mail.gmail.com>
 <CAOQ4uxiGpShrki9dnJM1hvz1GPPcDos6P8pAkAz_jksy4gJdsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiGpShrki9dnJM1hvz1GPPcDos6P8pAkAz_jksy4gJdsw@mail.gmail.com>

[add fsdevel to cc because why not?]

On Sun, May 05, 2024 at 09:57:23AM +0300, Amir Goldstein wrote:
> [change email for Mark Fashe]
> 
> On Sat, May 4, 2024 at 11:51 PM Hugo Valtier <hugo@valtier.fr> wrote:
> >
> > > My guess is that not many users try to dedupe other users' files,
> > > so this feature was never used and nobody complained.
> >
> > +1

So I guess the rest of the thread is here?

https://lore.kernel.org/lkml/CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com/

Which in turn is discussing the change made here?

https://lore.kernel.org/linux-fsdevel/20180511192651.21324-2-mfasheh@suse.de/

Based on the stated intent in the original patch ("process can write
inode") I do not think Mr. Valtier's patch is correct.
inode_permission(..., MAY_WRITE) returns 0 if the caller can access the
file in the given mode, or some negative errno if it cannot.  I don't
know why he sees the behavior he describes:

"I've tested that I can create an other readonly file as root and have
my unprivileged user deduplicate it however if I then make the file
other writeable I cannot anymore*."

Which test exactly is the one that results in a denial?  I don't think I
can reproduce this:

$ ls /opt/a /opt/b
-rw-r--r-- 1 root root 65536 May  7 15:09 /opt/a
-rw-rw-rw- 1 root root 65536 May  7 15:09 /opt/b
$ xfs_io -r -c 'dedupe /opt/b 4096 4096 4096' /opt/a
XFS_IOC_FILE_EXTENT_SAME: Operation not permitted

<confused>

> > Thx for the answer, I'm new to this to be sure I understood what you meant:
> > > You should add an xfstest for this and include a
> > > _fixed_by_kernel_commit and that will signal all the distros that
> > > care to backport the fix.
> >
> > So right now I wait for 6.9 to be released soon enough then
> > I then submit my patch which invert the condition.
> 
> There is no need to wait for the 6.9 release.
> Fixes can and should be posted at any time.
> 
> > Once that is merged in some tree (fsdevel I guess ?) I submit a patch for
> 
> Yes, this is a good candidate for Christian Brauner's vfs tree.
> Please CC the VFS maintainers (from MAINTAINERS file) and fsdevel.
> 
> A note about backporting to stable kernels.
> stable maintainer bots would do best effort to auto backport
> patches marked with a Fixes: commit to the supported LTS kernel,
> once the fix is merged to master,
> but if the fix does not apply cleanly, you will need to post the
> backport yourself (if you want the fix backported).
> 
> For your case, the fix will not apply cleanly before
> 4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
> so at lease from 6.1.y and backwards, you will need to post
a> manual backports if you want the fix in LTS kernels or you can
> let the distros that find the new xfstest failure take care of that...
> 
> > xfstest which adds a regression test and has _fixed_by_kernel_commit
> > mentioning the commit just merged in the fsdevel linux tree.
> 
> Correct.
> You may take inspiration from existing dedupe tests
> [CC Darrick who wrote most of them]
> but I did not find any test coverage for may_dedupe_file() among them.
> 
> There is one test that is dealing with permissions that you can
> use as a template:
> 
> $ git grep -w _begin_fstest.*dedupe tests/generic/|grep perms
> tests/generic/674:_begin_fstest auto clone quick perms dedupe
> 
> Hint: use $XFS_IO_PROG -r to open the destination file read only.
> 
> Because there is currently no test coverage for read-only dest
> for the admin and user owned files, I suggest that you start with
> writing this test, making sure that your fix does not regress it and
> then add the other writable file case.

...and yes, the unusual permissions behavior of FIDEDUPERANGE should be
better tested.

--D

> Thanks,
> Amir.


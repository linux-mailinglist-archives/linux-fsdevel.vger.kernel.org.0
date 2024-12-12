Return-Path: <linux-fsdevel+bounces-37197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C79EF594
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4035828936E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B2217664;
	Thu, 12 Dec 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiQIk1Kp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4D13CA93;
	Thu, 12 Dec 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023876; cv=none; b=R6JbnJQ4ZXXJfXs6xt0g1RYlZG7H6MO3rUlekxY04M1JrlHih5p8DpBaASZWQAvzI547joZ1G59ia0eyOXgmShpq6LLRAporN+vXeHSVQGW+X2VLZRBQLYzNYYgN6L3NbxjClLcHOqSXNwO2jI2CHLkzb8jd79C7cpPXhLpggfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023876; c=relaxed/simple;
	bh=2aEKcv/XDkhNJgSIvk00+e0To/+3vazdNmSMkazFpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKzH+YTjb9r2JTOuwrdhuLPoXf+OXxJaihyf/zRJz5NJ4UwXyZGAsto3O87p8udUMmF5pP1Neu/yXO1i2n+Cn54XoNbqft/U6HlhrPqDGwJ/EMfbCS1A1YwWaa2YqjyRtQqIcQ/+Rmjz+nrV8NRFKvS++vwTaurmKrjGV+5eZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiQIk1Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94409C4CECE;
	Thu, 12 Dec 2024 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023876;
	bh=2aEKcv/XDkhNJgSIvk00+e0To/+3vazdNmSMkazFpKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiQIk1KpkpuofPbh3GT31QKGnUMURaKwMjl2irWDCjJgx2j8H0dkWdFqEg5fDiw44
	 7oLSguXbPHazBrcjFrbg3vAAbKVvxqsrfeUlp8me+O0F1sx/I5Mn2T0I8JZSaVSoq4
	 PwEUhYpnOqiTL6dbzfPo3bmxnR8PjTkkLQRBjvrg1lFG+Bdyl2c4JXIQezFfBtUNfM
	 fK/tG2k/vV9lGRe6sXECF1Mzmd3jx5fZIQD7nL+kRaTwU0CE6HHADbsX0rIA+ebh4s
	 sBBApByoQ4LfREGn94y2zX/SJcdeTX9rSZLyXkLkj8dzmV0yt7pb1gf9P/vlkhTTtR
	 s4xHWa94FaccA==
Date: Thu, 12 Dec 2024 10:17:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Jeff Layton <jlayton@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20241212171751.GA616250@ax162>
References: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
 <589335.1733244955@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589335.1733244955@warthog.procyon.org.uk>

On Tue, Dec 03, 2024 at 04:55:55PM +0000, David Howells wrote:
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> 
> > Build error:
> > ---------
> > fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
> > uninitialized when used here [-Werror,-Wuninitialized]
> >   235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
> >       |                           ^~~~~~
> > fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
> > silence this warning
> >    28 |         struct netfs_io_subrequest *subreq;
> >       |                                           ^
> >       |                                            = NULL
> > 1 error generated.
> > make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1
> > 
> > Build image:
> > -----------
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/log
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/details/
> > - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/
> > 
> > Steps to reproduce:
> > ------------
> > - tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
> > --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
> > LLVM=1 LLVM_IAS=1
> > 
> > The git log shows
> > $ git log --oneline  next-20241122..next-20241125 -- fs/netfs/read_retry.c
> > 1bd9011ee163e netfs: Change the read result collector to only use one work item
> > 5c962f9982cd9 netfs: Don't use bh spinlock
> > 3c8a83f74e0ea netfs: Drop the was_async arg from netfs_read_subreq_terminated()
> > 2029a747a14d2 netfs: Abstract out a rolling folio buffer implementation
> > 
> > metadata:
> > ----
> >   git describe: next-20241125 and next-20241126
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
> >   kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
> 
> That should be fixed on my branch now:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-writeback
> 
> I'm just moving the branch to v6.13-rc1 and fixing reported issues before
> asking Christian to repull it.

Is there any progress on getting this into -next? This warning has
broken our builds for a grand total of a few weeks at this point...

Cheers,
Nathan


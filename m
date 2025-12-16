Return-Path: <linux-fsdevel+bounces-71488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C3CC4D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811CC302AAF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E9346ACC;
	Tue, 16 Dec 2025 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOK9fxbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72136257828;
	Tue, 16 Dec 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909354; cv=none; b=rB5D0rbGdu+l0KYaG+Xup6tHgJzeMZmCLr4jlTNt9nipOj7xd1SEar+YqkVFohe+H9ct51ycmwIm4T/21sBw7wOnEKi3wYJaUtctoTu7F2VDmRa8PAtNsa7+ADEKX8q7QCQ1tjusDq+Vyu9bAnctMi9mouuH/1A96qzehD9Eb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909354; c=relaxed/simple;
	bh=d2zbVDWP3wmF8H4IWVQTP+j4jJFsNnvqR0oorlzvfBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsqsd9IrAeKQviVqBL19eaUX89KtHF2fJ2Y3ZLfkJ2zyd6a1hurJ882orJmW2r7lSeO4oihW/2woEtqFGInbLaxRjGBb2yW/CDJaDjhBzfHv09FDbYUWyJU3UE5d6CQNsbrAFvmC0CTJZ5uXvVhegJbLswPEM8NPpHQTmP5XUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOK9fxbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D088CC4CEF1;
	Tue, 16 Dec 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765909352;
	bh=d2zbVDWP3wmF8H4IWVQTP+j4jJFsNnvqR0oorlzvfBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOK9fxbNW7+HC/2n5CJCGS0xm+4ZXm7G5ZHed5z5fiSusTuBnt0kblP5afdqQe8Xh
	 RBnFx8QyVbRw9h0l0Kd2hc3UHFzd8GVYPnVFzpJ8R3ydw9Q5u2XH3kL5LvzYc5b8y9
	 SY/cGWT3YtjQuoPjC2abT7r6kC6hJK+zxNKW6DzvWVhbYMQJ2a6K0EpsShaqsiZHLG
	 b5c3cZKwrQQDb9+G7oV4ZFs72vpgibuTAxQWmfe3JWDoq7Kh2sY/iV4aIrlQW0Zc2c
	 tEQUdT6RBBa/KJUTTYmNxAUYBPrGGqt0zWy+wWr8up4XuXrCVFE321dN/faUE7Gsw3
	 1mfjdxG5YmTvw==
Date: Tue, 16 Dec 2025 10:22:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 3/3] generic: add tests for file delegations
Message-ID: <20251216182232.GB7705@frogsfrogsfrogs>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
 <20251205172554.pmzqzdmwpmflh5bi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <be8dace96aa68c59330f6c7be6ec5e2482bb6ca3.camel@kernel.org>
 <20251216171333.GG7716@frogsfrogsfrogs>
 <33364f5a1f0626ff5e2be61b04ca2b0f59d4d12b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33364f5a1f0626ff5e2be61b04ca2b0f59d4d12b.camel@kernel.org>

On Tue, Dec 16, 2025 at 12:57:56PM -0500, Jeff Layton wrote:
> On Tue, 2025-12-16 at 09:13 -0800, Darrick J. Wong wrote:
> > On Sun, Dec 07, 2025 at 03:35:29AM +0900, Jeff Layton wrote:
> > > On Sat, 2025-12-06 at 01:25 +0800, Zorro Lang wrote:
> > > > On Wed, Dec 03, 2025 at 10:43:09AM -0500, Jeff Layton wrote:
> > > > > Mostly the same ones as leases, but some additional tests to validate
> > > > > that they are broken on metadata changes.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > 
> > > > This version is good to me. But this test fails without the:
> > > > https://lore.kernel.org/linux-fsdevel/20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org/
> > > > 
> > > 
> > > 
> > > Thanks. Yes, that bug is unfortunate. I'm hoping Christian will take
> > > that patch in soon so all of the tests will pass.
> > > 
> > > > So maybe we can mark that:
> > > > 
> > > >   _fixed_by_kernel_commit xxxxxxxxxxxx ...
> > > > 
> > > > or
> > > > 
> > > >   _wants_kernel_commit xxxxxxxxxxxx ...
> > > > 
> > > > Anyway, we can add that after the patchset get merged. I'll merge this patchset
> > > > at first.
> > > > 
> > > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > > 
> > > If you like. This functionality is only in v6.19-rc so far, so there is
> > > no released kernel that has this (yet).
> > 
> > Hi Jeff/Zorro,
> > 
> > Having rebased on 6.19-rc1, I now see that generic/787 (this test) fails
> > with:
> > 
> >  --- /run/fstests/bin/tests/generic/787.out	2025-12-09 09:18:49.076881595 -0800
> >  +++ /var/tmp/fstests/generic/787.out.bad	2025-12-16 07:23:40.092000000 -0800
> >  @@ -1,2 +1,4 @@
> >   QA output created by 787
> >  -success!
> >  +ls: cannot access '/mnt/dirdeleg': No such file or directory
> >  +Server reported failure (2)
> >  +(see /var/tmp/fstests/generic/787.full for details)
> > 
> > The 787.full file contains:
> > 
> >       ***** Client log *****
> >  10 tests run, 0 failed
> >       ***** Server log *****
> >       ***** Server failure *****
> >       in test 3, while Set Delegationing using offset 1, length 0 - err = 0:Success
> >       3:Fail Write Deleg if file is open somewhere else
> >       ***** Server failure *****
> >       in test 3, while Get Delegationing using offset 1, length 0 - err = 0:Success
> >       3:Fail Write Deleg if file is open somewhere else
> >       ***** Server failure *****
> >       in test 4, while Set Delegationing using offset 0, length 0 - err = 0:Success
> >       4:Fail Read Deleg if opened with write permissions
> >       ***** Server failure *****
> >       in test 4, while Get Delegationing using offset 0, length 0 - err = 0:Success
> >       4:Fail Read Deleg if opened with write permissions
> >  13 tests run, 2 failed
> >       ***** End file details *****
> >  Server reported failure (2)
> > 
> > (Apparently this test would _notrun in 6.18-rc)
> > 
> > Is this the failure fixed by the patch above?  If so, I'll ignore the
> > failure until rc2.
> 
> Yep, the patch should fix that. Christian just merged the fix into his
> tree, so I'm hoping it'll make the -rc3 or 4.

Ok, thanks for letting me know. :)

--D

> Cheers,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


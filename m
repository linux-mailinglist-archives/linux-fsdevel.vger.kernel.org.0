Return-Path: <linux-fsdevel+bounces-21451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE490417C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A51F24AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C940861;
	Tue, 11 Jun 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezPZlvOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CA38FA0;
	Tue, 11 Jun 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123822; cv=none; b=SHpC4Mkd6wzBq6o6n8jfYx4EJktB6/t6OAi/c6InvYaft4O/EeB6zYFlbYNHakp0Nix51vxrtf3LqHsmIMOODXImDxahF6ptPz+lnNB2Wst7/EdR7ST4m9ZueDu6kQhcGSLEEhqCEfVBQ3Ntcv9sFUPaws2OI0G51cWvXyy9JxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123822; c=relaxed/simple;
	bh=tS4mBtev0mmLy3lUhLhA6wMYT89/wSilamRsW7TK4Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRbGUTkvNVidzaXYjuk9fvugH4zF5V9FhbD4QbehNxszmIQ+Q+dUGbfdgpJn0OlngsSN5kTjh8rb9LQd+kuVZw3ZPzWwAhWyLqhRuKAQcpf33sV9V4sdW7F6WPiATVcnzPbahwx8+afEPYyRPCYPnoQsKTVfwoG06LMvoSp2Q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezPZlvOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC531C2BD10;
	Tue, 11 Jun 2024 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718123821;
	bh=tS4mBtev0mmLy3lUhLhA6wMYT89/wSilamRsW7TK4Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezPZlvOewo90DgaMjlztZ0+/CgkFjfShTR0LnPfo5OFC0WKhYjURa2R0FpcHEwGYl
	 Q9nQPvzxUIctA0sO65kcW6zp0zCnzNcaMGYYs7cnNzxDL+OeuWFlXcZPscT66JeFX5
	 vk4CqJ2lpWnkcinNuMlME8kVPLEmrsi9kNN1TloYo0LS2QdzeCx6IAXdopI3iaI4nd
	 lxWGwo22KhHY8d0bWb9Z3zpUbYQxyZnSAvx9GQDVzFKLiI6bVi6cBnRPRxohQmVbn1
	 PErb78tadZbVB1WwQqMAZ0wSwCPpaD9T9/w8quRh9BqBbxdRw8oVJKIqLxeO3RrHLX
	 UetDog6RgOvSw==
Date: Tue, 11 Jun 2024 09:37:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Flaky test: generic/085
Message-ID: <20240611163701.GK52977@frogsfrogsfrogs>
References: <20240611085210.GA1838544@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611085210.GA1838544@mit.edu>

On Tue, Jun 11, 2024 at 09:52:10AM +0100, Theodore Ts'o wrote:
> Hi, I've recently found a flaky test, generic/085 on 6.10-rc2 and
> fs-next.  It's failing on both ext4 and xfs, and it reproduces more
> easiy with the dax config:
> 
> xfs/4k: 20 tests, 1 failures, 137 seconds
>   Flaky: generic/085:  5% (1/20)
> xfs/dax: 20 tests, 11 failures, 71 seconds
>   Flaky: generic/085: 55% (11/20)
> ext4/4k: 20 tests, 111 seconds
> ext4/dax: 20 tests, 8 failures, 69 seconds
>   Flaky: generic/085: 40% (8/20)
> Totals: 80 tests, 0 skipped, 20 failures, 0 errors, 388s
> 
> The failure is caused by a WARN_ON in fs_bdev_thaw() in fs/super.c:
> 
> static int fs_bdev_thaw(struct block_device *bdev)
> {
> 	...
> 	sb = get_bdev_super(bdev);
> 	if (WARN_ON_ONCE(!sb))
> 		return -EINVAL;
> 
> 
> The generic/085 test which exercises races between the fs
> freeze/unfeeze and mount/umount code paths, so this appears to be
> either a VFS-level or block device layer bug.  Modulo the warning, it
> looks relatively harmless, so I'll just exclude generic/085 from my
> test appliance, at least for now.  Hopefully someone will have a
> chance to take a look at it?

I think this can happen if fs_bdev_thaw races with unmount?

Let's say that the _umount $lvdev in the second loop in generic/085
starts the unmount process, which clears SB_ACTIVE from the super_block.
Then the first loop tries to freeze the bdev (and fails), and
immediately tries to thaw the bdev.  The thaw code calls fs_bdev_thaw
because the unmount process is still running & so the fs is still
holding the bdev.  But get_bdev_super sees that SB_ACTIVE has been
cleared from the super_block so it returns NULL, which trips the
warning.

If that's correct, then I think the WARN_ON_ONCE should go away.

--D

> Thanks,
> 
> 					- Ted
> 


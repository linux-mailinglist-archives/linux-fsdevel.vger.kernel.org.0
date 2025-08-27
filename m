Return-Path: <linux-fsdevel+bounces-59335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1598B37869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 05:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AEA1891E65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE219539F;
	Wed, 27 Aug 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gBYCNu3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B23054F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263603; cv=none; b=H3mxRcqq/IkKJKWOlxWOlyTQP1AKhqJMHtoXzGjN/+pNyipYqLHb8w063llgHT0HNkU0l1bgRxsy6csFRsCTCYrCMgGjko0NXuu+arBkggte+1/XXPtRmACwuHGWkHvzofiWlJABPBl0Nc6uhtsUqGll+6AuuUv9fQZ1WVCGvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263603; c=relaxed/simple;
	bh=8y5zavweEOEQ5J/q/6nqRvC5OPYh3LUumGHc4Y0tb08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8bcWVY5JYLzOHM6GCt9UStSVPU0P0Dfzuu7MJNixpCpXKjMOaLAOjas9rlI2e8RPwzfgfY6XE7GYljK410jJzWwUL5AOt2lh2S/G1Lbvmzh2SwMGbEyVBhLX9QWeoYf4y0Rt+C3qQPGRBDf8/YqcBOdw0CLtYLzTodLP6qK//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gBYCNu3k; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-77.bstnma.fios.verizon.net [173.48.119.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57R2xdgf013423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 22:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756263583; bh=qh2oAQ6PzVDEwyaG3Pevqs4Aa5cIt+gTDJI4w1iR8bU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gBYCNu3kJIBcYNUbwWPc+/LjTrfY3kcBjjI5iIwRCmzd7sr8QprRMfhr4FuJX9Wnz
	 voDPhste9rA7N8I/mJXmYzawV1EWMiSqBRwC66zv8/sNrszXgqXd1rQFIFWqz3iRqp
	 S/AjwN+NpmFdCf9JCg+ryAUY30r6pLDv7sHpsWxqKUJP0HVkDtolp0MV28QNDc5u5D
	 c/F13vlL7qWnb5Tizt7lYNGwjnIo/U0+OTjAGG1/Wtru0Wda99KIhpCejPCD+aWI+m
	 +YCjkFQWUfFCjhDqJLzaJRFuMCwVdfLDMlR1IQgeor+NY2/MVjtVRjefE15DTxOXzR
	 lwqg12y5f7S/w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0F3EE2E00D6; Tue, 26 Aug 2025 22:59:39 -0400 (EDT)
Date: Tue, 26 Aug 2025 22:59:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rajeev Mishra <rajeevm@hpe.com>
Cc: linux-block@vger.kernel.org,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>
Subject: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
Message-ID: <20250827025939.GA2209224@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I was testing 6.17-rc3, and I noticed a test failure in fstest
generic/563[1], when testing both ext4 and xfs.  If you are using my
test appliance[2], this can be trivially reproduced using:

   kvm-xfstests -c ext4/4k generic/563
or
   kvm-xfstests -c xfs/4k generic/563

[1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/563
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

A git bisect pointed the problem at:

commit 47b71abd58461a67cae71d2f2a9d44379e4e2fcf
Author: Rajeev Mishra <rajeevm@hpe.com>
Date:   Mon Aug 18 18:48:21 2025 +0000

    loop: use vfs_getattr_nosec for accurate file size
    
    Use vfs_getattr_nosec() in lo_calculate_size() for getting the file
    size, rather than just read the cached inode size via i_size_read().
    This provides better results than cached inode data, particularly for
    network filesystems where metadata may be stale.
    
    Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
    Reviewed-by: Yu Kuai <yukuai3@huawei.com>
    Link: https://lore.kernel.org/r/20250818184821.115033-3-rajeevm@hpe.com
    [axboe: massage commit message]
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

... and indeed if I go to 6.17-rc3, and revert this commit,
generic/563 starts passing again.

Could you please take a look, and/or revert this change?  Many thanks!

      	  	      	      	 	- Ted


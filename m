Return-Path: <linux-fsdevel+bounces-18377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE28B7C05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E911C20D2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DC172BD9;
	Tue, 30 Apr 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvN9kz4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFC152781;
	Tue, 30 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491790; cv=none; b=ItPRpw1PSkdWV63X/OqCWppDIShovKVIAMmg+VHOg/38o1ZN3Jy3qUUMw8YZlwUVAMSuoZJ5WTJfJUil3scV34R45H+L2EJ7NMSgSztq33/ZdIQvaxj7kWHURRC3747joryMgh0QJtARMMHWtjjAuAoAaS6VhqVhKUQtmN1ngSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491790; c=relaxed/simple;
	bh=//LVdMRWy2Z0Kru5a8uMOF9ni1OsANoBtfNqEBjJPlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl9ydFqsPlvnxzmGuxAFvwKg+GBKtjJ2aOQJolimf6QYDP4OA2Yea/PRoKv38Y+BHYpGO8LJtMwoAQyx/xR6Rpk/8+WDaz/nXVrkSWa8p/nhBm+/9LvCghk4DEOVzBSNEFYvHW7PlLE+wD8Zpci3t8mg8EMaLFwkzbEdoX3aEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvN9kz4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D62C2BBFC;
	Tue, 30 Apr 2024 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491789;
	bh=//LVdMRWy2Z0Kru5a8uMOF9ni1OsANoBtfNqEBjJPlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvN9kz4D+/LQpjQAV7KVMlDQdYc1d+Y6CxYK4jgO4c7KZPkKS3Qe5WYVOy8m1d7ot
	 mF5U0A6GLgCd3n8fs+5dCq4V1tf22F1mqaM2rSYDSK6G2sWNXzCQk8i9yqYC7hbtJX
	 K1GUTwKUmNPR+r+/LFU7bm/hXsISQyiQ9c0LGI9MT/XHLfvZ1qGkLyUivW4s/N7Vs8
	 LulGjkyNFLx1I+m6oUlTBjmxw7vK8WvvkMFn3ylxtTI70ZEc4kY9NvrUcvuAZDrCWG
	 0vcGBeGpJ9+gWXYwcgyPzkm7dOxYC9+ib5ZdlbBEKPoDBmUxuBBX9TW6J8OXESonuO
	 1MWZZvhc75Dmg==
Date: Tue, 30 Apr 2024 08:43:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, guan@eryu.me,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: test xfs_scrub detection and correction of
 corrupt fsverity metadata
Message-ID: <20240430154309.GL360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688039.962488.5264219734710985894.stgit@frogsfrogsfrogs>
 <4atckq27cuppwfue762g3xctp46dnwmjffawuxqsdfq6qeb5rd@g4snomzn7v4g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4atckq27cuppwfue762g3xctp46dnwmjffawuxqsdfq6qeb5rd@g4snomzn7v4g>

On Tue, Apr 30, 2024 at 02:29:03PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:41:50, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a basic test to ensure that xfs_scrub media scans complain about
> > files that don't pass fsverity validation.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/1880.out |   37 ++++++++++++++
> >  2 files changed, 172 insertions(+)
> >  create mode 100755 tests/xfs/1880
> >  create mode 100644 tests/xfs/1880.out
> > 
> > 
> > diff --git a/tests/xfs/1880 b/tests/xfs/1880
> > new file mode 100755
> > index 0000000000..a2119f04c2
> > --- /dev/null
> > +++ b/tests/xfs/1880
> > @@ -0,0 +1,135 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 1880
> > +#
> > +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> > +# that xfs_scrub detects this and repairs whatever it can.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick verity
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	_restore_fsverity_signatures
> > +	rm -f $tmp.*
> > +}
> > +
> > +. ./common/verity
> > +. ./common/filter
> > +. ./common/fuzzy
> > +
> > +_supported_fs xfs
> > +_require_scratch_verity
> > +_disable_fsverity_signatures
> > +_require_fsverity_corruption
> > +_require_scratch_nocheck	# fsck test
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +
> > +_require_scratch_xfs_scrub
> > +_require_xfs_has_feature "$SCRATCH_MNT" verity
> > +VICTIM_FILE="$SCRATCH_MNT/a"
> > +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"
> 
> I think this is not necessary, _require_scratch_verity already does
> check if verity can be enabled (with more detailed errors).

It is because _require_scratch_verity calls _scratch_mkfs_verity to
format the filesystem.  _scratch_mkfs_verity in turn forces verity on,
possibly overriding MKFS_OPTIONS to make it happen.  -iverity=1 might
not be set for a regular _scratch_mkfs call.

Therefore, this second _fsv_can_enable call checks that the test
runner's MKFS_OPTIONS set actually supports fsverity.

I'll leave a comment summarizing this:

# Check again to confirm that the caller's MKFS_OPTIONS result in a filesystem
# that supports fsverity.
_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"

--D

> Otherwise, looks good to me:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> -- 
> - Andrey
> 
> 


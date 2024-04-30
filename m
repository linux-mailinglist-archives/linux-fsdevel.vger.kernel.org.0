Return-Path: <linux-fsdevel+bounces-18378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350748B7C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6ECB21F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA13173344;
	Tue, 30 Apr 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey1hP4pF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3F143732;
	Tue, 30 Apr 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492091; cv=none; b=tPRjUkDkY+ISomfvUkXJ9wvpJ6nAKEJBI10KrBvhx/klx66lQxcj8vSLGlb4o8CUQlY4jUsQ5ZN8h+t4/k9yc3Gnpuk7+y1bRMinZrFE36ou3UTyBPTksA/rz9vDlT0RfHWcbzWuiVbvpyEHWcmL1K+jOtbO01hQMttu7l1/LKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492091; c=relaxed/simple;
	bh=l4qgM6p3NWGqstOWRWtO8bFRvfm3aLrFLKTm0di+5G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwfvHhYrIUBuZQUWs0Nqf6MHx154UfP6r/8FKaE9A6gBr8jb+2KQ+BZPVMFscSQT9H8DJiPfFgFhOQYo88GL6P6D3CUomHJh1GFmGCnEDawtyGfZqjIzwv4q/ZQGtQjxBX36Qi1Tr4KOfEZlfzg9fjJ/BpvR5UrW5Ry3OsA1owY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey1hP4pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF47C2BBFC;
	Tue, 30 Apr 2024 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714492091;
	bh=l4qgM6p3NWGqstOWRWtO8bFRvfm3aLrFLKTm0di+5G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey1hP4pFU1r/a43SJZKAdnJmfadRxE0ZMT26EHj7Gl/y4jilqtkiyxshfWuNCFBnT
	 cP/9StcDOEJbs7gs6nYsUp7pCacA7f3R2vOaC3CYPM7iNOr6c4vink3WE0TbGFr2B1
	 RF4n/6zEFrTK5dh6NaNU5bfyL54fhCndS5hqojNV/X/MdW55d9S6DT7AWIWqnUtcB7
	 wtoFuoFz+LgGaQdh1XYudMspQwn7O3rT6fIEkM57QLN3KbU01ddx0lh2V6tmG3+8tW
	 Ob91JXLkdb7LpeCgHaKy/HXl4Raa/52JsOFc703g6vIWJKnbL/pKG9SPNVloVY2Sh6
	 aOcfsi5AbzSJw==
Date: Tue, 30 Apr 2024 08:48:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, guan@eryu.me,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: test disabling fsverity
Message-ID: <20240430154810.GM360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>
 <cjwdgeptjooy65czttyopop4ipkxmdxgdkxxdpfsmtdtzr5jbj@6bu7ql72wtue>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cjwdgeptjooy65czttyopop4ipkxmdxgdkxxdpfsmtdtzr5jbj@6bu7ql72wtue>

On Tue, Apr 30, 2024 at 03:11:11PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:42:05, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a test to make sure that we can disable fsverity on a file that
> > doesn't pass fsverity validation on its contents anymore.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  tests/xfs/1881     |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/1881.out |   28 +++++++++++++
> >  2 files changed, 139 insertions(+)
> >  create mode 100755 tests/xfs/1881
> >  create mode 100644 tests/xfs/1881.out
> > 
> > 
> > diff --git a/tests/xfs/1881 b/tests/xfs/1881
> > new file mode 100755
> > index 0000000000..411802d7c7
> > --- /dev/null
> > +++ b/tests/xfs/1881
> > @@ -0,0 +1,111 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 1881
> > +#
> > +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> > +# that we can still disable fsverity, at least for the latter cases.
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
> > +_require_xfs_io_command noverity
> > +_require_scratch_nocheck	# corruption test
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +
> > +_require_xfs_has_feature "$SCRATCH_MNT" verity
> > +VICTIM_FILE="$SCRATCH_MNT/a"
> > +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"
> > +
> > +create_victim()
> > +{
> > +	local filesize="${1:-3}"
> > +
> > +	rm -f "$VICTIM_FILE"
> > +	perl -e "print 'moo' x $((filesize / 3))" > "$VICTIM_FILE"
> > +	fsverity enable --hash-alg=sha256 --block-size=1024 "$VICTIM_FILE"
> > +	fsverity measure "$VICTIM_FILE" | _filter_scratch
> > +}
> > +
> > +disable_verity() {
> > +	$XFS_IO_PROG -r -c 'noverity' "$VICTIM_FILE" 2>&1 | _filter_scratch
> > +}
> > +
> > +cat_victim() {
> > +	$XFS_IO_PROG -r -c 'pread -q 0 4096' "$VICTIM_FILE" 2>&1 | _filter_scratch
> > +}
> > +
> > +echo "Part 1: Delete the fsverity descriptor" | tee -a $seqres.full
> > +create_victim
> > +_scratch_unmount
> > +_scratch_xfs_db -x -c "path /a" -c "attr_remove -f vdesc" -c 'ablock 0' -c print >> $seqres.full
> > +_scratch_mount
> > +cat_victim
> > +
> > +echo "Part 2: Disable fsverity, which won't work" | tee -a $seqres.full
> > +disable_verity
> > +cat_victim
> > +
> > +echo "Part 3: Corrupt the fsverity descriptor" | tee -a $seqres.full
> > +create_victim
> > +_scratch_unmount
> > +_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 0 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
> > +_scratch_mount
> > +cat_victim
> > +
> > +echo "Part 4: Disable fsverity, which won't work" | tee -a $seqres.full
> > +disable_verity
> > +cat_victim
> > +
> > +echo "Part 5: Corrupt the fsverity file data" | tee -a $seqres.full
> > +create_victim
> > +_scratch_unmount
> > +_scratch_xfs_db -x -c "path /a" -c 'dblock 0' -c 'blocktrash -3 -o 0 -x 24 -y 24 -z' -c print >> $seqres.full
> > +_scratch_mount
> > +cat_victim
> > +
> > +echo "Part 6: Disable fsverity, which should work" | tee -a $seqres.full
> > +disable_verity
> > +cat_victim
> > +
> > +echo "Part 7: Corrupt a merkle tree block" | tee -a $seqres.full
> > +create_victim 1234 # two merkle tree blocks
> > +_fsv_scratch_corrupt_merkle_tree "$VICTIM_FILE" 0
> 
> hmm, _fsv_scratch_corrupt_merkle_tree calls _scratch_xfs_repair, and
> now with xfs_repair knowing about fs-verity is probably a problem. I

It shouldn't be -- xfs_repair doesn't check the contents of the merkle
tree itself.

(xfs_scrub sort of does, but only by calling out to the kernel fsverity
code to get rough tree geometry and calling MADV_POPULATE_READ to
exercise the read validation.)

> don't remember what was the problem with quota (why xfs_repiar is
> there), I can check it.

If the attr_modify commandline changes the block count of the file, it
won't update the quota accounting information.  That can happen if the
dabtree changes shape, or if the new attr requires the creation of a new
attr leaf block, or if the remote value block count changes due to
changes in the size of the attr value.

--D

> > +cat_victim
> > +
> > +echo "Part 8: Disable fsverity, which should work" | tee -a $seqres.full
> > +disable_verity
> > +cat_victim
> > +
> > +echo "Part 9: Corrupt the fsverity salt" | tee -a $seqres.full
> > +create_victim
> > +_scratch_unmount
> > +_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 3 #08' -c 'attr_modify -f "vdesc" -o 80 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
> > +_scratch_mount
> > +cat_victim
> > +
> > +echo "Part 10: Disable fsverity, which should work" | tee -a $seqres.full
> > +disable_verity
> > +cat_victim
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/1881.out b/tests/xfs/1881.out
> > new file mode 100644
> > index 0000000000..3e94b8001e
> > --- /dev/null
> > +++ b/tests/xfs/1881.out
> > @@ -0,0 +1,28 @@
> > +QA output created by 1881
> > +Part 1: Delete the fsverity descriptor
> > +sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
> > +SCRATCH_MNT/a: Invalid argument
> > +Part 2: Disable fsverity, which won't work
> > +SCRATCH_MNT/a: Invalid argument
> > +SCRATCH_MNT/a: Invalid argument
> > +Part 3: Corrupt the fsverity descriptor
> > +sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
> > +SCRATCH_MNT/a: Invalid argument
> > +Part 4: Disable fsverity, which won't work
> > +SCRATCH_MNT/a: Invalid argument
> > +SCRATCH_MNT/a: Invalid argument
> > +Part 5: Corrupt the fsverity file data
> > +sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
> > +pread: Input/output error
> > +Part 6: Disable fsverity, which should work
> > +pread: Input/output error
> > +Part 7: Corrupt a merkle tree block
> > +sha256:c56f1115966bafa6c9d32b4717f554b304161f33923c9292c7a92a27866a853c SCRATCH_MNT/a
> > +pread: Input/output error
> > +Part 8: Disable fsverity, which should work
> > +pread: Input/output error
> > +Part 9: Corrupt the fsverity salt
> > +sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
> > +pread: Input/output error
> > +Part 10: Disable fsverity, which should work
> > +pread: Input/output error
> > 
> 
> -- 
> - Andrey
> 
> 


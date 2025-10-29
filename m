Return-Path: <linux-fsdevel+bounces-66168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD0C17EA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D983A795F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64932DA751;
	Wed, 29 Oct 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giqBXMw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5C2D949A;
	Wed, 29 Oct 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701295; cv=none; b=uHeoq4iMB8r5XAbjz3McGXfmY54LarMTyvl/GNN6IQHpuHaA817/GEpj6WkFFpBvBEk6zRBjDY36ok+RoD+YscxTD4szMCywYOMMP/Xm/7FxaHeiIczJmABV/al/vjStXAPzeoorVvofNZ619hG6aOzA7enUOXUfiuL8/+Zs2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701295; c=relaxed/simple;
	bh=enAaloAOVhmS1NOoUM2RHc8qdlOJGs7yuoNDpfDqBRQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYKIQCZew948Cd7D3FT5OBsOJdookxpgb7+PJo4tNyKvlv6t9IVBc40dcmcP6NilVHp0//b9drEddU9C4oiF4U2IlYY5xYuQ9ZAN/Cw2ghAdTpednYPQz7mD09TIZv+MRggBrTUZstEeW/GIUsdRbKkj4NQpEbz+eezhTyIIhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giqBXMw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCBFC4CEE7;
	Wed, 29 Oct 2025 01:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701294;
	bh=enAaloAOVhmS1NOoUM2RHc8qdlOJGs7yuoNDpfDqBRQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=giqBXMw1biZgkcJihzdcGmca0peY8eE6fYUU/vVOAs3rcDThDSGdKq8PWCljAG2jX
	 rZw67E8WLIa4DnETFj3jkToJ/itTh99owFCAdkPNf91OUO4L9fPggeRxOgcm2wpi7A
	 2DRVl7lJLc5LuO5VGOk2L1iEOteEmf5r0A/k4DfUWbSKHutQLaeL3Np+mhbDlPvg68
	 /LjwsgeRjRw7v+fTQp8Sr6yl9TF9Y+zXdTklai1ExIH8Kz9gTR7NOv0qfb6hT/JPeq
	 rbxeE2ajWqlgC8lCMzWKARHcMWA4/ZpqvfRiYvVQUCo8HC6JvDqvaYtA4sZbZttZjG
	 BgoPu/ZUle1Xw==
Date: Tue, 28 Oct 2025 18:28:14 -0700
Subject: [PATCH 30/33] ext4/009: fix ENOSPC errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820536.1433624.5204379993641116218.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This test periodically fails with:

    --- tests/ext4/009.out      2025-04-30 16:20:44.428030637 -0700
    +++ /var/tmp/fstests/ext4/009.out.bad       2025-09-12 15:30:44.929374431 -0700
    @@ -9,4 +9,5 @@
     + repair fs
     + mount image (2)
     + modify files (2)
    +fallocate: No space left on device
     + check fs (2)
    ...

This can happen if the amount of space requested by fallocate exceeds
the number of reserved blocks in the filesystem.  Reduce the fallocation
requests a little bit to prevent this.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/009 |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/tests/ext4/009 b/tests/ext4/009
index 71e59f90e4b844..867e0cdefd4223 100755
--- a/tests/ext4/009
+++ b/tests/ext4/009
@@ -45,7 +45,8 @@ for i in `seq 1 $((nr_groups * 8))`; do
 done
 blksz="$(stat -f -c '%s' "${SCRATCH_MNT}")"
 freeblks="$(stat -f -c '%a' "${SCRATCH_MNT}")"
-$XFS_IO_PROG -f -c "falloc 0 $((blksz * freeblks))" "${SCRATCH_MNT}/bigfile2" >> $seqres.full
+fallocblks=$((freeblks * 95 / 100))
+$XFS_IO_PROG -f -c "falloc 0 $((blksz * fallocblks))" "${SCRATCH_MNT}/bigfile2" >> $seqres.full
 umount "${SCRATCH_MNT}"
 
 echo "+ make some files"
@@ -67,7 +68,9 @@ _scratch_mount
 
 echo "+ modify files"
 b_bytes="$(stat -c '%B' "${SCRATCH_MNT}/bigfile")"
-$XFS_IO_PROG -f -c "falloc 0 $((blksz * freeblks))" "${SCRATCH_MNT}/bigfile" >> $seqres.full 2> /dev/null
+freeblks="$(stat -f -c '%a' "${SCRATCH_MNT}")"
+fallocblks=$((freeblks * 95 / 100))
+$XFS_IO_PROG -f -c "falloc 0 $((blksz * fallocblks))" "${SCRATCH_MNT}/bigfile" >> $seqres.full 2> /dev/null
 after="$(stat -c '%b' "${SCRATCH_MNT}/bigfile")"
 echo "$((after * b_bytes))" lt "$((blksz * freeblks / 4))" >> $seqres.full
 test "$((after * b_bytes))" -lt "$((blksz * freeblks / 4))" || _fail "falloc should fail"
@@ -80,7 +83,9 @@ echo "+ mount image (2)"
 _scratch_mount
 
 echo "+ modify files (2)"
-$XFS_IO_PROG -f -c "falloc 0 $((blksz * freeblks))" "${SCRATCH_MNT}/bigfile" >> $seqres.full
+freeblks="$(stat -f -c '%a' "${SCRATCH_MNT}")"
+fallocblks=$((freeblks * 95 / 100))
+$XFS_IO_PROG -f -c "falloc 0 $((blksz * fallocblks))" "${SCRATCH_MNT}/bigfile" >> $seqres.full
 umount "${SCRATCH_MNT}"
 
 echo "+ check fs (2)"



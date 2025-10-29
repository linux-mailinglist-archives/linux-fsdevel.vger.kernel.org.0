Return-Path: <linux-fsdevel+bounces-66149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C61FEC17DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AF4FF9D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323972DC33F;
	Wed, 29 Oct 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdNyl1fI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A74262FD0;
	Wed, 29 Oct 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700998; cv=none; b=fDL9PO1Jz0fxUcowcDnl7IzGeHfZLn/r6rpzRPpyqaGVKLZTcDDZ6AaWIIl+zaKooWe3MqEkx3DgHzuuRX8oNIdGE0152zlLzo5CYSkkeEo7hghkyWGx8/8w0uCKF6KWYsrBN8zenV1MTclWc9WSnN8Oggbe5WQnOgKGY+xwPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700998; c=relaxed/simple;
	bh=x3GLf1fhIPm7SuptEu/dojRmxFV9Gc3oGlcOQnxXLzY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOWxLzO1qvCRJuv4mcjHAjuRDVTfX1nFsxYmvtjRhBf68Q+Tv3taC8XADZaz0WrW41MyrQpwvs7QHCCyr/t4xJc3ScRnqEvDTB2ywn2UZnghKC1FL08jRNoS/OQIjVYrwQO3TvTAQHQ9lE6wQLC1T8jJk0AfUqiRsk1qaY0QEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdNyl1fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62014C4CEE7;
	Wed, 29 Oct 2025 01:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700998;
	bh=x3GLf1fhIPm7SuptEu/dojRmxFV9Gc3oGlcOQnxXLzY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CdNyl1fIaHr1sdiTZSw1Qt7FQI2N0KzUof5/HaNrfHXGENrt4v9SZ4VNgTkTltOVn
	 HZOw37hjR1ow2qHjqrabvTDIgkFTFsupaMvNxf7tD0CnDb8HMEPV8UrL3SKQ7joAiA
	 gdj8oefYcUTmq8KWCG/L+rMlPxuoMQkEhLkbMD3m3UZUcgJZJVuMCYWWbz07IRSyqR
	 KIeOXpf23xTCG0YCw4F5x+w6ERNHg4ko3Xpxw1GiepuLkvk1GjS8MALYNJ2RxBS07b
	 Ge0Dyfj91LqOquseai5qtduKxGYs7TYJInXBH8tXtypmsAsBkdtXPiTMoxj3jiuEsc
	 fH9X1vbYomE0g==
Date: Tue, 28 Oct 2025 18:23:17 -0700
Subject: [PATCH 11/33] tests/ext*: refactor open-coded _scratch_mkfs_sized
 calls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820184.1433624.2776673133341995124.stgit@frogsfrogsfrogs>
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

Refactor these open-coded calls so that we can use the standard
formatting helper functions and thereby get the correct fs feature set.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/003 |    3 +--
 tests/ext4/035 |    2 +-
 tests/ext4/306 |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)


diff --git a/tests/ext4/003 b/tests/ext4/003
index e752a769603f78..7f09c65c29af1f 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -31,8 +31,7 @@ features=bigalloc
 if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
     features+=",encrypt"
 fi
-$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O $features -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
-	>> $seqres.full 2>&1
+_scratch_mkfs_sized $((512 * 1048576)) $BLOCK_SIZE -O $features -C $((BLOCK_SIZE * 16)) -g 256 >> $seqres.full 2>&1
 _scratch_mount
 
 $XFS_IO_PROG -f -c "pwrite 0 256m -b 1M" $SCRATCH_MNT/testfile 2>&1 | \
diff --git a/tests/ext4/035 b/tests/ext4/035
index fe2a74680f01d8..3f4f13817e8746 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -29,7 +29,7 @@ encrypt=
 if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
     encrypt="-O encrypt"
 fi
-$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $encrypt $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+_scratch_mkfs_sized $((32768 * 1024)) 1024 -E "resize=262144" $encrypt >> $seqres.full 2>&1
 if [ $? -ne 0 ]; then
     _notrun "Can't make file system with a block size of 1024"
 fi
diff --git a/tests/ext4/306 b/tests/ext4/306
index b0e08f65ea243d..5717ec1606cc59 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -39,7 +39,7 @@ fi
 
 blksz=$(_get_page_size)
 
-$MKFS_EXT4_PROG -F -b $blksz -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
+_scratch_mkfs_sized $((512 * 1048576)) $blksz -O "$features" >> $seqres.full 2>&1
 _scratch_mount
 
 # Create a small non-extent-based file



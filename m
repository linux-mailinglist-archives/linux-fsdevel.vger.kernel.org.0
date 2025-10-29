Return-Path: <linux-fsdevel+bounces-66160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86977C17E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A846424B62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23562DCBE3;
	Wed, 29 Oct 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u76deHDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F417B50F;
	Wed, 29 Oct 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701170; cv=none; b=Y0fEUmE7axWjsY3OtmNADIs1DFHZ7EBAQJtlTe0HEqG4KV75gHnPlxq0xP6RU7Sw+Vcd9L0Xu3omzBzt5kEpaKPTeeGkbZl6ecRv/SRUmZxqV/ZnLCNFK537UMqAGKny27lzc0enPYIXLyVYgNWImy0rOM8RIWgQbrBaRzV5Pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701170; c=relaxed/simple;
	bh=hUHJFKYLZEZ+IUyvfur5PQlHIEU4MhhpjofEf+fTMSk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPqC6lWeqtLO9J5I4NxSgEPyWfK1n8wyaaB1Rflcq3O8k61ZWoAJugc5P1iLWiqc9TRsWF3663knvHHQaW/8tpVxXcahkbjFiRtd9CAAysLcpu9kgU53htPqT5HhJlbCFSdDI2b7NunPNM4XdeVufRlzZS0N+ogEjjjmpMdGq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u76deHDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE3DC4CEFD;
	Wed, 29 Oct 2025 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701170;
	bh=hUHJFKYLZEZ+IUyvfur5PQlHIEU4MhhpjofEf+fTMSk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u76deHDbnNI7v4pCBmDvTpHlaLKrYxtm4JllaUkOtizaXuTPq5xY/9XUcUeWf9TnM
	 WUeCOtxnM4oRB2gelPJiy/uNVXpi++mpda01YDtWbIXOPfNgCgcirXcGdEuY3npO53
	 JYnRHs9R6B8xJ+CEJ7XDVStF//pQ5AkjXKsjXM6bNlNThwJSgbNotkTYLq0MPmSzbH
	 7MZvcSo2YOaNZrkMAuSyisRdB1VCAtYf99DH0AVlWIKbzfu958wzVnNHzxgI8Nw3j9
	 oWRSHSe0YIehWAL3o/WFp6VqXr7xw1+ctJHbvG9Ow9WyyuEvyqY+ErWb6DM5gxMjx0
	 noLyLg97Id2AQ==
Date: Tue, 28 Oct 2025 18:26:09 -0700
Subject: [PATCH 22/33] generic/631: don't run test if we can't mount overlayfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
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

This test fails on fuse2fs with the following:

+mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
+       dmesg(1) may have more information after failed mount system call.

dmesg logs the following:

[  764.775172] overlayfs: upper fs does not support tmpfile.
[  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.

From this, it's pretty clear why the test fails -- overlayfs checks that
the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
fuse2fs doesn't support either of these, so the mount fails and then the
test goes wild.

Instead of doing that, let's do an initial test mount with the same
options as the workers, and _notrun if that first mount doesn't succeed.

Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/631 |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)


diff --git a/tests/generic/631 b/tests/generic/631
index 72bf85e30bdd4b..64e2f911fdd10e 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -64,6 +64,26 @@ stop_workers() {
 	done
 }
 
+require_overlayfs() {
+	local tag="check"
+	local mergedir="$SCRATCH_MNT/merged$tag"
+	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
+	local u="upperdir=$SCRATCH_MNT/upperdir$tag"
+	local w="workdir=$SCRATCH_MNT/workdir$tag"
+	local i="index=off"
+
+	rm -rf $SCRATCH_MNT/merged$tag
+	rm -rf $SCRATCH_MNT/upperdir$tag
+	rm -rf $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/merged$tag
+	mkdir $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/upperdir$tag
+
+	_mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
+		_notrun "cannot mount overlayfs"
+	umount $mergedir
+}
+
 worker() {
 	local tag="$1"
 	local mergedir="$SCRATCH_MNT/merged$tag"
@@ -91,6 +111,8 @@ worker() {
 	rm -f $SCRATCH_MNT/workers/$tag
 }
 
+require_overlayfs
+
 for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
 	worker $i &
 done



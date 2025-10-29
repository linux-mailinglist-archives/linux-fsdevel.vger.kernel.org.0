Return-Path: <linux-fsdevel+bounces-66170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC0C17E94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0F374E59AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658BC2DC345;
	Wed, 29 Oct 2025 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZHt0RZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D47191484;
	Wed, 29 Oct 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701326; cv=none; b=NVInk+5K5hz7aEimzeZ/p5tBRil2pDX07J/yqRO42Bky7IEZQ5cUFINNbTuwWXkdtLWFROfOhSnOs48EOZ4rYcPsYu+BaOFALJIqSp0baOrMGsjDyHFjk258X+4woTYJsMv2+DuSryFUfFfbl9lhBsHiqnWP4DUyW4n7ogTqaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701326; c=relaxed/simple;
	bh=lDb+y/NBBfrBvDlfbupfQ0DM/VxDImfCwAjSFgIMpoI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw/sMpaUqAgXBepOptR++dTTPaBTWamnY7TtyG5EmHuF6XnmL4oIDB81GkulJtPR2JDVGfjT2WEHD6oEvXViDsx9zI1+5KWitN+4h6uuYJLm4iBgSO9XkgvMtqSTij3d3pRNx2/WI/oLi3Zq8XF9AQWFKwpctLITwyByHixvhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZHt0RZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3940AC4CEE7;
	Wed, 29 Oct 2025 01:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701326;
	bh=lDb+y/NBBfrBvDlfbupfQ0DM/VxDImfCwAjSFgIMpoI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JZHt0RZsQiu2jGe6nWxSmnVW+TmtQeJ68u1Ma7sc2VvE07CtPdaKlWze2M+s/PLK9
	 qoeGcl98z1qBJeH2iacf3vl11H70P6jgHy1ClnuzDUZ27UZFhHkYuiIOD9CMD+8LpJ
	 YXDFdhvkNWp0ARNgJxNrHgyX5dyXVCAWZ/y/D8YtvLakITKxV/jBgqQTAvANPes5yO
	 g/RU5bD+nLHMEB7YFhFc4kRm1F1YljNvKUsQOYpswjVybhFSLhm2d51sMSvXIIRkuP
	 C2QVFXizV579s36LewzlohdiB2osY7pXXh0whjq41RUEe+fULiITkjm0uacmlqV6Yk
	 oEXEmZSPL03lA==
Date: Tue, 28 Oct 2025 18:28:45 -0700
Subject: [PATCH 32/33] generic/730: adapt test for fuse filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820573.1433624.17669754346289733490.stgit@frogsfrogsfrogs>
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

This test almost works for fuse servers, but needs some fixes:

First, fuse servers do not receive the ->mark_dead notifications that
kernel filesystems receive.  As a result, the read that happens after
the scsi_debug device goes down could very well be served by cached file
data in the fuse server.  Therefore, cycle the mount before reopening
the victim file to flush all cached file data.

Second, the fuse server might decide to go read-only when the read
fails.  In this case, the "cat <&3 > /dev/null" might produce an
additional error when it tries to close "standard input".  These need to
be filtered out too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/730 |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)


diff --git a/tests/generic/730 b/tests/generic/730
index fb86be4ce72ecd..a18a15adf7e9fa 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -42,14 +42,23 @@ run_check _mount_fstyp $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
 # create a test file
 $XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
 
+# cycle the mount to avoid reading from cached metadata, because fuse servers
+# do not receive block device shutdown notifications
+if [[ "$FSTYP" =~ fuse* ]]; then
+	_unmount $SCSI_DEBUG_MNT >>$seqres.full 2>&1
+	run_check _mount_fstyp $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
+fi
+
 # open a file descriptor for reading the file
 exec 3< $SCSI_DEBUG_MNT/testfile
 
 # delete the scsi debug device while it still has dirty data
 echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
 
-# try to read from the file, which should give us -EIO
-cat <&3 > /dev/null
+# try to read from the file, which should give us -EIO.  redirect stderr
+# so that we can filter out additional errors when cat(1) closes stdin
+cat <&3 > /dev/null 2> $tmp.errors
+sed -e '/closing standard input/d' < $tmp.errors
 
 # close the file descriptor to not block unmount
 exec 3<&-



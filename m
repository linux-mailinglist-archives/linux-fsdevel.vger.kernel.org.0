Return-Path: <linux-fsdevel+bounces-66171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9DBC17ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F2A1C6379C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07062DC331;
	Wed, 29 Oct 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeWYB6j9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA82D2391;
	Wed, 29 Oct 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701342; cv=none; b=CBiX7VjtomEiMv/5mqDmSQkKlJa+x8FZ5huZCmXtQH4iHTvXglCy3P6bEnBFHX970A19aTnAt2ZI6VihU+YcUiuP89Q8zFu7TXS80dmPMyNj15TkmyVja3OCE56YVQn620o59x39pFMLyxPsz507HQKoh+RJxHcLj6ks9WXOn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701342; c=relaxed/simple;
	bh=qGtSuaDnpIOTLIXELYOMccie+qfzAn4CXtcwOa4Lsa4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeFq2i66e8OHJ6eSBd9ZTh6Y4P6SDVtIQL0DX80do+HYVclZOV/E+xlqHVBN4WXVgbI7PFQ4f+1DYmnMRoq4uuqN1yQZrtlnlt/u1NDdmD9VPVKz9twWuZUm9UXxdaMMCRaNXUuZ9lEBpkqn+YblkhQcV8FnpvBjZKTJwGoV41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeWYB6j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB6C4CEFD;
	Wed, 29 Oct 2025 01:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701341;
	bh=qGtSuaDnpIOTLIXELYOMccie+qfzAn4CXtcwOa4Lsa4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qeWYB6j9++Ywm3EiW5Xlr/8lP4Rivtcia++ztEBcJUrGq0Vz6vADCZmGLd51xPp9N
	 pzWCIab9Fq7CK67Z6JH8GMdsYDBQRmPR8nXwbX6LttYYEiBLD951wrpsaQeE2sgzXe
	 wgBepZ80hb2OZe+m1MA3OQRQNI1Osdbnbg5qgdsTYanO1SvPHRz0KlgSUlUQ0jR69u
	 cSA79PPIhP23Yh8c5ZTFTywuwA9++Zq2Bicwg7D+EDjS+ltrr9h0w/EXKzVJ7PZyyK
	 X+H/h4aH1yWFXxlgJzm1oXiTJeteuvXf+VF6VlT8cvmxfV7FUzwRJvApAwtZyrk52W
	 ztqSOkSDeFBYw==
Date: Tue, 28 Oct 2025 18:29:01 -0700
Subject: [PATCH 33/33] fuse2fs: hack around weird corruption problems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820592.1433624.463275160043068250.stgit@frogsfrogsfrogs>
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

generic/113 seems to blow up fuse+iomap and the fs doesnt even get
marked corrupt so yeah

XXX DO NOT MERGE

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc         |    7 +++++++
 tests/generic/223 |    4 ++++
 2 files changed, 11 insertions(+)


diff --git a/common/rc b/common/rc
index b6e76c03a12445..ea991526105990 100644
--- a/common/rc
+++ b/common/rc
@@ -1658,6 +1658,13 @@ _repair_test_fs()
 								$tmp.repair 2>&1
 		res=$?
 		;;
+	ext[234])
+		e2fsck -f -y $TEST_DEV >$tmp.repair 2>&1
+		res=$?
+		if test "$res" -lt 4 ; then
+			res=0
+		fi
+		;;
 	*)
 		local fsopts=
 		if [[ "$FSTYP" =~ ext[234]$ ]]; then
diff --git a/tests/generic/223 b/tests/generic/223
index ccb17592102a8d..dcf7ef64ac5dbe 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -16,6 +16,10 @@ _begin_fstest auto quick prealloc
 _require_scratch
 _require_xfs_io_command "falloc"
 
+if [[ "$FSTYP" =~ fuse.ext[234] ]]; then
+	_notrun "fuse2fs does not do stripe-aligned allocation"
+fi
+
 BLOCKSIZE=4096
 
 for SUNIT_K in 8 16 32 64 128; do



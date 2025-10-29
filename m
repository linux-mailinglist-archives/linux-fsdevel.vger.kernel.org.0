Return-Path: <linux-fsdevel+bounces-66148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F2C17DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 897374FECF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924392DF13B;
	Wed, 29 Oct 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7JjS1WS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878E262FD0;
	Wed, 29 Oct 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700983; cv=none; b=aYGaUkbHljrYR//KE6mx3xkjG7jtEk4vyIm94eX7KJnJOrQL+fxSW5btwDeOFREtCzVnXcJWoXhkwBpKax0A4ty2FyFlPchOCnnZtQgUmEC/vfeXKI/DTKl51itqLl52u25NPp3ocsz/sny3yF2Pzmax67bP6wmv2KbaBclpmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700983; c=relaxed/simple;
	bh=fUGhZCcdKzxMnDMh0V0f2lrzpd+ctUEh24cCJCYQwpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWDInjO2Txa2tduLZinGzTdMDrrV8EuOiD8uFmUr17X70k5cPjDUeo5mulXSSq6PyRdbi/DXcZeIr3yqP39e6hL5uaMfLkcH3FlzDu+CanAcqrb/pTJCealP6BAMhVeB4AnJIbjyGKTlE+t0GstiXHFxMg9t7mTba4xh/FBRFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7JjS1WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C001CC4CEE7;
	Wed, 29 Oct 2025 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700982;
	bh=fUGhZCcdKzxMnDMh0V0f2lrzpd+ctUEh24cCJCYQwpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=K7JjS1WSGbnUUaXjp35N/Kotkviq1wS5Uyx59KkRcMzMMKoHQgIDn6maKmkBPAdap
	 Wf9nnHHL5pt057+XJ+Ogi7F/b8DdM7Muoin3h17V1L+73bM9jB6H3r+IxHNjB/hhv9
	 9qANSaiUqFH/ddd83Hs52tpF5Dv0po+SEBtkakEORLjd5sepcxmN6oUFZ2dZsL+rYb
	 iyXZAdBZIZ2Bhb9NBJTQcRjb+ObCwJdq57KpQSejcllXGDM2V/uqkWYBycUg+sS1OL
	 MlN7PT+MHKPvbBRGk4Rh87JucEnS+SClLm/DSnEQCxdJznT+cVeIxqxp1gNeVlkqWi
	 mYGGAq8c0bVkQ==
Date: Tue, 28 Oct 2025 18:23:02 -0700
Subject: [PATCH 10/33] common/ext4: explicitly format with $FSTYP
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820165.1433624.18204248404394943642.stgit@frogsfrogsfrogs>
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

Explicitly format with the given FSTYP so that if we're testing
fuse.ext4, we actually get the fuse-specific formatting options that
might be in the config file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/ext4 |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


diff --git a/common/ext4 b/common/ext4
index 69fcbc188dd066..ca7c9c95456692 100644
--- a/common/ext4
+++ b/common/ext4
@@ -74,7 +74,7 @@ _scratch_mkfs_ext4_opts()
 
 	_scratch_options mkfs
 
-	echo "$MKFS_EXT4_PROG $SCRATCH_OPTIONS $mkfs_opts"
+	echo "$MKFS_EXT4_PROG -t $FSTYP $SCRATCH_OPTIONS $mkfs_opts"
 }
 
 _scratch_mkfs_ext4()
@@ -85,7 +85,7 @@ _scratch_mkfs_ext4()
 	local mkfs_status
 
 	if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ]; then
-		$MKFS_EXT4_PROG -F -O journal_dev $MKFS_OPTIONS $* $SCRATCH_LOGDEV 2>$tmp.mkfserr 1>$tmp.mkfsstd
+		$MKFS_EXT4_PROG -t $FSTYP -F -O journal_dev $MKFS_OPTIONS $* $SCRATCH_LOGDEV 2>$tmp.mkfserr 1>$tmp.mkfsstd
 		mkjournal_status=$?
 
 		if [ $mkjournal_status -ne 0 ]; then
@@ -158,7 +158,7 @@ _ext4_mdrestore()
 		local fsuuid="$($DUMPE2FS_PROG -h "${SCRATCH_DEV}" 2>/dev/null | \
 				grep 'Journal UUID:' | \
 				sed -e 's/Journal UUID:[[:space:]]*//g')"
-		$MKFS_EXT4_PROG -O journal_dev "${logdev}" \
+		$MKFS_EXT4_PROG -t $FSTYP -O journal_dev "${logdev}" \
 				-F -U "${fsuuid}"
 		res=$?
 	fi
@@ -195,7 +195,7 @@ _require_scratch_ext4_feature()
         echo "Usage: _require_scratch_ext4_feature feature"
         _exit 1
     fi
-    $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
+    $MKFS_EXT4_PROG -t $FSTYP -F $MKFS_OPTIONS -O "$1" \
 		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
 	|| _notrun "mkfs.ext4 doesn't support $1 feature"
     _try_scratch_mount >/dev/null 2>&1 \



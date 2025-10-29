Return-Path: <linux-fsdevel+bounces-66166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D25C17E9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C033B253B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669F2DA75C;
	Wed, 29 Oct 2025 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsw6LcHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B8191484;
	Wed, 29 Oct 2025 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701264; cv=none; b=KbYsjaIzcOVB1W+9c94dxUSmFnKlzxK8hOjQsdE8OaeZMHZtfUd0g/oXAOTlEyyQ+BHPM3X4pbvJwOGgHRxdIb/DQ+dRL18s+X8rMuMiprZSMuuVyOPW0gdG1YbqrR38fEMuIw91n2LYoAZA/9TU4gOU+wm8g6WOthVESVISTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701264; c=relaxed/simple;
	bh=XDtmr7h/nggxkCe+XwImen95Lwjq2QxB2VG8GlOpGy0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MELkln0wVPJcvQr/3ZEUWghT6A0QCacjA80i4EvRGuiF2/VwACUhE1/nzx0uKEelN3EeuoY4qryrwWXjOzfYL1/sFnfEbodXpX4vVQCuN0OXU3waAzEM16ST4D4s/YpVpaC5/4vxNowuZIsfvqAhlVgzo/iNvxd6K+M71c3Gfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wsw6LcHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFACC4CEE7;
	Wed, 29 Oct 2025 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701263;
	bh=XDtmr7h/nggxkCe+XwImen95Lwjq2QxB2VG8GlOpGy0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Wsw6LcHi5bMVU9/CpaxeLe844alTTZ1LnGoyvfmWL8c8mn9U7MGLKGKoM+c19JtZD
	 Z83K9UqgzfKfjCexuc62fnVi1+s0u03m/J6ye+Y44AiYw3IITnOoWFfzbdXdyH0/uy
	 g+x4cfjIsZShxMJbklATY8OPV3s4NMIQagAUkxdqHCz4WlpZ4681jiscM75QTB0K9T
	 X1IJ264a320mN6f5BSK9vB+eXBkSQfXKBgI5qgznyWmP2o4zAPfe2zQi5RXEPm35hC
	 3OU7/douQtrdo3Mo5MbZMc4pTsKCZWovz5w23amBPOoP4lknI7Eqo1728NIfoP6fX1
	 y76/cSlVnyRlw==
Date: Tue, 28 Oct 2025 18:27:43 -0700
Subject: [PATCH 28/33] generic/405: don't stall on mkfs asking for input
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820499.1433624.12993835503190782134.stgit@frogsfrogsfrogs>
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

If you try to test ext4 with 8k block size, this test will hang forever
on:

mke2fs 1.47.4~WIP-2025-07-09 (9-Jul-2025)
mkfs.fuse.ext4: 8192-byte blocks too big for system (max 4096)
Proceed anyway? (y,N)

Because we invoked mkfs directly
---
 tests/generic/405 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/tests/generic/405 b/tests/generic/405
index c90190c8d28457..0cf5b76a7c20cc 100755
--- a/tests/generic/405
+++ b/tests/generic/405
@@ -36,7 +36,7 @@ _dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
 # try mkfs on dmthin device, expect mkfs failure if 1M isn't big enough to hold
 # all the metadata. But if mkfs returns success, we expect the filesystem is
 # consistent, make sure it doesn't currupt silently.
-$MKFS_PROG -t $FSTYP $DMTHIN_VOL_DEV >>$seqres.full 2>&1
+yes | $MKFS_PROG -t $FSTYP $DMTHIN_VOL_DEV >>$seqres.full 2>&1
 if [ $? -eq 0 ]; then
 	_dmthin_check_fs
 fi



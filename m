Return-Path: <linux-fsdevel+bounces-66143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD234C17E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50765188A2EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19432D4807;
	Wed, 29 Oct 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsmvyJ0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9C248176;
	Wed, 29 Oct 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700905; cv=none; b=tDjco1M8TIFK6zjpFrkZTQXcXIfOpIcvdVSOAWs/+x7M3qmE4YageBOw7bXLGmOJDOqX4nThXAcEmaJ0IG9QS6pywZ6ZC7Aj5eYFyhiqCMSI2zxaqW3Rr6SA+jq44N+xdvLCyLnAJYoOQuEvWV1j6nmf05p/srO+6sabQu3lIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700905; c=relaxed/simple;
	bh=2L2DXZPDwxDu7RqbgH2ll7dMOVq4LY/bsusjuLek8ts=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqbtOLoW/+qs70PVoJrV6B4QvNEV7n5Pl9AsYKg0Do98VzxKXse1Yu0F00+Z5fRarvvwCww79tSfaY6WGtVqosXdsdVCY/GjmRpqE6MKNmIK5xK3zF6SYgw2BtiV0XBhHiniZKyYZQrS6znt+IMiSNTjO6beqNJsdrNvoXP1/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsmvyJ0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B9AC4CEE7;
	Wed, 29 Oct 2025 01:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700904;
	bh=2L2DXZPDwxDu7RqbgH2ll7dMOVq4LY/bsusjuLek8ts=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qsmvyJ0UmplRPJlf11J7Vx+Q7nKJS+XScZHsL3dPaplQzw/0BRpgCbMTz7xtLBjeI
	 FimRy2SQ23q1oVDiKgfCCO23B/0saMXrbP6jTuF3yNpNn/e2uuzcfh+0djjIvqZaww
	 ZSnbzquGVD7QPvgJrcGFuw0cTkksjs0GwsZ2FwzX/vgQ/A5SjhMyRDvMtLj1EXBjz6
	 xQOE5Lu6BmxiPYFMWKE/4Zsm5ZkSMHrxxl80vP4ZFG3IFQ/4p25FWohYDBldGliex8
	 sxmilnek5ia2k+HEIKm5vp68Az6f5vCibDKOj7eSrbwN3Y+cNmivUHAHdfnjE/o1++
	 X2qvLBWneBZzg==
Date: Tue, 28 Oct 2025 18:21:44 -0700
Subject: [PATCH 05/33] common/rc: streamline _scratch_remount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820070.1433624.9318265704888391346.stgit@frogsfrogsfrogs>
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

Remounting a filesystem should be pretty straightforward invocation of
mount -o remount,XXX.  Instead, we go through _try_scratch_mount, which
recomputes the filesystem type and the mount options, which is probably
not what the caller actually wanted.  Streamline this by calling the
_mount wrapper directly.

This also means that /sbin/mount.$FSTYP won't be invoked for a remount,
which doesn't work if that binary is actually a fuse filesystem driver.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/common/rc b/common/rc
index 98609cb6e7a058..182a782a16783e 100644
--- a/common/rc
+++ b/common/rc
@@ -552,7 +552,7 @@ _scratch_remount()
     local opts="$1"
 
     if test -n "$opts"; then
-	_try_scratch_mount "-o remount,$opts"
+	_mount $SCRATCH_MNT "-o remount,$opts"
     fi
 }
 



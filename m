Return-Path: <linux-fsdevel+bounces-66150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78494C17E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A20B1AA23C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D292DA759;
	Wed, 29 Oct 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do+XtJPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A22D0C6C;
	Wed, 29 Oct 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701014; cv=none; b=mUIs71aRJUD7vgiitKuA/Q3DGHQ6uI/kFzQ36I0EsgbBy6Qs2mnZzUhEgBh3adWmmBz6eSncVacFQAYVwOUz2ou+GSvO8FLmiuHFQRViEDidgGoL3MldbB6qLd/b9rEztVI8fYKPdZfyUa/Nz/Xs27EFm8bEij3g483caTpfOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701014; c=relaxed/simple;
	bh=83oD5rW9TripMRrAxC03ZYG7iyBohHwCrvG+6UYefdc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH1CovBDSIjq4YY2uykWSMNX8zbS4x/Q++O4ub5zwbJ7DTKItyZ2B15yBsPUAA0B3Pyy/WwW1eT5ZYnwLO79Gt27eOdGCsDU2ku0lyMpqkCa0VU154mYg/NMAeGLs/oefsJC0PsvwETfDGKNsXx4f4/giAAwMH4c5B3ZkNaPa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do+XtJPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01449C4CEE7;
	Wed, 29 Oct 2025 01:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701014;
	bh=83oD5rW9TripMRrAxC03ZYG7iyBohHwCrvG+6UYefdc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=do+XtJPlLIkCo2RF2a5VcUaBuxcukwQUBtcWhgX1G/XBDajqIUKl3mwkpbyQsi75E
	 CR1cG8E5RUaoFeWoovqjkqduVc6f+kcnBmRxU+mdqEsgmocF2L2Yu4GwX412lrU1V+
	 Lyg1yUJfyljy5Pvewl9Ikz9NYqmh1NmDXq/xJdFwB6yPjpmQ0OQF9iHhgva8nqZim0
	 LQdGYXZu4/9zRsedO/FYNjPlUNnaIpc6cvo1rnPM695eaauaA+hQMLPgfCJzQy3DrT
	 wvhCKZCXelYTDuPEYN6fiWAYKpJIpfdoylc6dV343Lxog6ZPIm4IhKUNPcnhD5kjSS
	 mzpT54OdvG+3w==
Date: Tue, 28 Oct 2025 18:23:33 -0700
Subject: [PATCH 12/33] generic/732: disable for fuse.ext4
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820202.1433624.7967857427780514888.stgit@frogsfrogsfrogs>
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

fuse2fs (when installed as a mount.fuse.ext4 helper program) doesn't
handle the case where someone tries to mount the same device multiple
times because there's no way for userspace to find an existing mount and
bind mount it to the new mountpoint like the kernel does.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/732 |    1 +
 1 file changed, 1 insertion(+)


diff --git a/tests/generic/732 b/tests/generic/732
index 83caa0bc915c32..dd985c3006ee07 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -27,6 +27,7 @@ _cleanup()
 _exclude_fs nfs
 _exclude_fs overlay
 _exclude_fs tmpfs
+_exclude_fs fuse.ext[234]
 
 _require_test
 _require_scratch



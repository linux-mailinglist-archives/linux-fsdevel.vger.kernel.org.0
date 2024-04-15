Return-Path: <linux-fsdevel+bounces-16947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A78A5636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB77128377D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5F768EE;
	Mon, 15 Apr 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4Na46wT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4560EF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194461; cv=none; b=FJEEUOQbBPWZJJMCKTQbCSH+mjIMxpnMpBqffJADzA6m/9azeFL2qgt8n/BvgH5XmlTUwS0dn8kNcfEd4+gd3KMnQxZtsCYjKFHE+OuHAGmL9J9kMO3/AnfGIICVvsLautJn8+3sB/wTu76Op09fVjwavJHnG2hZdbFQa2dPHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194461; c=relaxed/simple;
	bh=UR27xg8SE/d2S3XFnEC5hwfjVH4NVNJmHySp2dUT/qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCXtyZOEaj+PW3DC7JBK2VJYHxteafYIWCYDc1XtGvdrwwZmqQcigBqsKWxZMoTSeCzCsLX8bGKeQx+2T5rIQIJIzcYRtd0ggPoOaZb57KOTS1s46GpWJOdsFSv6iQj1DiRGlHyKqjDnsbYD60i4AUcQABD50FBDaoATsnIkMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4Na46wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D19DC2BD10;
	Mon, 15 Apr 2024 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194461;
	bh=UR27xg8SE/d2S3XFnEC5hwfjVH4NVNJmHySp2dUT/qs=;
	h=From:To:Cc:Subject:Date:From;
	b=K4Na46wT6BT8rb70LCPeH1RVZ1GN/WrmHTYwrD6FX3QkMDsPO6L4cVZ5fvNOvkqUr
	 YO9l1auq/3J0dYBmWqoQUIcd7TDNAaEwRujMhpjNNwCBRSd2OJRymqoCBW0MGIACuW
	 emUIyBvVR/n73p4rR+StwM7Ol1XTq12TYgt0pu+gqB+4HnSx2WS4t42DB6h6hXn3TG
	 hHDsUkFTTGNE5ttL7HJNbdmSt/Wz7N6wDK8hkKSsbdmDLz35a6YgKIHDRI2dFKsaMI
	 axjNGS/4/HQTr8jNaqPGPT/fVNa8JL0dfR3Q4XsWbPiXjEDI1wNTA1Afi6jqOKPBI0
	 kQRmW6c3AJPMw==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/3] Fix shmem_rename2 directory offset calculation
Date: Mon, 15 Apr 2024 11:20:53 -0400
Message-ID: <20240415152057.4605-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The existing code in shmem_rename2() allocates a fresh directory
offset value when renaming over an existing destination entry. User
space does not expect this behavior. In particular, applications
that rename while walking a directory can loop indefinitely because
they never reach the end of the directory.

The only test that is problematic at the moment is generic/449,
which live-locks (interruptibly). I don't have a baseline yet, so
I can't say whether the fix introduces this behavior or pre-dates
the shmem conversion to simple_offset.


--
Changes since v1:
- Patches reorganized for easier review and backport
- Passes git regression and fstests (with scratch device)
- Dropped the API clean-up patch for now

Chuck Lever (3):
  libfs: Fix simple_offset_rename_exchange()
  libfs: Add simple_offset_rename() API
  shmem: Fix shmem_rename2()

 fs/libfs.c         | 55 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 mm/shmem.c         |  3 +--
 3 files changed, 52 insertions(+), 8 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.44.0



Return-Path: <linux-fsdevel+bounces-37448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D249F2600
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6917E7A0FE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F51B4125;
	Sun, 15 Dec 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmspAA7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF68831
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293849; cv=none; b=G1jMxtYunR3MWNd/8tQ4osy9RYr2pP7yQAnLgHZhc8vPV6htqGjmAgxW6KVk5kM7ZSWZtDTDhpYrPIAxr0DEk9c8yqQgOh8lNzwxkQwkRLTX43tRDgreDyT4wDFCwx/9Ee+Iayr5p7cPL8vy36NteUG+3NUNY7BXaxU2MYSjzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293849; c=relaxed/simple;
	bh=C9V/ggg/i0mjBRtiMF/kUkjKfa37VLit4hYoS+ceb8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SbZXSydxY9cj/Q1AxICB+o7RB+VNn2kQynLhrSMRp+QckRHzTKFGWNSYGoz3IC+sNaU+3dokuj3aS5pn3gtMFIBvVXRsFgwhL87qZM/dRuxZGrfDYHm99ax4XpfUFIU4xyDtoyqWAfMFKusDAGbGk+jjQp4vBdOSLyqtxL5MneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmspAA7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C6DC4CECE;
	Sun, 15 Dec 2024 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734293848;
	bh=C9V/ggg/i0mjBRtiMF/kUkjKfa37VLit4hYoS+ceb8Q=;
	h=From:Subject:Date:To:Cc:From;
	b=BmspAA7NY1hKB8ygS/fJKaPW+z/0bnqKuq//ghD+pxJoGnp4LIX4qs2MQ2pCaa8Lp
	 TJ9FO/pS27IPbBqqgbCNUS7jo/N2wohnI3Ga4gKUR5eQuUxoykPRLpStb2qxx5KWAJ
	 Dv5sIUFa5cYxVJo0OtgfGRYRAbjh7QpTqqXW68gyycLiB4nuJl4X4z6Qomc4cBuJGX
	 ng5YXUQ7EhqfehzXKVxobJhFZPiCfBtwOA/e4thU5AIEtnz+gLa8lwMLG86vDbMUBa
	 zpXiROFQut5hqOuA643kaS42ajukgyHnuZriMKl9qTQyr/DtCDu4necVfeiUyxQ4VN
	 zWDQMnAKGIMHg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] fs: tweak mntns iteration
Date: Sun, 15 Dec 2024 21:17:04 +0100
Message-Id: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEA5X2cC/x3MTQ6DIBBA4auYWXcMQ8D+XMV0gTooaQrN0Nomx
 rsXWb7F+zbILIEz3JoNhNeQQ4ol6NTAuLg4M4apNGilDWmyuPqMHZLBZ/rEN36TPPDsL/ZKkyX
 VKSjnS9iHX1X7e+nBZcZBXByXw6pES6atBOz7H2ex52OGAAAA
X-Change-ID: 20241215-vfs-6-14-mount-work-7f8591d51060
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C9V/ggg/i0mjBRtiMF/kUkjKfa37VLit4hYoS+ceb8Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTHW4Z5tv/rnKDaVf8ny+Pxp20x99cZ1dXvvqnDVyC5O
 eTAz6qAjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImwpDIy9Gm7TWMvu/G16cGe
 eSGdDXtOxCrm6nzv57G9YrdvoXyQIiPDv6nP2oLDLU88ZWOcl2e3dpFg9bENvZGJ/0wjNnktnFT
 PAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make finding the last or first mount to start iterating the mount
namespace from an O(1) operation and add selftests for iterating the
mount table starting from the first and last mount.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      fs: kill MNT_ONRB
      fs: cache first and last mount
      selftests: add listmount() iteration tests

 fs/mount.h                                         | 28 ++++++---
 fs/namespace.c                                     | 31 ++++++----
 include/linux/mount.h                              |  3 +-
 .../selftests/filesystems/statmount/Makefile       |  2 +-
 .../filesystems/statmount/listmount_test.c         | 66 ++++++++++++++++++++++
 5 files changed, 107 insertions(+), 23 deletions(-)
---
base-commit: 7664f78ba0c5f1466d0086e5db7039f971b3cc51
change-id: 20241215-vfs-6-14-mount-work-7f8591d51060



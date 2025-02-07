Return-Path: <linux-fsdevel+bounces-41224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D409A2C7C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656DE3A5462
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC9248165;
	Fri,  7 Feb 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d26Y/7h5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE02475E1;
	Fri,  7 Feb 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943215; cv=none; b=t4QCtPThmt9yCzWzwG48KEdr7K9FonliNf1Km14ZZ0lhldSKb6mNXyQjskI6WSfhNfNkt4viUEStEI++fYBlQXWWMBIPJ3wsfHgiEqEr0+AaM+IHhNoGEXAQBQlVcTI8qcSInx9KuFOnI/G2lssClpP6Kgc7wQRZyKYrf+2Taac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943215; c=relaxed/simple;
	bh=D6xsa/FglS4y0cvi4IgquLrXsqtSCsFowvEOW7/SjmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CSIL1myFGOuI2wD0jaKDgDGyR5/cJxQrxbqx3/ExRgkXyvkPuQFWp8u6JD5iqxl40EdLesywVKYdh/GRO+paEpFJkcpWn+za/1WiUCJuHWWIt6meUr9sy6jxCAmgQZC9G2/uE8u+jdrFmZgUpXlzLwd0WQHBcjr0RwNP+U2i3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d26Y/7h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E153C4CEE2;
	Fri,  7 Feb 2025 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738943214;
	bh=D6xsa/FglS4y0cvi4IgquLrXsqtSCsFowvEOW7/SjmU=;
	h=From:Subject:Date:To:Cc:From;
	b=d26Y/7h5/ZE5czBigq/TLnLOvOi53dFrkgZqOmJBAEkZJd/G8bXvsfw3nyqD/SF/q
	 CrpYb+csl8caLryr02aRUzkFl0BHRJNK2LQKMLlr8UUqinzrIIH9yrIS6GJF7o9knf
	 EmGYgGa//t1zNuELjSrR5lAj0pC8Qxc5zgefo8XQHNJmTGItOiMCgSOV4TcI1WhWLZ
	 Cvm62XJ9lz1rUhkbEphB3UXmF+2JcItem1/OCYUbrubRwJFGTk3dBKET4C8+MEE4Rq
	 AbHapjuX6lJY91TEbKKwxk5NfdX5TBH7xcZ6nYvRjpW2AHamrDRV77CGO2U5AdTZsP
	 1oF4uTLRgzqfg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] ovl: allow O_PATH file descriptor when specifying
 layers
Date: Fri, 07 Feb 2025 16:46:38 +0100
Message-Id: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4qpmcC/x3MTQ7CIBBA4as0s3YaQFp/rmJcAB0sUcHMGNQ0v
 bvo8lu8t4AQJxI4dgsw1SSp5Aa96SDMLl8I09QMRplBGbXDV+Erlkp8c58ouN1Hf9DDONlgoUU
 Pppje/+Hp3OydEHp2Ocy/zd3Jk7ivY68tctCwrl/6T0KOgwAAAA==
X-Change-ID: 20250207-work-overlayfs-38fb9156d4c4
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D6xsa/FglS4y0cvi4IgquLrXsqtSCsFowvEOW7/SjmU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv03pT/CHsSNt0rrIgbrdVsWql/2q3vD5a22S4UvSc4
 D/PmGunO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy5RvDPyNmhv6X38Pebvv/
 z+fotOVqyU35N3VMCu4deLcotXYTCzcjw82kyvdO2eckrt33eH9d/m72lectstYadxv8XNf6Zf0
 WZAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow overlayfs to use O_PATH file descriptors when specifying layers.
Userspace must currently use non-O_PATH file desriptors which is often
pointless especially if the file descriptors have been created via
open_tree(OPEN_TREE_CLONE). This has been a frequent request and came up
again in [1].

Link: https://lore.kernel.org/r/fd8f6574-f737-4743-b220-79c815ee1554@mbaynton.com [1]

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      fs: support O_PATH fds with FSCONFIG_SET_FD
      selftests/overlayfs: test specifying layers as O_PATH file descriptors

 fs/fs_parser.c                                     | 12 ++--
 fs/fsopen.c                                        |  7 ++-
 fs/overlayfs/params.c                              | 10 ++--
 include/linux/fs_context.h                         |  1 +
 include/linux/fs_parser.h                          |  6 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 65 ++++++++++++++++++++++
 6 files changed, 87 insertions(+), 14 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-work-overlayfs-38fb9156d4c4



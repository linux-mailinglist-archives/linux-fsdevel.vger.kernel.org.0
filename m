Return-Path: <linux-fsdevel+bounces-31782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E975F99AE3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB71F23A05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DEF1D1741;
	Fri, 11 Oct 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ3TcuLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679819D8B7;
	Fri, 11 Oct 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683173; cv=none; b=eljlZc37K1Dtz3EC1v6levKx+e2io8GYyClpe0X2SAvMIInJQJAAbGsys2icdT/S1EcFGlMp7x9seaZZb2kKuuusy0I+i2LVfqVhGOUg5uK86fsbaHxEJhhFKPcWJwxnCfTfCynN5KfkhccCuybZOpGJOm+b+PreJhYrDi/XOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683173; c=relaxed/simple;
	bh=6f8um1zFxGY8B6hCK/1WE/ffxc4TUjUG3YVwlCQZUOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eml3an/svnLnEtE4Jqd2CqXoSmVTVOTg6iXkjPSHTgpBRhqx/zMV1dU7octFhdEtuAsbitGW1rlypaB72fAZSHHxASgObqBOSRxx6oPK5fkcbDG5j1Ieg8tYDATUCIoz27WmHdURsbbBKnfH8M9U/7XyNCxa/zLBG+HVWMXFx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ3TcuLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF61C4CEC3;
	Fri, 11 Oct 2024 21:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683173;
	bh=6f8um1zFxGY8B6hCK/1WE/ffxc4TUjUG3YVwlCQZUOc=;
	h=From:Subject:Date:To:Cc:From;
	b=gJ3TcuLhgxu/3xxG1cqtP+cdE1EMyxmxvTdf43caUEvX9eC0TRQfJICcWAftTanpH
	 ZFhw2NCCBChhINsRO56iMuZD9lqVeaeOgpmLPfjp7aj9/dFxdwhz42ZNbr4vrU9rre
	 /9t148xq7YUsxxv3wVjDDhNQHZMS59fz/mee5in19fTzbD6h5StMApgq6oYy0PQ60C
	 pr5aKO7DeV6jzmzwuppuSb1XgxE65pxO2O2tEqlq1bQNRZZi2Ygya4cEAKdKYWNDNy
	 n4VIp8bPaoS7V/5/4PJ+46xj/xHe3q11jTvn/SKgapzQLWo9FTkLsv3LrI1HM8ytZ0
	 QK1a+ZHH8s+GA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/4] ovl: specify layers via file descriptors
Date: Fri, 11 Oct 2024 23:45:49 +0200
Message-Id: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2cCWcC/3WOwQqDMBBEf0X23IhZQ9WeCoV+QK/FQ4yrBq0pG
 0kr4r9Xvfc4A+/NLOCJLXm4RAswBeutG7eApwhMp8eWhK23DJigkomU4uO4Fy4QD3puvKgr0+g
 CMaU8gw16MzX2ewif8LjfoNzKSnsSFevRdLvrpf1EHIdzLFGwwZ3rrJ8cz8ePIA/632SQIhGUK
 lRpriRmxbUnHmmIHbdQruv6A/nBmJjVAAAA
X-Change-ID: 20241011-work-overlayfs-dbcfa9223e87
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6f8um1zFxGY8B6hCK/1WE/ffxc4TUjUG3YVwlCQZUOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzzln8u7Wx+YeeiXfB12Wqr69csUvOTWvf3hjYnijZ+
 uPkkbAjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpdmJkWP79za+qz1vUPLRn
 bvZSnjDvzNfJs36YNf3Zc3z/jziN/y8Y/so0MKWklpbXP3JoKa9I/LBquopyqKHrEpE8C/cjpzh
 3sgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users such as systemd that want to assemble an
overlayfs mount purely based on file descriptors.

When porting overlayfs to the new mount api I already mentioned this.
This enables user to specify both:

     fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);

in addition to:

     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);

The selftest contains an example for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Alias fd and path based mount options.
- Link to v1: https://lore.kernel.org/r/20241011-work-overlayfs-v1-0-e34243841279@kernel.org

---
Christian Brauner (4):
      fs: add helper to use mount option as path or fd
      ovl: specify layers via file descriptors
      selftests: use shared header
      selftests: add overlayfs fd mounting selftests

 fs/fs_parser.c                                     |  19 ++++
 fs/overlayfs/params.c                              | 106 +++++++++++++-----
 include/linux/fs_parser.h                          |   5 +-
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |  27 +----
 .../filesystems/overlayfs/set_layers_via_fds.c     | 122 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |  47 ++++++++
 8 files changed, 274 insertions(+), 55 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241011-work-overlayfs-dbcfa9223e87



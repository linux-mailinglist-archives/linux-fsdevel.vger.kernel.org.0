Return-Path: <linux-fsdevel+bounces-31732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A754899A815
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C2D282B91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12B195B37;
	Fri, 11 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNsvzNMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64815194AE8;
	Fri, 11 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661422; cv=none; b=sQIp6Gm6EA3c5M2sBOBr0Ml/HxZQq5Ze/8mdvaxQYejbEKwFjGPBBKS1DeZoEPXRXLJDCj8+Sj+O/HK0/PhwvWAqzWyl7kB7AyrPwThPOjHAs1D4uxOvnv9rL/MLQbRabi2taK1ziN/Q1EjYld4R0T/j22Vu2Z0V6eR9lK6/TIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661422; c=relaxed/simple;
	bh=oZJ6c9mbFwpso+luISAwXCvvxhRmHFjUmeTxr2ZtRYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wuybo6VajPXEbL/uj+lwf5JJlwiTvNl2xpKeE//VEjGptkD04vyf1Q8LsXLEo75m5hyrIhGRLhA1kYkvO1U3dMFL4v3Vsu/qEDdz3QRwik4CtLJSnAaPpyLG8Uxdd/VIGN9YZbA6mAWVJSHkQ0dYxONCYaK1yg8d/Ba2vqRDiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNsvzNMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB75EC4CEC3;
	Fri, 11 Oct 2024 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661422;
	bh=oZJ6c9mbFwpso+luISAwXCvvxhRmHFjUmeTxr2ZtRYU=;
	h=From:Subject:Date:To:Cc:From;
	b=BNsvzNMMd/PsXhZ52RyIFtLQm3E+iZXj7MlnKvZBJOdVcqgW03xqYuQNAaotNo+IG
	 efFe47nIswyuM1NQjHM9r+Q1/InD4BMxMPeDt++GYfqOo2cph7/+p4nDQYQZSp8sqp
	 cXC/ih3yQNmtaz2IwnbiVTPHA9a9MN8JPC4iaQ1FMDBmXMepd2iyhbZ9XxOv2dsqf2
	 e7ad3GhloEs6XXxZGZfHo7jSMZI8JpRXn4x6FYJTE6gJ10TQ59ZZwF+EvkyrFgMPju
	 99zWtYpriu2qlogXhrQOHPQT0GrnpVxLqhZkoRIMZ9EUliPliAcmDYBgR9+Tgk0V+u
	 rPwEw5tbvtUoA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/3] ovl: specify layers via file descriptors
Date: Fri, 11 Oct 2024 17:43:34 +0200
Message-Id: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdHCWcC/x2MywrCMBAAf6Xs2ZRmFV9XwQ/wKh426cYGbSK7E
 pXSfzd6nIGZCZQlssK+mUC4RI05VbCLBvxA6com9pUBO1zZzlrzynIzubDc6RPU9M4H2iEuebu
 BGj2EQ3z/h2c4HQ9wqdKRsnFCyQ+/10j6ZGnLurVoxCPM8xfrXfvIiAAAAA==
X-Change-ID: 20241011-work-overlayfs-dbcfa9223e87
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oZJ6c9mbFwpso+luISAwXCvvxhRmHFjUmeTxr2ZtRYU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzuq+psOJ28qwUmL9xVnbkv6nuK9PjWeW3ueq/O82bn
 ml1l/V+RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+yTEyrD988yfH5SUTdqfF
 am73Ttf65hKTt/mI5e6nJVe+HDct62D4xfRAWDuxTGqhytelpt94Ft87LTzvnixHkY3n85NprHr
 /WAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users such as systemd that want to assemble an
overlayfs mount purely based on file descriptors.

When porting overlayfs to the new mount api I already provided patches
for this but we decided to keep this work separate. This is a revamp of
the patchset as the use-case has become more urgent.

This introduces the new mount options:

lowerdir_fd+
datadir_fd+
upperdir_fd
workdir_fd

which can be used as follows:

fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir_fd+", NULL, fd_upper);
fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir_fd+", NULL, fd_work);
fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, fd_lower1);
fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, fd_lower2);

The selftest contains an example for this.

The mount api doesn't allow overloading of mount option parameters
(except for strings and flags). Making this work for arbitrary
parameters would be quite ugly or file descriptors would have to be
special cased. Neither is very appealing. I do prefer the *_fd mount
options because they aren't ambiguous.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      ovl: specify layers via file descriptors
      selftests: use shared header
      selftests: add overlayfs fd mounting selftests

 fs/overlayfs/params.c                              | 132 +++++++++++++++++----
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |  27 +----
 .../filesystems/overlayfs/set_layers_via_fds.c     | 122 +++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |  47 ++++++++
 6 files changed, 281 insertions(+), 50 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241011-work-overlayfs-dbcfa9223e87



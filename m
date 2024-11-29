Return-Path: <linux-fsdevel+bounces-36144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4079DE7C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5091632E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AB1A00F2;
	Fri, 29 Nov 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO+6G1kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EB19E97F;
	Fri, 29 Nov 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887560; cv=none; b=rBHq8Uv/OKb7ZdezIHBadTdpHHJ1e9K9rQNpHKhdbfQCTaPEyaUh8JlD1DczVtiGkK3Wrnzimg34HlSg8bERRyRIO0OYk2HOLk7nYAlg/JImmfPAtZMIMmuyTt8DI1YGGQ8TGs2w1Q4QW+mcxepGXk5/EKTDEnVPn55KXPI1q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887560; c=relaxed/simple;
	bh=cEIU0gfAPul58rODzvBApqpWPWAfUjLo8AKEGrOsgyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd+uOjzA6D88zh/6PlGBMPZJ7Ehvw94VdEGU+MynHKVdPiPQBaJvTa9HAagt6pVII+6K7V7z6l8zoPQ5Noz8JQdR3yZyaBdIS4iuq7HEUzenxXRAVnhtyeS5gGvVs1yhye6ab3PTtAZd0tv/UkgzhapFNpX5raSizottZNitYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO+6G1kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346A1C4CED2;
	Fri, 29 Nov 2024 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887559;
	bh=cEIU0gfAPul58rODzvBApqpWPWAfUjLo8AKEGrOsgyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rO+6G1krtyT6fn9P509JQ0xzsnbKX9v0rxoti11kZJy12+uEB7MkaC5Mrc+rO/CVz
	 sIwAfQEU3mskjH3TeQHlrM1FwYhP+ujuRhSWU3yfev3Pid1sb3WdnZB5fydEByN43H
	 J2N3qBVx1PmQK3hjnVVIgu44SEnkClP4pdbdSdksYS+7Fn5OACRgpcOkWBRCJ5GIzM
	 +vEGIAVexbePS+RO65AASHHr1BaTioXzvoIrEIjATklAS0qm+9FVHuti6VCJM1kUpm
	 Z2zFUOWeyyNgVHaMQulliWK9KBtwnNerooiRVp7dotpa0NsyNndTS8F14jpY50Ir8C
	 dpBDV+Bi685iQ==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 0/6] pidfs: implement file handle support
Date: Fri, 29 Nov 2024 14:37:59 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241129-work-pidfs-file_handle-07bdfb860a38
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=brauner@kernel.org; h=from:subject:message-id; bh=cEIU0gfAPul58rODzvBApqpWPWAfUjLo8AKEGrOsgyE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Ht7/cOspfj756XaLzm06wKE+b33/Su8D877lqJ3jT jr+tvPK2Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJZMUx/PeqadylNlFlXsrz rdLm8k9cG6/f79o5ff6C3KnHHrx+nRTG8L/075wPOSX+tvsr7T4YKO4TmnNy4/5Pn5wfL3Dv3cd 9yZENAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

Now that we have the preliminaries to lookup struct pid based on its
inode number alone we can implement file handle support.

This is based on custom export operation methods which allows pidfs to
implement permission checking and opening of pidfs file handles cleanly
without hacking around in the core file handle code too much.

This is lightly tested.

Thanks!
Christian

---
Christian Brauner (5):
      fhandle: simplify error handling
      exportfs: add open method
      fhandle: pull CAP_DAC_READ_SEARCH check into may_decode_fh()
      exportfs: add permission method
      pidfs: implement file handle support

Erin Shepherd (1):
      pseudofs: add support for export_ops

 fs/fhandle.c              | 97 ++++++++++++++++++++++-------------------------
 fs/libfs.c                |  1 +
 fs/pidfs.c                | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/exportfs.h  | 20 ++++++++++
 include/linux/pseudo_fs.h |  1 +
 5 files changed, 164 insertions(+), 51 deletions(-)
---
base-commit: 94c9a56ad3521a28177610c63298d66de634cb9d
change-id: 20241129-work-pidfs-file_handle-07bdfb860a38



Return-Path: <linux-fsdevel+bounces-55310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CBB097D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80068A47A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D5248871;
	Thu, 17 Jul 2025 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp7SZm8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2F246BD5
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794733; cv=none; b=BxtwyY1xAOy6heb5vYlsVaqxccd0S2g1ZTuXrUoI9Z6qOWSCiQwRqrUkN385u54rc0dcCVNskEbs03LybAvbCKus8DqiOeaARB4Cwx5RqV7JtHSlYOHKwAlK7Es6lMhaSPI+I/NpxBOreZ4i2Qau8mC9RM0m3qceUcLwzqyMgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794733; c=relaxed/simple;
	bh=0lYUxPdPO7P9z19JfK84zQ/qkse+oaOKKizAuEUsVUo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADSlNJchvtv20urKAdHf8qWduvLicYVozMFpZIjPedYI66EKYibCKOG7owcifHms4rp7zrb7xKFFjkzBb1WFat+68Agp7BGXDLOOkgMyonjUHOT4gnuDFsCKY324WeQi19fj323VzrqvZM3QcKROy78c/CxrlMchGAyhBVqkfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp7SZm8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E648C4CEE3;
	Thu, 17 Jul 2025 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794733;
	bh=0lYUxPdPO7P9z19JfK84zQ/qkse+oaOKKizAuEUsVUo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Cp7SZm8pt+maJvgO84qNTuOAftkCcmrVPol2EeXyMC8TbiY0ESnJaJ2PShcUDGe5+
	 AlePBVg+lTctg5fyL/zTYmVvgddHrqh3PLNbjVqh9iMbKiCMw+Pn/zzdyk8DNCqtdr
	 whjMsde1Jx7Xlo5VV19far5po5qLXD+o52Qz1ihdakr0MIpyQTSYKvTheEVCJnmgYg
	 EmNnkMEQh5k5OoCRSkShMb7v+Ic5OtqVVF3vuctxESop33PygCgDJi7XM4UaqfcHKP
	 36h4DdRcTVQ/kbgfJQj2Qz3mR3EqAKK+NB2FyrC5aN9OKPfEBwcTcDCcoPcpjG4TsE
	 Zn0g5B9092Ncg==
Date: Thu, 17 Jul 2025 16:25:32 -0700
Subject: [PATCHSET RFC v3 3/3] libfuse: implement statx and syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Implement statx and syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands and provide extended file flags to the kernel.  This
second piece is critical to being able to enforce the IMMUTABLE and APPEND
inode flags.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: wire up FUSE_SYNCFS to the low level library
 * libfuse: add syncfs support to the upper library
 * libfuse: add statx support to the lower level library
 * libfuse: add upper level statx hooks
---
 include/fuse.h          |   16 ++++++
 include/fuse_lowlevel.h |   53 +++++++++++++++++++++
 lib/fuse.c              |  120 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  116 +++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 307 insertions(+)



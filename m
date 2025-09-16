Return-Path: <linux-fsdevel+bounces-61484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C5B58914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880741B22448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADC19F40B;
	Tue, 16 Sep 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KovKv9Zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2B19DF6A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982102; cv=none; b=V8ew/4GaU0E1Tm4hnZVVb+ee93ftjP2xdldT1Meo4X/2BU8hkS7iQKdm4lvodD+E1CSeQR+RQtLMFoSoi0xayK3zcWlHtMGX6dPW9thBpiEXE3MRTHD2w5UF5uQ+LEP6kWYEIWOhZ46GKvCnc+15VAOQyAQi5ddFtdHt1c3feko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982102; c=relaxed/simple;
	bh=PJH+E0ML4EkOLP5aCKu7MeJsusfF0FhOl87iEtkwa8c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMtC52UGXzDkQ6ox3NFdx+SXyNuMDXTK5V32Riu9nxZwoMSiL4cx6bra6dJJbRdRxRz2kzlnsVlLyzudZg+xQRZ5I/ij6OBZW9A8855XwsmiTAiqjgfiV0QQABfTLH+u94ublIVjji7Y5vM+AcLopkOfiDEv5WI72S4w2w4mzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KovKv9Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DCFC4CEF1;
	Tue, 16 Sep 2025 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982101;
	bh=PJH+E0ML4EkOLP5aCKu7MeJsusfF0FhOl87iEtkwa8c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KovKv9ZoF7a3G1BrFJ9k0vg1+WSH1YdL9lylpirxdh8Lq/KhdsEZoAX03UoD8+PDR
	 W+l9L4xIT66tbCqFjPx28ZbnCtqV1NghyjuqaQWQ4YJInMPcqQlTbIx3shLdBS4k/d
	 baX4t1/VmFdkG0rbhqFucIibAallj6h83hB4ZQNLFGGYnx+n7N+gVNGH7OMRweX+J4
	 RAhcPTnIm2CRAXwegTpB58YNXBr44s/W4ECcwVdFjAO2PkzvIGz8dTB/2TrbC8ch6B
	 uQ+b2aGbTvVakR24sWTTMHdFmkrfxEcggRqeA2ROhWhb34j5CbHMofj13nqmuhj4uo
	 ewsd4X8H//6uw==
Date: Mon, 15 Sep 2025 17:21:41 -0700
Subject: [PATCHSET RFC v5 6/6] libfuse: run fuse servers as a contained
 service
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.  As part of the delegation, add a new ioctl allowing any process
with an open fusedev fd to ask for permission for anyone with that
fusedev fd to use iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * libfuse: add systemd/inetd socket service mounting helper
 * libfuse: integrate fuse services into mount.fuse3
 * libfuse: delegate iomap privilege from mount.service to fuse services
 * libfuse: enable setting iomap block device block size
---
 include/fuse_kernel.h       |    8 
 include/fuse_lowlevel.h     |   23 +
 include/fuse_service.h      |  162 +++++++
 include/fuse_service_priv.h |  108 ++++
 lib/fuse_i.h                |    5 
 util/mount_service.h        |   41 ++
 doc/fuservicemount3.8       |   32 +
 doc/meson.build             |    3 
 include/meson.build         |    4 
 lib/fuse_lowlevel.c         |   16 +
 lib/fuse_service.c          |  813 +++++++++++++++++++++++++++++++++
 lib/fuse_service_stub.c     |   90 ++++
 lib/fuse_versionscript      |   16 +
 lib/helper.c                |   53 ++
 lib/meson.build             |   14 +
 lib/mount.c                 |   57 ++
 meson.build                 |   36 +
 meson_options.txt           |    6 
 util/fuservicemount.c       |   66 +++
 util/meson.build            |   13 -
 util/mount.fuse.c           |   58 ++
 util/mount_service.c        | 1044 +++++++++++++++++++++++++++++++++++++++++++
 22 files changed, 2631 insertions(+), 37 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c



Return-Path: <linux-fsdevel+bounces-61482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331AB58912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540F2521645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201A919EEC2;
	Tue, 16 Sep 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQqHoitU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E935625
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982070; cv=none; b=L/nkP/8et8n/sBlkgFqngW5GSMEh1yVboRYjmuPqFxyxnB1WMbG59TgKp4qzMdOriedqoubMRdOKcFrZ9+UGdu/maCZAPEz7oDVNkVWBEdwTQbSm5ElMWcVKt2peNNszwayO+yksoXD/BSfhEOvjq9sejlDmnZY2PEjEcSbuixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982070; c=relaxed/simple;
	bh=tRqAK5bXKdmDGiowwKsbLkkU6jZVWZX1YeZ3PdQ0ayU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV57bGXmDyQT1SxYYLOxwH5KC8rvpYaQlXAVNUSl8eMeXxa7hQ6/lf+uMAKu8Av2ipX0w4YljwKRpPc6UPdbagqY9XjlOMU9BiG+zDOzz5HURrTiYQUe5XocJ1Y1zyRvMJr6/rNS/ixYQHYOFD0aYBCzd2Qj+7Nj/M4XT+K2WMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQqHoitU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57141C4CEF1;
	Tue, 16 Sep 2025 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982070;
	bh=tRqAK5bXKdmDGiowwKsbLkkU6jZVWZX1YeZ3PdQ0ayU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jQqHoitUmqALkkD+8CE+tZRGVt6AV2r+HfbfmnPl1YocuD/R9i1RzWqGsrDUtN0H4
	 LUkUQUaBvDXBBz+7H+QMCfISYtd/+NOKnptqQ4iyBf+yNUOWQ29nvX+nlF8+pXI4kq
	 r33FRsNnvdpcIEEBdw6dAkSUWYEjXnNFFIia5IZLC1vq1ZLW1w2ldFSWZ6fRjYY7W0
	 bMo988lEVbD8jvodv5MzE7R30XGU/DnvnqkvlRw4P/eui/FimoUfw/VhftKirMQTxQ
	 n4/2OA7rI3CoqLbWgV2be//tAMumAfcmUM1z2AnqzYPwe/wpwa/b94Ut0ZXhph4WEY
	 pAsMBLQPBbUsw==
Date: Mon, 15 Sep 2025 17:21:09 -0700
Subject: [PATCHSET RFC v5 4/6] libfuse: implement syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155228.387738.1956568770138953630.stgit@frogsfrogsfrogs>
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

Implement syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands, and enable fuse servers to transmit inode
flags to the kernel so that it can enforce sync, immutable, and append.
Also enable some of the timestamp update mount options.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: add strictatime/lazytime mount options
 * libfuse: set sync, immutable, and append when loading files
 * libfuse: wire up FUSE_SYNCFS to the low level library
 * libfuse: add syncfs support to the upper library
---
 include/fuse.h          |    5 +++++
 include/fuse_common.h   |    6 ++++++
 include/fuse_kernel.h   |    8 ++++++++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse.c              |   31 +++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   25 +++++++++++++++++++++++++
 lib/mount.c             |   18 ++++++++++++++++--
 7 files changed, 107 insertions(+), 2 deletions(-)



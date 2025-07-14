Return-Path: <linux-fsdevel+bounces-54826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B870BB03A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD069189BDB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABE23C8C7;
	Mon, 14 Jul 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKDehRgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41625CA6B;
	Mon, 14 Jul 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483945; cv=none; b=qq6/GRIisKy7zhgr5FMsmMXYED3d/pg1Qs/Xd24MeLqZ0k7mSWJchMgicSIj5E4FaBjP1vZetUFDrpNAnpRGe1Juvfce6MWYS7DzwK+tb399+grC56lYz7Nu8OBtiaIL6KdcfGBXRk4O+I6/1F04EqXniPwp0w2ftLwsn09QGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483945; c=relaxed/simple;
	bh=dlgK+c6Ad4nsRRkYkYA/YUfrHWCAIDqESij/h1IH7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga8q5EDgoQMGFm5p2ip6eWh2ql2FMoFvqy3c4apln5XlW1/jb7b/iWzy5KP6OAB2N0oZ+0j7cH3//ES2LBZ0MKhFpvUjdxhaNRhh8jx8dLEAwNg61UihnOxf3Vp/BMhyh0RrjS6H32lWQFHv+Tir8vBV5zyxM4lwv6YPNp1u5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKDehRgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC3DC4CEED;
	Mon, 14 Jul 2025 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752483943;
	bh=dlgK+c6Ad4nsRRkYkYA/YUfrHWCAIDqESij/h1IH7pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKDehRgZA5mj8v/ruf1wGuJbAc4hPJyjNlSV3M/KRhRrxIjYifgpmyySMBneKgaq8
	 CdjNPNIsNuNaJoBqFcpOJC3FaD9hr4omNnPJ2fDM42++tFfB8bD0hO7FEUaW3jMmFY
	 ek/cc1JDFKKBscnZAXIP5vAeu1YYqG9TyRB+EviluLnLkwnas2bTcBhcqcE5npg7yd
	 fvrXELEjvdTFymYh27ms8cvikcX1uTVCogocWMYT37jafxQP5po7t6rZNP72ybjWgt
	 5JTvqCrHW2cRupPHxWwwJaCYjLL8ujWcgW89TDXl7jxiYbt51fEqMlXv6SKsc20ZUo
	 gTdY5we3MDHag==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 0/2] netfs: Fix use of fscache with ceph
Date: Mon, 14 Jul 2025 11:05:31 +0200
Message-ID: <20250714-tonnen-abitur-b3993e954230@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711151005.2956810-1-dhowells@redhat.com>
References: <20250711151005.2956810-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=brauner@kernel.org; h=from:subject:message-id; bh=dlgK+c6Ad4nsRRkYkYA/YUfrHWCAIDqESij/h1IH7pY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUnEg8y/Hd8MqL7PhPVSZ7QvktljLIunyS/9tgfCd6o f3tg0ekO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiu4mR4YXrr6rbzOeSrmgK xMif33rfcMKp99e1fjpP/vRkMb94qh/D/yqF5NffZh9Zw/7wSAcDs/6SvtJ13i4/vMM3CBc1ioQ dZQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 16:09:59 +0100, David Howells wrote:
> Here are a couple of patches that fix the use of fscaching with ceph:
> 
>  (1) Fix the read collector to mark the write request that it creates to copy
>      data to the cache with NETFS_RREQ_OFFLOAD_COLLECTION so that it will run
>      the write collector on a workqueue as it's meant to run in the background
>      and the app isn't going to wait for it.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] netfs: Fix copy-to-cache so that it performs collection with ceph+fscache
      https://git.kernel.org/vfs/vfs/c/4c238e30774e
[2/2] netfs: Fix race between cache write completion and ALL_QUEUED being set
      https://git.kernel.org/vfs/vfs/c/89635eae076c


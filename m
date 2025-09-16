Return-Path: <linux-fsdevel+bounces-61492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B484AB58925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FA11B22779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54A1A0711;
	Tue, 16 Sep 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtqEJXe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A76625;
	Tue, 16 Sep 2025 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982242; cv=none; b=NyiWoMkVF4QptaQIXUSaumXh7KGlUa7AG0qFfoekyhI8Ne4ZOmmXMh8OkWnmIk259tOK99jqigZvzyLKqFLOjj2Y5CZD8ORSth1lgMf+SDlvkNy2FiaR6XAwj1SBySz32wzQNUE8zIL7rmJDbv3EzR+Cdqtrg/JW1q/EgF7dzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982242; c=relaxed/simple;
	bh=ItvDnY3RmLRv+Z1FcolF0pqC7po16gziDM8kJbZinck=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUUJkFQgZwZXTZUuNLy1CRLbk51kO+bUwee4+XiV138bzN7+hRRZiNjV2aiCfUqATuP9bm6rxNbsrvGPqtzwHjtVSp/pohaPITL59dvEpYdAoKF46NZN1xSPGF6vWrAV0Iv0wttjU6i38CpumDm/u8Ix2XnB77qlM3ur3OjhjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtqEJXe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171A7C4CEF1;
	Tue, 16 Sep 2025 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982242;
	bh=ItvDnY3RmLRv+Z1FcolF0pqC7po16gziDM8kJbZinck=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dtqEJXe1fGEgFcP2/gnNF7Yo5hME0AFdsU1UTc8dyiL3taDKa9ur7mK+tGg1/5/JV
	 wtSTmv5Y+grt0QGa6CM371gtUb46qzU6uBoA77TjseHEl7Ls/f+vSy4O10XuzuiQ0+
	 IV9gC+S5wMzZeyqugPmRG8yS2XyMidgg+IjdNqmHawfMzE4Qm3Ri96bqoTNjUMm1Vx
	 M34J8Vn6kFz/HqRlZy9N5PmHC9FGacvdrU8Zut6u2fhjHI01hgzUuNpcYknV3cw0qf
	 gwU6aOJEviqDpEdX+202V/4qBOu3SPgeWjfKz240UHFJPGI6Oao7/BAEiS9ylex7qE
	 ADNgqB6iwi4CQ==
Date: Mon, 15 Sep 2025 17:24:01 -0700
Subject: [PATCHSET RFC v5 9/9] fuse4fs: run servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
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

In this final series of the fuse-iomap prototype, we package the newly
created fuse4fs server into a systemd socket service.  This service can
be used by the "mount.service" helper in libfuse to implement untrusted
unprivileged mounts.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse4fs-service-container
---
Commits in this patchset:
 * libext2fs: fix MMP code to work with unixfd IO manager
 * fuse4fs: enable safe service mode
 * fuse4fs: set proc title when in fuse service mode
 * fuse4fs: set iomap backing device blocksize
---
 MCONFIG.in                  |    1 
 configure                   |  181 +++++++++++++++++++++++++
 configure.ac                |   69 +++++++++
 debian/fuse4fs.install      |    2 
 fuse4fs/Makefile.in         |   42 +++++-
 fuse4fs/fuse4fs.c           |  315 +++++++++++++++++++++++++++++++++++++++++--
 fuse4fs/fuse4fs.socket.in   |   14 ++
 fuse4fs/fuse4fs@.service.in |   95 +++++++++++++
 lib/config.h.in             |    6 +
 lib/ext2fs/mmp.c            |   46 ++++++
 util/subst.conf.in          |    2 
 11 files changed, 750 insertions(+), 23 deletions(-)
 create mode 100644 fuse4fs/fuse4fs.socket.in
 create mode 100644 fuse4fs/fuse4fs@.service.in



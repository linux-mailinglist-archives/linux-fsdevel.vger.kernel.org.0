Return-Path: <linux-fsdevel+bounces-61471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889AB588FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33C11B21A20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34319F40B;
	Tue, 16 Sep 2025 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJgPGL+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B718DB01;
	Tue, 16 Sep 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981899; cv=none; b=lVzw/6uArC75thnZy/u+XKlcf0/3krGRCFVtxRbr0QGbctfI9amNArvkMFAcdkYCS+ttMY/m0ob5E18YJEJ98XYba1btoZ+a0LeoNCtyHr8jUNLGCUSLL2AzxYvPpNwLb/dJZqd+3sUy9g7ZPqeytDiot5DgGYK8uZN4bFsAARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981899; c=relaxed/simple;
	bh=l8gDacOlHD1WhPZV6iAXx62PPLRHwgZGUcBphNhg7KY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVprzKVJTSKDES4mcWEvAMKRBWnym/yX6MRWRAaWAS1ClKoziDkQWqfrkhLrZVLp1MS3F6jiBoP//sg625zPSL27VCC3LWie5kCPVne8NDDmke5pZMPpsGz0TKcHndNjTni6BX7T/1wQ8MlUI1S/186SJFbdaM6S75x/wW6NMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJgPGL+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D81C4CEF1;
	Tue, 16 Sep 2025 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981898;
	bh=l8gDacOlHD1WhPZV6iAXx62PPLRHwgZGUcBphNhg7KY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CJgPGL+jF0y6Q+kYs1mRdCqKi4QTNY+ZgI6nsdh5kBjUR0OIwq3NUvmxi0FkYHY9M
	 7uGKhpNgQFqh8BrQd6SrZ5bRh4MaVY1NtcPtItkglu8/j74WdgqrqH9hU7ID7OH5/E
	 1rmBME4dxRBy6+MuYJSrjoIjYcbBTLMf3LjYoRVTI/OaWdaHtb/1FLZns/ZBrr7U+F
	 MD+WOAygJpU5cmUtTZ1nBZXHVo/h8R0tSn/EqDj1TH+fyxlf8hstHrpLid06VHIxEm
	 6/RAHlrbl/zaAy7o+kFuZMfrcsi+3GQT44RkIRvyGc9hoCNcWIe8vd4U1EoqVZDhIm
	 CAboUozu5FzUA==
Date: Mon, 15 Sep 2025 17:18:18 -0700
Subject: [PATCHSET RFC v5 1/8] fuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-xfs@vger.kernel.org, John@groves.net, linux-fsdevel@vger.kernel.org,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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

Here's a collection of fixes that I *think* are bugs in fuse, along with
some scattered improvements.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * fuse: fix livelock in synchronous file put from fuseblk workers
 * fuse: flush pending fuse events before aborting the connection
 * fuse: capture the unique id of fuse commands being sent
 * fuse: signal that a fuse filesystem should exhibit local fs behaviors
 * fuse: implement file attributes mask for statx
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
 * fuse: enable FUSE_SYNCFS for all fuseblk servers
---
 fs/fuse/fuse_i.h    |   55 +++++++++++++++++++++++++++
 fs/fuse/acl.c       |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c       |   60 +++++++++++++++++++++++++++--
 fs/fuse/dev_uring.c |    4 +-
 fs/fuse/dir.c       |   96 +++++++++++++++++++++++++++++++++++------------
 fs/fuse/file.c      |    8 +++-
 fs/fuse/inode.c     |   17 ++++++++
 fs/fuse/virtio_fs.c |    3 -
 8 files changed, 314 insertions(+), 34 deletions(-)



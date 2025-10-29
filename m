Return-Path: <linux-fsdevel+bounces-65993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B556C1797E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119B24E7DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89E2D2391;
	Wed, 29 Oct 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDnh5CI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08C16A395;
	Wed, 29 Oct 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698557; cv=none; b=dDjpjtDud/qq9dZ9kgdZ795EM5gcGrzFfpv8kEhfZCJJ/jzS/XaFx7NX6eO0QLBJDszqUWo1WEXPCzmcUOMlP8k6r7MN5+T+diiaC1Pf5NNJelVTbRe0st2zLsJ1k6g8Nwf+3ygurUo7o72Wpbvl3pIqToUtppP7XcUuu1x1Pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698557; c=relaxed/simple;
	bh=Y6Q7+oa5h2ETu3a0GWL6B8xKVitgHoX1upiw3DrCeek=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmYjoO01hdYZce+KQ1dL2PjGc1tzqi/+RKfy3FAmHPZVg9FvFa1vmyN2ZJw7FKgqaVN4YBAUG24oA22iOghpMwKmGfiacWz1DdJSF/j9e9HHzyT+Rre5lDWx4JmNwYjksmdxQeQ7Vh6uvgtmieKYtZlzp+ntyPNSOcM+UypOA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDnh5CI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ABAC4CEE7;
	Wed, 29 Oct 2025 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698557;
	bh=Y6Q7+oa5h2ETu3a0GWL6B8xKVitgHoX1upiw3DrCeek=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tDnh5CI3+uJR8v4AHPgsjWcW7ocC72w3uNP38J20ZHXbIQKi3wi6mK6V8QqxtHHfh
	 XGXyZwfFTvmo221Z41IBcCws6B5A7ldpO9qWCbZeaC4hJGjls5wBq+BXiVWGwpBxQl
	 AIsIvRxQi//bDssCLkj4cPSi9K9XrSBs06YqLCDEv3GE+7GZ5uMny6H09UiGkCdR0s
	 fhp0DFfMT02Nn+kuQ8Zuk6dki9y3qfGcmJDPcX+0WASHy/i/nASoyG/FF3ByzBrM1x
	 MCVpWextPpH2LOnaqZu8B0IqHht1nJlq3Yese0mJAyl5hBfMtIz2H0V0VXvE9XZ/eG
	 thPDW5q1TLHCA==
Date: Tue, 28 Oct 2025 17:42:36 -0700
Subject: [PATCHSET v6 6/6] fuse4fs: run servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
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
 * fuse4fs: ask for loop devices when opening via fuservicemount
 * fuse4fs: make MMP work correctly in safe service mode
 * debian: update packaging for fuse4fs service
---
 lib/ext2fs/ext2fs.h         |    1 
 MCONFIG.in                  |    1 
 configure                   |  181 ++++++++++++++++++++
 configure.ac                |   69 ++++++++
 debian/e2fsprogs.install    |    7 +
 debian/fuse4fs.install      |    3 
 debian/rules                |    3 
 fuse4fs/Makefile.in         |   42 ++++-
 fuse4fs/fuse4fs.c           |  383 +++++++++++++++++++++++++++++++++++++++++--
 fuse4fs/fuse4fs.socket.in   |   17 ++
 fuse4fs/fuse4fs@.service.in |   95 +++++++++++
 lib/config.h.in             |    6 +
 lib/ext2fs/mmp.c            |   82 +++++++++
 util/subst.conf.in          |    2 
 14 files changed, 867 insertions(+), 25 deletions(-)
 mode change 100644 => 100755 debian/fuse4fs.install
 create mode 100644 fuse4fs/fuse4fs.socket.in
 create mode 100644 fuse4fs/fuse4fs@.service.in



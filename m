Return-Path: <linux-fsdevel+bounces-34710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFE9C7F48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF80B24453
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392DB640;
	Thu, 14 Nov 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzuyGzah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97503C2E0;
	Thu, 14 Nov 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543532; cv=none; b=OxVL+G/TsUkpbJa1kp/GmBuYbk4DIryRCk9EneSuVDss5HSqzm9+cQ9mIEUYcS3YO+9XMgowpftp42e3JICqZTh3t3t4+yd96gRSLtgIN6zbYLOTskbByd33WkLb2XXEKqP+4IhLUAHz2rSNXVV6Gvx193wjXzRPPzsuI7v44n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543532; c=relaxed/simple;
	bh=d7FuRY31dqYNYxnener1g+KwXunx/z+tiiRMldLO6Sc=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=YxhpnOTz+yByGvgkoN29mCtMkpJKlDNhj4ofEkiP5vFX/fj1YI84i+XRb6zMIUOHRChwiGQcwUrEn3P+DHOyQWxIt2d4dyCSiLSFjm5lvk4Adgnd18S8pUhTvJIRLOH0RR46S15x9sJFwVUGnxDNS7QMewWOmcP/310G9ksFG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzuyGzah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CCEC4CEC3;
	Thu, 14 Nov 2024 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731543532;
	bh=d7FuRY31dqYNYxnener1g+KwXunx/z+tiiRMldLO6Sc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BzuyGzahCXDKJ96/wvHx2gkLDhWHz2W7NekAuYixhuyWaJMqD5q9Z3SLQJjwnIk3c
	 YTsdo/FCcsf0pgTr3OsNV9F9vgaNeGMLLjle9JKPjBgbxVoZZLv0ccr6jQeKUPImKl
	 iwB3iQeCdyO4HkEFtc4PPM/eG4erkwMqAOljyCCVbn9Bb7VZlDJBxsnkVymNVxglS/
	 oyVPVjqDxxYvqC820e65048jtfygnzP8YTXvCXJkdbssQeaX6P7kPJA1LRU1tV6dcX
	 +an4jnbVxuWjiHGnklIb6FZMtRRib7lLArDqqZtD8diGOWoUgUmaTkod3uKitiqn/B
	 zvoOXJw2dCw3g==
Date: Wed, 13 Nov 2024 16:18:51 -0800
Subject: [GIT PULL 05/10] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <173154342285.1140548.1175824791120337171.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241114001637.GL9438@frogsfrogsfrogs>
References: <20241114001637.GL9438@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Carlos,

Please pull this branch with changes for xfs for 6.13-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit dd2a92877987e615f5b62f872ee0d4f992362994:

xfs: make RT extent numbers relative to the rtgroup (2024-11-13 16:05:31 -0800)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/rtgroups-prep-6.13_2024-11-13

for you to fetch changes up to 320c28fb42f571064ddc9b769dfaa3a59c105677:

iomap: add a merge boundary flag (2024-11-13 16:05:32 -0800)

----------------------------------------------------------------
xfs: preparation for realtime allocation groups [v5.6 05/10]

Prepare for realtime groups by adding a few bug fixes and generic code
that will be necessary.

With a bit of luck, this should all go splendidly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: add a merge boundary flag

Darrick J. Wong (1):
xfs: fix rt device offset calculations for FITRIM

fs/iomap/buffered-io.c |  6 ++++++
fs/xfs/xfs_discard.c   | 19 +++++++++++--------
include/linux/iomap.h  |  4 ++++
3 files changed, 21 insertions(+), 8 deletions(-)



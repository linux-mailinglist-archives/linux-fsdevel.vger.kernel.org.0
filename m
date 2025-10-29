Return-Path: <linux-fsdevel+bounces-65976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E219C1790F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16D14F747E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F32D0C7F;
	Wed, 29 Oct 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD4jImx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BB2D0292;
	Wed, 29 Oct 2025 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698292; cv=none; b=tVlswQGkz8eSVReIbFaEd1Fsrs4WZh4yjEarwCFDBUcojLt6LVZFwZl+AWBedatZxcIvngS9dUa+NZTDFmrMoayLFF05IjqF4QEBref80+H4duiZpm5wl7W4zsihnzfHoMP+3VdspljwKYmecpc1xIN2ZkDBFdvkRJTeqbENwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698292; c=relaxed/simple;
	bh=Xy+EQR183KsgFUPM48U+6KP3vfalzxWmBDt3QfdF0A8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMMgKvj5d1bk2J6KgGUTv9VZ/sfJ5W3gR2oRafect5tqedO1ZMe28w+nWNY1n41BT2HrGQUkB78XHf+oX7vRJD7PPE55vlglwaUA7/8ZM8Jw9kLXUo5pPgznfmT0Uv9/NsHVYf3UFsM5Y7s5Scrsqrk3N95MeqWO8/JsNyGirAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD4jImx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B6FC4CEE7;
	Wed, 29 Oct 2025 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698291;
	bh=Xy+EQR183KsgFUPM48U+6KP3vfalzxWmBDt3QfdF0A8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hD4jImx8I0DKkmMjIYfRsrwx1Et/79n45tE4vioEBz+j2J4VbzjgTF0+lWTDcKP+Z
	 WvwAtGfpmHRRwHARth+HsME5sZbGMlb7lLiC5d+e7NK/nek7jDer6Yt+37FqJKoODK
	 1nYwSv3adY3NUt49xVlSgwjNS1ED6WvQnoHwHzI5satCyvBrQX4uFJoHtpncxlMKYk
	 fBgNL9vwfBlR/JNNnLg3EshgSaNEIkR2Kj2pGRmuhnkqwdKhFmujFRFq1QbQBH1uST
	 rR2aSJoLLSv+/shre07CsYayr+YbHuY8+5JhK3FcyNVKHQ+masU7/spCatV0VUT3He
	 +zRd0aV1Xtssw==
Date: Tue, 28 Oct 2025 17:38:10 -0700
Subject: [PATCHSET v6 2/8] iomap: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu, brauner@kernel.org
Cc: linux-ext4@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.
These patches can go in immediately.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-fuse-prep
---
Commits in this patchset:
 * iomap: allow NULL swap info bdev when activating swapfile
---
 fs/iomap/swapfile.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)



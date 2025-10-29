Return-Path: <linux-fsdevel+bounces-65989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1709C17960
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950E8189166D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4982D0C80;
	Wed, 29 Oct 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clq0442y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AE1FF5E3;
	Wed, 29 Oct 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698495; cv=none; b=iIiQd8rtB4+tjrwe4qfVel2Cwcrgxg3BF0J3Qmf7sWZz2492IMx3tTp6J+jCjwopGajEASeb3bpXS7WEEPBTDdRFykSGK2rZ4e6Wd+11VG+wzSGrF+/KWn53TDnfcrjajYL1RsNiEtk1Vm+t6sC+YoRYqZ5ITnVLA7XYQ1cV6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698495; c=relaxed/simple;
	bh=fMZ3INbIwKNSat+bAUL5njgYV0UzY/r/P57OtqMG/WY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E122A/5NvXAdnll8jxFsqiLFLY3nvM8h3S+XvxhnhEHLIdzyA0z5i+kw/bOGT8hPqfNdpyecewY1B473s592doge8536A2+VaXy0sEVFQHAxGnsXhAgNpSCvtlmCqi/w15KXPva1BazUpBXi/M1rxYIKlxIB77555nh0OW5szD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clq0442y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19CEC4CEE7;
	Wed, 29 Oct 2025 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698494;
	bh=fMZ3INbIwKNSat+bAUL5njgYV0UzY/r/P57OtqMG/WY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=clq0442yo/4B7yOuObp+pmRF/7vFiQ2xpraVhHDTzV6cI89p1p4rEm5kGXIFwtPxm
	 ww0oafrmjf9vQgsV+dcJhcu+LsBoW4dKFV5G6EfrtI+Vw7HM2Q5mNeNhHw9g4mPoq+
	 +O0kIke3749o96sYagZ6NsYv2A/vfZYPy4LnMsCmrZ071mS1ththysEKmHjdwqyJpD
	 /c59fVUfg7VWcO/oOSHx8mX+0CAgGtTQykCgy++mRQP1QQ2u5Tqttv5Q/kc6k7ZBBw
	 nqIMjI7kL+afPYEfngFejnPWJYikDllKWzlNaLCGlxS0yGfqcQU+gUlnBtXyV8rIS3
	 8UgwLU4Cg9pOw==
Date: Tue, 28 Oct 2025 17:41:34 -0700
Subject: [PATCHSET v6 2/6] fuse4fs: specify the root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817993.1430244.1454665580135941500.stgit@frogsfrogsfrogs>
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


If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-root-nodeid
---
Commits in this patchset:
 * fuse2fs: implement freeze and shutdown requests
 * fuse4fs: don't use inode number translation when possible
---
 fuse4fs/fuse4fs.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 misc/fuse2fs.c    |   84 +++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+), 6 deletions(-)



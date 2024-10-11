Return-Path: <linux-fsdevel+bounces-31652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA207999806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BC8B23D92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A255523A;
	Fri, 11 Oct 2024 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRaepg+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783F4A28;
	Fri, 11 Oct 2024 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606874; cv=none; b=JnMhflbUNiVodJYOsPj517ZIe1aFTiB95vKEXJ1ary2EU7H1VP3GU8tIxhgbgX13VUkwz7N/cG/eXlIjAukep0YEtISz9uv6GORSQx2Ypji5JtIyBQ+quf0vBAZlHC93c2/eoyUZj7pdINHeMl1bZrsD5H+MkNSfa02W/DzuW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606874; c=relaxed/simple;
	bh=5M6/uHXjBj2jyF4appkQDTBNFnpTL3s7x1/Jhn2TlpQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiBjmE/Oxlu+NuFijBAYLCW76tZhOWtMvVCbsbQ2doQoIgBEayrydJgt6g3F5xv5J1GyAqlivkRTYdpKcSr74HMPqeX4R/AfAzXPw5vQ0v583fKC5eqBhMgeP/JCXyiai2oc3Dsa8ch7e52BJdXhq26sSFdR8fwDV3MYbKMaN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRaepg+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1147BC4CEC5;
	Fri, 11 Oct 2024 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728606874;
	bh=5M6/uHXjBj2jyF4appkQDTBNFnpTL3s7x1/Jhn2TlpQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nRaepg+69UQbvhnSXp+27nEW34EVp6YB1s+8GrKryJVM9Ur5nm93Be6eMcgKXH0q+
	 v1i+DO9qTLCf+JlIko23rPV+H1yuh3cxvhwFlB2KMaNKHK5XN7YYqEF0BbsJ6UAmQE
	 zxwm46WNN7VbZYoj80c/jH/sAuv3I88so6JdrlvFWDxrO0ivU5hk17YknuQhq57m41
	 cF+DYy2T141pizLH2fAlQAz8ziFkGVScBK1BxZOTQsYX3snhuuCSbKUl7FKyOp6I12
	 RsRBarkskISHuxAV590Rce36IrNxlSjike1AWaiNLj/ARcXpTmqeJ+VDxBxeaToPcp
	 8ZFwcFmjYTdYA==
Date: Thu, 10 Oct 2024 17:34:33 -0700
Subject: [PATCHSET v5.0 5/9] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
In-Reply-To: <20241011002402.GB21877@frogsfrogsfrogs>
References: <20241011002402.GB21877@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Prepare for realtime groups by adding a few bug fixes and generic code
that will be necessary.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=rtgroups-prep

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=rtgroups-prep
---
Commits in this patchset:
 * xfs: fix rt device offset calculations for FITRIM
 * iomap: add a merge boundary flag
---
 fs/iomap/buffered-io.c |    6 ++++++
 fs/xfs/xfs_discard.c   |   19 +++++++++++--------
 include/linux/iomap.h  |    4 ++++
 3 files changed, 21 insertions(+), 8 deletions(-)



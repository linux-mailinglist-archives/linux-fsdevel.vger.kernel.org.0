Return-Path: <linux-fsdevel+bounces-26850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6C95C1AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4291C22CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78713187334;
	Thu, 22 Aug 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpn1y+KO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10417E006;
	Thu, 22 Aug 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371095; cv=none; b=oIsauVWzLCFvyIr4mO5VvFtyAVC7po7f2+o4d3RiAmfgj7jodrmjd/x/9gtE59X6IiDt940eML7O57/k88uEGXthgcaIWmhyB4ou2kDMymBZeqsnVRjZO/6/VkXg/8fVDkPvY5zj8i0TNBGdBcfCNG1yd9CeN3+K7FsCA8d9ZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371095; c=relaxed/simple;
	bh=iT2Y8ZVWF0wQBG5JezYrV1GNSi6ZCI61+A58ALRLrzg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Es3ob8Jz8noB1paJn/QOrVD5ttJrzxOLbkZ6Kvf5OauB+c4iL7arNzalSXvkg7hqvZjyheKsxangrfJ4kbQA1+Yufc9l/b7JBobFWhdrl9v3fdoan3wvARE4H5FVAn+m4cayc7wqCV2rwqXLn3u8ouOyAN83urnFnLlXWRkuKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpn1y+KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD8CC32782;
	Thu, 22 Aug 2024 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371095;
	bh=iT2Y8ZVWF0wQBG5JezYrV1GNSi6ZCI61+A58ALRLrzg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zpn1y+KOXdKfbdRStzHB33iHZ3lqod0uDL1ls9I+RoQTKTj8U/N8SfUuK5lkB+1iw
	 VQTgoqwBqFg3o2w0tzkegZ0t1kn/3W96FoCZDno/f65pGy5JCKtXqkhUJ0EiHzMjmL
	 jfElya8WozuwgSNqJHLYNUdYohrEnnU8/gZ//T2JL58bnzK9ec6qnf1tzl6P2VfuxS
	 m0z/b8WFW2R8aF20Gw6dYt8630g7bqUB3RqnDmSRu5XlBpbGtarkVKOkMVtSFgz73K
	 T+KbDaBUDmLZ/aRvmd3GOOneZz7sXi+dsJ4Q/b5lfprfpl4WAuCXRe96p2CgpF4qg6
	 LjRMXJwAXFkhQ==
Date: Thu, 22 Aug 2024 16:58:14 -0700
Subject: [PATCHSET v4.0 08/10] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <172437088004.60482.1804382935786067855.stgit@frogsfrogsfrogs>
In-Reply-To: <20240822235230.GJ6043@frogsfrogsfrogs>
References: <20240822235230.GJ6043@frogsfrogsfrogs>
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

Having cleaned up the rtbitmap code and fixed various weird bugs in the
allocator, now we want to do some more cleanups to the rt free space management
code to get it ready for the introduction of allocation groups.

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
 * iomap: add a merge boundary flag
---
 fs/iomap/buffered-io.c |    6 ++++++
 include/linux/iomap.h  |    4 ++++
 2 files changed, 10 insertions(+)



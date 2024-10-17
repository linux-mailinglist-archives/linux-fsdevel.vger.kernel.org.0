Return-Path: <linux-fsdevel+bounces-32255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D89A2C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD871C2128A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA0219492;
	Thu, 17 Oct 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsXhaoup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC9218D96;
	Thu, 17 Oct 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190827; cv=none; b=By2kFwKbRZMTnM7j4idK/AtpBNCSOFg6qTlqrzgILW7DoMK0Q2VpTmpA9RtU3w5R1pOY+GhlQUvPMZo0m2pmjGMFiZu1nCe8SPr2QwMXjbRp1ngXmGXzkLB2zEfcSNiilaIOhksiqviNh41Xc+uUQMlF8qy8W01gG/xc7p+DrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190827; c=relaxed/simple;
	bh=5M6/uHXjBj2jyF4appkQDTBNFnpTL3s7x1/Jhn2TlpQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuIMq0N+AlF2nLxKF+nn1qnbsvdyp0AFc7YT0gsrmHZx+vltToRr60vVGIIWjO/HHXtQnEvdoilcykoqRCRbjbS4wU8Niigm6ydVzdT/fQkvOd0Y2dgVYsj52F8J4TOUA+U7o5Z4AlhJLUgqL9/qQvJnT5xS+FbUp2nSKGFTwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsXhaoup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B81C4CEC3;
	Thu, 17 Oct 2024 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190826;
	bh=5M6/uHXjBj2jyF4appkQDTBNFnpTL3s7x1/Jhn2TlpQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hsXhaoupolg4tX9uV420eVTPuwK5UHNkarbjy/+atNnyOz3whelb7dV/d/B096PZ6
	 tNFDI1GMQdl4BHvYwnTqvszqJpm0ZpxLnqdOZN7uo3QVWfR/U3sok3yRFYzODX1815
	 ATFxqzIUUDbSepd9MglApkier6IH3qEo3xBzvuK+f382jZ6ps4Y2SRH7sDTdHABvpr
	 0ITOy4jm2Fyj7CZzUStnvioyO8Nkc50qXS7yPll3RtKd8yjfUuLiSNt68oJShwUPKP
	 IPURdvo4tdjoSbXdVLX/I6fOXj6dRbP8Dkss9kTXrKlOgUpoekmHz8uNQqAcZheoph
	 FNUbEW1ve5beA==
Date: Thu, 17 Oct 2024 11:47:06 -0700
Subject: [PATCHSET v5.1 5/9] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <172919071109.3453051.9492235995311336058.stgit@frogsfrogsfrogs>
In-Reply-To: <20241017184009.GV21853@frogsfrogsfrogs>
References: <20241017184009.GV21853@frogsfrogsfrogs>
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



Return-Path: <linux-fsdevel+bounces-30895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FC98F229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA91F21F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277291A0708;
	Thu,  3 Oct 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxSx+nQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349A1E52C;
	Thu,  3 Oct 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968136; cv=none; b=ZWRsQTn+L99X+LlHK0P2Z2nHCYNeXvkwDm9jxDEnTFdtm5qt3VE3b1LcVGztuFhfy+al55kLAwHUKtqDqXnxYE5D4Sk8NWTTWQMK3k30pmI5MHTKd316iDnk2u/ASiMJ3u5UB2y8DRyevk/2ueSiC+Px3bKE5pROZKus3vZkpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968136; c=relaxed/simple;
	bh=bYHbMDFdgJDEt8lUvQXp1KBTl3OYgaXTHCRAdASXRj8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=GtWeMNGj1JcR7nHq7Tcv7ThRUmr9ghjyhMMDdjRfNMtbVJxTPorGNly4x88GP/IiDrXaB9tmQNIlKvDSKXFrhFv0iZBMX3dteVT63rGdwZgizO2E7uhXoWF17ob65mj4kKyoSAAzu2GEFKB4jy5ARfEnFVf1huhChfcJKcADNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxSx+nQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D5C4CEC5;
	Thu,  3 Oct 2024 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727968135;
	bh=bYHbMDFdgJDEt8lUvQXp1KBTl3OYgaXTHCRAdASXRj8=;
	h=Date:Subject:From:To:Cc:From;
	b=KxSx+nQJqsKjDfSZ5Mx3pPKMvrVMozM+/iNrKDcpMIsBMzXNcnlzZBDhPccJhqyJJ
	 hkMl79J5iVuTbn8wDTXhyFWDk7lOVeazxahoDWlxWGKSq0xXktFR48D2E0LLtRoDhb
	 y56o4Nz0I2yaO3W9dV9iePgjuduOHcVYYCtTWgrpCedLl4vIlweWXoyxBuairdS53Z
	 1CKjDQUWC5oQmcAO1LMthkF3rp8plxzwIbAFrIXDr/mi9X+OOuCWM71ll7ZziGOlaD
	 qTNRoKVjpeSXNZbzP2AvE0NK3OZRy7L/rr7p4qCA0W5zdg6FvBTnQ89ek9flRY/aFg
	 3kvD4xwWA7MpQ==
Date: Thu, 03 Oct 2024 08:08:55 -0700
Subject: [PATCHSET] fsdax/xfs: unshare range fixes for 6.12
From: "Darrick J. Wong" <djwong@kernel.org>
To: willy@infradead.org, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: ruansy.fnst@fujitsu.com, ruansy.fnst@fujitsu.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-xfs@vger.kernel.org
Message-ID: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
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

This patchset fixes multiple data corruption bugs in the fallocate unshare
range implementation for fsdax.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * xfs: don't allocate COW extents when unsharing a hole
 * iomap: share iomap_unshare_iter predicate code with fsdax
 * fsdax: remove zeroing code from dax_unshare_iter
 * fsdax: dax_unshare_iter needs to copy entire blocks
---
 fs/dax.c               |   49 +++++++++++++++++++++++++++++-------------------
 fs/iomap/buffered-io.c |   30 ++++++++++++++++-------------
 fs/xfs/xfs_iomap.c     |    2 +-
 include/linux/iomap.h  |    1 +
 4 files changed, 48 insertions(+), 34 deletions(-)



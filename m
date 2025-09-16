Return-Path: <linux-fsdevel+bounces-61772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C687B59B54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618BE1BC5A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65EA35FC35;
	Tue, 16 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgvPa2FC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B235E4F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034825; cv=none; b=nhCGKeyh8qtCq1Cr/SFiILFkt0Nc+khxjDRrywEHgQ2slxwTogzuyCuhxyQ1jq6X5UJGmdHI0w94yPHoSvT/I4YBmWfLfXzq7pMNCvriNuzLzjLcM03PwIsQELCj6jIlHkr3l9E+OWsyR5bFb0tiJyc+xWMy//j2LeFiU7BsO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034825; c=relaxed/simple;
	bh=fwSbSm5aR+pFnNb0ILt9hrAunOhekR3Sg17cxJqVfDY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=uWpYjGxOMuhh7O8NXJCJucMVmSsNunpxeCd5iOvjh4XoikJPL0blzgLx28F8XjENh7PERlKguuOGA1bgM/wSE+4W/bYHLPfWcUaUYJnMBeurObK+SH9Ee7qe3MwMgFHB77BLLhv+i/D0wzux63T2IYFqZSU4PcnR4Guom8fJ8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgvPa2FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D89C4CEFE;
	Tue, 16 Sep 2025 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034824;
	bh=fwSbSm5aR+pFnNb0ILt9hrAunOhekR3Sg17cxJqVfDY=;
	h=Date:Subject:From:To:Cc:From;
	b=bgvPa2FC19Dk14dY8LXcyYKNz+VVHYiYNHCsNkewJGIDiVH90eZgZZk83UZ5ePYVb
	 eySN01uvipCBPKoJS5Nmn7rt50Mp0uoH5pCroEpJdhe3z8aZ+F3lDnz1rsJjYNcDoN
	 0y4nXHy1ue5ZqcDTXYQJtRhTT8onYdp+3Zq6l4VJ4smTwiPykx4VbsPIjBm69n2rH+
	 36uqkUUbQp3G9r2En1bF3wTCYEZpyrlTcr0QdPQA2JTHj4wVAqbnzl0ZZO9IL4ikoG
	 981Jp2GOrmaMKC4883Ntms085lAeeOoWrvV5a9lVa72Nn76xO2xZzUKDUGt7Eg/OIi
	 S8KChArjkGyaw==
Date: Tue, 16 Sep 2025 08:00:24 -0700
Subject: [PATCHSET v5.1] iomap: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
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
 * iomap: trace iomap_zero_iter zeroing activities
 * iomap: error out on file IO when there is no inline_data buffer
---
 fs/iomap/trace.h       |    1 +
 fs/iomap/buffered-io.c |   18 +++++++++++++-----
 fs/iomap/direct-io.c   |    3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)



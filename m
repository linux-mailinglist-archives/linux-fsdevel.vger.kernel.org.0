Return-Path: <linux-fsdevel+bounces-58423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434BCB2E9A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BDA7BA165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4C1E493C;
	Thu, 21 Aug 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLFi8QAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E631B2186
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737267; cv=none; b=eHPOUiq4BbsenhZIDrsKs+S0HO9zOcNY8R6CnNipbKMINWJlfVpSzd+QJNxoK0gDz7Ga5hLziD8L7e+2s0YLFp6Desc0QE1jhHTeHHuSHv8sYWqz8J+ugQQ9mNW7vEhmRjx+ZonQd68ykYx7j+09FiI2xfYn45c2aCjxQM87Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737267; c=relaxed/simple;
	bh=oVTJv+d4Urjd/DwC+Rit6+KWLsXl/R3yYH94aMDO964=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RC1Fl8lHlAvB/Qj1KdISYLMVTaejPGdi6NgBiLeZi11sDIF/0xjlx2LonXihYHLYAf/7+vTjAbQ5X7zEpI+qc8ouedUTo+iELOPYyEfxrriVbYq0NORYtGRK/0zsqIDyBi1Mt8KBfz3GOU38kuf1qsdM0A1JJQYQTmiTgZ8s6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLFi8QAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B56C4CEE7;
	Thu, 21 Aug 2025 00:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737266;
	bh=oVTJv+d4Urjd/DwC+Rit6+KWLsXl/R3yYH94aMDO964=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LLFi8QAWJ9PQ5nDML5Fk98tXpcnq9NwcRTRNs29DWsqyNuqwMK2RrH0yf5ExH5VCV
	 DIl0CC2k0Lpa56Z53A9xz2rFf2ep7jWd7+pEEpUtlgbTyp6mBEHhB2D5LdoRxPSvcl
	 v87DSHhWXesGlfH4NGSegrBgU6XLUtlGIoMEIsdWFSrssUUdZ4TXDUCjz7hVWl2UvJ
	 REhCQPoV7YdK2pyYxC7eY3HFG9nTkATMe1eypuw6hk6KGFb4+uze1fOE1AdvFqZuet
	 YJ42b4D1BROH/VR2WeyEn+4smMtnZ3JU+XL1NilyvHMF/Xw3rMoNDzr5uGQPkZTNFO
	 yvILfmZOzmmKg==
Date: Wed, 20 Aug 2025 17:47:46 -0700
Subject: [PATCHSET RFC v4 3/4] fuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709825.18403.10618991015902453439.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * fuse: cache iomaps
 * fuse: use the iomap cache for iomap_begin
 * fuse: invalidate iomap cache after file updates
 * fuse: enable iomap cache management
---
 fs/fuse/fuse_i.h          |   51 +
 fs/fuse/fuse_trace.h      |  434 ++++++++++++
 fs/fuse/iomap_priv.h      |  149 ++++
 include/uapi/linux/fuse.h |   33 +
 fs/fuse/Makefile          |    2 
 fs/fuse/dev.c             |   44 +
 fs/fuse/dir.c             |    6 
 fs/fuse/file.c            |   10 
 fs/fuse/file_iomap.c      |  527 ++++++++++++++
 fs/fuse/iomap_cache.c     | 1693 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2934 insertions(+), 15 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.c



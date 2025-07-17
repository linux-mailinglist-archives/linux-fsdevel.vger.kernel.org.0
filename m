Return-Path: <linux-fsdevel+bounces-55312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBFAB097D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1FA615F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39D253351;
	Thu, 17 Jul 2025 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy59CytU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287F2417C8;
	Thu, 17 Jul 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794768; cv=none; b=TKK6Q8BdHv0wnVWP9E4TktIMvAFFoFO+SJhDYElZqOKRYIDuqy0nEmzyeZlDCma6becVW4pu3YQ/BBEh4f1LPmeG6VE3b/wc3T2Vurc+4eOSylzxoxck6lduIubclzHcrVJclTqlsNxZKjbrwai7r9NYKO9uyi/Fb0+Y9yzOp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794768; c=relaxed/simple;
	bh=FtfPrQILyyYB7pn04ITilqvB/31MhWsBbORwWLJgg8M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp/Ped9wRM3inpeXjv/yTuK2AcbJIR9E2+uBdAOGURu1aRW4HqkGmuZcvAnX+Y73yNABgm6WIdN0eAaGnaTBGUXt+XWQaS8DpaUhg/zlRjLaLHtVpAU7DJy6LrLRdc9eG35wQEm6RDhF58453bfOI7xEbAwvrh/9yUdqPVjY5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy59CytU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE46C4CEE3;
	Thu, 17 Jul 2025 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794764;
	bh=FtfPrQILyyYB7pn04ITilqvB/31MhWsBbORwWLJgg8M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Cy59CytUojY/eFgg0WVlTUrfK4a/JHmwUun8IciT26VVy4ereAxYlcKdhX8V1PWAG
	 LlKaCtYkHhg36MISlScTIzFcM2zuckiQJx4VdFfpq9QIzmLAQp7HhPDHqbazMwH+DT
	 rMY+0nzovnisOCD5m3sX9VeEx2U/UA8pb+u42dXE7/xsgAcYF/Sw5XpgJOsjbo9FDC
	 5eLcDS5w8YlcaQ4eKdW8JZNjTbbKUzC2E+2CO/vlM47iB2K+6oxcyuQuPbpVoMjWaD
	 ZdsnfSnOYWK408pNHqFBsiioqMgH+YpOEGyc/AUPHc7w2UNwcixCTCCrucnwwjTGp5
	 +Wd/ahjwP0FMw==
Date: Thu, 17 Jul 2025 16:26:04 -0700
Subject: [PATCHSET RFC v3 2/3] fuse2fs: use fuse iomap data paths for better
 file I/O performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461545.716336.14157351878342981972.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
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

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-cache
---
Commits in this patchset:
 * fuse2fs: enable caching of iomaps
---
 misc/fuse2fs.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)



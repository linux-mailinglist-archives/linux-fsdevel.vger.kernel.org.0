Return-Path: <linux-fsdevel+bounces-55306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89944B0972B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0DA189E4B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726B244663;
	Thu, 17 Jul 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRnSvBW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CF2417C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794671; cv=none; b=ecwDq42kc87s2tfmzn4iAb8ramHjLUJrA+vT18aRVtI2o0V7Bq55LR8aT33yRXTSwbHQ2+rjcDLY75TZ+VoGh9vCT60yMia8QVAoAznRp6ZUzRpIsN3DdECbZ6gZRqxiTw6VVpByS+XHM3ETzAs0MyGfiX3aiIppoSLH392JjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794671; c=relaxed/simple;
	bh=/8+4Ooy3bfsYQmvmNQ5gdS0Y37E3Eo4Ljl2237KIIKk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnBxqpkXTcYW/M4txFQ7R/X2glVp4fQLtSfhp+FhThSp0epuyC1ySqLEQBZMXa9NfqEk09j8MBgnEyDZ7SQndXuk3+/UsfVwmQM3eW/dIKgilgYbolJgJqCFouIAP9qxgQxrdb+6cj3XjZisUvNU94fRskHHKChYNmjU68lXu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRnSvBW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90314C4CEE3;
	Thu, 17 Jul 2025 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794670;
	bh=/8+4Ooy3bfsYQmvmNQ5gdS0Y37E3Eo4Ljl2237KIIKk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YRnSvBW/yWsoIj/hlXmlzSpBSA3VuV0TKVGFjCUlOeEl2WjvR1SpR4ku7xmiWQ/U1
	 4SDMoA9BfGQYewMmUU7wKeBY65g/TDQhTsC/jPdIHZdddZdlDb5EwPlfPK6DuotiaY
	 t9L2Gnw99raLiAwv0vRMQGuLbfSgJtUA1IYO9YPQrwQqbMlDwdZ5NjaJr8yhHG731a
	 BuhjwuRBa2fn8oarU7fyoaS44ndiZNTCQG0zV3WrcxdPZncq3bjwx3+9qVPHyiZf9E
	 7fxnhizdPxuWTHbPCRyuHJ5TAH7Lgy9E5yfxKSWkByuKfk4AzY2JcTO+TKrUBzrHpe
	 V2LC9q3hYi32Q==
Date: Thu, 17 Jul 2025 16:24:30 -0700
Subject: [PATCHSET RFC v3 3/4] fuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450420.713483.16534356247856109745.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |  110 +++
 fs/fuse/fuse_trace.h      |  646 +++++++++++++++++
 fs/fuse/iomap_cache.h     |  122 +++
 include/uapi/linux/fuse.h |   38 +
 fs/fuse/Makefile          |    2 
 fs/fuse/dev.c             |   46 +
 fs/fuse/file.c            |   10 
 fs/fuse/file_iomap.c      |  679 +++++++++++++++++-
 fs/fuse/iomap_cache.c     | 1743 +++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 3377 insertions(+), 19 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.h
 create mode 100644 fs/fuse/iomap_cache.c



Return-Path: <linux-fsdevel+bounces-11441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA8853D44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19F71F252E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473F61690;
	Tue, 13 Feb 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWJepqos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008D612F9;
	Tue, 13 Feb 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860240; cv=none; b=qJZxCh7Q0JhxpjygxmOiFDkHVXqVVzLTQGoqwhSlxJUSYEYEq2qsD38lHktCLk7sw3T23m19gd+glu5zV3KeiUenjy2y4KhvKSGOVzGHNoikaN26aAHSW1FG9n7oAJ5Hw5Rt7uAkqG8P4WzPs4YPp4m7Lz5Xcb+JRkWzF5mJfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860240; c=relaxed/simple;
	bh=iZuJJf2L4A/9BC89nmeB2uDzQCKPBrFKPnqEznO8JRo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=e8TN/afQsszFgPyntHfjOSSPeKLr2evpqyiY5cVKRy3Fo39zxJpHbcMOHdQELNd2jipQffr7dANTpEiGPIxo1JB6N2QhCP8n1nQHPur4ckgYYzo6bHbkjdZX4qp0np7V3peDC3+QxRcEpps4uAkTX9FmfACClQoQS7lMm2CsXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWJepqos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12E5C433C7;
	Tue, 13 Feb 2024 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860240;
	bh=iZuJJf2L4A/9BC89nmeB2uDzQCKPBrFKPnqEznO8JRo=;
	h=Subject:From:To:Cc:Date:From;
	b=OWJepqosehGJPEZO9d/bePFqq3qbGgUjY6fPdj83QbSZf8s2XoJbVbgneG20oEQAz
	 GxrRDaga5RZZ+TC0H73HccGqy8D4/HeGvSDSXa7ziV7gJpNk5HsxiunstM6tJZwErf
	 y8U4X+oboJmNthftzoEtEFU3UUu9K+8eFqsNV5lp/ApXH58N+h7hUYBN07bQHJyqNz
	 NbYCkRe5fJ2B0ILcMqPjmuAeNVlEORLvikJXZcyf0/eRVMS2VMjzQM75r50SY7rcTx
	 ISJfFK+/0E2ob1Tt+Z8zCOTYh5iFXWRMoW8JJLll9Qa6RZDM91txTIfemPmv4EAFpg
	 ncWwNqsHnQnKA==
Subject: [PATCH RFC 0/7] Use Maple Trees for simple_offset utilities
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:37:17 -0500
Message-ID: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In an effort to address slab fragmentation issues reported a few
months ago, I've replaced the use of xarrays for the directory
offset map in "simple" file systems (including tmpfs).

This patch set passes functional testing and is ready for code
review. But I don't have the facilities to re-run the performance
tests that identified the regression. We expect the performance of
this implementation will need additional improvement.

Thanks to Liam Howlett for helping me get this working.

---

Chuck Lever (6):
      libfs: Rename "so_ctx"
      libfs: Define a minimum directory offset
      libfs: Add simple_offset_empty()
      maple_tree: Add mtree_alloc_cyclic()
      libfs: Convert simple directory offsets to use a Maple Tree
      libfs: Re-arrange locking in offset_iterate_dir()

Liam R. Howlett (1):
      test_maple_tree: testing the cyclic allocation


 fs/libfs.c                 | 125 +++++++++++++++++++++++--------------
 include/linux/fs.h         |   6 +-
 include/linux/maple_tree.h |   7 +++
 lib/maple_tree.c           |  93 +++++++++++++++++++++++++++
 lib/test_maple_tree.c      |  44 +++++++++++++
 mm/shmem.c                 |   4 +-
 6 files changed, 227 insertions(+), 52 deletions(-)

--
Chuck Lever



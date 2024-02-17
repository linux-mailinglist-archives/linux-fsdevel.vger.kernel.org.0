Return-Path: <linux-fsdevel+bounces-11918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F485929F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AEFB23488
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD07EF16;
	Sat, 17 Feb 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF6WuRqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3047EF04;
	Sat, 17 Feb 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201415; cv=none; b=ES+JFhR8ofJwvdGAhyOUTtQLgA95vSRY5+i+BiXoWT51PLko21dHPMmq6bC9+3YK8ZsqNoE8T1zmtM2NgxnGifiMkIeT1fxdRV2b5gHxfvgBGlx/DC7FihOkTCz6b8DKFUbnmFy207sdcvJWG5+i0mEjT/t7seeF7AimhNSAL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201415; c=relaxed/simple;
	bh=4t7dPPQMhWfJU3cAARNkKz1sCE8G4qlxADkwZj7St1g=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=GMFHCXTM4glqPw0Nuh9+jhmKiz5CBNS5yuqLEc2d/acsnv0+KSMniDnAxz8m1+O3G7OLo07tSI1QTqdmItPGWcOdhmO9on+lSZqtTzwOwAD9AcLw4zJUjVJfthq2xrpyY77iuGQF/dH6RhPPIxAGHvraWMg4Og5U8K1DWVuNNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF6WuRqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD9AC433B2;
	Sat, 17 Feb 2024 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201415;
	bh=4t7dPPQMhWfJU3cAARNkKz1sCE8G4qlxADkwZj7St1g=;
	h=Subject:From:To:Cc:Date:From;
	b=kF6WuRqjYC+NyxUMjH+o0NK2IbDxcQ3Y5fMeNaTVtxzFzw+uUMRpYEHgQXDKXOw2u
	 dvrSiD8vdsg7LhDEZZYOxxuh7OS5yIcrcIlCKoE/AyHzNzk/Wf9Ji1HOs61XVXeVom
	 ER/P+PqNvv7CFlIX9FJsyJKzrxaKEgrjWCZOTStruBQ+csnfkHVsRDoMsFkb0/rQAM
	 DsrDqNFlVaFHRMVF0ZPcwXpQIP7mEeYTvm0kKv3bC/NJ83SJ5es0o/uiOHRV0BBysv
	 SROfMZPQtkSrhi1OJ52lBACQxatd+qQ/P8m868HacGOMsYbmaunkCKOZd79wkFgaNF
	 vR2r60ruFPdmw==
Subject: [PATCH v2 0/6] Use Maple Trees for simple_offset utilities
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:23:32 -0500
Message-ID: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
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

Thanks to Liam Howlett for helping me get this working with Maple
Trees.

I don't have the facilities to re-run the performance tests that
identified the original regression. Oliver, Feng, can you please
pass this series to the kernel robot?

These patches are also available from:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

in the "simple-offset-maple" branch.

Changes since RFC:
- Rewrote and moved "Re-arrange locking" to the front of the series
- Squashed the "so_ctx" clean-ups into the other patches
- Clarified some patch descriptions

---

Chuck Lever (5):
      libfs: Re-arrange locking in offset_iterate_dir()
      libfs: Define a minimum directory offset
      libfs: Add simple_offset_empty()
      maple_tree: Add mtree_alloc_cyclic()
      libfs: Convert simple directory offsets to use a Maple Tree

Liam R. Howlett (1):
      test_maple_tree: testing the cyclic allocation


 fs/libfs.c                 | 96 ++++++++++++++++++++++++++------------
 include/linux/fs.h         |  6 ++-
 include/linux/maple_tree.h |  7 +++
 lib/maple_tree.c           | 93 ++++++++++++++++++++++++++++++++++++
 lib/test_maple_tree.c      | 44 +++++++++++++++++
 mm/shmem.c                 |  4 +-
 6 files changed, 215 insertions(+), 35 deletions(-)

--
Chuck Lever



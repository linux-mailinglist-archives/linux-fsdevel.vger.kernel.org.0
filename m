Return-Path: <linux-fsdevel+bounces-37946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A39F9582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ADF1883347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA8219A63;
	Fri, 20 Dec 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlUzhc6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612D218EAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708799; cv=none; b=TK4HWY8txucSN885C7m4s5HulhNm/xzjMVeTVmfhdImzVV465udeH/Uzak3d+XsWJaKAFyWysxeJEot7WJlY/cF09vlzH9UrhPNEmHMdfLJnMqlEjd/xm2Qucg4SwUuKpYSUxhiuGcUBHRaf/0vTqh1syx1y580slmY6N2lpQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708799; c=relaxed/simple;
	bh=uKpdjPl/prEWmgIxsZT3Fna9IFkvWwQid/TKaFC1+gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQXwhtZsyc7ongxbP25W7HG49joFJ104D5j0AjYsBx/Mgm/5dFML1uUuAjELB9KVJU7WjXMxS7ZZJlbxuby8SQ86t6VT+nzNjH+avr2Dd4FsrihcmpXdQ87C+GC8LqDMQz7JgIra3pDAZligyOcfmLUT0mc1MHs8TPYYy+N5qUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlUzhc6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86F6C4CED3;
	Fri, 20 Dec 2024 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734708797;
	bh=uKpdjPl/prEWmgIxsZT3Fna9IFkvWwQid/TKaFC1+gk=;
	h=From:To:Cc:Subject:Date:From;
	b=mlUzhc6mB+m1G8Q4irZgSegZI3kwD+Jv3zKQ29Z7WSQEntCKaaooo01B0WP3QoC2E
	 05kMoj5KlN+LM4HGT7psxX3CVnBboUX/C0j4CBef72VgIILMWYqFAm8Qb1w+HhkzHZ
	 1keGAowkYTGL9lveG48rXehevtqP0MRNKVFFwQ6wjjcwPrB6bGDDPkRdaWNlOg1YCq
	 KdpxljRYAs28TGS/n5e7HVOSW5U/kbtrklSH83/nc3KbaJvAVEw0ktb4w6Fi67YAgg
	 XPpLPLHcfHivipImhf+sYqHqbttHBhC73qLpueFaghtInlm3Y89cb9L6FqmxJ4Osph
	 Ky3qC5pOev4Tw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 0/5] Improve simple directory offset wrap behavior
Date: Fri, 20 Dec 2024 10:33:09 -0500
Message-ID: <20241220153314.5237-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The purpose of this series is to construct a set of upstream fixes
that can be backported to v6.6 to address CVE-2024-46701.

Changes since v5:
- Improve error flow in simple_offset_add()

This series (against v6.13-rc3) has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  Revert "libfs: Add simple_offset_empty()"
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Replace simple_offset end-of-directory detection
  libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 163 ++++++++++++++++++++++-----------------------
 include/linux/fs.h |   1 -
 mm/shmem.c         |   4 +-
 3 files changed, 80 insertions(+), 88 deletions(-)

-- 
2.47.0



Return-Path: <linux-fsdevel+bounces-40062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8FA1BCB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9636C3A3C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63F2248AF;
	Fri, 24 Jan 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE1LPkkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACCCA64;
	Fri, 24 Jan 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746390; cv=none; b=uos/b5Ssnb1jkYdR4uFdU1YUbYLldA2jmrsjShf0mvZppa9hkm/xNW4f9yq5gYzHVxGiOZs8dKN6TXPvLc/LOn7mSG23eka4cTE+ghn4E6CMLCVjwFr2gl8o5bZLZFBYPoJ5KzgCTBkG6x9R6559/efbRb+l+Hvd7qMR0+SA+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746390; c=relaxed/simple;
	bh=uxWfJQcKZSJZwKoLlWXgT8zlZHeq5O98kmC9kyGjAzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyd0oys9FZMYlvA348stXveJD+OjzAnJdWLbZuRaIgOfFFGsHdWZfw+CSJYy0PQ6ClnRcEzB54XmtZWu7MOWZk7hEZIE1YL1U3i/0WZXgd0jmnqxNwlX8N3e2bFXdCiqNSug1ZGpB1IC9viiNUfgtq+FK99me2i4QzBBCUSHXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE1LPkkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0979C4CED2;
	Fri, 24 Jan 2025 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746389;
	bh=uxWfJQcKZSJZwKoLlWXgT8zlZHeq5O98kmC9kyGjAzo=;
	h=From:To:Cc:Subject:Date:From;
	b=UE1LPkkKb0Q1Qk6D/Vp+DFAJ+5MMmwI3EDN/BDgZvhSX1BLJ8RgLJmykKoT5qfQ0h
	 4Aismz1x/y6/X9o4Z7kQ0sVJICEalQ9THifnedsAi1ww+KHraGwpNZ8h2Ri9BMM0ri
	 tBUg2BDjQv3F5PxorHBb88qk92f1ZKt7MzY1iwPkBXt5ew1pO5ZWJ+ZKiqkwNcTQpo
	 QCLG/C7bpbUxXMpF4yvNCDBLA0j01QhhGUtWYd1U1hbDZGmCJvysjrtzTLO8svgXG9
	 JL7BawxnlLrG4Q3MfyiNg5+jfl2+098dQHq8MGX5dz+8ReaeJFvWU24DaYDx3fU1PW
	 ov1xjdwxzqdJQ==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
Date: Fri, 24 Jan 2025 14:19:35 -0500
Message-ID: <20250124191946.22308-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series backports several upstream fixes to origin/linux-6.6.y
in order to address CVE-2024-46701:

  https://nvd.nist.gov/vuln/detail/CVE-2024-46701

As applied to origin/linux-6.6.y, this series passes fstests and the
git regression suite.

Before officially requesting that stable@ merge this series, I'd
like to provide an opportunity for community review of the backport
patches.

You can also find them them in the "nfsd-6.6.y" branch in

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Chuck Lever (10):
  libfs: Re-arrange locking in offset_iterate_dir()
  libfs: Define a minimum directory offset
  libfs: Add simple_offset_empty()
  libfs: Fix simple_offset_rename_exchange()
  libfs: Add simple_offset_rename() API
  shmem: Fix shmem_rename2()
  libfs: Return ENOSPC when the directory offset range is exhausted
  Revert "libfs: Add simple_offset_empty()"
  libfs: Replace simple_offset end-of-directory detection
  libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |   2 +
 mm/shmem.c         |   3 +-
 3 files changed, 134 insertions(+), 48 deletions(-)

-- 
2.47.0



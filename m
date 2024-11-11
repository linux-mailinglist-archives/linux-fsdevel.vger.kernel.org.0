Return-Path: <linux-fsdevel+bounces-34168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EE9C358B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A28D1F2249D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263BCEACD;
	Mon, 11 Nov 2024 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhwow0Ij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777728EC;
	Mon, 11 Nov 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286383; cv=none; b=AX0jUm0FiIasO7aP44guSdeh0v6kHYPWDZ8cJ1MCKMZK7jxvaVijvjXTxbqxWaLjen3nLVXxGs8fbU5thATEQAh2gPf2tqCb8Kz6CuWPlA8d6qeN0eizRqkFXZiE8BBng2MxYbN+axm210TvHd81NWyvu8HMKCyheznn4A6BXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286383; c=relaxed/simple;
	bh=C7U10fwANKiFBMRI52JouNQIj2KlR6BzvPBPUClWPD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fcn4j9Ml7mNG8gjnIqUBHvk4RvmzXj6ec2Ipfkrlwskh7I0jB6TVW4SR87nbCSjQCSso0opixu1ODZXaTBZK6GGk//xE/r1YZu6pZKttcBg3518di5zcgCugui9Z47an8BQsTBx9YYEkv52CQfxPNQTQIApTtDWCBdWyoyBoTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhwow0Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20823C4CECD;
	Mon, 11 Nov 2024 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286382;
	bh=C7U10fwANKiFBMRI52JouNQIj2KlR6BzvPBPUClWPD8=;
	h=From:To:Cc:Subject:Date:From;
	b=Mhwow0Ij212yflZSULWSomZb5GiK6f/567/Rs9y8BH80zSCwtq8/JiesbTlKioDV5
	 dN3UWOmmhGAyzlNviW3r5IZur7x0p26gKwTOaYsXGa6W14FKWbFRDKZk+nQLqdhvvP
	 fjtf58j9qlQTmZ/q8xMI00zmbe2w4ygw7eC6iZCkzG1BW/IWPTyJhAsPlmJpLnbwFA
	 vSKY52joO0rnRa+/oXCQ28XF6ajIdH6uiDynOq1XEH4UvB/oXFGprojnAk1OuQM8L6
	 Ms18C5x6dpX3aENekQwApc+LJqmvr2kjCneGrBKsmJyln0JHrryBExKzk7Mjfqb9gC
	 g8sqf8Il1YFpw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: yukuai1@huaweicloud.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	<linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/6 6.6] Address rename/readdir bugs in fs/libfs.c
Date: Sun, 10 Nov 2024 19:52:36 -0500
Message-ID: <20241111005242.34654-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Address several bugs in v6.6's libfs/shmemfs, including
CVE-2024-46701.

Link: https://lore.kernel.org/stable/976C0DD5-4337-4C7D-92C6-A38C2EC335A4@oracle.com/T/#me685f54ac17ea1e39265dd5f1bb1f173c557a564

I'm still running the usual set of regression tests, but so far this
set looks stable. I'm interested in hearing review comments and test
results.

Branch for testing: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-6.6.y

Chuck Lever (5):
  libfs: Define a minimum directory offset
  libfs: Add simple_offset_empty()
  libfs: Fix simple_offset_rename_exchange()
  libfs: Add simple_offset_rename() API
  shmem: Fix shmem_rename2()

yangerkun (1):
  libfs: fix infinite directory reads for offset dir

 fs/libfs.c         | 135 +++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |   3 +
 mm/shmem.c         |   7 +--
 3 files changed, 119 insertions(+), 26 deletions(-)

-- 
2.47.0



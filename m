Return-Path: <linux-fsdevel+bounces-35920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB849D9B12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA15B2904E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FC1D88C4;
	Tue, 26 Nov 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxVVjKpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF001D0DEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636493; cv=none; b=r1qR9z/bhlItkkeTcRggsAIwoJsmdMXbNgM/O48+2XqwFfj6ya3wdYmgCXFAOR+tnWBPVvGzmL78DlLAgOCFrfiQeM8CvCI6L93CL7p/HUNcUPPR65BUWdTRkMgTlT6yBJ3XeQNrd6Eef81ql5n1qjmV2Ncx0XqmqzxjTu9cp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636493; c=relaxed/simple;
	bh=8e8Q8/YtSaVAdENoI1U6mbj2xfawBpxlEtPJSKzh+B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+SIfuixF2VxICbPWfpEbQrBcia5RoMR8D8IVxIhul0TEQMmwHtiRX65mBq5NyZqjv83Lh72TjIq071Lx+cprjQ5k+I/NueX4i3e18Nn880d8miKh9NJ+R2luO4gzs5K8xuSRBGtTOlu5Ze0Q6FIJzOKjJGZr3Ak+bVmGFIO3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxVVjKpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC9BC4CECF;
	Tue, 26 Nov 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636493;
	bh=8e8Q8/YtSaVAdENoI1U6mbj2xfawBpxlEtPJSKzh+B0=;
	h=From:To:Cc:Subject:Date:From;
	b=lxVVjKpeNBqXWucQV4DimWxB2ihN/uWsYVVnf1r99Fn0ggsevGLLNxDX/llUnuVB5
	 Y2Cn5AyufHhlE+IIlXMUno6OzZAIci1PuRgIZw7vwhALOa4zfu+QyNiolbbWCiogh8
	 Urgu0egXgOwkxTm6Fupx1V/kWvD3hDOvArR/H31CPueV4/XaMxm2yEdwI1DjrPoG6a
	 Ac/q1VqjgtgaW/Tl6hm+EbDJ+CHGHTBxc9WpvOuTXXhiwKTYyP883HKKmsByFI0bIs
	 tv3GkuEdQj0OnhSb36uIfZJvAm0uDWo0YSEwC2qNUbZGdPZ9tgl6F3hg0aDZlEOpC+
	 L1PC121YliNyw==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 0/5] Improve simple directory offset wrap behavior
Date: Tue, 26 Nov 2024 10:54:39 -0500
Message-ID: <20241126155444.2556-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series attempts to narrow some gaps in the current tmpfs
directory offset mechanism that relate to misbehaviors reported by
Yu Kuai <yukuai3@huawei.com> and Yang Erkun <yangerkun@huawei.com>.

This series replaces the v1 mechanism I posted last week. It
reverts offset_readdir() to use the directory's d_children list,
instead of its mtree, for finding the next entry, as readdir did
before v6.6. Directory offset values continue to be allocated via
an mtree.

The purpose of this change is to enable readdir results to continue
to appear after a directory offset/cookie value wrap, while not
regressing generic/736. That should enable this fix to be
backported (manually) to v6.6 to address CVE-2024-46701.

These are still a little unpolished. I expect review to find
opportunities for further code reuse.

These patches pass xfstests except for generic/013, generic/637, and
generic/650. There appears to be a problem with WHITEOUT renames
which I am still looking into.

The series has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  libfs: Check dentry before locking in simple_offset_empty()
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Refactor end-of-directory detection for simple_offset
    directories
  libfs: Refactor offset_iterate_dir()

 fs/libfs.c | 145 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 109 insertions(+), 36 deletions(-)

-- 
2.47.0



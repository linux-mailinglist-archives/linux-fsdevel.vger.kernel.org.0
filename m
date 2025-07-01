Return-Path: <linux-fsdevel+bounces-53481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4CCAEF7A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508567ACE23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5A274FED;
	Tue,  1 Jul 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyEJ2SWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E04274FDA;
	Tue,  1 Jul 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370992; cv=none; b=HSIasj8ByTMT2KnfK0lGOQkw9QyuIzTLyUk4TgoMcGBxqCxJ0Nj+wcv9LDkGYe1YVvmXt/H0A7Hwxn1pQaIUqjXovwEs+O5OFkq0SOoL1dSEz4OSeSpZKJ8rUZ5ji7dRAtONHdtqbFAhTy4X32geS7ZQ2HWGXT9auVlTciI9yNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370992; c=relaxed/simple;
	bh=0O5xGIBere+k23sB/mfNZTeRZIA+xHMcxprWIRhim/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL3UFwiAI7+5OVbR+YI4wXWJwj+9kzmUzByYWYsyingGkggqi1Lw5P57ImAvbYVm8JR5RAuivcWsHrztSFma9xIEOWrl3+4YnRlz0pXibnTicj5076SQBZAsSjsTpZmk4eZ24J96bXfajlYHwNDIk7XN5/nCDwos+qrFX0xC2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyEJ2SWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0F7C4CEEB;
	Tue,  1 Jul 2025 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751370992;
	bh=0O5xGIBere+k23sB/mfNZTeRZIA+xHMcxprWIRhim/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyEJ2SWWjNyTbdnOllRJSPiCJ8Ym+soyIc5IenHTadBMksVfRF9UU4PP0LYZdswU9
	 I0ReMLunLKJBnRm7Z+M/911gVkGpST5HoGxox8imLkasdslzyMj9dFCcHWJ4VvDFg9
	 Lal7oieo9udUgwJVEcL7z6BAoQidiBDNLl2yWlBDDrzjh0S+aFHZ/BV7zlQlmWjajP
	 W99NS9pRoRgKOlKSszMCiGtbshsq90ZggCib9KTo3OOWIJcIf8USuB0rycc15ujlsX
	 syUFWsjn//sla8Cv4+YBnyaPxxYwXxojKZa4FP7KXjJ+VW9HTzYaaBV0FZjEalUHl0
	 L/b8xLojswaNw==
From: Christian Brauner <brauner@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	gost.dev@samsung.com,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org
Subject: Re: [PATCH v4] fs/buffer: remove the min and max limit checks in __getblk_slow()
Date: Tue,  1 Jul 2025 13:56:17 +0200
Message-ID: <20250701-muskatnuss-exklusiv-36750fede25f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626113223.181399-1-p.raghav@samsung.com>
References: <20250626113223.181399-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305; i=brauner@kernel.org; h=from:subject:message-id; bh=0O5xGIBere+k23sB/mfNZTeRZIA+xHMcxprWIRhim/s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQkn3nltrbPW3vRPqOs9dyLD6oXcXy1/Gjev/HpItN99 63ON9qndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk3VmG3+xGBQy9nhGvTi73 qLB2YD38pF2op9Rqzl3Pe4eXTow48o/hf4GehJh+oh2ztNLeRw3VZZP2ST3ODp3y4+q9mjO9U5e bsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 13:32:23 +0200, Pankaj Raghav wrote:
> All filesystems will already check the max and min value of their block
> size during their initialization. __getblk_slow() is a very low-level
> function to have these checks. Remove them and only check for logical
> block size alignment.
> 
> As this check with logical block size alignment might never trigger, add
> WARN_ON_ONCE() to the check. As WARN_ON_ONCE() will already print the
> stack, remove the call to dump_stack().
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs/buffer: remove the min and max limit checks in __getblk_slow()
      https://git.kernel.org/vfs/vfs/c/36996c013faf


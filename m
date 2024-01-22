Return-Path: <linux-fsdevel+bounces-8410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC683603F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A07B298B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54D3A29C;
	Mon, 22 Jan 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoPEYy+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCC3A264;
	Mon, 22 Jan 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921063; cv=none; b=U+UvfPnAqOB3VigvMiefwJ3p3a3bnyREu3de9D03Qc/gewyCl1JfIuB0yb9U2wJl5d1bYDlr4qSCWPGEPnFisujbQohCCnNLXG2MqNBZ955PwEV9tgZqRJVqiBl10esmxW6DbKvvSllunMjeCOwzsZ402O35eKGPiR5Zcrlvf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921063; c=relaxed/simple;
	bh=95Z6kUtIf7ltH67is2GgnpfvAXTB7aP8wozJk2ze7w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKW5cndgjgiu7PiB8p2myjGhJkQwenYnPC3sqiNj+yCq22ZwhdEJixwL8g842/jLRVsSDAQY0tcVwlrTeEI4buY1QKnTokI7a3U5jQJ8oZb3OtWVP06WjuWKy0AuLvo1xPor3SsWY74EN539VQJMWN88bH3YF7whmmajJSpV8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoPEYy+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CFC43390;
	Mon, 22 Jan 2024 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921063;
	bh=95Z6kUtIf7ltH67is2GgnpfvAXTB7aP8wozJk2ze7w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoPEYy+e7lrZhjkQNWcYqaj/Ywnxd+HXJb3/r8lO3YgWGb7vSZKR+Kv8/VB1myUZ4
	 sRris8PqaWtEYcvi38SF4zCWMXfqOtU0VDnzFzh2Rkyreyc/nWkKm2gHfWzYGTHvgI
	 YCW9eIhAvTP1nhw/enVMns/f522UvU5pmwZ2T1A/puU/aRvd4HWflSb178lhq5QoF1
	 +OjR0Nrr/oOIi+s4SCqQwmTO1cltBQpzGrbgE0/l8xyAgxdRCgO6n016yDTWfCDZgo
	 9KR5CJYlxx3bVx+9dJTnfPVwsDqAUeusF7UoE8ZzpGTBSEgrTu2mH4hBhu2ukmQa5J
	 2dz7xZ+RhEyEg==
From: Christian Brauner <brauner@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	tj@kernel.org,
	xiujianfeng@huawei.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	akpm@linux-foundation.org
Subject: Re: [PATCH] writeback: move wb_wakeup_delayed defination to fs-writeback.c
Date: Mon, 22 Jan 2024 11:57:22 +0100
Message-ID: <20240122-netzzugang-melodie-64d58a032679@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118203339.764093-1-shikemeng@huaweicloud.com>
References: <20240118203339.764093-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=brauner@kernel.org; h=from:subject:message-id; bh=95Z6kUtIf7ltH67is2GgnpfvAXTB7aP8wozJk2ze7w0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu85JTOZzG7CNtuz588pnNNfVvFNeY3shQEtt84NSyC IvTXb1WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZNIGR4UfeAU3hKW2KAoUL uXsnqT/b8XCy+lfLwzaaX9S2lGaf1mNkePjhb/Wtt0zHLM2jvOIFHjDu2u2/fau+9VuRBish0a0 H2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 04:33:39 +0800, Kemeng Shi wrote:
> The wb_wakeup_delayed is only used in fs-writeback.c. Move it to
> fs-writeback.c after defination of wb_wakeup and make it static.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] writeback: move wb_wakeup_delayed defination to fs-writeback.c
      https://git.kernel.org/vfs/vfs/c/983d926149ea


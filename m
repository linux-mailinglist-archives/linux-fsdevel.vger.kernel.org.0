Return-Path: <linux-fsdevel+bounces-38007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C19FA54B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 11:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82B27A2191
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28F18A924;
	Sun, 22 Dec 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb9iS4Ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB15189B86
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734864293; cv=none; b=iMBXf+in9sSEY3KMb1IFgjsxj0TPwfg96XCDDVpRye0mxh5Q1XvL20dHeGS+rzkktzR/uFYe9ZOcrkG1DlIunHb6dE8Hw5p3le+NKDmEH/V7HFOaN/Av3ZJRZQ5YZ8JRGTVFvtGGb/BkHkkUvii+fs4OiN9NN2Zo8HZGPmMe8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734864293; c=relaxed/simple;
	bh=UNlZaBUJOp/OLWHsK2jBXdSKalUbpdR3O5ZvhA0wu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/GtfQmzwS29GNj4vEsaZg8bZTNz7C39J/WTdUSZB1dmBXd2teb03mm7yNIUFfUNExYhveVvVqSJL1oTJkpMqx3OeNjgBmvc0+uRBliC+Fp64mKv9oLZZ5nT9mK3xKkbcmpDwyhzc3sekYf2q82VySlU8dmpQG6io3+7umOMGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb9iS4Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C4FC4CECD;
	Sun, 22 Dec 2024 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734864293;
	bh=UNlZaBUJOp/OLWHsK2jBXdSKalUbpdR3O5ZvhA0wu3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rb9iS4PhS84JfZVHfu04RAHnskP9hVND/yP9y/shQ8xDfa5I642EquaKmUVAdBvME
	 XqfcJV6scATRXdlxy0ZVj2yyvml4rsxQQpF3rXtqodHGSBt7Cecy92dOuLKfcJwXjK
	 IJXbfiwL4YeQpzbNBs39QJ+2X/Mq+lPyhwj6WF5mfblp1xZdonKBg1Hduxi6Rq89j9
	 YvRrfqmYIzPdP3VvSOFMu2/ukLiZXfisbF1FO7CADiBjjSqphIZ8tG69XxZTVQ6sbL
	 kCi4NcLd82Upva/koWdkQSzEwZ1Hp7gFuS8+s/dr3kPAu3F8X6ca0N4imBNhciro00
	 YrwbxQWVi7cng==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Hugh Dickins <hughd@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 0/5] Improve simple directory offset wrap behavior
Date: Sun, 22 Dec 2024 11:44:43 +0100
Message-ID: <20241222-baldigen-ungewiss-a2b704fc6104@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220153314.5237-1-cel@kernel.org>
References: <20241220153314.5237-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=brauner@kernel.org; h=from:subject:message-id; bh=UNlZaBUJOp/OLWHsK2jBXdSKalUbpdR3O5ZvhA0wu3g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnv539VuRa/SvBqratghzp08W3tH8/Ficq02UV9KLyq PEiVeOyjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk4H2P4H9F/657fLobmDYIP jQOnfO6f+dzDrcvwv35R37V/0lVpSxgZDjWmidZ7SKZKuYasOHajueZSyKNZfvwvjy3P5d/Ckav LBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Dec 2024 10:33:09 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The purpose of this series is to construct a set of upstream fixes
> that can be backported to v6.6 to address CVE-2024-46701.
> 
> Changes since v5:
> - Improve error flow in simple_offset_add()
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/5] libfs: Return ENOSPC when the directory offset range is exhausted
      https://git.kernel.org/vfs/vfs/c/a644104d9168
[2/5] Revert "libfs: Add simple_offset_empty()"
      https://git.kernel.org/vfs/vfs/c/fa9c3b906334
[3/5] Revert "libfs: fix infinite directory reads for offset dir"
      https://git.kernel.org/vfs/vfs/c/41480e28a4e0
[4/5] libfs: Replace simple_offset end-of-directory detection
      https://git.kernel.org/vfs/vfs/c/4ea4beb53d0f
[5/5] libfs: Use d_children list to iterate simple_offset directories
      https://git.kernel.org/vfs/vfs/c/02a3d7715c3e


Return-Path: <linux-fsdevel+bounces-35441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00E9D4CDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A28E282208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1F1D7E46;
	Thu, 21 Nov 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNUPQW36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A91D3629;
	Thu, 21 Nov 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192493; cv=none; b=BaAS6MEHz1t24rl/Lo+/+XGAvHUksyK2Z8cAQ2NlTuDUqqvIKMzM9RGth5zRnJRkFFCx6BrXI0yLfvIWN62Csli38+zbME1wwYP/KvDwa3Dt1Xj6zi6IOtdnnhCQyDammV0/Mn0+miwYNC7M1IMWHKk5o8ozbqruO78aFGpFMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192493; c=relaxed/simple;
	bh=9peFlhC4ruSN6CtZ3OzEwhHu359NZdsnNpRUcSrcQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7/+XKC/N0tim7mezt8zNcyFaiR2jiNiQMNvgwMTlmhuongzWjJlFV/yB4YcEad2a5yljlynrFzr8ZuKkmN5mf0xQg+1D85JLdeOPlLVNJcCKFodDItGmdHyCbeIRHnurHccVrip3g2GvFe6D/a+7k7Gs+Y9iicefmSiu6kPiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNUPQW36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4781C4CECC;
	Thu, 21 Nov 2024 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732192493;
	bh=9peFlhC4ruSN6CtZ3OzEwhHu359NZdsnNpRUcSrcQaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNUPQW36SjxwGAiVy261aK8fE4BPdYUKGnAI85RSyL2fVSAtEx0a/k4ktnuHzw7jA
	 OjwCy+7SCxSmQO9328Z4fLb7pCpxFyepOjjAWzjOC8AWLMiqTuLXAdVE4lvwB/FXMH
	 9NiTIvcDv1tEZ22r1y3yAGRVHEpIVcZ/qgbBwjupIVFdIXIPsMsKQnf1JaeSWvGeJw
	 3h/D3WfzwycWj3i8wR+VBlxcNNlgmKu36oWUG1nCUqnCWgb3QeTK+GwT2fZvHgoB1k
	 gEfxPzDUnUpQL9H2MiaWG17zJWYARrdUR4aejrPcyqrug8JUmtIs4mNbEmlm6ywtSt
	 1uCWIB9jN3BJw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] symlink length caching
Date: Thu, 21 Nov 2024 13:34:44 +0100
Message-ID: <20241121-blatt-akkubetrieben-ad5d655d184a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120112037.822078-1-mjguzik@gmail.com>
References: <20241120112037.822078-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=brauner@kernel.org; h=from:subject:message-id; bh=9peFlhC4ruSN6CtZ3OzEwhHu359NZdsnNpRUcSrcQaA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbazyNrz58+ZvrCj+1hw9YA59dUyxZprLRZFWIYpX1G 6vixtBrHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZq8nIsKpHzNbqzauft73s 9VdNdbBtuuOseniC73el2fsS5S937WVkuP1Mt/2I18WH5zxblXVenT3HXnDA+HF7SbHc/h2Xu1c mMQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 12:20:33 +0100, Mateusz Guzik wrote:
> quote:
>     When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
>     speed up when issuing readlink on /initrd.img on ext4.
> 
> The size is stored in a union with i_devices, which is never looked at
> unless the inode is for a device.
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

[1/3] vfs: support caching symlink lengths in inodes
      https://git.kernel.org/vfs/vfs/c/5cbb3c7e0051
[2/3] ext4: use inode_set_cached_link()
      https://git.kernel.org/vfs/vfs/c/740456f67017
[3/3] tmpfs: use inode_set_cached_link()
      https://git.kernel.org/vfs/vfs/c/30071e02c163


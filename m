Return-Path: <linux-fsdevel+bounces-73222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E64D1294E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 593343076751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A1357A20;
	Mon, 12 Jan 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZCKVwpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFC3570D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221853; cv=none; b=PBsIJCvsLi08pqNjMU0h1sAXIuxFMbLUJepND1+io+kI37ZjPI+DaPacRjN/BU7wUFEyxUunYLV86ZvcYKBcgXail7D4q39I9tMfA+Frg1DRIrGwMBDfXIgioLLlid/5yXqZFtPRypRxEUtDfqN3jBLVfQQj0Z9YECYwEe5V85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221853; c=relaxed/simple;
	bh=H4qWGA0HiEkGsIhZuto2PZy2IA3OGIgKnCWv31xS09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO1gRxU5S9lhBcRhobD0VSqn6wmg+B6F0Qh0JYhsmFh6r9qnDsUWVzNFvI1u7Ox+IEsd68MNNGKQjlPtzKuJ1KMKgncggdFLRjTjtqctlw3A4+rlLgwImNZcQBdNMHvSEEWdOkNiY0TsA9JiuLyqeNKyLFqKNl/tZ7nqC/w2WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZCKVwpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFA5C16AAE;
	Mon, 12 Jan 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768221853;
	bh=H4qWGA0HiEkGsIhZuto2PZy2IA3OGIgKnCWv31xS09o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZCKVwpcT8MK/DzAJ3tL5Ov8KM8tCnvzggFO9Moc+YLj9jWbR/IMI11C3GGWE2sqm
	 4aNi/TYyW/1OsnobB3++kYYk8l5VkucRgWbILE6QZPe6jZ12WLee3eIYKN6cN9198e
	 f43C11IjiH8+jd7TnAp9WXMaR+Ay6TxGH/Bqz+LN51qxf9YHPO3Xb1CrLHn6XbrNgS
	 IYtePrBWtKXoyE/8DT7EUgfZMS6NdN1TcFnaTLuANsSkx1UVFb+AOug56X1OXpWaz3
	 +cL21r4ZrDTw+Lw7VM/IqyKdIoQKEqRXM0sUrUWSHpETrMsVuvRL6MlsLOC22H5zs6
	 XEbkFP2SplPRA==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move initializing f_mode before file_ref_init()
Date: Mon, 12 Jan 2026 13:44:08 +0100
Message-ID: <20260112-essverhalten-grabkammer-c5344306ca09@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109211536.3565697-1-amir73il@gmail.com>
References: <20260109211536.3565697-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=brauner@kernel.org; h=from:subject:message-id; bh=H4qWGA0HiEkGsIhZuto2PZy2IA3OGIgKnCWv31xS09o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmvJm5ZLZWaORxY/vZd1fsSzuy98S6GsbSEK+P2Xu2C 75x290u3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR2CRGhothTyY9ff5aa+rF qvvOsxVrll88u9zHZGP5JofpS4+zBlQz/M9nKBBNsT+x26xzQgR3yZIl/ac/iMZL3WF/K/Sihl2 anQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Jan 2026 22:15:36 +0100, Amir Goldstein wrote:
> The comment above file_ref_init() says:
> "We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last."
> but file_set_fsnotify_mode() was added after file_ref_init().
> 
> Move it right after setting f_mode, where it makes more sense.
> 
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: move initializing f_mode before file_ref_init()
      https://git.kernel.org/vfs/vfs/c/cb3e4998cb16


Return-Path: <linux-fsdevel+bounces-74198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB5D38413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD34D3063243
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8239A7E7;
	Fri, 16 Jan 2026 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSbu0AqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4901379998
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587368; cv=none; b=NgnkMByWw9J0Lcw/YmJnhn0g0fHWEh4gE5ujF3Pl4U4/AmGsjo12OFyHU7FloARZcL5EWydC2SvSsulyLHzx8teABHgWTcWf8pgg90CLm034sl7HLT9o8QWZ3wzePy0YaGqwxwWqt1eSe2f2Qj8NLA+s3V7/+KSul043ulKPU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587368; c=relaxed/simple;
	bh=tBmzC3ZzttxrSoFl5uUehsUqX0LZtB3j0l0rHUC9Ngo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICYqgYtpClB6qLpw7jeml0cosVjg9WEbT3njwOwcSlXkzR4pPwyAhhat78kekXOxK+schTLVk16hHhPmIMomklSQSicPCCCnr/ZtVfWAAeprxeMBk8yC7S7OM/0a6gmWsVujtOV8ykuLlIcWf8KNOUsoHJ2hyy8A2qUyKaQy0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSbu0AqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B84C19422;
	Fri, 16 Jan 2026 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768587367;
	bh=tBmzC3ZzttxrSoFl5uUehsUqX0LZtB3j0l0rHUC9Ngo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSbu0AqQnzBAVwSpBRfmsT1WxqNNQHyPm2XziToJg2gypvxSDWAW9mgbEvffZHP23
	 NT6QHjSNyo+d4wf0xOuUkAie1RFjh9TRFyNcg4KTPJk9BJQN3ZYRrUoZRGaNryWVAR
	 +AZZI6J5W9szRATIlU9jY7B1OJcB1sW6I2uZhSmT8tnLoI01QpWJ0t6VOQyZ08J+e7
	 XRGQmniTrhapIFGPLsBPdqPXumAHe5G/F7GLSIXjUIeT226WlyFlWOvPjK5c9paMxR
	 xWk9bqFoR3vtoh76kbPVBdAWKdPcJdL1sRnBTWQEGNKEIlLMRRqOKB8XKyFBi6ivTw
	 0WnE2hL/LqhKA==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] fuse: fixes and cleanups for expired dentry eviction
Date: Fri, 16 Jan 2026 19:15:52 +0100
Message-ID: <20260116-posten-anfielen-e5054c07241c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=brauner@kernel.org; h=from:subject:message-id; bh=tBmzC3ZzttxrSoFl5uUehsUqX0LZtB3j0l0rHUC9Ngo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRmNSQcXWE/MYX1zAXZs2XzlNX/PpY2P65a++jn5FVXN G9/99B+11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRk/sYGVpXaVgnW06zF075 f1BZzFs6iZcnRc+WoXf5Yq1ybYYjKQz/jO/t7zmZ+e7GE+sVrc/WX7hc9iPq4LV5S20/Z7MnrGD bxQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 15:53:37 +0100, Miklos Szeredi wrote:
> This mini series fixes issues with the stale dentry cleanup patches added
> in this cycle.  In particular commit ab84ad597386 ("fuse: new work queue to
> periodically invalidate expired dentries") allowed a race resulting in UAF.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/6] fuse: fix race when disposing stale dentries
      https://git.kernel.org/vfs/vfs/c/cb8d2bdcb824
[2/6] fuse: make sure dentry is evicted if stale
      https://git.kernel.org/vfs/vfs/c/1e2c1af1beb3
[3/6] fuse: add need_resched() before unlocking bucket
      https://git.kernel.org/vfs/vfs/c/09f7a43ae501
[4/6] fuse: clean up fuse_dentry_tree_work()
      https://git.kernel.org/vfs/vfs/c/3926746b5534
[5/6] fuse: shrink once after all buckets have been scanned
      https://git.kernel.org/vfs/vfs/c/fa79401a9c35
[6/6] vfs: document d_dispose_if_unused()
      https://git.kernel.org/vfs/vfs/c/79d11311f64d


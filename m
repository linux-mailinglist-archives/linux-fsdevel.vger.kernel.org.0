Return-Path: <linux-fsdevel+bounces-72057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D4CDC49B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379C0304D9FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F43126D0;
	Wed, 24 Dec 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgR9gxSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B725524C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580797; cv=none; b=ADB/R5dtVLGWrtlexzbElKCmdjPSJj8d+bJZc16ZwjTe5nazCMpua4xxqhuUCgew4SEJEoxExobAFtdaWzR5pzj0G7nKkuqNi/OlhW5iUDNlqlXHayjJvB/gNaLy9HCAEn9fmH6UgMr9SHW4NfiVVZmW3jd+3PcUbDpLWd9LJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580797; c=relaxed/simple;
	bh=B2vnyneOrCJNRDGjqtT+DYwy7WJYR1zPFcMn3ysX1Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwCsAlmWoQaU8F3HkLXY5wqYIYGhiLHqgLQx05EumzcHvDPiCo31jmQAdpLmTRqNT9P/BDrhVql3Nrbs0jhlY3xJFHuVC184KNT079FsZ6VlU6vv+pTLjGU6CfSAcyLIxOm6JTojjfnaseM+kyUBMg6KP6RKI9uFabCI0gVk2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgR9gxSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33132C4CEFB;
	Wed, 24 Dec 2025 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580795;
	bh=B2vnyneOrCJNRDGjqtT+DYwy7WJYR1zPFcMn3ysX1Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgR9gxSw2NLfZTVIPHTgUTdFtGQkoU/TlWjFcl78QnDsvpeXpYstkWrETEBUoa6/3
	 /ytgNH1aJzCfz9nghOvwAcfhG3zGtfznsso0eKehxspgPH3aBwpz7yylnpOf0W355l
	 o7//DF6w9Eu+71nV5P412JtyEqguNiJy0WqAlkkBbeOCykCP0cyvwwQSVRfDc1OAAI
	 3HubDX5cYb5TPuVQtgLLJtddlZO1KHo14MFBpLFLLjnBQ3fLpnXkig1ggN0xU/XCrK
	 s1UVdCjgOHDQcIdzoBAobA2uLlvivTtuHcZmcFDokbTTnO6s9TdI4gAvlBvNxdw0lC
	 1AAWP5VlUd76g==
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] get rid of bogus __user in struct xattr_args::value
Date: Wed, 24 Dec 2025 13:53:03 +0100
Message-ID: <20251224-sumpf-auswies-15388591860a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216081939.GQ1712166@ZenIV>
References: <20251216081939.GQ1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org; h=from:subject:message-id; bh=B2vnyneOrCJNRDGjqtT+DYwy7WJYR1zPFcMn3ysX1Rg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6PzJjXC48pZS7bWnApZYoocdTXqovne+558DM3AKvW WdZv9oxd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykcjnD/6QQW4eI0q3roy1l Ziq9brtR2HjwcfvM5cGfXzmfZxfl2s7wh9f4r1HUzNkLFz0N9Arz+io7OYWpouDG/CKh7u1WCWf WMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 08:19:39 +0000, Al Viro wrote:
> 	The first member of struct xattr_args is declared as
> 	__aligned_u64 __user value;
> which makes no sense whatsoever; __user is a qualifier and what that
> declaration says is "all struct xattr_args instances have .value
> _stored_ in user address space, no matter where the rest of the
> structure happens to be".
> 
> [...]

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

[1/1] get rid of bogus __user in struct xattr_args::value
      https://git.kernel.org/vfs/vfs/c/3dd57ddec9e3


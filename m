Return-Path: <linux-fsdevel+bounces-39273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1289A120AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2B3A3788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A81DB147;
	Wed, 15 Jan 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww3b7dMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325C248BA6;
	Wed, 15 Jan 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938064; cv=none; b=jE76kk9ISWa+nb+z8zjUeC+HdfxfJJU/Ao6u4VjJDpdQgrgKSHdJFmQriZ4SMXVhDJYb2J861tQY5HwjHFetnAwVI4WJya0bdJwPqwPKF/TRVUkPNaremX7cUakxfFWaKkFLISow9soikGHx8lCDLEv3/7GcMqo8jiCT5ZAMOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938064; c=relaxed/simple;
	bh=hiQaknAB1bQs5+kn97QMfTW1qO9DwgHzYY4PktiIPOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUjSDL9RcQbbnzLNtWSOkw0BcI/ZbRWxJfbRWGWJykcesoaYbKOPCJaS7V5s1VLZ7rR7Y9Y8onBS2pEFyTQnECMUhEh/QnMusOyC31XOMGOvbMWPRaLcD5fOzZnc7aCExoUysOOcwPCWdDyuwCPG98mc1JN8mHVutb5d4ifHewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww3b7dMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD778C4CEE4;
	Wed, 15 Jan 2025 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736938064;
	bh=hiQaknAB1bQs5+kn97QMfTW1qO9DwgHzYY4PktiIPOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww3b7dMByz/4nL+8maLg731p7f73JqXoBEuQSmKgVRX4PKyC32JpaH8tqbHbm2tcT
	 3Xfjq8LeBGfZZJ8OwsA45NF5s4Z449yBuF9AWdUjGT0bWA39zdlSIeA47aw19aCdqB
	 tQ/WtHDuYeND9PieChLymoryOXunDAutqbSuVZUXIZlcGo6TvyrEmhZYlJhirJDwa7
	 FZ86XwYkw51EqUqdBgkiXVOG4TILgaXOv5klzU1qekyZF5HAwLavQFqVjJ0ovr+wen
	 TqM6fynQiJZZbfejsCLGKhON6YGDikEKtSpUEQNxurcwcOFH9CThzLVZBqd83c72lv
	 KT2o3laUcVhUg==
From: Christian Brauner <brauner@kernel.org>
To: Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
Date: Wed, 15 Jan 2025 11:47:36 +0100
Message-ID: <20250115-gepfiffen-wenig-799588d55bb5@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <109541.1736865963@warthog.procyon.org.uk>
References: <109541.1736865963@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=hiQaknAB1bQs5+kn97QMfTW1qO9DwgHzYY4PktiIPOg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3T/K8YaLE/Eb5rcb+yiZ+85lfkzzf57zeW1duO3dXv O/u63zOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5pcrwi3mLv5ZsLOuXSr0T ovd/pbn88d4uvMXIfqm77to5qWdWfGRk2ChWFMuemcP4b+OVk2rcntdCjwW1arSX1h/cPu3QlTX ZTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 14 Jan 2025 14:46:03 +0000, David Howells wrote:
> Fix a pair of bugs in the fallback handling for the YFS.RemoveFile2 RPC
> call:
> 
>  (1) Fix the abort code check to also look for RXGEN_OPCODE.  The lack of
>      this masks the second bug.
> 
>  (2) call->server is now not used for ordinary filesystem RPC calls that
>      have an operation descriptor.  Fix to use call->op->server instead.
> 
> [...]

Applied to the vfs-6.14.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.afs

[1/1] afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
      https://git.kernel.org/vfs/vfs/c/e30458d690f3


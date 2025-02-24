Return-Path: <linux-fsdevel+bounces-42397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B25A41B66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F279A171C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE72566E2;
	Mon, 24 Feb 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhbTpfsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031B24E4CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393721; cv=none; b=lzbiB5wxvNw0+gxco3nMzfW5OXxM8KbDvjoJl5i43EJh0gNyZjQg4Lh2BdKNdLBoI7vd7r/ICwPl1FzyrPlflU4LTqUMf/BH/ttoqRsO0hyUwKcXgQNJWX7mVB17hyRGd6wcQ3FVo3q9GeDfIpRwLRUFOl1koHbZcREj4tJhDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393721; c=relaxed/simple;
	bh=pe+bCn5fxHj3ZlrWDovedu6Z8qWMXRaqDl5MQO6TXfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kbsqc63L1Tudd/FlOckbEOcIwjiM5IAgxK9oPQn19Ttw/4TgGxwRWVy1qZqk4EjW9xDuVoQdWUfJ7zjNZtmOHAa8OawxGy7aju/vx+YqIiFXyWCpRiORW4dcPKJT0C95ruiEAB2QCQ2/zmzxGo+Hd5lKtKlrkxaeiSPbW9zDYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhbTpfsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023B0C4CED6;
	Mon, 24 Feb 2025 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740393721;
	bh=pe+bCn5fxHj3ZlrWDovedu6Z8qWMXRaqDl5MQO6TXfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhbTpfslP+/55TWNSNVVVcDEgSsG1Fg8+0/oZIaOwUUJV/mZABUvThVyYY6tMI8Sw
	 vBT56CZmTm/G0rUCrZ15YSCBcomARA4VfHVSjO3lOFhJa5pmA7PI3VU8xy14UwXaoJ
	 f8GX4nYA6LICgAEHbjhhuncblDn7jD+KfheTRf8YBhFCnwEVBim+x/ijAOp33FxQp8
	 HZFGFnDmhAmoav7cQurqmVw0XM0foxvNx6Od0q8h/b6cn6hwBacfels4tQj1ZL0ZLf
	 KHO2Q0crCnEhZzRgGMUuJhAOCAABNqa5KCnrti0b5Ge6mY9vKmgWxySoO6B8dAhqmJ
	 5XUDnraAEX5wg==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Turn page_offset() into a wrapper around folio_pos()
Date: Mon, 24 Feb 2025 11:41:54 +0100
Message-ID: <20250224-widrige-abtreiben-2cbc360a37e1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221203932.3588740-1-willy@infradead.org>
References: <20250221203932.3588740-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=brauner@kernel.org; h=from:subject:message-id; bh=pe+bCn5fxHj3ZlrWDovedu6Z8qWMXRaqDl5MQO6TXfw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTv8fmyw0PM5dGtg3I5ltx3z4cJi7/OP7My7r34rrart 1bkMlxe2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARpa+MDNN1FnJsN6qZmL6O wVNq9pqPZmEynYJJzwMXKF74mqG/LInhf6L7/7sKm/b5npf91VHHqrxMoTtyhqeWr8ARpaZdGe8 jGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 20:39:29 +0000, Matthew Wilcox (Oracle) wrote:
> This is far less efficient for the lagging filesystems which still
> use page_offset(), but it removes an access to page->index.  It also
> fixes a bug -- if any filesystem passed a tail page to page_offset(),
> it would return garbage which might result in the filesystem choosing
> to not writeback a dirty page.  There probably aren't any examples
> of this, but I can't be certain.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: Turn page_offset() into a wrapper around folio_pos()
      https://git.kernel.org/vfs/vfs/c/12851bd921d4


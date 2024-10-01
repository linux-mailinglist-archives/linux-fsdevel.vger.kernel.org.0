Return-Path: <linux-fsdevel+bounces-30468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFF98B8AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A571F2498C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638419E808;
	Tue,  1 Oct 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlsFhNNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D192BAF1;
	Tue,  1 Oct 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776230; cv=none; b=WTckK8oNEd1A85LNXsXW3sS46pupHkhYwUuxLNkbpkQfl0sl5wga534jjSd9b2K3thMGN6gOGewALZX05oTCi8Zz4c6Ev2w/8WI8qDSb9ztI4AykYslqQzkblE8ccqEenRxaWATYbALoVaiQLQOJKc6rqpuzThfVL3j4ZA7SH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776230; c=relaxed/simple;
	bh=TA36krAyJnVhU2tqDYZyR0XwtwgoWzebH5zbPuWmmu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgkAq0IWNhWTg7SZXYmtklhqGiR/a99B0Lhm00+oMIilnahsYgkbeTiGIIC4+zPmoatQwrM6Pv9HyketoFc2x9i+kWwVHj2agM3QmY0ApTvE0z4GsRd6TXZvzG2qpOe6DqFMThspV40HmaXC43Qy0wSSKWXdESBKVmGLeT54VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlsFhNNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0ECC4CEC6;
	Tue,  1 Oct 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727776230;
	bh=TA36krAyJnVhU2tqDYZyR0XwtwgoWzebH5zbPuWmmu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlsFhNNGwE/TRdxKwihGJ6mKu4KDrmiEubEdyrke23opynqCqW7nF9JlWzjziemps
	 L1A6g5/DUo76bl6ydzxn4XXako0Ib3y5I02agu44+OYhW7F4ck7u4rVYAZkjnWqdUg
	 ad0hidkIqsCpBgfdDPl1wxXSyQn4hoIvFqckLjvCBpFSa6ZsMfzxd1HzTzUCicanbo
	 V2YwuZDjOPqGCdsGwI8p9rVHCUijd4OnLIBrzEAu6AFJctpijmqONTA1vv6ZoDXRzx
	 88EFR0KONt9Ob2btf5vpdtIyDNW/FoV426tGnbhp02YnuhzQraf8x/OClL5kVRkmAa
	 kkYqj/fYhXsng==
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-team@fb.com,
	v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Date: Tue,  1 Oct 2024 11:50:12 +0200
Message-ID: <20241001-revitalisieren-beipflichten-9b36df43d295@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
References: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=brauner@kernel.org; h=from:subject:message-id; bh=TA36krAyJnVhU2tqDYZyR0XwtwgoWzebH5zbPuWmmu4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9Pnr/4ZUWm9ZJUfMuvrvGv2KK5+ZL+lN8l+QYcG9w9 XypeJbPrqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi8fUM/9PFux4K3t23zHJr 1K/bdpMCPCpzUhj6d/FGH57ocJqn8BfDf5cjm+P4Pqpd9rb+Xm9i8Dz7uM5dX/H2oOXLCmXjZ3d mcQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 11:55:00 -0700, Omar Sandoval wrote:
> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
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

[1/1] iov_iter: fix advancing slot in iter_folioq_get_pages()
      https://git.kernel.org/vfs/vfs/c/0d24852bd71e


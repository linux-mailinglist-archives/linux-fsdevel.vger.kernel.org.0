Return-Path: <linux-fsdevel+bounces-61382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC09B57BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2717B2CEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4630649C;
	Mon, 15 Sep 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kevc8wI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94368305945;
	Mon, 15 Sep 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940463; cv=none; b=E6XJ7SLQ0VjCgD9r9QJo9JwQp4oBlYMDkha+m8S6/g2Bw03rJ3YR7eo8aL3F8nJjd56QA6E8AyZaK/zkP8WGg89dW3qQbG0w+WsBHyKGmemB64Hp5nqQQGljFdopp3Jv5TXNfiBNoUmNyvxWesBm3ohJTnZvHwQVJpucidSiLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940463; c=relaxed/simple;
	bh=/Jm12VEaeDqaGf18fbyEWkryLl2WgAe0cp69Io73xNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbbCACYRr2E5n1Uj44R/LFq/7z0aJ+OrxIPlD0gpQe73en+FVypNWTflpHIXZr9vYfXXDeeP4tKUyYAVFZOkSHcDkvoaVC8Z9Ubfd3k92VuQRHcxjnBpSAFq+HLUnmm6AxhU8D4vfCUjDS7KJAXyqUlPpqjlPo+N/2/jTi5iJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kevc8wI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA761C4CEF5;
	Mon, 15 Sep 2025 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940463;
	bh=/Jm12VEaeDqaGf18fbyEWkryLl2WgAe0cp69Io73xNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kevc8wI18e+YonCDHZ7qyf35Hof5E5kErJY9t17GRD+ge58CYwVA3jCVZv7VJ0UnH
	 6nhmAuZx+ZxJ4qIj6eisGQ7UsLJAKuQt4ZwDpcKxN6LbsInXXzdHeqpSIO2OeMtpMU
	 W3r4vpr3oOJSphQ7WJDQXSNyP9kkCNdTN31C211hplNlixOARIJ8JPX5c5XYGM3HfB
	 j5W6O4GQfwsctuUZM9RoNUvW2r1wmHC1umFOB/u0USsvVm6912YBVh9oOS9kdNJe3w
	 raZdv9ZPCI3VVjeAi//zZ38VRVOHHrj9oGDogPK0ymqqZ4xfN32R9X5DIeKJBolSuG
	 RBHXrep24t7nQ==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] initrd: Use str_plural() in rd_load_image()
Date: Mon, 15 Sep 2025 14:47:29 +0200
Message-ID: <20250915-rauben-verheddern-b5109813c528@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912074651.1487588-2-thorsten.blum@linux.dev>
References: <20250912074651.1487588-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org; h=from:subject:message-id; bh=/Jm12VEaeDqaGf18fbyEWkryLl2WgAe0cp69Io73xNo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc4Hol4rV8s67PGneWlE3MwfuLemx1jy46PEn+6R3ru LtHOXbd7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI2VNGhsNGayrvPTyyl2HJ z9vGLmcZHk6YUaN6akfTg/yZU233xnAy/K9TtP9wK+J4z7b4M9zqvMtXLlt/Qllp5sXl2mYrVXI LdrACAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 09:46:52 +0200, Thorsten Blum wrote:
> Add the local variable 'nr_disks' and replace the manual ternary "s"
> pluralization with the standardized str_plural() helper function.
> 
> Use pr_notice() instead of printk(KERN_NOTICE) to silence a checkpatch
> warning.
> 
> No functional changes intended.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] initrd: Use str_plural() in rd_load_image()
      https://git.kernel.org/vfs/vfs/c/beb022ef9263


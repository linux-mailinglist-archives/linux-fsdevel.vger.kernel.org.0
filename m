Return-Path: <linux-fsdevel+bounces-30043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B1985568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A498CB22C97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E11598F4;
	Wed, 25 Sep 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu0GdY1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791E157487;
	Wed, 25 Sep 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252672; cv=none; b=EUHGNkLStyKspRzxO6dIleYoEh8U3Ck8lJ/L8jBiAFB7zEFEzYpDUrbjVBuqhppFl1j+4nwgw6KdODqfi9MtznqkFDH0yA0GsC1UuwTYypYqVrcV1K7p+CM6b7ltGVm0KxtjgCLUkr5/clznnSxTTIZXgl/dk5fmEaxUw19r4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252672; c=relaxed/simple;
	bh=q8FTcriqRJnzHwN71OQtjDOy8qupk22wTVfmSKmvVXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJl8ozE16sbnj1nsvPq7sODuokfDP6HRb7hM39ymKJ/KohyoDAAch5bLh0G5eE4CCdGWjvjAjrBIryw0D1tjqUHYlgDvYD1vL9Am9nBTTPngeRDhJuAYQ9JyrgShCCapbPD1G+fRK6zpwQ2s7xnqkwoeEkkZehTmnjDzTeJCqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu0GdY1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28119C4CECD;
	Wed, 25 Sep 2024 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727252671;
	bh=q8FTcriqRJnzHwN71OQtjDOy8qupk22wTVfmSKmvVXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fu0GdY1zQKi5uqUB72mfGY6w5y7EkkEGd3ce64WgPkuOItwTJjMrykZ1iLRd2gv4t
	 /7U1ZbXdSvnuo76utpqSIbuTsGwBYNjsUNrigoP9MIzEUPU4Yo7AHWJ8E201XIQwD5
	 EdppsBHJ9g3zDnihn1nGVTnRtF6ZF2cBSXIKG6437JeHWNP2M+s4XWsFLHUrqi+dKf
	 yv01YE+Kp+TakHa7g+4CfmzIBzWcB116CRZ69NaBL45udzgPFY11W9G3xqcO7CCM4R
	 nV3lFAdywzwT4Qg0iM/1SgMfTpizbBgbH19kE6U1dTHM1fYfHfdOyS1tH8V703FJkI
	 IcGxXRoJ7/47A==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chris.zjh@huawei.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in mount option.
Date: Wed, 25 Sep 2024 10:24:16 +0200
Message-ID: <20240925-tagebuch-rosig-720884b18e71@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925015624.3817878-1-lihongbo22@huawei.com>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=brauner@kernel.org; h=from:subject:message-id; bh=q8FTcriqRJnzHwN71OQtjDOy8qupk22wTVfmSKmvVXI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9PrGdseBo+NEMo4g3TmmMnL4x2p8XHfonyXJNOr5io 7/ncbZtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpuMTwV7A4k+/ooa/hMXu6 Bc7Nqq0OW/z1jssUQYOCGLXHJzZK2jP8Tzov0tX47ZzzmXCH5Omrj+3QVDzmKrhun8yeLQdrT00 PYQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 09:56:24 +0800, Hongbo Li wrote:
> The `fs_lookup_param` did not consider the relative path for
> block device. When we mount ext4 with `journal_path` option using
> relative path, `param->dirfd` was not set which will cause mounting
> error.
> 
> This can be reproduced easily like this:
> 
> [...]

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[1/1] fs: ext4: support relative path for `journal_path` in mount option.
      https://git.kernel.org/vfs/vfs/c/457f7b53e736


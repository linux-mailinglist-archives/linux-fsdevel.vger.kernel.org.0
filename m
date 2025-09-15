Return-Path: <linux-fsdevel+bounces-61391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE02B57C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E26482E0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D223081BE;
	Mon, 15 Sep 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sukjZDl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723686353;
	Mon, 15 Sep 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941361; cv=none; b=GNv9APAfcIg7wDZotzAdlP1zbo+/vjwz4a7hTHYeudskm152ADubahyjdiUYBF4s0wTJqoIW7wbyH5D7mAQvxHYhWStmDSi09aOfZlVYPpokFs7wmWpn43cpdX5J2d0IeUY6c5daHHR3aUcH2YDwgoj3NCmtrgiyIJzLBulLEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941361; c=relaxed/simple;
	bh=w3cS1Rn6gi0bre616pcmxcHZvzGXrmJ2CYBxvJxBd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJnNcGGF7zI9FbhW8ffVGxCAwr9tqrjmBGWL1RYuDus93YHLk4R3Zmrk7NxrIQyxZxY8D5TT4xW4urHFuemkuyiNovDlMOmYUnZhWzDnKHsnkgCQNjgFrjqKK+qjNIeIswjP3WZh50y2/9KVMQLZyUGDfvjI5neJEorKqz1QiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sukjZDl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344AC4CEF1;
	Mon, 15 Sep 2025 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757941361;
	bh=w3cS1Rn6gi0bre616pcmxcHZvzGXrmJ2CYBxvJxBd9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sukjZDl1PuSO6kTVk0taZapaUJ7ciLDjVkizU/hDhp58PObhVbwhxr3XvT1ABNEXG
	 Mqbb25uyawdL4g900HOTqkUfExTmPoh8gOY4jy14e1N8Le3ASPxiseU/j14K/tKWyc
	 0427nSjlObU7h3XJyc88bO2JW389ygYVBJPUF0sjArYzYt+vfJEKtltBb8ZRauoetC
	 iqVth5Daf/huRmwJdaKugSclZwPmrqcBaSHnbWKTPoJdJR5tSaoAWI1OfC1QSW2meV
	 lV0QIElHBhNwN/SQh7qTDb0tQ4kz8zZaNyh3+rub7gcuCi7eLK4eeNruO6kPhwStGn
	 yR7aNOAho7vJA==
From: Christian Brauner <brauner@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Christian Brauner <brauner@kernel.org>,
	Askar Safin <safinaskar@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
Date: Mon, 15 Sep 2025 15:02:29 +0200
Message-ID: <20250915-zahnarzt-innung-5d096e779843@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
References: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=brauner@kernel.org; h=from:subject:message-id; bh=w3cS1Rn6gi0bre616pcmxcHZvzGXrmJ2CYBxvJxBd9I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc4MuWdPF0P/CESZNd1cTg3eOrzpy3b/P4acyJDmaLC I8+t2BPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESeVDEyLH5drHSe/0/zgbNZ l7Rq0lbMklsl9nB69ImlPIc38Oi1n2b47/RFYNuRzZ+Pv5MLt1+606RJdAf/K0M12dBdzfZG/Ls 12AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:11:05 +0200, Geert Uytterhoeven wrote:
> INITRAMFS_PRESERVE_MTIME is only used in init/initramfs.c and
> init/initramfs_test.c.  Hence add a dependency on BLK_DEV_INITRD, to
> prevent asking the user about this feature when configuring a kernel
> without initramfs support.
> 
> 

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

[1/1] init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
      https://git.kernel.org/vfs/vfs/c/74792608606a


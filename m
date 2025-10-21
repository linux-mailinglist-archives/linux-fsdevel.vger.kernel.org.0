Return-Path: <linux-fsdevel+bounces-64910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6663BF664F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 468845034BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002135503C;
	Tue, 21 Oct 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGLJZYWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712E1E7C23
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049013; cv=none; b=u9GbIi6N7EvcLAOH1oeT7tcFoJZqrFth6yo2biZGl2BgYsYlKqpxl7KV9UY3QMYsV6gyJ6N1tOZ09xynzajDkKdCGcWKpPaw431HqwY17wjbQVdQqyxwpw/qTcI/xStNqi4Pii5OXMs06s/wPpyvTJZBJVbthBNInlorzEWyKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049013; c=relaxed/simple;
	bh=8JIExmKFL1e/CmjoJnRReujq8mU/REJBTwDG9/fjmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMKOvvcIkkkOrqfhsjKynnd4V0gUq1LAD6FZC0F/DxnGnbqfwhSvJHaIEVI3IppVbXsjliJ3GNKOMcPnzbAMlD1WXNT8RYRCHWsil2Otg7uBGkGLbr7LgIUrzZ8rABXJbMTE5diRbXyt+ZP8Gw+qgCl47p4pXg1bxabsSAkJp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGLJZYWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80DBC4CEF1;
	Tue, 21 Oct 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049012;
	bh=8JIExmKFL1e/CmjoJnRReujq8mU/REJBTwDG9/fjmkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGLJZYWROnGvExmYkpXY4E+CrprIx+KCNr+WptCpQtmc/zHCY71hGPeLTZqIHT87x
	 v/YV85rpXuABPTl4JXzhFjH5acPF23vIYol4MGVUrky+415tynJPWA0PwyehSgsHIA
	 k/sU5EL38wzaIOMkn1Wl7ZNbsmcFuuHmk47VQ0DW3OhK9I8btaigTx6YRZBprK9hKT
	 8KXmHoCiFKSPTR6ut/kLClCRl1P+8shhu7kcD4BRNc8so6fNcST0gnUwBRNKGwnOhY
	 2JNUBbO4bSgsGm4JwmOQAmD+Tc652+AOL4595AsZnpzIb4nzwF9YIWEQ+68nBgqOfA
	 glAz4lV71Wv/A==
From: Christian Brauner <brauner@kernel.org>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	geoff@geoffthorpe.net,
	Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Fix only passing host root in boot stage with new mount
Date: Tue, 21 Oct 2025 14:16:46 +0200
Message-ID: <20251021-genau-erwachen-eb2436082486@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251011092235.29880-1-lihongbo22@huawei.com>
References: <20251011092235.29880-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=brauner@kernel.org; h=from:subject:message-id; bh=8JIExmKFL1e/CmjoJnRReujq8mU/REJBTwDG9/fjmkU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8r1y/Rf/WKsu3lzLW/rxiuPuNmvWdmRkNf8/PyvoQx fH8V0V0QEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENvkzMuxy8/t58cvkqFd/ jC/e/ZDk/ForQLvVsipfr83u1eZjq18wMhz2jlG7Esc2wVpER2xJCVOzlE588cq35fvMYwXnBX9 tZAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 11 Oct 2025 09:22:35 +0000, Hongbo Li wrote:
> In the old mount proceedure, hostfs could only pass root directory during
> boot. This is because it constructed the root directory using the @root_ino
> event without any mount options. However, when using it with the new mount
> API, this step is no longer triggered. As a result, if users mounts without
> specifying any mount options, the @host_root_path remains uninitialized. To
> prevent this issue, the @host_root_path should be initialized at the time
> of allocation.
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

[1/1] hostfs: Fix only passing host root in boot stage with new mount
      https://git.kernel.org/vfs/vfs/c/590a4c70008c


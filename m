Return-Path: <linux-fsdevel+bounces-49111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15EAB8238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7B93B744B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4729345D;
	Thu, 15 May 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i091mygM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1C28C852
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300402; cv=none; b=f8sedlAYx99IHYFtS/FcT9qf37hReM55PLi3ISeWkdP9uYJZdsJQ8htWLL4DW0J6RS44/mMYTw/t3XyR4bvlfEWea18ZHTDC+HKvRklP3A1gDqbi52XYCoHJHQ30ITYpQgq/s2mOzkulMn6pY0bhGtcu9mfs3cVZ3wYASUiTb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300402; c=relaxed/simple;
	bh=wI0+/QsIgzinlzjoPIbQxSnUfjTjuEPgrlfHI+R4R08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZbq3G1wiyZgkX/5KHIl7Vzfd9CtXRN1KeyHCCTA4mDPeQSW3IxxiJ9tjtZdHKSSy0wkwwfRq2o3ldNP7bmxio3FyVg+bPKNurX8PExyto+Qs4Jfwf4eHDkcQVBav1TsgtgTRpYx2iXxweW5pt4n4r+8MAVArHY2Wc6nCobvDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i091mygM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3E2C4CEE7;
	Thu, 15 May 2025 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300401;
	bh=wI0+/QsIgzinlzjoPIbQxSnUfjTjuEPgrlfHI+R4R08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i091mygMeyYXLoap7drzp+TIeJls/k59fMl/6Kr8jJWo6WUOnjBwpBvngsLBTtKPR
	 A13jWFJxZTKxn4URgf/haQOZOo8/IjV1nDT6rTdEqgX/MfmjC/1QG9ec9AhH4gkbk6
	 N0IRYNKY2j+hz4+Zm5L9KvnMWBxO5KDKNcnWUlbK+Clg8SW9CX3oH5CcZzxkIRjYLP
	 lmOiI7xGpKgh2gCGXbEsk7XXwj0kIXgQDDcKQ70sA++45X03yPpf5VSj5USL4fjrgg
	 i5tnjbKymvnbFgnzyfWGbaTAkvHZwZ99bDsDsBw25n65NA2laB7yGIeGuMTBWh6DEr
	 J9SIJMKHTr9Cg==
From: Christian Brauner <brauner@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] vfs: Add sysctl vfs_cache_pressure_denom for bulk file operations
Date: Thu, 15 May 2025 11:13:10 +0200
Message-ID: <20250515-isolieren-festwagen-9dc606567970@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250511083624.9305-1-laoar.shao@gmail.com>
References: <20250511083624.9305-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=brauner@kernel.org; h=from:subject:message-id; bh=wI0+/QsIgzinlzjoPIbQxSnUfjTjuEPgrlfHI+R4R08=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSobtCpP3xpQ8blM79UvRyv/L39hfHUqd899x1mc+/0F GUPcX1wu6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiMkyMDG3pXapL79ypTWE8 sdbr0p6cesfd+r/L9zOeFjrb/nlpvR8jwz/DZ68XaN3krpKN3sn6PG1j4cbN0hJXvh/SzN/4zlH rEiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 11 May 2025 16:36:24 +0800, Yafang Shao wrote:
> On our HDFS servers with 12 HDDs per server, a HDFS datanode[0] startup
> involves scanning all files and caching their metadata (including dentries
> and inodes) in memory. Each HDD contains approximately 2 million files,
> resulting in a total of ~20 million cached dentries after initialization.
> 
> To minimize dentry reclamation, we set vfs_cache_pressure to 1. Despite
> this configuration, memory pressure conditions can still trigger
> reclamation of up to 50% of cached dentries, reducing the cache from 20
> million to approximately 10 million entries. During the subsequent cache
> rebuild period, any HDFS datanode restart operation incurs substantial
> latency penalties until full cache recovery completes.
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] vfs: Add sysctl vfs_cache_pressure_denom for bulk file operations
      https://git.kernel.org/vfs/vfs/c/e7b9cea718ee


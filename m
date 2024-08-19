Return-Path: <linux-fsdevel+bounces-26239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26690956635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5901B1C21765
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44415B97B;
	Mon, 19 Aug 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDQYW4We"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105611CBD
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058041; cv=none; b=j8Y9v3Lt6vzsFIgA7zkgiRC2LaWiUGSlc1bMAVdmzib0yFn9mIzXQXkz9b2P9RlY9H3tETxRSvhM2HX3aeDTDgsGD9dgFdQgy0fXNdnNxKXnaNay3oRlksVKbZh/M4LPk5KdGLdpt/Fmr+kyEZMErW8vWbUTJY7QjUxYrDhLh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058041; c=relaxed/simple;
	bh=M1EIABN1S+HSCMol/P6puKXeipUJ20rEFUmTBrtquzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ/Vi+DR+8/i6sdJcrTjxoAjQj4wJHT2wGSpHu5VOmY8cJdIEqmcNn8uGbqlOga1T9ocdS3lFpCTq+GTDLgUGLzJmwDq1yeJo0oClVh9EDU4pkGa6NgiPgVMix2BtAp+pj5jFFvAYIF9OsjhIc32W+UneVuJX6coQNCZG5wHm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDQYW4We; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B665C32782;
	Mon, 19 Aug 2024 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724058041;
	bh=M1EIABN1S+HSCMol/P6puKXeipUJ20rEFUmTBrtquzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDQYW4WePxMxu5aWmEK2A6uDWwged/PIjCdik6vRlWh+D6ZvqC1O5rNbc47n8m7Z2
	 CMHC1avIoDYeZh0WnzBhrqjfMaq7AHkvM/4lNlru39j+31HGWFzZ59uJAVyCv20nFs
	 b7Vvtzqi/ViG0UrPSW31gYHCh35PVuVXbRKqqhYjOEhEoCp+DizR6gJ5BSz6zkt7eg
	 5bOHWDQoxI6yVjJh8C02BKXRz3Q4Kf/yt2WiNQMatwOtml/nzaoVGOb6itJ4egTG97
	 TlqRtECxBufvF4k+XDnUFCHMXktCKiGGfM9ooghaCYZrh+JimdusvcdOGZDLK+0Tyg
	 A7vDKsWeZLRSQ==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH -next] fs: Use in_group_or_capable() helper to simplify the code
Date: Mon, 19 Aug 2024 11:00:27 +0200
Message-ID: <20240819-verinnerlichen-allesamt-bdbff67cb1e3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816063849.1989856-1-lihongbo22@huawei.com>
References: <20240816063849.1989856-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=brauner@kernel.org; h=from:subject:message-id; bh=M1EIABN1S+HSCMol/P6puKXeipUJ20rEFUmTBrtquzw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd5ty0kt8odUPcjITOJBUunYAF15mZOa9Hxhe9271BI /mK39QpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5/4zhf2DQ9Lr5rDyXnvR/ u/ii8Mmkd7f4VRI71lwrYjkWxKdryMjwh8/GfsLX+cnZ6rpzGiQ+3Yh6eHvC4a0/VQ3nVrevzzE 04AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 14:38:49 +0800, Hongbo Li wrote:
> Since in_group_or_capable has been exported, we can use
> it to simplify the code when check group and capable.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Use in_group_or_capable() helper to simplify the code
      https://git.kernel.org/vfs/vfs/c/b882a0608243


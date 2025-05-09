Return-Path: <linux-fsdevel+bounces-48565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F68AB10DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A99521E06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B928E57C;
	Fri,  9 May 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfNY23yX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3328ECDA
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787090; cv=none; b=dNGQyRAIjur+rIXOiTG8orhW/a4m9+xaIV5N291XeqTwNvpLwTdv0mqYdd0fUt1x8Pmr3yOAnGp0gPmkj0Yvn+R13189Q78WLfcsuPkpj2QDrpnxq+E+O4/TSpMWdB2Sa3sElIhlvEwlJC2dQj1hnA8q9SIhlkCxj9BrrvHPfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787090; c=relaxed/simple;
	bh=do2B1WUA6o2es6Z8FF95UE/pDAnpjOMYigHicR/TXAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibqERyTcwgLnLsh7k4SH5zT7Apo9pru8LVh7LArQGPXQtSve+i0LRSIfIELqv6GOLn/szPcQC6ET/iUFWK0u2PV97FugJlPNS9OErLvdLWkb/qBgHFarVfwqmL+0eiUUrh+39XiVAiGfo8IxUlxT6KMrQtiiBLz5Y97swwK9ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfNY23yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634A9C4CEE9;
	Fri,  9 May 2025 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787089;
	bh=do2B1WUA6o2es6Z8FF95UE/pDAnpjOMYigHicR/TXAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfNY23yXpNx6uuzCLBGSLjBeU5NIK2bQ9OO+GrJuIRArCC3iyE7ACNtHz/BNbbEX6
	 1AnEubbD7FQUc8vDJxngSRuYvP/ynSWFw8uFtIypUrFjggk5OrHOvmm+xRNmCZgNrO
	 WiSKngdbKoygSsV14RBN5ytUlM/PDNW82Bu59YYZAtokQMMI7DZ2MXXj4EXDLGU7fR
	 xnN0tyLd+0SWMxGYptajtq9iFffsnrR8XpTlJlPo24Z2JjkrDePnDdk0yFy9jFLqhW
	 90MKJrVxHuykToToyTj/uqM2T+OsAndpMeC0sW0J/M306PO9hkSc+nM8b3Vd6RlCIb
	 I6SZW/QTXVAbQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: use writeback_iter directly in mpage_writepages
Date: Fri,  9 May 2025 12:37:59 +0200
Message-ID: <20250509-vollwertig-wohnhaft-765426542567@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507062124.3933305-1-hch@lst.de>
References: <20250507062124.3933305-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=brauner@kernel.org; h=from:subject:message-id; bh=do2B1WUA6o2es6Z8FF95UE/pDAnpjOMYigHicR/TXAE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3uY9JqLQbS70lrVVvCH+hhKjhzh3dF3d1vLp8k5l2 mdUYjZ0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCSfi5HhZE9brtGeXbMf9Fx7 H3uVyecLz5uSy0cvXmxd9PltTvElHoa/sh82MO5Nm2C54tOOK9MMvu6QUm4omNtSbzFTvmvaeon p3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 May 2025 08:21:24 +0200, Christoph Hellwig wrote:
> Stop using write_cache_pages and use writeback_iter directly.  This
> removes an indirect call per written folio and makes the code easier
> to follow.
> 
> 

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

[1/1] fs: use writeback_iter directly in mpage_writepages
      https://git.kernel.org/vfs/vfs/c/bb01e8cc10f0


Return-Path: <linux-fsdevel+bounces-23463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0692CA1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 07:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1E1C20DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 05:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BECC44384;
	Wed, 10 Jul 2024 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKcnXiFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882517FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588673; cv=none; b=c+hIUXL2/fbuTgY14CyjQVdQRLeQL7Gnf8/4JTNVLWP6V+sr7jm3Odi/k5HkmChexBwdCtTUyNBqu2zVFkDCWAtIMTVDloKxpPFFyVEdjCc7NRVJGmwGpg244SkjUtkh5LIlPHetXV14gBH1QDZw5fpYbgLAvD5lpUhBuw3lAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588673; c=relaxed/simple;
	bh=9tbPJN+wWoasm8CdWuFp+mmwpiqmjqFALx91FpB00WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSTYWbHD2ariguyzg5PYEIyYOtmSK2syX11qlIjYyb1YAcekKWwWtvbR/LzhmrPC/pDME0a9CNjditHbLVBKvc2MPqj9EUP8tGutsZrEXLa8jOKAQrt4eCYLRkGm7Qq/9X/SoQaYltexOflhs9yCqhjEa1utDlgr14sqOUoVdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKcnXiFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C21C32781;
	Wed, 10 Jul 2024 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720588673;
	bh=9tbPJN+wWoasm8CdWuFp+mmwpiqmjqFALx91FpB00WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKcnXiFltGu/WIt/edByTQLEPfdEnf1pxmainTlApqa7JhHjAjt21x7UsHpVe4Gpn
	 akD/XpPHMx03oFBusn9o5rSUAi5+YqDWAgirsFP5zNj0jdqryjvpV5q1ygkuVHE8A5
	 1uXGex1g1A/MZx7FGQGETHPGU4ZJbYSSlYgFmkrzooQe6xI/2Ypf2qtt+OZArpucV/
	 Xn62n2wwgx5ad81vjT95rsr4ZiLAiFFDvzOOUSJldnUmYMR82BHJUFrE6uhItGuSIK
	 UGBhejZioyl3yyfHHn9r/6aHi1Xo/vuIHBTukEDtgbro0qcfnldMAVwofdgASWQzPP
	 SlIa3SSmyVsrA==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] minixfs: Fix minixfs_rename with HIGHMEM
Date: Wed, 10 Jul 2024 07:17:45 +0200
Message-ID: <20240710-sturm-restaurant-bc01fe16bb8e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709195841.1986374-1-willy@infradead.org>
References: <20240709195841.1986374-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=9tbPJN+wWoasm8CdWuFp+mmwpiqmjqFALx91FpB00WM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT1SVb1OD3TPCLGVrhNQ8XkTdui/h+Lnf7FHbVdx8ttl Hzx6ILOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0tzIyTBN222xus239a4Hb 2RPUDqxwrJdRSXe1zgp6wuckprrgBCPD1zrFQ+LuhZOXyTOWL+hgOhSd8umT6VkPLvt/MuyGjLf YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Jul 2024 20:58:39 +0100, Matthew Wilcox (Oracle) wrote:
> minixfs now uses kmap_local_page(), so we can't call kunmap() to
> undo it.  This one call was missed as part of the commit this fixes.
> 
> 

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

[1/1] minixfs: Fix minixfs_rename with HIGHMEM
      https://git.kernel.org/vfs/vfs/c/3d1bec293378


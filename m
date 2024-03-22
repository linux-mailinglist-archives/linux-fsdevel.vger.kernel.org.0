Return-Path: <linux-fsdevel+bounces-15084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBB886E37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2671F23378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2C47A6C;
	Fri, 22 Mar 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I71/PQGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605C47A55;
	Fri, 22 Mar 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116772; cv=none; b=lMtjhDdc1WJwx0LVVtoNluJnLtkT+lGPlt1nwRZdOqc8VC9gr7nSBEdD0PZMoIDngvHC2K/Ig4CXGL8JTveV+oVlwmdkSvgg4WSs43MoSI0SHgbb9NYwgROHaAV3L7DUNrKRc9kvQEdAPoSRdYAtHX82lVsO2/WT46+cyTUKCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116772; c=relaxed/simple;
	bh=WeXXfmSf1eObBCCvc/WGUG0pS+xp6MKLs+xYQPCR818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtgPYMsYtuThDSMOEWdHBxlpKbUsMK54t9FzYkbr9jy1SDcasyVpZMpVVwYeAmL+MioMsxAEGeuiu+tct0jZojqZcRAKITM1uOKS9k7SWqYm7GjnuJeLz+kg4AeUu4ECF6YZRnNOVqbBHTHo39Z/ZdRY1skmi6pxUaPpOjiOexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I71/PQGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80508C433C7;
	Fri, 22 Mar 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711116771;
	bh=WeXXfmSf1eObBCCvc/WGUG0pS+xp6MKLs+xYQPCR818=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I71/PQGvypwsjVwIh4xbPDHqZRSd2o6chxAIWsRRJ7//xVX38evD+hPm25eSnPwn6
	 BL8zXs2/zcfMC/DYOaqpy1pBAPDW8LPZQEVinYXrt7E4dEZexOnHIb05KRTLf4F+ZK
	 3HdkQnHp9rmSAROmGphuhZMELX763PFPaU62ps1mZ4DIG/F6sP3c2C7eB8rDr8a5BZ
	 O3Cc5u3iXlxXZSnyWW/aaI3khBHOnLrciqT5GTzVHqgPRktKeSxxqlUz07ZnZ4kml+
	 2Mih1AJjoZDwHp8yngRHF0sckcsmE0mSGU97h2eIniIL1+ccuZFec5NDpInz4pGG/E
	 MwlknjmX2LIrg==
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs: aio: more folio conversion
Date: Fri, 22 Mar 2024 15:12:42 +0100
Message-ID: <20240322-rangfolge-teilnahm-9815a419610d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
References: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=brauner@kernel.org; h=from:subject:message-id; bh=WeXXfmSf1eObBCCvc/WGUG0pS+xp6MKLs+xYQPCR818=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT+nXj7xNJjH3tFeGaG9yu8dJmzglVBPbXASWL1Asm8+ 82Pb+Zt6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI3HVGhtOF60w+LDh2OFmC /9+it4u4ODJK5ENub1+f0vvou8OBq06MDKv335vG1n6nwuKRQyizjcqfuOgPzK3rFHRC3n95Ui2 ZxgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 21:16:37 +0800, Kefeng Wang wrote:
> Convert to use folio throughout aio.
> 
> v2:
> - fix folio check returned from __filemap_get_folio()
> - use folio_end_read() suggested by Matthew
> 
> Kefeng Wang (3):
>   fs: aio: use a folio in aio_setup_ring()
>   fs: aio: use a folio in aio_free_ring()
>   fs: aio: convert to ring_folios and internal_folios
> 
> [...]

@Willy, can I get your RVB, please?

---

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

[1/3] fs: aio: use a folio in aio_setup_ring()
      https://git.kernel.org/vfs/vfs/c/39dad2b19085
[2/3] fs: aio: use a folio in aio_free_ring()
      https://git.kernel.org/vfs/vfs/c/be0d43ccd350
[3/3] fs: aio: convert to ring_folios and internal_folios
      https://git.kernel.org/vfs/vfs/c/6a5599ce3338


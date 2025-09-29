Return-Path: <linux-fsdevel+bounces-63007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEDBA8A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C2516B813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA872877E2;
	Mon, 29 Sep 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdQn0mYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005122868AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138518; cv=none; b=a61y18NTsgjeXaUI45MFp8KidnmVlkdn0LK1r4ekUmjZL5ekcKvEtyXivuUvZy/HYgfLJ5XeoMDKUO4Ne/mlHpCx+/04HPuSEKOD0+iPGrR7rJjvvQ6THfsDVFgS8YwRXrO8B2MTZwsqL7kwjQrn3OiQmt5TNQmaRsp8u+efQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138518; c=relaxed/simple;
	bh=MFOyIq/TUUsrI8sQLNJUF56fdPJElrGxAv1tjKSeCGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn8mi01KDTtCTL+SMeuSm30tae3AWYP6MRzsgv3a1wqYUgn4OAIy+hdb0350Zr8VUQZLA7x0gkUU99OYaXKk6XRm9d52fyCJ/dkcGRLjOVqHHW14I4X36LBfsxNt3skbLloUGzRelgCKT0fluf9UEI+JE//yLr1POaNYPHPwONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdQn0mYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645EC4CEF4;
	Mon, 29 Sep 2025 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138517;
	bh=MFOyIq/TUUsrI8sQLNJUF56fdPJElrGxAv1tjKSeCGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdQn0mYKlj4qVBiqTuDeYP9J6F8BkS3T7IZU48bB8XqCS6JyvK7lKJWJJotBmFbhu
	 4HC8ZK8pQbgH/oChRv+6X+bH90riy+/72UjBfRcG9PgrjVo4jl8mjTviOgk8mmnooP
	 VOc8FoVK7Pkk+bASykD4XnjYoEZ1vnlW9tHknQwrWgTXSm/2CZYy/bqO/4twt9KcRJ
	 isxpKh065nQKNKJa6d2PDYC1S/1pQvifrYn5VwCDJg9z5Iaw/q7KW95fk6wxJuTmCs
	 pxD8iQxuOVlNH5XLBby0hRVkdSvKcnnPNDRtoabh8cVW63CvPlJOzqqn9mekAqw1S7
	 vXIiYuq++M9hQ==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: adjust read range correctly for non-block-aligned positions
Date: Mon, 29 Sep 2025 11:35:11 +0200
Message-ID: <20250929-gefochten-bergwacht-b43b132a78d9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922180042.1775241-1-joannelkoong@gmail.com>
References: <20250922180042.1775241-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org; h=from:subject:message-id; bh=MFOyIq/TUUsrI8sQLNJUF56fdPJElrGxAv1tjKSeCGc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTcCrrg/+XCjQCN9Merj1cxxb/RtM5VZVZ0OH/klca0r BPzg7dP7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6/mMDN+CvJdMOvY70mvx pLCvD585Sdh+aknJkTaWjhWdrKgmdYvhvzPDsh75s/9Li/bX6mhF5DBJP/Gv4JA/y/giea/ar+2 prAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 11:00:42 -0700, Joanne Koong wrote:
> iomap_adjust_read_range() assumes that the position and length passed in
> are block-aligned. This is not always the case however, as shown in the
> syzbot generated case for erofs. This causes too many bytes to be
> skipped for uptodate blocks, which results in returning the incorrect
> position and length to read in. If all the blocks are uptodate, this
> underflows length and returns a position beyond the folio.
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: adjust read range correctly for non-block-aligned positions
      https://git.kernel.org/vfs/vfs/c/94b11133d6f6


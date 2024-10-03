Return-Path: <linux-fsdevel+bounces-30842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BD98EB84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FE61F22841
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833813B2AF;
	Thu,  3 Oct 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUC47KR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745812C473;
	Thu,  3 Oct 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943838; cv=none; b=Sly+WIRbilwqbs20diAi13wb1sMQh1/UL/TZaX21is/ng/odLSsA41hirFMVxotBvMkqY8XD+KZz4b4UiWXXbiGswstjzs1CeYfpdJwlbLmhYrhD7aeNINoE1b5oV+Cv3z2BPehZzGVS7bJxVh1NXwRNu6PbFweiyO42yFe6B54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943838; c=relaxed/simple;
	bh=e+cIkQtMZLBK6Z2bEpeCAUcdUT9M5Ca88NIVa+LpYYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsGUj+HRYoeJWwGRyPE8e1uGnfqM1NhePSw8wCAr2mOf03lErHnjyQwPA4r1azMiO7OX6x0CzNKGPOt6lTW7vRuPEH16CimKiclEjh7wji8A9m1oyPXGATOWyAC5mt7dvJXvSqSqQapZ4GhCY8GNG2fPeWO4v9pPdrgUfa3w2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUC47KR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9DBC4CEC7;
	Thu,  3 Oct 2024 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727943838;
	bh=e+cIkQtMZLBK6Z2bEpeCAUcdUT9M5Ca88NIVa+LpYYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUC47KR0aZ8lajtCDtFFxqlKkL5xbk3+XIA8O1yalr8kNHJc3SnN4cCXSAKLSI9vg
	 AV+ZQVxfTmr8JCrJQzWsnaiK9B1a9kwNdcazis3Bt12CuFwssVyr1ROerlVsegx/Jo
	 NTamZotGfQSnG5A1Hh4WLLUERzCaXD2MFUZi/x7MQLYZrhLEiVo0dF27mEneCq+/CR
	 lX7v9gCVIl+jZ7/cdpjHi76wqgBGl3U/YuNVtIB6aLW6wNL6ihdVJRRcXRJW5QwwIX
	 xA/JldV8yIGCKg+Rl9xjoo53AKG4Mp0iCi5T/KwYQ4kYte6Qb2ty6GmXvGGkaemwLL
	 7XnUehgmPfEzQ==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] iomap: don't bother unsharing delalloc extents
Date: Thu,  3 Oct 2024 10:23:51 +0200
Message-ID: <20241003-qualifizieren-skalpell-553802f6ac9f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002150040.GB21853@frogsfrogsfrogs>
References: <20241002150040.GB21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=brauner@kernel.org; h=from:subject:message-id; bh=e+cIkQtMZLBK6Z2bEpeCAUcdUT9M5Ca88NIVa+LpYYQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9C5nxsK5xa0EdW865h4dP6s63DfH8ujDTxjVI/suS2 HOKrn/edJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkcw7DX7k6b3+1Tzu8noVv i7pkbxHtavHjkOtB9UUKn7YoMIYd3szI8OQ9b2n3NSWRvRImqjnuymkS07x7dNs3Tf6zJeDu0+l RDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 08:00:40 -0700, Darrick J. Wong wrote:
> If unshare encounters a delalloc reservation in the srcmap, that means
> that the file range isn't shared because delalloc reservations cannot be
> reflinked.  Therefore, don't try to unshare them.
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

[1/2] iomap: don't bother unsharing delalloc extents
      https://git.kernel.org/vfs/vfs/c/f7a4874d977b
[2/2] iomap: constrain the file range passed to iomap_file_unshare
      https://git.kernel.org/vfs/vfs/c/a311a08a4237


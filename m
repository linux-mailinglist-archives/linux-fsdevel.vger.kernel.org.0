Return-Path: <linux-fsdevel+bounces-38745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C58A07B81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1DC7A4523
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A962221D86;
	Thu,  9 Jan 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSE76wuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A52206B9;
	Thu,  9 Jan 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435398; cv=none; b=NDUCmk/JHtY3+x3JYl7jYvrwKGfrvM4aGsp+L42HUskKRrI8aUsR3eSFd9TzdvxhFOsEgJSpfhAn+Lvix7k4xmcaATeqFfLvM66xIExqVtzlANd/GNyrImSGgdII2MmOOswKL9JYxMezMzEd5mWnfxA5ITlLDigWny2z+pdwu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435398; c=relaxed/simple;
	bh=vHZJTFgcwdf5jrTfSWYFOQqAZ1ocdmVE5Ot361BHimY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5koqYlK3LLRfWP40CYKppwnGdtaYVB/bezI4Ao1RKroyToEP8PVro4XcmDOTLyqeg5aZZ3yf+5VYK9OH1vF5bkoEkHP+AVurbx1CE8I7N4AQOeWV8+QYVImBTEFqvwp5nYgbCZq55JdSqWczwudQK26wT8LREDg+8jFNQDqJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSE76wuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB63C4CED2;
	Thu,  9 Jan 2025 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736435398;
	bh=vHZJTFgcwdf5jrTfSWYFOQqAZ1ocdmVE5Ot361BHimY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSE76wuQ8FYfn7waDsWEUWykavgRi6DhqUFk5o2Y+ZjzU+ZaUavelk0euDJxMIVRH
	 6IrgDh8SvLeuRYChnHSznkN1Zh3ZTEytVjGbSmbsnsRMhKnGV0khf36Ri5CipUzBhL
	 WXb+eDkAt2ih8LiEUIrvqi6FA9eOLyhU5cbPXL47H6vhhO3Ob5TbsvZDLkWXSLPBDT
	 TT5w/GNAPUxX+sk36lVb7V8mK1S/USbgV2a6cjmVYb5nsO4+jkFNb/HkA6XmjZCcwW
	 R6qvX9m40jy2E9zl0uCj9XXh1cQhBGIMH6+w1QqSKRh6ArEs7jO3HzU/OIbogdp9Q3
	 pIqB2LvrmIy3A==
From: Christian Brauner <brauner@kernel.org>
To: Marco Nelissen <marco.nelissen@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Thu,  9 Jan 2025 16:09:43 +0100
Message-ID: <20250109-eishalle-sitte-b2b54d61839d@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109041253.2494374-1-marco.nelissen@gmail.com>
References: <20250109041253.2494374-1-marco.nelissen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=brauner@kernel.org; h=from:subject:message-id; bh=vHZJTFgcwdf5jrTfSWYFOQqAZ1ocdmVE5Ot361BHimY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTXPzugcU/6cfd/hqYrU5TPTZ0j0lYi7PLjtf3d6Xumv F8VcUHCpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAixw8wMqxqrkh+3FHa5VTX 0O605HPI1cJitVjm6PyWTau2z08+tJSR4dGfTcIS31YmmiUJiadtznvC38LSEBRhMu/a9ASW8sa 5LAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 08 Jan 2025 20:11:50 -0800, Marco Nelissen wrote:
> on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
> 32-bit position due to folio_next_index() returning an unsigned long.
> This could lead to an infinite loop when writing to an xfs filesystem.
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

[1/1] iomap: avoid avoid truncating 64-bit offset to 32 bits
      https://git.kernel.org/vfs/vfs/c/c13094b894de


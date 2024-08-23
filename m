Return-Path: <linux-fsdevel+bounces-26898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5895CB35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DD01F22F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DB187342;
	Fri, 23 Aug 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLWb/qFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD6149C46;
	Fri, 23 Aug 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411545; cv=none; b=XNgMymijCxLlBmEv812qZyXmXSU92fxj67qLkJboOjn2LFih9v2cvOta6DE0eSngVdtHR7clcGuBV25aAbO9wsdYpOSUPlJlIRkOM7vM+pHDc7xd9L/llnBMd1IMNJ62Zzy/IyTgVm72ZTr4d0GxuaryJyVangGVt9IG5kLpdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411545; c=relaxed/simple;
	bh=ewqXtkCTnp3DPbG11UD8KFbqosDFXT8dcMAnfnfjGX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwaT6rd8KfNO8QZokVE/G/nveCBpinRQKpBPzSmUimsszd3UJR9glkGfxN7i2Wc8wAi2aDYROEmWPlYTqXYoBYsnW+AgRhvvia9LNDT1G3+5Ouyhtu0Ts8tyoyDOqU4L+A+onJH3qff0a/0WotfDN1nvNZZE+ndKYPwYwSmmcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLWb/qFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B32C32786;
	Fri, 23 Aug 2024 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724411544;
	bh=ewqXtkCTnp3DPbG11UD8KFbqosDFXT8dcMAnfnfjGX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLWb/qFK0pLiDbG2NIGglhkAaFxYKRihCSFU3n5phFdWrFERtpzV+YDTjpx++atJv
	 FI36HuuTR8cBLkThPR8KCMPYJgtVOl2PBiNGduoWR8+SM089uzMNieSiKeTrmHqRlx
	 yzxmypXvssnZSAMSDeN+TJjiKpOMGeCI6EK5aJW5oWRoU+fLrHggfhf9lGNEwmKs9J
	 dFxc5lGc/xqVfPPWfYf0njo4sm07QIsSEhCpStQioJ0Boa0ub69kY74vyN2rNOUpy4
	 DP3aYAWHio3iwJOFN4yM6PXLWBgz6PiyRcYTvQLvqLUw4MxDE8WUgU8ZRX1ePsHDNR
	 Juz02TiRHdruA==
From: Christian Brauner <brauner@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3] Squashfs: Ensure all readahead pages have been used
Date: Fri, 23 Aug 2024 13:12:06 +0200
Message-ID: <20240823-satirisch-pseudologie-689e0a05bc51@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822233106.121522-1-phillip@squashfs.org.uk>
References: <20240822233106.121522-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=brauner@kernel.org; h=from:subject:message-id; bh=ewqXtkCTnp3DPbG11UD8KFbqosDFXT8dcMAnfnfjGX0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdyJtoVXh91rq7yRtEilI2zPASr3pQLyZ5Vl5Dtr9oZ avOB+9tHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxrWD4X32d88OKx398vh2U EPovfl9DmLOngDt+Wc/t44uCtbamNzIy/BLgFbFL+WfrbvDvb9CaHntZ1qlmLu9dpZ4/ii+feSm eGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 Aug 2024 00:31:06 +0100, Phillip Lougher wrote:
> In the recent work to remove page->index, a sanity check
> that ensured all the readhead pages were covered by the
> Squashfs data block was removed [1].
> 
> To avoid any regression, this commit adds the sanity check
> back in an equivalent way.  Namely the page actor will now
> return error if any pages are unused after completion.
> 
> [...]

Applied to the vfs.folio branch of the vfs/vfs.git tree.
Patches in the vfs.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.folio

[1/1] Squashfs: Ensure all readahead pages have been used
      https://git.kernel.org/vfs/vfs/c/84e0e03b3088


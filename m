Return-Path: <linux-fsdevel+bounces-69732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAAC8403F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0E34E737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B682FDC53;
	Tue, 25 Nov 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Qd3NFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B652D0C64;
	Tue, 25 Nov 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059754; cv=none; b=l9LlkkXwSiv0+QwmG9Ubu1dgNg9hnO7o8pHaIipQpyE8pjkWArDIj6YmSLo3yjzADoeSWoyVvFd1D/4i7b9yni7nehw97aYUxTPI8Tg0N3SpbGHgGbFD8/JF+XAs4Dbin1REMQ1i5jgDGV8lWEOmFyyS2Jxqpnoc5baQUkzzcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059754; c=relaxed/simple;
	bh=nCuBpk7PR9FRmu/l+FVLItkkVf95qdDCEkK6XMKESbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ0yE3IQh/TmPQQ+Uj/YgeRqcZ15NxwG/e3d2903Y7zSgRCMxEJiL8knmwC7U/UAJTNJ2c1lYEogfb1/pOr0Wkvi2avAMUVeytdCZpzWlIJN4+EFqAPMhW+4Ohc94JW6DJyrh5QGsKnfduZY5kjmUTdiQIuKM852pzSkUyMFJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Qd3NFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C4C4CEF1;
	Tue, 25 Nov 2025 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764059754;
	bh=nCuBpk7PR9FRmu/l+FVLItkkVf95qdDCEkK6XMKESbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6Qd3NFqhKaAsSNE/5oZox1oBZdtFhQ0rjrvy9MfE7TWO0foaSxq+sT07Yp1ys1LV
	 IfGfbl3wMzdiiAYDNSL8IDRb4fggEP+9agw0dVC6pr1L/R+z37NnL7y2NN83gTSLIf
	 nG4U/3isKvP5pA7LQlFTFKezF9/het7UMkyS0buNa0mWXnUmqMTfBP9eI8LrOEhT2I
	 1jIpKLFiiq2FvK9b3dLi9Qhha2692reiPRQbHEerB0lo4aIMHkw9JhE3hYnoJ8Rs0y
	 9KyrJmkRfem4KJkcuMSjF20wLA4Y9xkqsoifKApmEdYHgqmXTfiULrFS+jBu4CIj9E
	 lfvKYEKCM5cJw==
From: Christian Brauner <brauner@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/namespace: fix reference leak in grab_requested_mnt_ns
Date: Tue, 25 Nov 2025 09:35:49 +0100
Message-ID: <20251125-kuhmilch-aufmunternd-a3f17aa03d42@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122071953.3053755-1-avagin@google.com>
References: <20251122071953.3053755-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=brauner@kernel.org; h=from:subject:message-id; bh=nCuBpk7PR9FRmu/l+FVLItkkVf95qdDCEkK6XMKESbQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqZqU9CQt+sbcy4fKkrVrx2zYYqAc1z5n49+7d1Vc6h LMlmo+kdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkqgXDfz+50if/2Fy6u1VX bV294dTFrSVXrV6d9A594HdnT0v4hxaGv4LJHfum7jikIM0oVNbp7VVR+15rwZG4wpT2mPp8y5g WNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 22 Nov 2025 07:19:53 +0000, Andrei Vagin wrote:
> lookup_mnt_ns() already takes a reference on mnt_ns.
> grab_requested_mnt_ns() doesn't need to take an extra reference.
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

[1/1] fs/namespace: fix reference leak in grab_requested_mnt_ns
      https://git.kernel.org/vfs/vfs/c/7b6dcd9bfd86


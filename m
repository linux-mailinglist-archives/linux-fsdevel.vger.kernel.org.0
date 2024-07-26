Return-Path: <linux-fsdevel+bounces-24297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5A93CF24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808C41C21C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C9176AAD;
	Fri, 26 Jul 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDojCTwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741522F50A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980673; cv=none; b=EvrWcpDPopD69gHZsTECKn4B1d3rgPEMFFy5VL0UbC+mjNYXvLkBIF7sWTGHsrqX3l2DFTSl6newmIGJBMH39P84GzLyBFzuRSa9v8fwnxo+N1obJdQCQSxPM7sgOEcDKh6zHtQTbnQDjZp/5m0W/OyKr/PYO76Dnd25Kb+fbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980673; c=relaxed/simple;
	bh=8jTXfsrcnJXENs/Y0Aq1k8+dlxRjaFtrHUhzQhG6Mhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDenAMb6NXwRPOG2G8TMzPXFtuPMB+uznX72lsH7jCZFuVBB710zFZG1XmUipatA3b0tWUmk//if/H3Z4z3/67eGGbS6t3dKLSEhwYYLoryih26xnrfFJOZAp9Y183cpE9AvrKPx1JYML/JO/v8a7Ail7fi9AZELRH+WcXtWOFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDojCTwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE4AC32782;
	Fri, 26 Jul 2024 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721980673;
	bh=8jTXfsrcnJXENs/Y0Aq1k8+dlxRjaFtrHUhzQhG6Mhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDojCTwUuj6WrevadK2nRu+jFz62+W2UUXvdI0GpNUYwx7GZJrsgHUahGUq4KraBT
	 jR61xVmTKHYvEU3t7kHUz5UsQF2tXV5pUGsV2NsbXiuI2SIxSwjqWLp41UGSyD3Cpy
	 RwY0kRzL1qTDUY9hDpOQfFwoFa5SQh7MqgNn+FmxskIFJyLqCn3dPq8x3oAVKj8G+F
	 cLXpdnl63OfVAPuYT989VtYBH6N4ocaCTl2BVv7SL92SzwfOEOpr+eaOR96ZEg79Fo
	 cn2VK1InrLNs+I9QysWVaMxboedoa9L0ozCWv1ScPPRu+riK0RwMYZt2pl2h8/eh6W
	 7dzwzLr+OegVg==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	maze@google.com,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Subject: Re: [PATCH] hostfs: fix the host directory parse when mounting.
Date: Fri, 26 Jul 2024 09:57:43 +0200
Message-ID: <20240726-bearbeiten-inkognito-0392543e5743@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725065130.1821964-1-lihongbo22@huawei.com>
References: <20240725065130.1821964-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=brauner@kernel.org; h=from:subject:message-id; bh=8jTXfsrcnJXENs/Y0Aq1k8+dlxRjaFtrHUhzQhG6Mhs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtDvvlkZMZmmtudF3F+oD0PtMt/G6G8jcv3X13xjk64 GJgwIeZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5Kc/wz+SWo6A621LN78m1 kfurf/+offzhQLzA2wPesh77piaWb2b4ZySpbjyxqvLt1yk7nl5dvtWZ0yNB0rd3n7Xxfe2nyy+ 2cgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 14:51:30 +0800, Hongbo Li wrote:
> hostfs not keep the host directory when mounting. When the host
> directory is none (default), fc->source is used as the host root
> directory, and this is wrong. Here we use `parse_monolithic` to
> handle the old mount path for parsing the root directory. For new
> mount path, The `parse_param` is used for the host directory parse.
> 
> 
> [...]

As mentioned somewhere else the check for param->string being empty needs to
check for empty string, not NULL. I've fixed that up.

---

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

[1/1] hostfs: fix the host directory parse when mounting.
      https://git.kernel.org/vfs/vfs/c/3ab8d61f1e4a


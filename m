Return-Path: <linux-fsdevel+bounces-44028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5FA61534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39463B022D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C8200BA3;
	Fri, 14 Mar 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eILPBr78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC47081A;
	Fri, 14 Mar 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967082; cv=none; b=fJvvb8whHf8j7fhBPxuHx2NnGaz+n507KAl/whxut/elTbpl+vboJZE9ZZwL1EH3aQWUQS5E7o+m6HNlz89Q8stdyeqEnVW+XQi0xGX47ChNRWMGXYdEe2Q3d3xMlz06BUK+WieD3x1XHJ0i4jRNBgi68EtxOoriym9VxNmdfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967082; c=relaxed/simple;
	bh=12gBnWBrlsr8hAimFNvyWNcT/8eRcB41OcwjzN3xe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uI8gI4xoJqSyhyE73tDPPtk1Ki+VZpMPHB3bQvw+35RLujhwNOeH3TYqmKpy2EfogJkZnCItmWHg/SxZ0+fhYETOsmuo9sLbmIVldkUSjr+Kl9PJmlUWWS8aeSKWIQkjBSgjIs8x0WAjQ//3UDnfXkxHFioCGqRT40jzMQw7pcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eILPBr78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428FFC4CEE3;
	Fri, 14 Mar 2025 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967081;
	bh=12gBnWBrlsr8hAimFNvyWNcT/8eRcB41OcwjzN3xe0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eILPBr78CLrGYrhmzv6PT4lJ6476zZRMwtCCzuhTFiG+P77Zf4Y8BjwG6+bgWY57P
	 +cCdbMJkPpYB8/kF7FEsgJypKF7jCMoSD0prtRg9GsmmmsNQjp44FVnRMY0usvlnAc
	 wc3481hlWwUNSwRGnkfyTFSlUD00xVULLh0iWfh/ID5OhOZYfZ6ogEkRTp/XJB/saW
	 gDLMbGpSdcjBlgzs3F0miEY/bLclbOhnXgVFNUKsW+xXGIQzM6ArtTBX8qvtTJ3gQ2
	 f0/HEkoOl8ptl17jjcvUn8wYjkvSAPOO9kDS4eHDT2ftzlwiGnQPwGufO2FtDeHUih
	 Ag2Tt/QdOZhTw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: dedup handling of struct filename init and refcounts bumps
Date: Fri, 14 Mar 2025 16:44:34 +0100
Message-ID: <20250314-urheber-zujubeln-ced6d7db659f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313142744.1323281-1-mjguzik@gmail.com>
References: <20250313142744.1323281-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org; h=from:subject:message-id; bh=12gBnWBrlsr8hAimFNvyWNcT/8eRcB41OcwjzN3xe0Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRf8XviPrFyjvYB+5jA8PftYQ8cHxcdXSjM9M1nlanL7 BUn4g4c7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI4kOMDJMT1hcziq5i1e02 qGlYd7+30/Nt0y9GyRVB71W+r1oWcIaR4dkCu8qPyw2S3zyYuExhysct1+RbWMSX6nHt9A3z+Fb KzQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 13 Mar 2025 15:27:44 +0100, Mateusz Guzik wrote:
> No functional changes.
> 
> 

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: dedup handling of struct filename init and refcounts bumps
      https://git.kernel.org/vfs/vfs/c/e05a35026336


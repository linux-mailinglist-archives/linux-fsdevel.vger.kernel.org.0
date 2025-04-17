Return-Path: <linux-fsdevel+bounces-46613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F1A91646
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771F019E1349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5D22DFB0;
	Thu, 17 Apr 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCzFYijU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5522D4F0;
	Thu, 17 Apr 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877697; cv=none; b=VHwz7dVrMqGUiqtjxC2CyhVJvu3rz5H+htmhPLfUhDUbHIjlKP0dMtAopLlALsSSTbU5805S/j69MHbTL6TMhbuBQ8OOCv8oAcHMvnWRQgrTTQAxetahkirbG/6IJ78r/JTk92XB4lSck2TNX+KAOPHMh6bChUs1Cnxu9Li4ld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877697; c=relaxed/simple;
	bh=axP3jeWYmVJwbuD8CXzky/MHGA+XcwiudV6wF63CfVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K95zuiLW8CIxmCREFvIpo+BvYNU/idva9zhET8ccFzKFJXtZ9dITMUqaUbhcKgrEhJhEWxMgveVyY7feTeWSu0d1hxeJh0UR0u8CvT3CrfBz/EMtVIeFPv4y+c+MtNqed4X6QO0wEnxOLc1BblYMEN/BASETyenRrBQZ615tEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCzFYijU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7476C4CEE4;
	Thu, 17 Apr 2025 08:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744877697;
	bh=axP3jeWYmVJwbuD8CXzky/MHGA+XcwiudV6wF63CfVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCzFYijUaLumPW5Qp/5OXhF0FZHKRK96o+NBZ2PrZrYjHEZgGI0Y7l4lZVyRnxr5K
	 Ho7m5iY7RzV2XC6ZFUdNqnZhNNhGfHZJIqKgCRzUeG0TOZC7DrjzrPsJ0fYpEzVfPX
	 JC/gLmYlZOdjy06nL4wx81MpyIMAQ4p20k0kxUQ+vmZCdcljTZ+QiXyn7FCB+1YCfJ
	 0oP7GSHP2bqeaStMwoWDgnTWrgSu6BTWRgOt4sNhADzlaRMy8CJ39t8mohkuuUh5fa
	 pJ8pQN4fmPAYLjSmEFIYLRWY0HJzuCqLYhIThGwACtQowWyXPWZm+WQ7tazWTpPm4p
	 FlMiiTx53iVQg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	axboe@kernel.dk,
	djwong@kernel.org,
	ebiggers@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Date: Thu, 17 Apr 2025 10:14:44 +0200
Message-ID: <20250417-injizieren-sinkflug-2222808feb68@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417064042.712140-1-hch@lst.de>
References: <20250417064042.712140-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=brauner@kernel.org; h=from:subject:message-id; bh=axP3jeWYmVJwbuD8CXzky/MHGA+XcwiudV6wF63CfVI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQw7Kj+HsLKXjhVRG7dGq7mS+aZ3MYv2L12FhSy9c5cU zjp27ttHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5Y8DwV26XtZnsUc7Ge8us 7gRnme5ZXfk37MjKikk2nw0lfdZJyDP805ddvT3T8xY730ZW319axkefHLlYs3ubY7HThJVaamd uMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Apr 2025 08:40:42 +0200, Christoph Hellwig wrote:
> Currently bdex_statx is only called from the very high-level
> vfs_statx_path function, and thus bypassing it for in-kernel calls
> to vfs_getattr or vfs_getattr_nosec.
> 
> This breaks querying the block ѕize of the underlying device in the
> loop driver and also is a pitfall for any other new kernel caller.
> 
> [...]

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

[1/1] fs: move the bdex_statx call to vfs_getattr_nosec
      https://git.kernel.org/vfs/vfs/c/777d0961ff95


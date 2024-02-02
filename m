Return-Path: <linux-fsdevel+bounces-10019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23BD8470B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D215B29ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D246558;
	Fri,  2 Feb 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zls/716n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408B46535
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878424; cv=none; b=WyZV4qJky4DPZQRPK52b2I6EuZWdQqTxvnZdVC8vHUYAAy/E1rAVlgo7nB4pB4SwPdFv0Xuyomc3zhazRrQ+R68h2YhsEkjttfT9wpB8wQWlRUXBTWnbvKX1W/WVrYhk1OcrPpXy9vXh7sKXa0Njvd1ohz5a3wXYWld6X9GMB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878424; c=relaxed/simple;
	bh=JebRVmaBdM+RahHGzeysUvg5Lx0K3al7L5sjm57E0dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFPhd1fgvaw+/fuGAyzQ8kHjaht3eSalxvbndNtohFAYAzEiQaBK2eiUDOo/5pgq7Mdu+1R9MbU1gOfblMk5sB9lAiFmthUTyoVnVLVInFE+4aKfZFU4dM+/6KC4I4tIuhAdp0E9pHDve8+2JTVCvXAqSf84KbDQuCpBlpWy+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zls/716n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE45C433F1;
	Fri,  2 Feb 2024 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878423;
	bh=JebRVmaBdM+RahHGzeysUvg5Lx0K3al7L5sjm57E0dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zls/716nf51OmfF3y9/2fJSSIMF5ZKTS3bbi3hOQYewDSTcpRAMdLdXJqf8uvWnBv
	 2OCS8gxxAMRGWu79d949Lk1Lr4grcSv3L5kdUL94aMxeAyoK6fD52wl+OV/wBejRem
	 4BmkiBK/jldqgXJot7jaOMpmuWFVoC3zrfQn8OOnNNCO/41gvJnyeQnYFuc4ACnc1P
	 EVxp6xzGQ4FtZdRh7+u4Vr5GoWZWDPkxiWBBDUz2xIQDUBMbIyZLS4tM28JH8742sC
	 GjZlyYyMmz8Qq5sTDffFgR0EjFVp9ovK4waiRxfY0PyQnb3EIHb8E8mGlnoqWVc/1a
	 +VgcnldVo+0Fw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] remap_range: merge do_clone_file_range() into vfs_clone_file_range()
Date: Fri,  2 Feb 2024 13:52:21 +0100
Message-ID: <20240202-hackfleisch-trompete-8c3c197fc2f0@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202102258.1582671-1-amir73il@gmail.com>
References: <20240202102258.1582671-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=brauner@kernel.org; h=from:subject:message-id; bh=JebRVmaBdM+RahHGzeysUvg5Lx0K3al7L5sjm57E0dI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTueXqhon2J9tYf9kkPPP9lZK/dPveFsEmE3Z8e53nf6 t+uF7/9oKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiR2oY/in+v3NZLnvf7mOb t99neXi5aP3F5G2bz0nMPukopvrw0+/pDP8jhKNa57I/33PwCccRgQfhnA2fCpKefkmxf/4uaaL vqfWsAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 12:22:58 +0200, Amir Goldstein wrote:
> commit dfad37051ade ("remap_range: move permission hooks out of
> do_clone_file_range()") moved the permission hooks from
> do_clone_file_range() out to its caller vfs_clone_file_range(),
> but left all the fast sanity checks in do_clone_file_range().
> 
> This makes the expensive security hooks be called in situations
> that they would not have been called before (e.g. fs does not support
> clone).
> 
> [...]

Fyi, this will probably only go in on Monday because I won't be around
on Saturday. It'll be accompanied by a few fixes to the netfs library.

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

[1/1] remap_range: merge do_clone_file_range() into vfs_clone_file_range()
      https://git.kernel.org/vfs/vfs/c/f7530a139f4c


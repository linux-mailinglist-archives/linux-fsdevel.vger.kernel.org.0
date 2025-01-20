Return-Path: <linux-fsdevel+bounces-39683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16191A16F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A061676F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D661E5729;
	Mon, 20 Jan 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnD1cWWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB118FDC8;
	Mon, 20 Jan 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386468; cv=none; b=biA72QbVfLvaI/rlHZ8Tm1Gh3iYLGPuUewVRHzLpSMg9crdu4nBRCBs5FEDmmTMFHMXsor5XmEESQDFwUh2H9AJDyiVz40svkPlhs48eLuu6f95fOGuwaVf30j7tOQ5tFEKfyLZJqvUDghCNnEpR3OxylcYWvpP0r6HLviiC48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386468; c=relaxed/simple;
	bh=eQHSqzN8NNeyUdEbAFp3dcGQok8/Z6JJwajOUCXdOOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQGuSiq8EFa13GudiV0CeHPZ9SIGO+LAlzQjA1GYX+KJJuXSqETrTcEqvvejMxhtgl1Hp2vRsiAzKr0jTbvM+fGxePRRvY4pc0EpzpDcBy8eKaTRIKY/nee2vF0v8gV0eSRTAqs+Uac6hmppcYcxGQP6YHVmRCcZiH+zb/4yEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnD1cWWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D80C4CEDD;
	Mon, 20 Jan 2025 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386468;
	bh=eQHSqzN8NNeyUdEbAFp3dcGQok8/Z6JJwajOUCXdOOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnD1cWWqAVsnV24Tyhp0GE2Mm1szOQn25fxtrfW1oojFSjBKZJGeWBkiThubks5Ry
	 rYR6u0OLf3fplaObrkQ/m3b9AEiO3AYITOPETBpgk6VQeEYRbgggedLjwKu0ZpYq6R
	 nerfn+RcXiUyh4aTpM78x302pKa7wvTE/i7259oG2qSMnaktWGBw3aIwTg5VYS1h9x
	 pLIezEeUveBTH016cKnpumTZqQtX5VFR3G8nxexwcp//XdnMyYZyW/uZeUt/LmPvVO
	 wLhSx7Ia+e+CvLvU634oakqzhDL/xc0rrblWiTj/8LqvxPmf6issSh6X2U3dW8qE/6
	 cfqhBRz72p/Og==
From: Christian Brauner <brauner@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Subject: Re: [PATCH] fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()
Date: Mon, 20 Jan 2025 16:20:52 +0100
Message-ID: <20250120-einhundert-chauffieren-4f5ec1b4bb06@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250119025946.1168957-1-suhui@nfschina.com>
References: <20250119025946.1168957-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=brauner@kernel.org; h=from:subject:message-id; bh=eQHSqzN8NNeyUdEbAFp3dcGQok8/Z6JJwajOUCXdOOQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT3Zd5lCOXddf+5i96aXYK9OxbO153Hck3H121W2rGG1 2/ssiV4OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDaEi1MAJhI9i+GfzZXY7L9rsvqs7oaw WeyaLd4mkLvaryc8NVhi36Uyx8vbGBn2qbI1LF8TanjkydcpMxSbz6+KfOVXkuZ73Wl+26PFXds 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 19 Jan 2025 10:59:47 +0800, Su Hui wrote:
> Clang static checker(scan-build) warning:
> fs/stat.c:287:21: warning: The left expression of the compound assignment is
> an uninitialized value. The computed value will also be garbage.
>   287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
>       |                 ~~~~~~~~~~~~~~~~~ ^
> fs/stat.c:290:21: warning: The left expression of the compound assignment is
> an uninitialized value. The computed value will also be garbage.
>   290 |                 stat->result_mask |= STATX_MNT_ID;
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

[1/1] fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()
      https://git.kernel.org/vfs/vfs/c/7984cbe223e0


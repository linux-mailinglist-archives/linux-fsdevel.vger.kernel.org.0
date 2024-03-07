Return-Path: <linux-fsdevel+bounces-13852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D434874C23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C99CB21FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9585272;
	Thu,  7 Mar 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnbAdDb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AF1CD29;
	Thu,  7 Mar 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806724; cv=none; b=hRLWBZ5b/1NVnRinSISwfD+k6mrUmpnKurwlcfwHF7VsVYtxH1A4zPLSJPInfeCc2iMfZYnX7Wf7e3bFwtzK3WzwDamVU6FoH6RMO79kEwIX5ZM6m6fzTvK0MLGwzkAqEQau6UKHXfafEpn+rChXONIPjAGvW24dnJ1HiLtFHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806724; c=relaxed/simple;
	bh=+0Oa2jHUICRbuqKJwTQq++Eufn8AHFdNcjT4/IAsGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgHjtYFH90F31ABuOhNk6eeCpVjkhRlBXEwfjtPmtPCWWJvXXfPZJ4yyj4YpZKPgbSOwSbnw/hA77gEJ07phjaYXA0WTEc2d4B3XEoESCpJmPG91omC/aSB2DzQmXaUw4UMFlFj0fWy5KhImpPHCc2v3qgWGQlDJesidwuU+sC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnbAdDb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59542C433C7;
	Thu,  7 Mar 2024 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709806724;
	bh=+0Oa2jHUICRbuqKJwTQq++Eufn8AHFdNcjT4/IAsGN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnbAdDb23PBlK9t0mMF5gIIhyCaKb3L4irC62f5lweb4+Kr7cw9cv6vVf1gGdIWd6
	 MHCc+UNMpP7kHOoqvwGnzE/YizYxOlF5NDdX/VEVvRQTYmfLWSie5dUnvVS75v2YIj
	 y0BskxiSpGStRi0PeFBEyNBo9cd9s7+pPu05/MzvkSvBPWFgwhbDEbdwraWaXezxep
	 fhrUNhl35KFzfbhLJ3zGSzd1Yizp2b1wA9gIi0X0pliUaTyYTv/FoeVdBlivDPRjB3
	 BkWo7jg5BAoTvPRiVyVo1+zj+s1YWafb9pN8o4246ZXueH3YCJC3NPYgYW/lucWfET
	 QGmOsNfvww8jA==
From: Christian Brauner <brauner@kernel.org>
To: Wedson Almeida Filho <walmeida@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	willy@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] hfsplus: remove dev_err messages and fix errno values
Date: Thu,  7 Mar 2024 11:18:35 +0100
Message-ID: <20240307-speck-meerschwein-5b13faf7b1a1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307092009.1975845-1-colin.i.king@gmail.com>
References: <20240307092009.1975845-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=brauner@kernel.org; h=from:subject:message-id; bh=+0Oa2jHUICRbuqKJwTQq++Eufn8AHFdNcjT4/IAsGN0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+nFLj1fxtzuxnstUCN3dsl+bfNL1+seC+4wvyJ65d4 esmLcPT2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRcG2Gf+qut1USYkz0OJha WNqeqvi9u/2lrHzNVh/3Y0H7TA0NzjIybH/ycu7Gq/eD1W9Irq9xvH5gR7KExIp9bHMcn0kZW6l J8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Mar 2024 09:20:09 +0000, Colin Ian King wrote:
> While exercising hfsplus with stress-ng with xattr tests the kernel
> log was spammed with many error messages. The need to emit these
> messages is not necessary, so remove them. Also fix the errno returns,
> for XATTR_CREATE errors these should be -EEXIST, and for XATTR_REPLACE
> this should be -ENODATA.
> 
> Kudos to Matthew Wilcox for spotting the need for -EEXIST instead of
> -EOPNOTSUPP.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] hfsplus: remove dev_err messages and fix errno values
      https://git.kernel.org/vfs/vfs/c/41983afe811a


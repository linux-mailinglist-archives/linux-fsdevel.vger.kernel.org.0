Return-Path: <linux-fsdevel+bounces-40909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F90A289F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596F11885212
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D522CBC4;
	Wed,  5 Feb 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6iZxNrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E022B8D0;
	Wed,  5 Feb 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757571; cv=none; b=Uy77gCd+Z85S3JZUazXZhMnShRPscufSdfWocuAHJ8RRiHWDZdDSFVYoe9lTKv1psXYR1829wwzOe9QhAtVm52yqWlZ7Hj3zb62x/GnlPPOLKHoB9hUpv95ZkOsWOteCmvJrGjyaPb1y9xc+gim0vNP3gKSjmJLOGT7cP/k4hQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757571; c=relaxed/simple;
	bh=zEhI8pKRp7Rru8p9R1drtIFnel3SBMPqhlIHthqnADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwXXrmUSygA0bd0qoyhbr6E1qFNhgEkPIzR06pB8r0VrZAY4xVkPUr7ppl/y7w7yL6m/gg6aYaiAuaLS566cQspPwOVa/MzWEut47hFU/dt8gFQUveQkrLwmwIJHB9lhEjy+Bbroe+kHUVca0o/gRyu2jg8LAUpnYUc9QmtE63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6iZxNrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B5FC4CEE2;
	Wed,  5 Feb 2025 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738757570;
	bh=zEhI8pKRp7Rru8p9R1drtIFnel3SBMPqhlIHthqnADo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6iZxNrxPOpkDDL1NfflO7qDnxYFPAEYYN4LxbNO/XZ53Dm/pGTlLXbNLaMdv3O00
	 C6L139b0cTHQ6LWucqp7opAfaHrDoy+LEtq4FpwYAffZxvMIuP8T79/f1xGlxr9bDA
	 pMcSGIXoCQkZNRRsUzRRJ6mLBuyYZGOp8ExfKCQODLyKRS3ctZFReCsOCgQ+oK06ya
	 Oc1ySGL3KWW7N1fiRMC3qovzN1bmoNd3yQZTHE8bCR6f7hobnLELkpKrA9Ka04+wHV
	 d/QSgZ3Y4NYfouE/U/04rq5wjT686f8OD7OeIyngkfpXkudmZm7DGSbBqdfv4YZqeT
	 NvA2YmnvvOVPA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: sanity check the length passed to inode_set_cached_link()
Date: Wed,  5 Feb 2025 13:11:57 +0100
Message-ID: <20250205-fangen-bibliothek-5cc2d9fc4460@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204213207.337980-1-mjguzik@gmail.com>
References: <20250204213207.337980-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=brauner@kernel.org; h=from:subject:message-id; bh=zEhI8pKRp7Rru8p9R1drtIFnel3SBMPqhlIHthqnADo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvDt39dMmm7Ud3KCRWqcWyurgq20YsD5sp//++wc+wB 4qV695f7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrb8M/4uUnKfYil01Cmp9 fDRcXu9wygLDF8dzy4ynz01XjQycdIWRofvXYtHlK36/TnjOKTclKmvnjoe3v9VpPZcv4o/7qPd vKgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Feb 2025 22:32:07 +0100, Mateusz Guzik wrote:
> This costs a strlen() call when instatianating a symlink.
> 
> Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
> there is no such facility at the moment. With the facility in place the
> call can be patched out in production kernels.
> 
> In the meantime, since the cost is being paid unconditionally, use the
> result to a fixup the bad caller.
> 
> [...]

Seems ok if ugly.

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

[1/1] vfs: sanity check the length passed to inode_set_cached_link()
      https://git.kernel.org/vfs/vfs/c/c1c84bb08cc7


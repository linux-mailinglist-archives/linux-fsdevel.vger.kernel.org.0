Return-Path: <linux-fsdevel+bounces-18496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE38B985D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B48C1F25AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073958AA5;
	Thu,  2 May 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNMfLtM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4D5788E;
	Thu,  2 May 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644014; cv=none; b=t8KdFWxxGtE9/vLERNNGLijEtWVHJwDHb1/bWprK8S/3tKlfW/kSyUtmXRHtyNAan4PQo7TLti+pUebmMF1OBGnt/e+n0oTjYPdIHZN3BD30gpiLFI8z4WQCZ/HMUshR5jZZu0tNU+e6XgS0GlM7NxQpE8xa5vmcIm0kDgN4HYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644014; c=relaxed/simple;
	bh=BnCgqVy4roN1RWYDwZMmuRnxJPPxt8cJhTwRPFNWUFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqdMeFVHPSAzyXBCfN4nkFSb6Rkh0G+7NIW3eqJA8qRxqdes5hXhphyEKhz3y+4cPzWTCeg9RXwf+ERirs2X4XAKpwFB85ccU9K2nJa9bPtalgdGclrExDUM/yQF/x1QOqqvpzf7o/iIjLEeIG5NnnxU/IehEZOxHk1rWwZJfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNMfLtM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D960BC116B1;
	Thu,  2 May 2024 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644013;
	bh=BnCgqVy4roN1RWYDwZMmuRnxJPPxt8cJhTwRPFNWUFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNMfLtM84rEo00JxZ0JmHaPpHx2Yv6FcwNzvzV5k1pgPZ+wUzejzJWH5cmpkVs0F0
	 DW5+twPCS7Lp3SZ+33sC4yVPkRJFIYVnXC49iZimEpJn4jdXc4DZ/rl43Z9OPl6k9m
	 XIokVW2FsIhvjjeqOqc7wh9Yzmtmp9K2oHZmeNhygA/a3LzYrQMl5dIa2uwiivwBb0
	 i932zJVQzEoVJiMnLuL/znmi3ZhHvx07sjMsFqO9Dfp74NY+vBAdGimF9N4zw2MB5u
	 iqQ2ADOVtqTd7111/rl0CDJZN8TeK7JTjk4XUVidEtGoikokdu4LbzgH01ZjA+hSGt
	 YUyOUPEsMucCw==
From: Christian Brauner <brauner@kernel.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Kevin Parsons <parsonskev@gmail.com>,
	stable@vger.kernel.org,
	Christian Koenig <christian.koenig@amd.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>
Subject: Re: [PATCH] proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation
Date: Thu,  2 May 2024 12:00:03 +0200
Message-ID: <20240502-logbuch-zumeist-b3957cf80757@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501005646.745089-1-code@tyhicks.com>
References: <20240501005646.745089-1-code@tyhicks.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=brauner@kernel.org; h=from:subject:message-id; bh=BnCgqVy4roN1RWYDwZMmuRnxJPPxt8cJhTwRPFNWUFE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQZp6h6bF4UwLVgUtSOaPbjDxe3zzmWvzm4KT6l+PQV9 eZbl0V+dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk0zlGht/fv1Yp5D80n3El 9L33Hl67w+1C0oemWq7l/h3GXdoR4c3IcNPwXVNM7IfZ27geM6YkbPgu2pe/7mOp7or9HAuDjLa sYwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 19:56:46 -0500, Tyler Hicks wrote:
> The following commits loosened the permissions of /proc/<PID>/fdinfo/
> directory, as well as the files within it, from 0500 to 0555 while also
> introducing a PTRACE_MODE_READ check between the current task and
> <PID>'s task:
> 
>  - commit 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
>  - commit 1927e498aee1 ("procfs: prevent unprivileged processes accessing fdinfo dir")
> 
> [...]

Hm, a bit unfortunate that this will mean we risk regressions by fixing a
regression. But this looks sane to me and having a permission handler for
fdinfo does seem like the more natural approach instead of doing the permission
check at open time.

---

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

[1/1] proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation
      https://git.kernel.org/vfs/vfs/c/0a960ba49869


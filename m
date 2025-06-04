Return-Path: <linux-fsdevel+bounces-50677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D69ACE5E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD27A171733
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F020D517;
	Wed,  4 Jun 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qui73LPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14675BA42;
	Wed,  4 Jun 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070315; cv=none; b=mzEdbObBOy/YJ+MmXnzSE7tFWG6fKEdlDQ0N8TV56Aou4A7eD3eH8zW9szkYwmZK2/CvAgIDjp+Je/LZuwnh09ma8wTHarP2S0Ffy5/4dU4oHy05hiWApF3Gn8S6vsl5NIVuawCGsSlglXykOfhRHl4LNwdqslV2lxjWjpZyflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070315; c=relaxed/simple;
	bh=q1ItLl8hb0svlGL7qApVhJBy3xKiqmCvNH/oYjin/vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVnq+qRI5lGVN8Sh1gTK/Pnz5rei/dS1B6Xq0482L/Np7GogWR6dCTG/mNJZZ6zcug7XQfGybSHRmHY/fDTu/2Hd5eH1ZYjAqVjRTUlX3rW4O5YcMYwYch+oVecN4+FEru5otdw0+9VmYzri85PoB8mxVauUYGqc24/utjmwpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qui73LPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C892FC4CEE4;
	Wed,  4 Jun 2025 20:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749070313;
	bh=q1ItLl8hb0svlGL7qApVhJBy3xKiqmCvNH/oYjin/vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qui73LPg7EfNN7/jeHKpwSzKMrxZMqvIl1HcRIlW+hjdFjyxP9Tzg4QZ4nf59Veoh
	 SwRdWykduwrcnGod3vnQqHyM+UhVaEBwWGB6SS8JKuMMcFVPo8u/XpZV1Z9eeML35p
	 DqtNS18k+FgcXzloW3t98+1cgiXPGyaqsvVBaLDzCwAc/NGGOF4pj/ROoxCoLDWRdX
	 7Yb/l3gdG3CWYm6NnXfhXejii7Y5SW0lPG0qxpVEEdpaBbzyyrsfvpulUQIDvuT/mJ
	 1jJqf345MRr/bYOHUpLGbaMCidEI7mqBrmYIe3Z0zc63qma89/5iqU1pPF8polRGnH
	 wh3AdHMGBZ/ig==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Mike Yuan <me@yhndnzj.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: never refuse ppid == 0 in PIDFD_GET_INFO
Date: Wed,  4 Jun 2025 22:50:29 +0200
Message-ID: <20250604-umtreiben-pulle-3a0f7ffb961b@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604150238.42664-1-me@yhndnzj.com>
References: <20250604150238.42664-1-me@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=brauner@kernel.org; h=from:subject:message-id; bh=q1ItLl8hb0svlGL7qApVhJBy3xKiqmCvNH/oYjin/vs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4bHwcl2NoYjcxoeSsoluB7+Y/d3oWCuakh/48J6N32 qYl+++8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcXsXwT22HzYFtGVeMFoi9 3JY9c7ZsU/BEnr2bfI5Ou95ZtXrN8RCGf7qKcVY+e+a09fc4R6/eYVngon/wiu/R+8dfv5KYu7r gJRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 04 Jun 2025 15:03:42 +0000, Mike Yuan wrote:
> In systemd we spotted an issue after switching to ioctl(PIDFD_GET_INFO)
> for obtaining pid number the pidfd refers to, that for processes
> with a parent from outer pidns PIDFD_GET_INFO unexpectedly yields
> -ESRCH [1]. It turned out that there's an arbitrary check blocking
> this, which is not really sensible given getppid() happily returns
> 0 for such processes. Just drop the spurious check and userspace
> ought to handle ppid == 0 properly everywhere.
> 
> [...]

The original motivation has likely been to exclude calling
PIDFD_GET_INFO for kthreads. But it's questionable whether that's a
sensible restriction given that we allow to retrieve information about
kthreads via /proc/<pid>/status already.

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

[1/1] pidfs: never refuse ppid == 0 in PIDFD_GET_INFO
      https://git.kernel.org/vfs/vfs/c/b55eb6eb2a74


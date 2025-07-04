Return-Path: <linux-fsdevel+bounces-53910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECFAF8D59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A561C87519
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39BC2F49EF;
	Fri,  4 Jul 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPW7EHW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B52F4338;
	Fri,  4 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619445; cv=none; b=IH44Jqdwa7AdDWmMqoQ4duSqxnvjUssLcqyCMhIb87kkxg2uBStnEronc0YFHkkxUFiLAEZVsxd8ZoO16prI5oZjjsUU07O/BWVVaXFfm3Mv3D1z/glVFJL/6hvsi5kH4fDVwRgOPcpDyw+WPyvodDnkLtcKJBrge3jt/ZbZzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619445; c=relaxed/simple;
	bh=bbjLcmIBW1o+XXxg6tn/23VBSChySRZ8Li0TSIQlJCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+eehrtjn8kd38dXXqCU96i7bUzP0mb7QMEHoE22It3FdveWIJVF3SvpQwwboM32lv2Qd5nyGWw6NcKQSBV+PvzmhSc19+Ayh8h4wY5N9SeQiips4xa4Ulz4DojKY7mAv0ssxISvUn38Ye47Q+NwKxfqNW32T4qd/8ntHVkF2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPW7EHW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38916C4CEE3;
	Fri,  4 Jul 2025 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751619444;
	bh=bbjLcmIBW1o+XXxg6tn/23VBSChySRZ8Li0TSIQlJCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPW7EHW4Mq9zjeLZ6o/FsFlUib8/d7wjibToOI36GWccfn4XDsvB+USa5IgOLSUib
	 7Qpa1IBRfl87cbMcAmnPsYqotx4grw/Vi+Ibc7NSIY4KrtLAV0c2lv1fsej7Zvy+o3
	 hajie0Y1znsPD2KPFODM2Lzcl3lLT5J1Wp4qhSzQ5HccVgDCiTwOaGoY71mAzH1WiN
	 QW9EcM3gnz3Xa44SX99Qy4kTcZmJ/B0AcWa+UClGPQA04yXaaIPIfaDj6zjynR77Hg
	 dGn5tHdbtDX3hUMmo0wYmBapveO6ySEf16f3TjXwa7HksgX68Q/f6fWBaN8+JlI5ef
	 Y3rGVHdwPZfyQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Laura Brehm <laurajfbrehm@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Laura Brehm <laurabrehm@hey.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] coredump: fix PIDFD_INFO_COREDUMP ioctl check
Date: Fri,  4 Jul 2025 10:57:18 +0200
Message-ID: <20250704-erbmaterial-hilflos-962418895b8e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703120244.96908-3-laurabrehm@hey.com>
References: <20250703120244.96908-3-laurabrehm@hey.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=brauner@kernel.org; h=from:subject:message-id; bh=bbjLcmIBW1o+XXxg6tn/23VBSChySRZ8Li0TSIQlJCk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkTy9QfFR6gmXN4UmhWaK6Is7FjVxKV7aELJ/iJnrTa fH3Cb8EO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCEMzwTzlhryBH7oFdxWem MW+zfPV3/+u67kcmmsF7vk3ePj170SuG3+wL7Dj/WYiF96duOPRUYb70HdZi3acmmgnaM99NKn6 1jxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 14:02:44 +0200, Laura Brehm wrote:
> In Commit 1d8db6fd698de1f73b1a7d72aea578fdd18d9a87 ("pidfs,
> coredump: add PIDFD_INFO_COREDUMP"), the following code was added:
> 
>     if (mask & PIDFD_INFO_COREDUMP) {
>         kinfo.mask |= PIDFD_INFO_COREDUMP;
>         kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
>     }
>     [...]
>     if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
>         task_lock(task);
>         if (task->mm)
>             kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
>         task_unlock(task);
>     }
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

[2/2] coredump: fix PIDFD_INFO_COREDUMP ioctl check
      https://git.kernel.org/vfs/vfs/c/8c0bcafc722c


Return-Path: <linux-fsdevel+bounces-35970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C29DA62D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC29F282F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72181D5AA3;
	Wed, 27 Nov 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5QlllCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299111D5154;
	Wed, 27 Nov 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704721; cv=none; b=UqBWXHZJzI1rxawI+BXKwpt3MT04oqO3DYIjPjt8CFK1o1rpzKJk7Ic2WwNKiBM4zM99Bu2/H0siSr68bTFEFyxC+WA+DPpwUlRKbQ46t3O++fuOadVQG//vk0njcHPeEkOphEiS9Xtp+b2vyPhynfb8o41DZAoSDsriDF7n2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704721; c=relaxed/simple;
	bh=jhfCuG//hKf93/Uj0gV9SnmY/cy69M5v4LN5FI+Ru/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWxH2brCBwKdjDS4cg5kOnlR0A/6SRWqPGhWdRoLqku0uvE/Sh6sIsoJjJeKk14Z8cKfdJklCmIcCLOHOOif+xYsk59RF5z+kLkyedI+TVsDNAR+rBZP4dh+KmHkKc3xVvQuN9xxCNb/zvZGGK9st+2NaipOaN93gw2y0AgtgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5QlllCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DC4C4CECC;
	Wed, 27 Nov 2024 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732704719;
	bh=jhfCuG//hKf93/Uj0gV9SnmY/cy69M5v4LN5FI+Ru/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5QlllCtc37KT2cydMX76sbsx+UaXHbUF5MY8Qd4PXlZZgkSEdU16+MvST96Y1iFs
	 oDxXnmK0t+ZFInhcg3t0dktxdXZCX48t88MXJPgDca/oifB+HFfzS3iD1Vvdr580uV
	 0+ijbpoxc7ctBoJ38uT2yVrPYNF/zHxUGrGU2KJlkwn0/d/5Y+DOclX6sucUvIZF6Y
	 f2tXMeG6mp7+942XmmfpBCEoJoIdzdPqTJXC8zHT6UvynkCBSG27v7yzZaHQ+bt7gm
	 qWHtTouHTstbUWv4Y/MInm9bH+BOWdfiteWAsRqKNgTpeRXs+FRik+2wJ5rnBdBJa0
	 u4db7qcHYdtFg==
From: Christian Brauner <brauner@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: Christian Brauner <brauner@kernel.org>,
	yang.yang29@zte.com.cn,
	yang.tao172@zte.com.cn,
	xu.xin16@zte.com.cn,
	lu.zhongjun@zte.com.cn,
	chen.lin5@zte.com.cn,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boot: flush delayed work
Date: Wed, 27 Nov 2024 11:51:51 +0100
Message-ID: <20241127-flohmarkt-beispiel-718586524de1@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023135850067m3w2R0UXESiVCYz_wdAoT@zte.com.cn>
References: <20241023135850067m3w2R0UXESiVCYz_wdAoT@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=brauner@kernel.org; h=from:subject:message-id; bh=jhfCuG//hKf93/Uj0gV9SnmY/cy69M5v4LN5FI+Ru/w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7/TzOfrFNQE9sBt9PhndX/i/J3+ZQtOY5U6nG6fVPX 3/J0tay6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI8xVGhst1vI/+CW/XctnL c47TIMtXyKJ7Qkt35rzXMedk68QPZTAyPNM4wSxh/dMm/eIHJwUvhmKHSN2DBsE3Nu+fcnWxv8l jZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 23 Oct 2024 13:58:50 +0800, shao.mingyin@zte.com.cn wrote:
> We find a bug that the rcS file may not be executed, resulting in module
> and business not being loaded. When trying to execute rcS, the fput()
> related to rcS has not done to complete, so deny_write_access() returns
> ETXTBSY.
> 
> rcS is opened in do_populate_rootfs before executed.
> After flush_delayed_fput() has done to complete, do_populate_rootfs
> assumes that all fput() related to do_populate_rootfs has done to complete.
> However, flush_delayed_fput can only ensure that the fput() on current
> delayed_fput_list has done to complete, the fput() that has already been
> removed from delayed_fput_list in advance may not be completed. Attempting
> to execute the file associated with this fput() now will result in ETXTBSY.
> Most of the time, the fput() related to rcS has done to complete in
> do_populate_rootfs before executing rcS, but sometimes it's not.
> 
> [...]

Commit message rewritten by me.

---

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: fix bug that fput() may not have done to complete in flush_delayed_fput
      https://git.kernel.org/vfs/vfs/c/c0ef70cf7a91


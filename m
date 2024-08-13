Return-Path: <linux-fsdevel+bounces-25769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CA950443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE6C1F22314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09992199238;
	Tue, 13 Aug 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMu0UrB0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E91991D2;
	Tue, 13 Aug 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550259; cv=none; b=IeMnzs3Vb1O43XyIrHKab6Vqg8Em9xaNLgin/dNmcz+FJ7QijITPXFNGAFVhg/RBfgFkxK42PePNHfFmxyuR/baUPLJ7jz5HwoNp5LPYfeukkTMKEO+pFhqubHkvTRuJUvRDu74OF2g3ipxwnxkUE7GM5z6tehiJ71rGuTbj+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550259; c=relaxed/simple;
	bh=4gN/Y2rCcH73ALAfjmDWuIYSIPnEfOJRUChVr/R2A/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTxDB40k+a4z510ORkhxf9fIGwS4OcQfAL6Wowzd+jKRkQBNdTPyj6gI8/ntNyI5ER313Mmo5oifV6zVcHT1ExlwY8XnC/DxxoA5IObBJyrhx9Wd4pKDLB05I5lhbreO8XGWFsavcSne0TtJyTe/siA1CDuUHm7+bwEvf2ae1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMu0UrB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB279C4AF0B;
	Tue, 13 Aug 2024 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723550259;
	bh=4gN/Y2rCcH73ALAfjmDWuIYSIPnEfOJRUChVr/R2A/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMu0UrB0fx/oiTVMqLiP69LupT+NwSAAELrKSvWQF0DSjTZptqOtiLkqDUlE/yelZ
	 nCmPoIpH6vgF7eXL+ZJ963iRdUHzxli8tUQVfmNxTQ5WYktoCtC5x0U5Yh43qZh4Oo
	 7Yr2eexupGNdKdVNO56icgcNSfcjwJjhdBB8SWbePb7dtClKK2BXitYPei5CVZL9rm
	 gVQ0P37vSEA03F/Kg0ZZWOJAUp8YTNt6YnmabULP0l/+Z4espncbA/g+oOnBVOfvkB
	 jC3IvoAVi4Q6aPHZ6Z7btcFssa4SLaXrY3XeP2VP7xUB3Vje5LEDNkFKc0rj7WCSKp
	 SDuwj27U7OWNw==
From: Christian Brauner <brauner@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Squashfs: sanity check symbolic link size
Date: Tue, 13 Aug 2024 13:57:01 +0200
Message-ID: <20240813-chemie-rotation-5ab2a178d043@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240811232821.13903-1-phillip@squashfs.org.uk>
References: <20240811232821.13903-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=brauner@kernel.org; h=from:subject:message-id; bh=KjaOO4Q4VSb+ysrAyQ15dfPNcmm9n1J7EzqI1wGjIA8=; b=kA0DAAoWkcYbwGV43KIByyZiAGa7Shah4k8F8KIqpMb1fI45Ix4SgZ27h78wqdFmN0xHiMPFy Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAma7ShYACgkQkcYbwGV43KJJ+AD8DYJS l3X1RrSZjTAX7G4f02xFZTFHW0ejdTwcQq0YSNABANdfOlDQqa30Z2ib3BysDKn2Vh03WXi8NX+ jL8y23fcJ
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 00:28:21 +0100, Phillip Lougher wrote:
> Syzkiller reports a "KMSAN: uninit-value in pick_link" bug.
> 
> This is caused by an uninitialised page, which is ultimately caused
> by a corrupted symbolic link size read from disk.
> 
> The reason why the corrupted symlink size causes an uninitialised
> page is due to the following sequence of events:
> 
> [...]

I've grabbed this. Let me know if this needs to go through elsewhere.

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

[1/1] Squashfs: sanity check symbolic link size
      https://git.kernel.org/vfs/vfs/c/810ee43d9cd2


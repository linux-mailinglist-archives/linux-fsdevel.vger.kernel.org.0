Return-Path: <linux-fsdevel+bounces-44565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBBA6A5E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D26171913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48521E0BE;
	Thu, 20 Mar 2025 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAlds+kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57F21B9C5;
	Thu, 20 Mar 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472446; cv=none; b=rAbHhHeHZvCVKJeUjeacDX5AWwO0SnKCCQxEyq9NZ48wWrHfisWV3ZaM0/RZrwzC5Q5uBmTV/6+ekM8l9uT1wJCfWLlVxqMBmOGDNUf8AteHn2TPAIqCg/qviSoA30Y7abQ4/7FhDLh0VUhlnjIU9tXPSrCRtUYMEOeRsWUP6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472446; c=relaxed/simple;
	bh=DdLmbiZIe5M95mj8ZrqKxiqcbLuETf4IHvDcbhbav20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avg7O/MrNKfWYTXCREqOSJeBVpsCCxBUdI8oOhNAPkuVjy0RVDONu0elBXSCucQbXvkGowWbvZAPZngf0RkZjl7p2vWBrUtFiQe+7dJ2jXBLtahwAhPbERcGMrglUM2ODiC7IMhB5PiriZkAkBMhCSOBn2Ts+ej8v8JFWL2PuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAlds+kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F245C4CEDD;
	Thu, 20 Mar 2025 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742472446;
	bh=DdLmbiZIe5M95mj8ZrqKxiqcbLuETf4IHvDcbhbav20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAlds+ktckns+lx03YOhpcg7QLsXf9aTlsiGKvG65wTlG8kGo2HsLfriEq1U/AcDs
	 mLVZ3CuuKVEuAyeq0y0iNA+ICMevPsGa0BRE/g6cB+z/kpBBuWxwS38Y+dxPjNIhRQ
	 0mtBsJstRSHycySS37jacLoCmSD3Y5k1IOPBMYpDok/ADoiWZGaEMkBkNa7SSlrTlL
	 UuLekyyTzn7FNb/R2pEVhJD2PbkgdmBEGehqkQ7pGsA8UwTO+t4kUsxOlWVX6L5uQM
	 FfdSoyAuiEaxo259JWLDS70qY98+2O63Rv0U0XdyGtn7WEZvSyuBe37qXY01OCjaDb
	 88FM+56MeoXkQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: call inode_sb_list_add() outside of inode hash lock
Date: Thu, 20 Mar 2025 13:07:20 +0100
Message-ID: <20250320-rustikal-urwald-20739009faa8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320004643.1903287-1-mjguzik@gmail.com>
References: <20250320004643.1903287-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=brauner@kernel.org; h=from:subject:message-id; bh=DdLmbiZIe5M95mj8ZrqKxiqcbLuETf4IHvDcbhbav20=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfYfmxX9HM1eu/zYcpl/bfNJvSH2Sefbxg+ev+5D9id zf86jt3t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBcsZ/uleLV84pWZ640G3 d/8rWZ4dy1h/2qh1xrIrPEuF9y+88EuSkeEhR1zVj4O3Ci/nSKvd2bTli/NDQcuvr3+0HhC3eOu 0YBkXAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 01:46:43 +0100, Mateusz Guzik wrote:
> As both locks are highly contended during significant inode churn,
> holding the inode hash lock while waiting for the sb list lock
> exacerbates the problem.
> 
> Why moving it out is safe: the inode at hand still has I_NEW set and
> anyone who finds it through legitimate means waits for the bit to clear,
> by which time inode_sb_list_add() is guaranteed to have finished.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: call inode_sb_list_add() outside of inode hash lock
      https://git.kernel.org/vfs/vfs/c/c918f15420e3


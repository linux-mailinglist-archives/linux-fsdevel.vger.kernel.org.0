Return-Path: <linux-fsdevel+bounces-67887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4FC4CD24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E8426756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A32F290B;
	Tue, 11 Nov 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXxNjQ+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F22EDD72;
	Tue, 11 Nov 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854612; cv=none; b=WAf+eXzyV1vZzZcJWN2r/B4i9C/E9AY8p+qUjR8Ux8HGI9KFawWhbeXT3gRZ5kf1XNvLkNVhDN5MDUO27Tsj9vHglkmKa3+spfzuiZJ8fJKHQyRORbQqb/pdrRkPGnRFwHFeZHRvE6rRB9OuWW0DJMeYHkP155Uu3g1o74jKy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854612; c=relaxed/simple;
	bh=l16okVrNgxsDI6U6EIfS9tmHA0egk0SYJcVLBk1Q3gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO5cpq+tz3s1AtkiXws7W4UFy1wGXQa4LFqOWxlfibyPBLyQjPWApALRImmxFq2M84n7osHewjSUgPv0406No7xGb3+VWIC8NZgywEcdhkunfD0h35UHQEDCNy6bxMyY2o4MIN1p9mPDZxglA6bW3GmCRXSuMaalkS1Ijn/NcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXxNjQ+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C31C19422;
	Tue, 11 Nov 2025 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854612;
	bh=l16okVrNgxsDI6U6EIfS9tmHA0egk0SYJcVLBk1Q3gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXxNjQ+tZmUOHcS7hcmQM0Mq6bsCH3Bz5+630nwMTbL4iZptKiz8x0BPEFEduZcF7
	 tXc8MgguM7CYN5/unB5NEu4B/Bn78NkqOx2x1bSCim7M0gvbdgx7cCIBQer7PhsXcs
	 YqhATkUtpaEg8lRpQSRG4AhjEhJJ5s2lD2o+BxqWp/xJ5NsgOG1gVTREod7q8j6amH
	 EZ/4J1bXGddHJkfxYYUtDfC3gZtuPZzYv66IIG8TVnEYzpTxNoLuIG/qxJxvW5KZV/
	 5hermCcYKCmGBOL7RnWAsiQZfSK6rTsQwCZddFYXGwcVRTyhW6ZXSxkJMAawuXFISC
	 //8m4QbyBoO9A==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move inode fields used during fast path lookup closer together
Date: Tue, 11 Nov 2025 10:50:07 +0100
Message-ID: <20251111-zeremonie-amortisieren-d1455ae20d5f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251109121931.1285366-1-mjguzik@gmail.com>
References: <20251109121931.1285366-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=brauner@kernel.org; h=from:subject:message-id; bh=l16okVrNgxsDI6U6EIfS9tmHA0egk0SYJcVLBk1Q3gc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKs53X/eYoEaf27cfqj9OOrFm0t33D+YC14Tp2voLq6 VfWB5tN7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI2DeGP7x8J+qOTna05Bbc 1SC14dyL5SsF+d0Kjl/YXPHFXkvx9iqGf1bRXV8995iJNLro132uSp53ievaJt3nzPJT9nbUJk3 hZQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 13:19:31 +0100, Mateusz Guzik wrote:
> This should avoid *some* cache misses.
> 
> Successful path lookup is guaranteed to load at least ->i_mode,
> ->i_opflags and ->i_acl. At the same time the common case will avoid
> looking at more fields.
> 
> struct inode is not guaranteed to have any particular alignment, notably
> ext4 has it only aligned to 8 bytes meaning nearby fields might happen
> to be on the same or only adjacent cache lines depending on luck (or no
> luck).
> 
> [...]

Applied to the vfs-6.19.fs_header branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.fs_header branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.fs_header

[1/1] fs: move inode fields used during fast path lookup closer together
      https://git.kernel.org/vfs/vfs/c/dca3aa666fbd


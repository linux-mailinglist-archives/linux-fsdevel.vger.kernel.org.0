Return-Path: <linux-fsdevel+bounces-59017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D1B33F04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC1916D30F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1192F0671;
	Mon, 25 Aug 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5q/SxwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380826D4EE;
	Mon, 25 Aug 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123780; cv=none; b=arTnU6yjq+jurUNeH/4hiqRUHYUcfPMSgivj1x6Z0YGXK8EBjhXrxUGuq5S6/EC2loBBAUCacYo+mC2lthZm/P3TC615cocT/HHYa8hCZ/X48/H00twD02fH+pzNeuYjKVdy226jx2owM29R4I/IwJjHiBhCG9OutVtG2rdgOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123780; c=relaxed/simple;
	bh=Xt9GeesO7UKYZ6HvYtSooPom4+T/++Ibq2YDteVCRaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASPzZDIKJund2zMvBo1N353hrFeQ7nN5WQn4G3UBVOASwA1VcKIq0//o9/qEGM/vOYuNklQLvdmK3Pr77R+f5DT7iuM9pymaQJZ6cJJ6GxDnkxH4wB+LVRucpi6kqZTRnaWnJFzkxgVHci3e2qyJFk8BDLWpRxxe06TprNnAR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5q/SxwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E07C4CEED;
	Mon, 25 Aug 2025 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123779;
	bh=Xt9GeesO7UKYZ6HvYtSooPom4+T/++Ibq2YDteVCRaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5q/SxwURn9NypgRDf8dSIeuvvs3dJZrAL+OMLF0+1XbWrNatXiG3+mxyG1re/kNM
	 Buj7XYJb++903KcMMUzuSvtIXVKfG95iJek25mD6ajEZNyO6HKpH7j4MGNbKes+27g
	 nXAX++y+nHmDfJA8H1DFuWSGjrRN5OB2F9NizqIkJFM/oV6W2HkhOBbykgsbRdNhTd
	 zqbyIT0ph55JROlc4dFXodi5FAkewLg88zOvYSwHoyOhfH5wcjLzpUvYbCUPVjW1f8
	 BsV0gNnFA+7ilz8hQuldG/hdT+Dh3yrr+mb+f6KImpPUGhNiX5E+eOYShvVPFgKbF4
	 wJa4WRp4k94sg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Use try_cmpxchg() in sb_init_done_wq()
Date: Mon, 25 Aug 2025 14:09:34 +0200
Message-ID: <20250825-rundgang-drakonische-b339b25c6f90@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811132326.620521-1-ubizjak@gmail.com>
References: <20250811132326.620521-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=brauner@kernel.org; h=from:subject:message-id; bh=Xt9GeesO7UKYZ6HvYtSooPom4+T/++Ibq2YDteVCRaQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSsCarb/OjfHucWrYWzLF49DTJknBB9d4G/9lQNCbFa4 87HKp5bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS7s7I0K6cOs1yVbZ6WIuK xKy8qkgrAYH/vPpHnh2ZzMJXKDhnLcNfwYK6irIziz02WrZ2Nh9WL/6p8n6bTa/uj7s759XqTZz IDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 15:23:03 +0200, Uros Bizjak wrote:
> Use !try_cmpxchg() instead of cmpxchg(*ptr, old, new) != old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after CMPXCHG.
> 
> No functional change intended.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: Use try_cmpxchg() in sb_init_done_wq()
      https://git.kernel.org/vfs/vfs/c/ec6f613ef376


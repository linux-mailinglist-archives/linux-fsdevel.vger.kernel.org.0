Return-Path: <linux-fsdevel+bounces-73197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3C8D11763
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB3E307AB46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5B346E56;
	Mon, 12 Jan 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC82/nOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDE338598;
	Mon, 12 Jan 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209530; cv=none; b=iY/+lnqjSOdZtv7N0VviClJopkBEjYgvkTiK576ip95jNn/Jt4Oj/0Cabogr8/c8fSo2tT1RPua2t5ucr43A3rcsynmMALjgzpjLuQrWhh40M74sr6FYPuQHzriJxKjV+ZQFwdzgLsk+JvVaA73CuibRF8ptO9KYs4yVSmqrOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209530; c=relaxed/simple;
	bh=lyOZpKLcoRHice/EkuXStShTY1Kz8eDe19lq5Q10+YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vs/RKGn5/Bly+bsLYYvkVomdyyv1lBMWAPp0aMjqbqAobsp19qGOZgKta+W4qOsAfFKnCWDAx5C7r2SQuZcti9T37udV3blQIAxJKog46pvtpQ4EzKmiMsF2ZwRtlAT7KOGNSGpc4l3oQxVrmLT4GILWNtHKqA6jLPVBUm0vvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC82/nOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC9BC116D0;
	Mon, 12 Jan 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209530;
	bh=lyOZpKLcoRHice/EkuXStShTY1Kz8eDe19lq5Q10+YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PC82/nOEPqQNCJvcLo9CbRfB8wZdVnCFZtHzZnqxsyzqCSlZER0Wkrp/N0nWibKrH
	 iUqIgRqR7im9g2oKy8BIpD5/aan5Mi0AZ+B7BszoT4UZE3M9iICdB7ufhoZoMd4J+H
	 1HPjeQv5hf6KCstZhMn68UPJchFBCdSO7GaUnqshgGAaIQDCrRAjPTP6j4DWP90QEi
	 Gig0W0DYZWsdl5hZWqTqeVkcnKIW3bc6J2YSkxq8lbz6dMsCe31Ay5+S0txXj/pvHN
	 4w2y/WY5aVAa2A2Cd8FM1HN6Lw+HX0CcA3VA9TgnPwoJ9riLy0/6SkenB0dPiXdFV5
	 5gNVhA9rqiXOA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: make insert_inode_locked() wait for inode destruction
Date: Mon, 12 Jan 2026 10:18:43 +0100
Message-ID: <20260112-weben-feind-ddaa3ecba58c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260111083843.651167-1-mjguzik@gmail.com>
References: <20260111083843.651167-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org; h=from:subject:message-id; bh=lyOZpKLcoRHice/EkuXStShTY1Kz8eDe19lq5Q10+YE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSm7Cl5IH949YH07vovMpP/VyuZxK/zXni86YrfRC3ZX fOmSLVFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEP5mR4S7r5s63nt8d/vDN DUlnrb0kKC3TyHru4mqhxuZXYgvWVjL8T3i+zsh/wRQm5o1fdt77bL2Vc25Pts4VtU9LL2lvtFX 9zwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 11 Jan 2026 09:38:42 +0100, Mateusz Guzik wrote:
> This is the only routine which instead skipped instead of waiting.
> 
> The current behavior is arguably a bug as it results in a corner case
> where the inode hash can have *two* matching inodes, one of which is on
> its way out.
> 
> Ironing out this difference is an incremental step towards sanitizing
> the API.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: make insert_inode_locked() wait for inode destruction
      https://git.kernel.org/vfs/vfs/c/757b907b3ead


Return-Path: <linux-fsdevel+bounces-46609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC54A915D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D352F440B3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153D221F30;
	Thu, 17 Apr 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFPaqbT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F91A264A;
	Thu, 17 Apr 2025 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876601; cv=none; b=SwFC7XUxLKMG3Hs7nBU1nSNhdu5yEWnU1cB8YUuvIxvBTa4+M+e/hEhwyfAK2wZXojrxvm01Xat8nINYd53HL8AzSES5Kx3Yh2rDEj9HKlBuGNi+P2OFtms03vrMNxSp186WEoFKnURFT/Oo3R9EHEQk1RT8F3+54dPmyYNotAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876601; c=relaxed/simple;
	bh=RxUiFzrEpZlvqlS4fuqNrXLhBNDOhrE1KIvoZVywsvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz+id0ILRMGdXoKTYvFL1ZxOylHHKXDTcwdxmnxF7jW41UTZB36wPExTsr6FQ/wpnmu1agcA419XJ/scdy4JMJB53IU9NDb0Q2vkY7KIO19Xa3eqY3lOP166sXNKRzDJ7IEGKPicE3JLH0hi7WpApG9IJ/ifQO/oK4QbQYmKIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFPaqbT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31344C4CEE4;
	Thu, 17 Apr 2025 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744876600;
	bh=RxUiFzrEpZlvqlS4fuqNrXLhBNDOhrE1KIvoZVywsvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFPaqbT+hGI+wo4OmKtFnepG50kbuWkcPeosOB8tINH/SMpSqaBDj+u6Fa2oUT6Qx
	 fugzQ0AJ1So4SbxvccS6vyd7fgCjt/vfEF+FCG/N4+krBAQvxpQsuI/mEi5QH9ZtS8
	 73lDh5LDTyVvWXcLFX7lGMz4mPcOZNtLtVjSzQY70uwcrIZolZR/NAU/Buu67VPCij
	 2cXDsK+xieZiF7th/5EH0crdQbg21gYzRfNZt5RTBMHpFpbB2qXG1/DGpD+GlRyCh/
	 R4HB8A0uJNW9tgD+c+EQHD8RUOoFiO3UmUPV036X9LIZXCAaHQaoEkzEpRfmzW158X
	 ZF4MlqFVYgNEQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in the future
Date: Thu, 17 Apr 2025 09:56:32 +0200
Message-ID: <20250417-kurzlebig-bedrohen-046f8724a6d6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416185826.26375-1-jdamato@fastly.com>
References: <20250416185826.26375-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=brauner@kernel.org; h=from:subject:message-id; bh=RxUiFzrEpZlvqlS4fuqNrXLhBNDOhrE1KIvoZVywsvI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQwbDFa3XYgalHswbWLF7wRrp04iSuVudPBjqM2J1Ypp mni82sZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJCGT4XxFhd59Nr1W3+a+7 c/KazrlsgSGsp934DfNDJJ/1sZ+VYmT4HHy+6F5T5LlLjgk/A7pNg0K1HSbq6JZXTL1bXWgU8oQ bAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Apr 2025 18:58:25 +0000, Joe Damato wrote:
> Avoid an edge case where epoll_wait arms a timer and calls schedule()
> even if the timer will expire immediately.
> 
> For example: if the user has specified an epoll busy poll usecs which is
> equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
> unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
> consumed the entire timeout duration so it is unnecessary to induce
> scheduling latency by calling schedule() (via schedule_hrtimeout_range).
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

[1/1] eventpoll: Set epoll timeout if it's in the future
      https://git.kernel.org/vfs/vfs/c/0a65bc27bd64


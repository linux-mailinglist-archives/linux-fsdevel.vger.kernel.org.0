Return-Path: <linux-fsdevel+bounces-52520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2475AE3D08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82871799C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EC23D2B7;
	Mon, 23 Jun 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl//8Y3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C832238C1A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675037; cv=none; b=Pr4TbeVwOcZ85rp3s+ImwOSSQtQol7pYMoGzr9LZ9AkeswJ5NUYmz9iLmewTILRd4DWGOD7Tl690gRFDt2fPMIS21SKSaHo55m2pX+qbOidi4ovvxgEKU06539jm0Z/elcNQ74hhAwLiHdnihHyQbMvt9+EiYsiJRK8i+tSs1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675037; c=relaxed/simple;
	bh=O8Cg6ubblTOPrUrpZ7LKvXtbHT6NOcneLX8QiKA7Jno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVuXhuaW+R8ILMmXciSdSkcNmPP3fQLIXUZAapKT9J2V0a1eFIcAh1M0dxqF1rlKMWKWx6IbLBv/LI2kHj+/ug6sFI9+mRpA8CdrYxR1Yq7xMMPaZUHMEY4zNvFpA4AX8oxWjM1TlGiMCVKIiS9jyRRm5qoGjAvzWyuTtL1yTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl//8Y3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED46FC4CEF0;
	Mon, 23 Jun 2025 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750675036;
	bh=O8Cg6ubblTOPrUrpZ7LKvXtbHT6NOcneLX8QiKA7Jno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kl//8Y3rEUhiUm90+gvwm4PsFZzMpu8upMkihWmyxmTL8EnwpS+sMgDQzeYCWsaYD
	 jr/zGbWsllDmSlHqQPcEmKxMfh4/QQzFxWzcWdpDUyyFnC2bMvcRAYk2o0L49EXFTr
	 bo6b3oVxuTtxJgMvMWrEdmr+feBPDHRKGjjq50fsv2tg1kHpa01UXu7hMDASD5tF7c
	 9YCJiR2yZQrlwAFvGmMTEmpCjiTM/uX/PPBi33b/zlONiyKpwYc8EJEl05pswRZOxa
	 8iCnNdfnUVdZkab6yibG6R9SmSmLaHDNRQnyoMGm0LCnq3U09g7u9gZ52cCZm48UOy
	 jYnC1MpD9zEvQ==
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: annotate suspected data race between poll_schedule_timeout() and pollwake()
Date: Mon, 23 Jun 2025 12:37:02 +0200
Message-ID: <20250623-felsen-pollen-e575160f148f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620063059.1800689-1-dmantipov@yandex.ru>
References: <20250620063059.1800689-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=brauner@kernel.org; h=from:subject:message-id; bh=O8Cg6ubblTOPrUrpZ7LKvXtbHT6NOcneLX8QiKA7Jno=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRE6oVtvCG998XCBNk83mX2AZpzX7T1atft4xK/tV+U2 1qieGFcRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQK/jL8s2Q/zxTBf+5y6/R7 GvlqH2Yef+Jj1nJL4Lhk8z/nxda7Whj+R85SmDpjicrM6pLnpQ2yB4Pe50tq6+5+qnzNRrxjzuW zTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 09:30:59 +0300, Dmitry Antipov wrote:
> When running almost any select()/poll() workload intense enough,
> KCSAN is likely to report data races around using 'triggered' flag
> of 'struct poll_wqueues'. For example, running 'find /' on a tty
> console may trigger the following:
> 
> BUG: KCSAN: data-race in poll_schedule_timeout / pollwake
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs: annotate suspected data race between poll_schedule_timeout() and pollwake()
      https://git.kernel.org/vfs/vfs/c/2b7c9664c3ce


Return-Path: <linux-fsdevel+bounces-21529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21D90525F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409741C20EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861C16F845;
	Wed, 12 Jun 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgl/eBT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B2208C3;
	Wed, 12 Jun 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195170; cv=none; b=qxR/ZnnTPWHTzodXI9qWWfrswKj43qxP4YTBy08kL7jaoC8HX0JSSoznqm8FVtJnBq5j68b++za+WI8Zjgxd59staYwMlIioWgJIl0ZK2SAu8ZGlcZd/QOixUa+d5rRmRLCodA8svxp1dfTNIl+RyFQaOHwcDoQUbQLxsqok2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195170; c=relaxed/simple;
	bh=r+Lw98mCKQ055kDR0R/dmMveWb/2XAJFiy3REMQRYzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hN8mGAx3BTK16qgKbnF36EMrImMtAiS4yuxn5dEYilC1ZxLu7fKAPsGBXXBcTfWCfE/Vbeh8CkD71N8mkjOjNqUbijRDlG6hc74dyeJ5O/1i6ircpLzTT7J9aZobCuf9fGAwI7abwx0rTcXT8JBB7Hu2FUxEiG53oimSP8ckP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgl/eBT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7379CC3277B;
	Wed, 12 Jun 2024 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718195170;
	bh=r+Lw98mCKQ055kDR0R/dmMveWb/2XAJFiy3REMQRYzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgl/eBT9dmbt9Nd/zno81sl+ClZJ80u1fnXdvBDxJLi6+nJRDko+SaaJRIBP+ArwY
	 7fra1gfZ+OHRjR3HertfAkI4iTi6GkQgU+aowgYTYRzuDhUNFpRq4Ka1V3yvOa+dNV
	 dx/3VdBMDvre1gfFiuJfA/HaYYmUTwIcUNX04oBwZJ7bJUIKT9VHHnsaM2XsNMBPmJ
	 qU1Cqrw+Z/+KlmwYDQ9CRMFfOmSkTuWDW4zwMorUCNWoj7UjdmQyXRQgo2DZAltJJt
	 suPbpf85XErSYuXYUV6r/w45NsDdlZZmuGbMU6UtQgzGDDh4nyM633SWiUuxLQsiKX
	 z9QKcfWevg7Nw==
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?q?David_Howells_=3Cdhowells=40redhat=2Ecom=3E=2C_Uwe_Kleine-K?=@web.codeaurora.org,
	=?utf-8?q?=C3=B6nig_=3Cukleinek=40kernel=2Eorg=3E?=@web.codeaurora.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] netfs: Switch debug logging to pr_debug()
Date: Wed, 12 Jun 2024 14:26:00 +0200
Message-ID: <20240612-wacht-dolmetscher-2200b9e6459e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608151352.22860-2-ukleinek@kernel.org>
References: <20240608151352.22860-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=brauner@kernel.org; h=from:subject:message-id; bh=r+Lw98mCKQ055kDR0R/dmMveWb/2XAJFiy3REMQRYzc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRlTr5jacakN0m1cvdVtSe/3DIVF8idDXFZfiubM7qiW FfpG8//jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsCmJk2HZqmXPhnrhTus8m dTiUpu7mWdDkM29+0PGFDSoLXr0O+87wPzR4ySJWwzZhJWFWfUcdYV+e2ROZ1OR7Az6z/Vy+7rg yPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 08 Jun 2024 17:13:51 +0200, Uwe Kleine-König wrote:
> Instead of inventing a custom way to conditionally enable debugging,
> just make use of pr_debug(), which also has dynamic debugging facilities
> and is more likely known to someone who hunts a problem in the netfs
> code. Also drop the module parameter netfs_debug which didn't have any
> effect without further source changes. (The variable netfs_debug was
> only used in #ifdef blocks for cpp vars that don't exist; Note that
> CONFIG_NETFS_DEBUG isn't settable via kconfig, a variable with that name
> never existed in the mainline and is probably just taken over (and
> renamed) from similar custom debug logging implementations.)
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/1] netfs: Switch debug logging to pr_debug()
      https://git.kernel.org/vfs/vfs/c/999876f35003


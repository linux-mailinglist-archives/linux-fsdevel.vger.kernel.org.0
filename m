Return-Path: <linux-fsdevel+bounces-25505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2694CC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C321F228A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA418DF7B;
	Fri,  9 Aug 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGI70ITi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A91741C8;
	Fri,  9 Aug 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192416; cv=none; b=mskQd8dkpagr11gfl24c7ul5yMHa6CHpz5/8QkTyPFO2j+plFj1kqoHzcVUohNtoD89APnJMg84A2PeyW7nX4u8fmHT0dwqp/tFuiBiGi2CsMyZSimz7srJkdOvdQvE81+WZT1EAIpNwRJhTiVk/PRGit07D+VyrSNEkljR6S8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192416; c=relaxed/simple;
	bh=tyLdCyDCC6G6/w+ZtOcdI6dtV+ayR9XnwYUxrRl5gqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly/8x165vCkmmvA6xYsrAsB5Hx4lOUlRD/W1iyif84MvZHBWNGyr1HS2Q5Du5n+4ChUeiz97/rc7lksRiZgnYTo9XOKZtSglWTAsrpcU8muohInTRfBrbcXkhjPCXgAgChMN1tCt4lfUngCwDr1L8aDiCligDdX1s+Mm4rlynSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGI70ITi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462BFC32782;
	Fri,  9 Aug 2024 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723192415;
	bh=tyLdCyDCC6G6/w+ZtOcdI6dtV+ayR9XnwYUxrRl5gqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGI70ITi2gUFJQqkX49+/58kdsRDVW0mhGU4nOxq4PGlhA7s5bwmdy7J6zSzXIBrv
	 4FpEIrSEr7OGgyKHiUTbGuJSBy7JxMX8CzPFzfaC0y2nKdjfFJgpGG08y6/kyk9GeJ
	 giT18AIAy2ese0ef/O3dLt3LoNcff35t+n5grebkW6oJTrP43cDwwnRfXu9Eqgglbv
	 rcvpdMUwBu4iatlYLn+sbQlhjo6zT/SUkkI1TkHx5GGSevoMyI0QIMicyW3EHV/zKw
	 TJCr5v9TrH2aqBr4POe9jU8I+m+CLKQbL8N75NJMjPDZ+I/Dl0TaBFMIXBV/Kfl9M7
	 4nYJQXcC3bnrA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kees@kernel.org,
	gustavoars@kernel.org
Subject: Re: [PATCH] fs/select: Annotate struct poll_list with __counted_by()
Date: Fri,  9 Aug 2024 10:33:20 +0200
Message-ID: <20240809-lodern-knirschen-43681b70e2bd@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808150023.72578-2-thorsten.blum@toblux.com>
References: <20240808150023.72578-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=brauner@kernel.org; h=from:subject:message-id; bh=tyLdCyDCC6G6/w+ZtOcdI6dtV+ayR9XnwYUxrRl5gqI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtvRLR+idQPK7ZvCN/sUWt09YN6Y03b33Z3CQwOy+V3 zDtSO/SjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlk5jIy/Ipob/vp6TZvXZsM 388VaUu3vqqNDdi26s3ryxcfV92OOsXwT89ZZEmpkMfDvWlz33zdsnljUKP0oxwBtvynp21uXez u4wQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 17:00:24 +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/select: Annotate struct poll_list with __counted_by()
      https://git.kernel.org/vfs/vfs/c/92f7fe9a4c12


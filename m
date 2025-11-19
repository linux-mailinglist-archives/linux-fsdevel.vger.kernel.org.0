Return-Path: <linux-fsdevel+bounces-69100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBEC6F0D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1A3A42E6FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB733612DE;
	Wed, 19 Nov 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XClUMDYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0D328604;
	Wed, 19 Nov 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560217; cv=none; b=GX1Bz0XCmhLudPLAU3oNXqTVJjn4XXKFluKsUE/6EGleBIFxumB+4nfPv6f1unL2+ZE2xXvZzf99JViaNnJmnoPks+8RBlJDSIYAwYmH/s/wfvNUPAfbOvSjK0nRrhhi2OscsMKZ0nRjnGZBglL7HgJ0Ty0n45m4XFyQ9pLa1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560217; c=relaxed/simple;
	bh=5/z60YZ4HDwgQcWS+xT3OG+VFbEseWYjLnf2sArfWCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwtg5xIIJv/+cd7EB00ev9Tm/1darMsF6A4BcMnLsQvjXTzHCN7ebUmIluzvtMMCJJoZiz90G0i5R6O3vLmycqgrjpvEo140FXrk0GL5rrtehaK0yuN3yiY99i+AhgY2LpWDCOjRknPYdbcT3SwSRopfeMk50qj4XioXURSDyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XClUMDYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9204AC19424;
	Wed, 19 Nov 2025 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560216;
	bh=5/z60YZ4HDwgQcWS+xT3OG+VFbEseWYjLnf2sArfWCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XClUMDYaYwGTE17d0UHvhDbzy1mPDyfVpq4GszeLO48WcdWlWRoy1s3fkomIuP7cD
	 AQnUVdqEfp9pZYBFYAoJs+KPNInwSbdjhpxV6sU1h6JAX5yFVPjDzF/ZAXx763hGxk
	 IEAFJ7hOI9epd9f5rftPbGUx0e9CZfPv36Uj90mSs1LELWveMXH6dF5gMoZfrJWb8h
	 FXoPR+DKOHql3Ehtx/y8rH8EdEdCuMZL2wtU52Tl1nt49D5egAOWctVVFAg60EbyOx
	 Cmdr+3367xomNeEe0Kciy4ke0o4L99HwLyg1fJJFBdMcZ5jgIEMxnoh1kMnOsBY3CK
	 ne/D5w94DParQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: move mntput_no_expire() slowpath into a dedicated routine
Date: Wed, 19 Nov 2025 14:50:04 +0100
Message-ID: <20251119-anlocken-gekippt-adc0ab055229@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114201803.2183505-1-mjguzik@gmail.com>
References: <20251114201803.2183505-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=brauner@kernel.org; h=from:subject:message-id; bh=5/z60YZ4HDwgQcWS+xT3OG+VFbEseWYjLnf2sArfWCM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKnhaSN2Bk3Kf9bq579effz2WbN65b4PFcZeqbyKYw1 p2py88zdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEehYjw9KXUx2q9/OoqN16 vvRz8HVh7bQu7/MftHZMLEhYu6XzxBRGhsPhFan2k9lE9k/TNbnZL2av9jrketxqHycDbr65dUf 1uQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 21:18:03 +0100, Mateusz Guzik wrote:
> In the stock variant the compiler spills several registers on the stack
> and employs stack smashing protection, adding even more code + a branch
> on exit..
> 
> The actual fast path is small enough that the compiler inlines it for
> all callers -- the symbol is no longer emitted.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: move mntput_no_expire() slowpath into a dedicated routine
      https://git.kernel.org/vfs/vfs/c/bfef6e1f3488


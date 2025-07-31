Return-Path: <linux-fsdevel+bounces-56387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BABB1704D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9B93BF5BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDC2C08C0;
	Thu, 31 Jul 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgLtjnKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56C2248AC;
	Thu, 31 Jul 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961013; cv=none; b=TrdmpWsCmw0Ff1VrNrO+wNFFf60amYCUV9tf7owMvTLVsyPhMg1WDu801vjH3QUpR2CuTGbNzTqnY15I4m67eCgda+gIvulNAi8dO35h/XepU/RjPTl+qyKDMof0Q5HHc7Hm4IXSOyDh/7OJNpcSwpPXsXI5F8gzCuhUvy4/Acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961013; c=relaxed/simple;
	bh=BJpUBlmPExNpmqRqWiERFmtVnLVQNBstgN8qr4fE9xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc0MC/dUnCcZ2KZmzpFXDY3/cVNUQGsH1FC2tDOZ7OuxQIENYLAdXWWE9GbcKa/b/wxY81wfYkiiNmf6HutwTG3rKMAWhN2wx25VMGnbBO8FvcCdZeq1erqP+9nGLwTuyCN+Pupo/otR5S6pZUgbgr/3iB8bsrKFZLZ/1ijGq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgLtjnKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33909C4CEEF;
	Thu, 31 Jul 2025 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961013;
	bh=BJpUBlmPExNpmqRqWiERFmtVnLVQNBstgN8qr4fE9xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgLtjnKECUELhG4k3aKNiz0STTkJQCbd68NbJbgUVtZHaHO2qHhrCPEwJbTzk2knN
	 3NlLH0PwaaG5Ftd/imAOZcMgxUzdrZuTtSSUPMmvshH1LWJG2+NOEH+Kmu0Ci2d1e/
	 KaoGGBR/c+bsFT8B8QHuspXcTjIofZa3Za2a13h0b++qkrBkYJ/EruuMgdbVIu+O0+
	 38nAhEpZLIfVR46OdD44xFS7mVEcK0TgfavposKKSwsuPxqD9byEuQynr3phUW/ags
	 VRH5XMwL+OP8XjvAAHQSnF4UKmnWo2UGR+4mqGw9U/dvid5tvANQyfIjBt2YTabP6f
	 raC+KiNzJrt/w==
From: Christian Brauner <brauner@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] fs: document 'name' parameter for name_contains_dotdot()
Date: Thu, 31 Jul 2025 13:23:22 +0200
Message-ID: <20250731-beckenrand-bernstein-43308e9da697@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730201853.8436-1-kriish.sharma2006@gmail.com>
References: <20250730201853.8436-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=brauner@kernel.org; h=from:subject:message-id; bh=BJpUBlmPExNpmqRqWiERFmtVnLVQNBstgN8qr4fE9xg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR0Bxkobbz8jeX2E6XIEIm0s07M7+b7L9oSyDI9PS85m ufA1yCTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImEXWD4n3U0/a5OZeyh2Kms Bxb8Uy2QjIs2WHQo3qX4xZHAVLU0e0aG9U38J9iV9nQpMjx17dq9zPP5jNPt8/WnM+VPX1yxjHU RHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 20:18:53 +0000, Kriish Sharma wrote:
> The kernel-doc for name_contains_dotdot() was missing the @name
> parameter description, leading to a warning during make htmldocs.
> 
> Add the missing documentation to resolve this warning.
> 
> 

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

[1/1] fs: document 'name' parameter for name_contains_dotdot()
      https://git.kernel.org/vfs/vfs/c/a2e446e55e59


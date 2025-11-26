Return-Path: <linux-fsdevel+bounces-69893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5ADC8A1D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABCA3B1A4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8AB32936A;
	Wed, 26 Nov 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVdfdo2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC32741DF;
	Wed, 26 Nov 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165558; cv=none; b=VgI9cgcF8E05c3Usxq1v475a9oJ6dLwpHA9ljaqNKbn0UvgAlxf2Krpe6Ao2u0qxvPBtzVbEW0AWS5ED55h0v4n8sHGBfUjV6d0xEvVpB2nSr7MrOACagMsuKm0aXFxS2y2tpNFUTUtz7ko7cxFo1EE1Yi5Q+Aga9/jy4zZCZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165558; c=relaxed/simple;
	bh=Wdb0W3+Xcq6qeLoeB6Jb7cHknvGwIZT7ED+LbUZDXno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxHRnbQMBSb3Z6JWJX0U0p3tNgrorY2Awns2W/6xcwXmvo0cCadsC613PoObkL53hoRYeVnOdVOC711tEB/W69q81F6pf8WvLI2U2NcCHUMeEkxTsVx9H9QW4v3w3matDQhW1iQdESm7oagZyvAkrurIZlMlfi5gfvS3VjCxwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVdfdo2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7CDC4CEF7;
	Wed, 26 Nov 2025 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764165557;
	bh=Wdb0W3+Xcq6qeLoeB6Jb7cHknvGwIZT7ED+LbUZDXno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVdfdo2Kx0Bp364dmQ05Dasr3VetWFjvJsvgIZMVky96Xmu72zz0ZaOTSEStw1q0q
	 wpVlw33+ouYV2rM0kh2Mt22Uhui/v1fiaaBYCb7+xpbkR4MN/sd1+2qL1r3GpAv/Ld
	 YjFNtCFAYw+QUXNUFb0dxUoOsv5PIHMdlql0N8OyombF6hT00AFIE1GY0pkTDUR/GZ
	 Rv6O/Ih9t5lI6R6cCmEvPJNcKri7QEePJtV6iPGCKaZOG6xWyYXeoWMhcTGZ9XskXp
	 nz3W4jS5lZPRt9mC6HnMN3WwSCCK/SWhO69YWHI8k2tRkv/Ro1S7X44nAKxAIVS4Gf
	 bx3VHCxN0PsKA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 1/2] fs: tidy up step_into() & friends before inlining
Date: Wed, 26 Nov 2025 14:59:07 +0100
Message-ID: <20251126-zumutbar-wettmachen-5f87c2c28f5b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120003803.2979978-1-mjguzik@gmail.com>
References: <20251120003803.2979978-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=brauner@kernel.org; h=from:subject:message-id; bh=Wdb0W3+Xcq6qeLoeB6Jb7cHknvGwIZT7ED+LbUZDXno=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqs2+Iz7j//pzRo2XNC2QL9a+X+Vae1fk/9cqlrTH2p +L+u08W7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIQQYjw5IOP4ZQkZa35aVX lt19c/jcucXVyU+TKtefZl7BGb9WfSfD/5DTy++dSRLsLN/N9Lr/TEyv1DaxiZqBMvXrLi9ks7x TxAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Nov 2025 01:38:02 +0100, Mateusz Guzik wrote:
> Symlink handling is already marked as unlikely and pushing out some of
> it into pick_link() reduces register spillage on entry to step_into()
> with gcc 14.2.
> 
> The compiler needed additional convincing that handle_mounts() is
> unlikely to fail.
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

[1/2] fs: tidy up step_into() & friends before inlining
      https://git.kernel.org/vfs/vfs/c/9d2a6211a7b9
[2/2] fs: inline step_into() and walk_component()
      https://git.kernel.org/vfs/vfs/c/177fdbae39ec


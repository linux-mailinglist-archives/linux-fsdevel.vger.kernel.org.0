Return-Path: <linux-fsdevel+bounces-61416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65991B57E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D092B172F66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4730DD2A;
	Mon, 15 Sep 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/y+L3Lc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604A3054E5;
	Mon, 15 Sep 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945406; cv=none; b=k+YZkifH81QP+ZU3rczTuhdzL9xS8G3fpPkW/Yn8/FKXvxGpafya7zBDsMtKPG3Gdf42jbs9M4BfLY/iiel1dVeWpvRA4BRHO2suv4K96MOqTSGl5VTrmjYO5sMIfPZJLcvm++CuGwa2Ursits/FDWGB+qmbyuNupuswTvK888U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945406; c=relaxed/simple;
	bh=U3l0JLONT4lR2oTb62J9IVRuDlQmdYpgsvB2Snp9ORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCmyQzXz8qr4oa2QPF1lTeXPkSUpLYslBVwMnvgc9Tqv+CSgbBqB69CGdl6MGYohMNPuNc6lNjtIH6507NlJQYjCJBFpZGcyUsWxqVdZHKCIEb3OnaSu74YZhJ2KwIf1p5gN4T+a3lm8eIhod7cl5gsRs/UrMdP6ytahroQPpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/y+L3Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCADC4CEF5;
	Mon, 15 Sep 2025 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945405;
	bh=U3l0JLONT4lR2oTb62J9IVRuDlQmdYpgsvB2Snp9ORQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/y+L3LcAc5X+wvN16zUgThJ2UTZTPDuiN85XVHdldJEuUBQzLVF+aKvJNpX0OuUT
	 BOhCpX/GdxyhHQvqxpfvykNBLoSGN4ZLb3uD/SWduv9iVPJ7AkO0lrsJf2X5HdUwkf
	 YeRbjgQJkBzn9u/hk/PXYUzIgh1qbhXjYcMmhXw6AblEZCeM6XANmNsg5c91i+uLKn
	 LLJZ127u4pj4BYWxLw5HZwdYzi/jRmG6GbljTRHNu/4IobFcKpREDT39M8vFeh3SUE
	 RseRBVYo3+oIZ6p/Apd51olf7VHZnNhixWEdSlbFdjgZfsyDeJtsF+LMPzwgwDoFlQ
	 pg+qCW39sa2Yg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: rename generic_delete_inode() and generic_drop_inode()
Date: Mon, 15 Sep 2025 16:10:00 +0200
Message-ID: <20250915-kniegelenk-patient-5e891d940586@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915125729.2027639-1-mjguzik@gmail.com>
References: <20250915125729.2027639-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=brauner@kernel.org; h=from:subject:message-id; bh=U3l0JLONT4lR2oTb62J9IVRuDlQmdYpgsvB2Snp9ORQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSckLPk4Z0iFCTMPOfYhSKbRxbX0yZVdDLXFt6vcbWIW uGy7K9PRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWeTL8U5qyo4jXcceBhc+E mGf5//3TxTyrWSxMoHfWP7NZi69vEmX4726eoSfys0eZg+GuGK+8dLff0WdbWjfNU3q44eV/Hjl vVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 14:57:29 +0200, Mateusz Guzik wrote:
> generic_delete_inode() is rather misleading for what the routine is
> doing. inode_just_drop() should be much clearer.
> 
> The new naming is inconsistent with generic_drop_inode(), so rename that
> one as well with inode_ as the suffix.
> 
> No functional changes.
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

[1/1] fs: rename generic_delete_inode() and generic_drop_inode()
      https://git.kernel.org/vfs/vfs/c/f99b3917789d


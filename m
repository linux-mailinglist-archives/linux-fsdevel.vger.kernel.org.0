Return-Path: <linux-fsdevel+bounces-41044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031CA2A41D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B06F16777D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA6226167;
	Thu,  6 Feb 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVmBL0vF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E225A4F;
	Thu,  6 Feb 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833746; cv=none; b=LBIt6/tj+gHOz8bZM9r/beCt+gqfVjr7jV155gMo2UIS4Ps5veYzSu8oBjstr+ZZuRWqPgO7FegniH87chvpGkqiJaUYkci3Rdvk5siqwkxmsYLNO41lP1QTBF/y7laLF/pPglhq5kn96J42w1I+fMCssIbsLHX2/7Y0jzSOrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833746; c=relaxed/simple;
	bh=KfebdL5i0F7wFb3SjOK8DYq82RHPD0wFiQpKwiTHGao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQRu9VRke5xCofLNFgyZnyloCntrQKHz9fesvfB+vzS+kEmDZ/szPDUYr5YOEscZTZXMoijotyZlSfuHewv7NO+rabJ+eF2sSAGdoERodkuhh35tgAgmyHVfoQiUkNYw7CGHnX6v/WtGacBnGUvGh1NnZv3ZIRRZX0qixCnyH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVmBL0vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1133C4CEDD;
	Thu,  6 Feb 2025 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738833745;
	bh=KfebdL5i0F7wFb3SjOK8DYq82RHPD0wFiQpKwiTHGao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVmBL0vFpMN/9qLhgLSNArBofDKtjzh0oUpvBLrMZ9qdfLlcJHvKsxtl6gLvl9z8b
	 WZbo9IUY4nVOCir/rdKgjhIV39CuLRP41l+LLAYyxhEUmY5AxNQMvlt9leNeTJkUK/
	 HACaTE5g5VvjL2Uz0kofD4EVx3oXM84k/z6jS5z1wWogJ/njjxPDtFjYlmb/NaCPko
	 nq5E5hdPPr9aSisVrLYQo7EAsLGuWisy5H93WtvuHucSTIn/ZOIlpGzcK4z3V3h6rE
	 AFmTf286i9kFU3HZ1zGf94GAfoJqGrsP6i7CuFDv2q+QbsXajZkyWRuDl7MdE2uJ+v
	 x2Pk0eHmuchJQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: inline getname()
Date: Thu,  6 Feb 2025 10:22:16 +0100
Message-ID: <20250206-erfordern-gastarbeiter-1c8af7cc7783@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206000105.432528-1-mjguzik@gmail.com>
References: <20250206000105.432528-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=brauner@kernel.org; h=from:subject:message-id; bh=KfebdL5i0F7wFb3SjOK8DYq82RHPD0wFiQpKwiTHGao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvqfd04dL+IjYhYFloco1MWo1qjnU8q2L8pDx+l22fx PTW8R/sKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjcCIb/gWmrPt9j675cwRpt cY5n7R3L3tfSU3yNzn6/6zbHsd78HsP/cn3Brsg51ySY9f491X2exyhzxSt0a8j6RedVJ6W58fn zAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 01:01:05 +0100, Mateusz Guzik wrote:
> It is merely a trivial wrapper around getname_flags which adds a zeroed
> argument, no point paying for an extra call.
> 
> 

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] vfs: inline getname()
      https://git.kernel.org/vfs/vfs/c/521fbc6e8653


Return-Path: <linux-fsdevel+bounces-63480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E3BBDE28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88C3F4EC895
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AB26FD9A;
	Mon,  6 Oct 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koFsu0GM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AB2652B0;
	Mon,  6 Oct 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750649; cv=none; b=XoBo7fva7ZbjEKW1zhw7TYeDZeyS8+CXsMVdF9SiOobiP5AxJtptAi8IY6WWHV1TzsqN/d5xM3N2Gw1CB7gM5QXr1/65T4quenIa3p8g2yGWOKraO7XVnxVIq3njqRZYNYlq0C+YjgBfv1ZHB1l31xsIP6+Bw6d3jJ/bGRhUWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750649; c=relaxed/simple;
	bh=pKtMhkOu7g8zA3ZhO3kCTRpbb9O+N/vKPekloahsxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PV4ybM2IJJBWv4x00lUotiTSvIHiancCtxO+CCdHS2w978DameP/jBFuTHVYQOjYAe8ArY5cpVNZUsDvbhau9dKIx5bJsVQfmkTFb8/PNXExjF4V5OStOY1RKlOAw9qyVtVL8lOwhQZ6rmSX0MlVgtgv/ePI8yhahvYzos6iYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koFsu0GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63439C4CEF5;
	Mon,  6 Oct 2025 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759750649;
	bh=pKtMhkOu7g8zA3ZhO3kCTRpbb9O+N/vKPekloahsxls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koFsu0GMBBz8LA/3zLwmYLR+hiozePtTjeKJ2v7PgIrWYvFL+h6czxlRpwc5OP0uy
	 m5L7Ec/N8xNZlv2iGK9GqavxlEUnLjB0vt3cJ/2okoeomEtdpBDBVcA7w8C5G+mR7e
	 w5mhSThKtScEpsr0iZOf1iP/vdyxDrrnh8kydVsOnJq1UfvmDY3Dtua923lZVqRBen
	 tCy0+EI78JG0ZM0pw3lnVW+JI9iUv6O8ovSekcXELL9nLcs6vxvyiAtpFKGeNuysyF
	 AYLyxqFE/a0Kr5b9UdCqO6ix1BCXdkGjnnyDoClty2TpqSQVydpZTIx6qmIv2zgphf
	 tCDuOGAegggTA==
From: Christian Brauner <brauner@kernel.org>
To: ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
Date: Mon,  6 Oct 2025 13:37:24 +0200
Message-ID: <20251006-geprahlt-ballnacht-6e680dfc62b0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251003023652.249775-1-mjguzik@gmail.com>
References: <20251003023652.249775-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org; h=from:subject:message-id; bh=pKtMhkOu7g8zA3ZhO3kCTRpbb9O+N/vKPekloahsxls=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8XvnlzcUbk1dnM9hxlIacK12webqWCvvmuuulUr8fh a24mf9xV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBELn1l+GeSyuX07P/Us+fD ny3Pult3/9LjnCJL1cU//BQfcUTfNrjB8N85f2/EXMWf+w5ZMeveqmnhWnqArfRm9lmPaEOmGQX yWzkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 03 Oct 2025 04:36:52 +0200, Mateusz Guzik wrote:
> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> fine (tm).
> 
> The intent is to retire the I_WILL_FREE flag.
> 
> 

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/1] ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
      https://git.kernel.org/vfs/vfs/c/20bca90a05e3


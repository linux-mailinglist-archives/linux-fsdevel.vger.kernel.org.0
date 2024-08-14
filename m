Return-Path: <linux-fsdevel+bounces-25913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0324951B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A2BB21C16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286771B0121;
	Wed, 14 Aug 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVZMC3wR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972515C9;
	Wed, 14 Aug 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639392; cv=none; b=XZoYYDYAJ4qr78d1fMoTZHgYFF2XGixCrIcU07R08OO+h+5BR76B0aApPsF5aizVm5HrqjRXtp3Qf24XQQJSi0fBSwzA7fj/hijh2nrnxfcv1yw84ZhjBSeQLPBs53WHHQuX540c1+NV+x16t0bOKl4lWIJnvfyFQ1FSzYoZcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639392; c=relaxed/simple;
	bh=9XpBIEy57Jbne2fnkWqnxjZB/6USaoP6RVYiQyX3mSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+l1T4fjAWCyIhmNtIlrtrF2pCPYlohuIqX4I3Uz4b9uXk7LHEwlI7lDUTMck6SXrpjvirAUNEJzdWKvFRfjfxlkQHbZ8sAwUltRuVOHauKUs7HzrK5/WaKFABVCNTJg3Hi1LBKu+NziN8bL75rpd3Yw9T+NJwgz1Ca0/3an2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVZMC3wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42441C32786;
	Wed, 14 Aug 2024 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723639392;
	bh=9XpBIEy57Jbne2fnkWqnxjZB/6USaoP6RVYiQyX3mSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVZMC3wRN7zUPFTqF0GGSuy/lRChcTbs1ULH3xu4j0UGYUsJMubiuleEoPnjw0WPb
	 EqcFfZV5nKqSDk5/fBLILz+AiaSa7gzD5Fnw7aWD58imqFeGh/SKA+I4Fu2zE1fSv/
	 3IXunequdKeUVzZDtqkfsF3Uetc8hKP1A8IhCS0LMXX0tBDz9xJrgNzGYy+yhdCiAT
	 rMEeh+vSPUBF19a2Py2M4NfD3DkBcREbxbwxwWSYk+v8F0S/L52VBXYMEaEFnt8nFl
	 fSeNERMsIpe3AHoaDO8Jtz/3h0jQ+G8X/rNa9br2+G60SzJZ7FpQX5WlzKjWCwzeGx
	 bLjh4dcoZmwSg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: drop one lock trip in evict()
Date: Wed, 14 Aug 2024 14:43:03 +0200
Message-ID: <20240814-banknoten-podium-752bc822ac71@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813143626.1573445-1-mjguzik@gmail.com>
References: <20240813143626.1573445-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=brauner@kernel.org; h=from:subject:message-id; bh=9XpBIEy57Jbne2fnkWqnxjZB/6USaoP6RVYiQyX3mSo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTtWRaVfSNofWmRknL3+W1PPswROXf9nui0uXsdT36fn FHm88KepaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiHMsZGeYrHF3xbd2Sm32s HRLeSY5HN/F+61Y2uP4lc/cNaz3HTntGhqfpXLeXzk4x/qhesHiKb4dB3eYJYkteMr2XeOJ6zTa tjAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 16:36:26 +0200, Mateusz Guzik wrote:
> Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
> kernel takes a back-to-back relock trip to check for them.
> 
> It probably can be avoided altogether, but for now massage things back
> to just one lock acquire.
> 
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

[1/1] vfs: drop one lock trip in evict()
      https://git.kernel.org/vfs/vfs/c/8b30d568bd8d


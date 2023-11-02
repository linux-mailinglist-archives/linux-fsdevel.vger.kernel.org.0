Return-Path: <linux-fsdevel+bounces-1813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6407DF0F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350BF28196E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088314277;
	Thu,  2 Nov 2023 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p58rEyCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF51426F
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1174C433C7;
	Thu,  2 Nov 2023 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698923435;
	bh=Lld2/QQulB4Yn2BcKv8FAqMH+Gc+z+gXEqeqig3i8Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p58rEyCwgwUL7d0IYhAze1TP2WcUQJmL9vaaFurwM3U+BikZTaez9KI8fDUdZVexj
	 btTtlXsr/lnOvpuiiHzXC2RwbHhiIJyc2fUcPYAg0e6abhKSz8AP3FctqHJA7X6ulu
	 XjA73zjKvlWclFe8AQ/GUDf+xN1QzfWfy/u7x3nCHRlryoDuKYjd2rBPkXo3gQ9rgZ
	 fotDaDtjIWNMNvXCjW5pBoLhC1wGhhSBb+qWLvRWldOd1wp3qpK/6N4vnrcZx540cr
	 8u6aZjSaF/3E9v3Hs2AnCRSS1CrpPKwj20ffujpYWMkHib9UHUspKhqfbm3X4zIalh
	 1MyQ2LhRZeOoA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: Re: [PATCH] nilfs2: simplify device handling
Date: Thu,  2 Nov 2023 12:10:27 +0100
Message-Id: <20231102-hochnehmen-zerrt-3d37601f7dd6@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101172739.8676-1-jack@suse.cz>
References: <20231101172739.8676-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=brauner@kernel.org; h=from:subject:message-id; bh=Lld2/QQulB4Yn2BcKv8FAqMH+Gc+z+gXEqeqig3i8Uk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ6N8/fsFJn49SXm3kTfB9anLP2sj8yuydUtETswHouRuOf MzMCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS956R4V5Rk6kO23SvWM1XBTeLTl zeGq4jp1O3i/PRJ3HvTTI5Fgx/hQ7ezBOpi1v3fEEH+3Vm0cll3lKHG7RueE4tDxab5ujFCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Nov 2023 18:27:39 +0100, Jan Kara wrote:
> We removed all codepaths where s_umount is taken beneath open_mutex and
> bd_holder_lock so don't make things more complicated than they need to
> be and hold s_umount over block device opening.
> 
> 

Ah, thank you, Jan. I missed nilfs indeed!

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/1] nilfs2: simplify device handling
      https://git.kernel.org/vfs/vfs/c/c6a4738de282


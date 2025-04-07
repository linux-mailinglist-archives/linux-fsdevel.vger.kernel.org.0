Return-Path: <linux-fsdevel+bounces-45868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48EA7DF1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF723B4016
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7A253F25;
	Mon,  7 Apr 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMPH9s83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF682253B4B;
	Mon,  7 Apr 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032289; cv=none; b=oSxZb/QZHOBvDmDFu6MFTLj9D13X0Gv98CxDM/gZA6MKlIp3jCPzDIep2q9xkRMNCMUvDU6MYth/hxNCKqOxs1mBCyZM3AHFmsUic/Nw9CcQQOrY/XVxP9qZNqrd9Ut17LzXIQbW6BwsLr55WbwH/Nx0llpLkCahELJIWqSnTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032289; c=relaxed/simple;
	bh=phz+W/y/P98TEbJzgV0y5Ve9zvJ2zXTVkoIK4Sd0Rz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrfS5GF4/5FRBHm9YNAjLYt6v9B2m6ap9AL4lzJ4VunG/tCV2VBe4Y9bPmjGMgHjKsY9k1H1FIKG0TlleY1pSNKyR7vujFyC3zAnKyIuae69dItNB7gqNyfpQuUA5gekbbHadhB+DU2HaClQedQjS+q9zeTYLidzCj5pV6U+4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMPH9s83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6D7C4CEDD;
	Mon,  7 Apr 2025 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744032288;
	bh=phz+W/y/P98TEbJzgV0y5Ve9zvJ2zXTVkoIK4Sd0Rz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMPH9s83obHD/J4Ik3GrucvSZ1HvxqMFUaVBhBsE3ECURdL3gO0LMM+1wzfO+2Nl0
	 msMJIbdgl6bqFjf9LW3gMuy/IdtAhjyZabrVLFlZP9ni28+XAA2QvxaqEsuZbwu6qU
	 eT1wYu2AUHehWodKeTcx0yvWhAd0qboDezG4HVQZyX0cB8jvIsxj6QMjDrbrCbRpjw
	 h5WhU5otun52iDmd2aWnsBjuFFxu5uTJB4foYrIEUONew7GP5GyLPHyfZJgju/mkWH
	 Yn0EQegdKgTzPqRbxD2OWXVcQUdNqLPClwq+U7FTKQByobcUnrY+T9m7Nt7pdFDvB0
	 5UbxZyrOEIvPw==
From: Christian Brauner <brauner@kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	eperezma@redhat.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	benliang.zhao@mediatek.com,
	bin.zhang@mediatek.com
Subject: Re: [RESEND] virtiofs: add filesystem context source name check
Date: Mon,  7 Apr 2025 15:24:32 +0200
Message-ID: <20250407-erzeugen-granit-5fdd39986bfd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
References: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=brauner@kernel.org; h=from:subject:message-id; bh=phz+W/y/P98TEbJzgV0y5Ve9zvJ2zXTVkoIK4Sd0Rz0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/viR+uDh1wTkdg2mVAqyb9F9PjM/5EuUp+WuDsM4ji +1hxcsKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS9prhn9mM5ufHhQ6aZO9W Sj5W8KfH77Dxml8ORjnFaRM6rnde3s7wV2rV5Dd+oj93p21bwVGiemdh7qntsfvfRakuDHkSuq9 lJhcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 19:50:49 +0800, Xiangsheng Hou wrote:
> In certain scenarios, for example, during fuzz testing, the source
> name may be NULL, which could lead to a kernel panic. Therefore, an
> extra check for the source name should be added.
> 
> 

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

[1/1] virtiofs: add filesystem context source name check
      https://git.kernel.org/vfs/vfs/c/a94fd938df2b


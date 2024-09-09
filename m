Return-Path: <linux-fsdevel+bounces-28927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75A9712A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D541C2253F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848011B250C;
	Mon,  9 Sep 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmGn2G1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356116631C;
	Mon,  9 Sep 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871931; cv=none; b=VWSLxAmJV+hOXlaB9K5fKpNPqYZsKU5PrbmjmilCD5MTkXdK2M/jSVqjjHA+v5TFL4lshdZsUpcnC/MMP0SeGc3m4nP15bQrn+lDrTuWg+XS/B+wYMD879GDaLobyvOqlA1RoeX0v5qaJzybUctgHL+nxMIGo4dLTdiJh9UhcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871931; c=relaxed/simple;
	bh=u9yIhycMRbv+Zz1SiqFnwavJGsdWGzRGAtLbAQfaA1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpeSLt4r7ujmkoqBUeT6fGKyDLvhjgn9AX/mCtSe0/yp3B524Aemz8MS04ewA+DfWiU0GRuYq4kdj71GakskqpVzHA43s+6YGsvUUkFQ/AWo7j1+BL9kC6zGkUHqtRJ6c8UYChm+9zBUbHLst0dmD3ypJJmzzp6a0pRaY1ubd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmGn2G1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E852EC4CEC5;
	Mon,  9 Sep 2024 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725871930;
	bh=u9yIhycMRbv+Zz1SiqFnwavJGsdWGzRGAtLbAQfaA1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmGn2G1W/LTzv/GiHaPuvj7VC+D3UqzD8mJHLVg418ginsCoh62XLmjJEOxVhubiy
	 idIKKsgOq3n8wKE++R0jyNtcdi1HnSvjTHL+cuyAdoNgVZruKrW7WoOw0Lsng5rszE
	 QNSGogl762PBw+J0rfam9Z02v0qMp1UO5gMKpB32Axl3mReOlc4csOAPZ3KNwuZMev
	 H5weraRqzoL96+i7YRj0dfnzoQD1RZsKTIC+JuOlylfA1+96ZBYv0bEMZ8YkkuDVyJ
	 AxFkF5z3k8CZh0XUWELH8gS7ZSjGzj+WD7kmdlVVxomxZHq2BQ2lI7U7Lsq39ZFLHu
	 BKKtcXrjY6uaA==
From: Christian Brauner <brauner@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Date: Mon,  9 Sep 2024 10:52:01 +0200
Message-ID: <20240909-gemocht-klubs-0c62b4db29d0@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
References: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=brauner@kernel.org; h=from:subject:message-id; bh=u9yIhycMRbv+Zz1SiqFnwavJGsdWGzRGAtLbAQfaA1A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd2248o6DBXXSj/aGiEqtIcS/1GW2XS+cE//ts9e1Jw NSioNlfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSvY3hf/nbLA6VOVEMgolR 0ed7Mx+42Obt/nPirAln+73MNhfxWIZ/Jj1yRodjMpcL8kVWXL0rYXGjTsxc++xW85buDzuNNHb wAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 08 Sep 2024 12:27:45 +0300, Alexey Dobriyan wrote:
> strcpy() will recalculate string length second time which is
> unnecessary in this case.
> 
> 

Applied to the vfs.procfs branch of the vfs/vfs.git tree.
Patches in the vfs.procfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.procfs

[1/1] proc: fold kmalloc() + strcpy() into kmemdup()
      https://git.kernel.org/vfs/vfs/c/4ad5f9a021bd


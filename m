Return-Path: <linux-fsdevel+bounces-8609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E78394A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADB6282670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E50664CB;
	Tue, 23 Jan 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy6wJZVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFE50A72;
	Tue, 23 Jan 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027359; cv=none; b=bKbpS5s6qb6O6o6j+ZnAGMDivxXnVBGLO47uCs+K5EkA2rE3EZeKnI89kItRma9PQiheE/zCEfMu3PlGL0mx0XXzrZhxgWhOzTqseWIKOX4cBG+gkxZzJ7/IadfrNewH8qaJfNFSmIjaeLAQJBW3bUXMQmr8raVst3hOII5suLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027359; c=relaxed/simple;
	bh=T6jwThoEVErlLv8ErfxZVbNpJtCFWt1YcVJNclrRyac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwpnFd4E4YshbX38vPQPH2xM7Z3sY8wsmMaTr1mnxsXpzWo/HM84IrfUe5b44jete/UbZg/c6GlhxMteDSOWLvVYbBkXayvqGNiP1oCnkMfsktGwuVCw0OgV8mDifB+Mp3LLzZ8imOL7xUXXDwouwZlGFgyQkgfsfzcEnSu66rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy6wJZVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7DFC433F1;
	Tue, 23 Jan 2024 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027359;
	bh=T6jwThoEVErlLv8ErfxZVbNpJtCFWt1YcVJNclrRyac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oy6wJZVWHPqO9GOhBbtAle5xtQD7zLaUhVj/laIVqUpNq6AWz8x3JPvBYXXSWsFVU
	 S9ZqxZXbuRsqXzmbPgAR4q1HGgxjGoLsA4ta9y29mkFrlQgob93wqoKGPfWIiSK4cK
	 yLZplnRC6Kl7wwHnLz/hq1PS1X3dhdd3NTLH7PI9SHsdH1+O6tPxiLNSPQPJNZb+mw
	 X0d6q7JkoQWLjpdIRP7VkqmP0ZAZvdkafcXYC9rC9Lt6Kfx/c3tB5Jc2U5jGYUdoO+
	 RfSNY55nNexhovkKZoJV0EqGrER0At89MU0c5yubZFrpYyRwA8nyxycfCSySbcCUCM
	 5OI+M9g9kIyYg==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [GIT PULL] fixes for exportfs
Date: Tue, 23 Jan 2024 17:28:54 +0100
Message-ID: <20240123-vfs-exportfs-e7cce6310bc4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <BDC2AEB4-7085-4A7C-8DE8-A659FE1DBA6A@oracle.com>
References: <BDC2AEB4-7085-4A7C-8DE8-A659FE1DBA6A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=brauner@kernel.org; h=from:subject:message-id; bh=T6jwThoEVErlLv8ErfxZVbNpJtCFWt1YcVJNclrRyac=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuf+nOeHxt/S+VmkXGB0pWXdWZJ3x5nfyRC7am6Qe5/ l88qHulpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAibVsYGb53OpwI2jblqKAf 29UjHKITU74uN87aOeeUsPzsCTkJTtkM/10SJ53sFizdHfyi6QP3gWyjnkOLmSao5UlsOPrvbKy jEwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 16:03:53 +0000, Chuck Lever III wrote:
> The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> 
>   Linux 6.7 (2024-01-07 12:18:38 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/exportfs-6.9
> 
> [...]

Pulled into the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

https://git.kernel.org/vfs/vfs/c/41d54434063c


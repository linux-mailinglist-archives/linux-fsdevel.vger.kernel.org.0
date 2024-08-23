Return-Path: <linux-fsdevel+bounces-26897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40395CB33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF11C225E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ADE187342;
	Fri, 23 Aug 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaSeGMCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC77149C46;
	Fri, 23 Aug 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411394; cv=none; b=ptCPd/Tp7paKbtMZ0AoLCAt3C7XZ1YVia7Vd++FYpTqk1vFynbdWPdXCiH4pX7nB0HUToNfnwY++vSS1Ttq8/fCvCZFQpL+OWHaNCQgHovW2t3Xuk+/Ero+rWYzTFKOxw0ftIXGPf4CjCQp01tvb4r7ULrS+3RjHmrKbGoD3tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411394; c=relaxed/simple;
	bh=i3XiKwNhL8s8yH0uXi1l3GBXpjICg9YEFS0VirpaIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKkHMFkEmyu0CnBLOun8oJ6e86D/KUxCmb8r8kY6FHzCNQwe6CAb6It0o6mov0Cj4+4u7XAAwosJ92y0Q3coNJILOoxFn3TM09+W8S0rRX0W+RqiYNUVYuidqLU48lJIznfXfMuLWj/AkLtmu8k4b6mxqu4PUjmYInTVvyDEpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaSeGMCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBE4C32786;
	Fri, 23 Aug 2024 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724411394;
	bh=i3XiKwNhL8s8yH0uXi1l3GBXpjICg9YEFS0VirpaIWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaSeGMCS8WAEFoV+ahKG0fH+ulGXDB9KvjfmftDRF1LvZTvGARJriRIbR+HyR3Zi2
	 4EQm6FqKKxgsu2gTi9P2VGR3IEm9nWsiHh8Vq50PCxd8wfA9Mrvr2WsIdothhpBgcC
	 xXioRwhDOV15WQraeOV0Y6U1pA7W7x0ZoRe3yGWubBveNk/WliYGsaMcWlXGw3I5CB
	 qliLMqH/El9nB6wO1Qn5fHMO+LvtMg1uyGNct2UXHpebp1LGPrszrBP4YhbxNSH93f
	 VDZnfsQMLCc8ewcnYsITWMzAT0iwd6nn9NF75WX+DSOR07U8unizRQyMv/lRXbcK0h
	 KarfHPLlU3VDA==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	ed.tsai@mediatek.com
Cc: Christian Brauner <brauner@kernel.org>,
	chun-hung.wu@mediatek.com,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] backing-file: convert to using fops->splice_write
Date: Fri, 23 Aug 2024 13:09:44 +0200
Message-ID: <20240823-abnimmt-projizieren-32c61f79b3ea@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708072208.25244-1-ed.tsai@mediatek.com>
References: <20240708072208.25244-1-ed.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=brauner@kernel.org; h=from:subject:message-id; bh=i3XiKwNhL8s8yH0uXi1l3GBXpjICg9YEFS0VirpaIWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdyP15pvlfy9u4dQ8CwhMVP56Ou3Ej+fWf7HNvXWyOv ZSXN5E92VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7kBGhhf8EYUBB9fX8h70 2MtxMmnLr+oLXsnZzf8Xvfp+rTsjK4eRYY/H3ceLnM4/9l1zNGPbqp2bchom3du9N8HnReGF9h8 3FdkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 08 Jul 2024 15:22:06 +0800, ed.tsai@mediatek.com wrote:
> Filesystems may define their own splice write. Therefore, use the file
> fops instead of invoking iter_file_splice_write() directly.
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

[1/1] backing-file: convert to using fops->splice_write
      https://git.kernel.org/vfs/vfs/c/996b37da1e0f


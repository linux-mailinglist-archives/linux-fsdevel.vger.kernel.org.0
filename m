Return-Path: <linux-fsdevel+bounces-44443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D49A68D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60B41B602AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E7254841;
	Wed, 19 Mar 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeaWphTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F2A935;
	Wed, 19 Mar 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389604; cv=none; b=XmJl4e5MHlFZOlBsMEQY+I7lWZAFM0xYxTAqtXgYH68nPt2pnULg7KGRCwn5igCpM4LxqOVyiC59U+GfYJIkwMgo3wAADbpS8JuYSG9rYpPcoiMKQCIg7elIGxJqE5PNgwTBAAvHk2ttQxcp23O7Ukjsh3EHjRDv2R5KOGLknDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389604; c=relaxed/simple;
	bh=CPww1TQSDOLLkdBO3ROjU7WbbIGpj/GzEovD+pZ6Q/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QViBxaLCdt9G4zpLm6IJv1f8IP/+pHg8ERdRMfc6QVfjzg3WGOwwRcJWcrk1xqXZYYRfPpaFwbDIDarkBUbUXbqEpXOK/ysN7Ch+4XF7X144C4s0DMsNiV4LcjsfeeIgiiDZmi3lYYZUUrLjLaPeY/xzAt+w8bkaOu8t4JPDzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeaWphTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D71DC4CEE9;
	Wed, 19 Mar 2025 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389604;
	bh=CPww1TQSDOLLkdBO3ROjU7WbbIGpj/GzEovD+pZ6Q/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeaWphTCO0hr+ok2QjxTNhxgfePARWtf9TuyJZQEVIe6hXxtxIokPSTDxk8eq4DCo
	 yFZYp7MUl8fcTZeK1arE5+JzMsAGKtZqnGAgRw2Oh/dAoGoCip9sT2rGYNq9MfLpIq
	 11+nSz/eeJBXezrpNTDpENxhv5RxQQ53ih/eaLOre47239157mpAtRI26zJcwEC+ud
	 zuansiYlwjpwVBiSNPRzhuWExkfXc4ptEBV+fv0amHB+STr7qD1iNMhipKO9fjH9g8
	 cAXUB9T21FRo4FDa2kb+MBeEjGyMBYrrTeRpxNd3Veo9GfhDTLaa6U+CmpAl3b1VOY
	 nv0GVFD/Wl25g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>,
	Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 14:06:37 +0100
Message-ID: <20250319-daten-dissens-4cac8b38fea2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=CPww1TQSDOLLkdBO3ROjU7WbbIGpj/GzEovD+pZ6Q/M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfOhjXUHnz/V+W6OBn5S2BfNz7NFLcyq7sL2Q5tvv6j t0nV3Tkd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE1Zrhf2l0fF+dzO0ngZk5 CpVMk1f4Huh9uGxF3oQpcVEZnJH3khn+e8bcSM6eHTtZv7xnz0ZBZ9VPSWFnoqWNdygrh2+xlyt nBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 16:51:25 +0800, Gao Xiang wrote:
> Previously, iomap_readpage_iter() returning 0 would break out of the
> loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
> relies on.
> 
> However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
> buffered read") changes this behavior without calling
> iomap_iter_advance(), which causes EROFS to get stuck in
> iomap_readpage_iter().
> 
> [...]

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[1/1] iomap: fix inline data on buffered read
      https://git.kernel.org/vfs/vfs/c/b26816b4e320


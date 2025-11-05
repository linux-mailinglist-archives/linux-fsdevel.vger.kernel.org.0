Return-Path: <linux-fsdevel+bounces-67118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE4C35905
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6815561B69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FD313528;
	Wed,  5 Nov 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/x0dtX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904B30DEB1;
	Wed,  5 Nov 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344601; cv=none; b=Rmc4SCl96S99aQVt4vGNDy043GhXaWHPnAWUgJoPr3Vcb7IuNjq+J4skZr6MUgWCEwTZxm+Qi33dtwFA0oeJSR5IvHYjJZpiOQ7qZxv+b+n330zHLBqOg1llKg6LCinj8U/oFS1mqZqOXHZK5EkokjiWWo96oiOF44JGVqxmmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344601; c=relaxed/simple;
	bh=Cc5xGZyxDmntplyt64WbomYMScoW8HcyNjUlmM/BmpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWHHxhMruAEahOQoeYINLD2UG8l8kF0SzB2zqBLCNyo6ZDi16JXdYZ61AXaZpmrtM521Avl2as1iyMf/H4ZpSaf7koeSTjR/XSOaa+BadIqHMciEqzWc3inxbRdh4GvIUyfznWGrcsIIA301gHFkTRLMUk/cxM+UOqiYmsUvDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/x0dtX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0368C4CEFB;
	Wed,  5 Nov 2025 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762344600;
	bh=Cc5xGZyxDmntplyt64WbomYMScoW8HcyNjUlmM/BmpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/x0dtX+CljJxks7F9axOf3UkKaTScBmMRxFIGDFxzI4JRxdcZU6Klj1a238m+LrW
	 QTQ8zgH+8Oo83IMnVkzYpI6EO174NWNaj6iXg5CU0Oga5jasuyLL1s6o10Q0wEueln
	 sFa8k/T9eTDjVBJZ4vVMF02s9/qJM/n1KXUHNdmDMuXN9tgOtxl2uOFpGTUkhUwWfx
	 VSjkNpYPz5YJtPIK+MT+ifgdw7+4OoTw9m36fzC53g9PlES6CbMS7NRHiIxxcYjZ+T
	 886V27f3U1vbk2fTenhB+2J40t1dl4iKi7bto+6TfvVRLFFK1UhAUzFJxshrF7Q3qB
	 7ve+pYunuAJoQ==
From: Christian Brauner <brauner@kernel.org>
To: Carlos Maiolino <cem@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: alloc misaligned vectors for zoned XFS v2
Date: Wed,  5 Nov 2025 13:09:55 +0100
Message-ID: <20251105-senfglas-heutzutage-f96d464faa82@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031131045.1613229-1-hch@lst.de>
References: <20251031131045.1613229-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=brauner@kernel.org; h=from:subject:message-id; bh=Cc5xGZyxDmntplyt64WbomYMScoW8HcyNjUlmM/BmpM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRy201Of3B/TQPTxY6yiyd0Pn+fJ23fltbM+eAs7z7Bi 0rSC+JDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiMYuRYebrSscFIWd3+037 n93o0hA7zWhv57SGzxYTki5uVL6npMfwP521p2eSQ7zIl2UvTk5ruXr0SOfRZdxx6tx1hTfNsv/ 7sQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 14:10:25 +0100, Christoph Hellwig wrote:
> this series enables the new block layer support for misaligned
> individual vectors for zoned XFS.
> 
> The first patch is the from Qu and supposedly already applied to
> the vfs iomap 6.19 branch, but I can't find it there.  The next
> two are small fixups for it, and the last one makes use of this
> new functionality in XFS.
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
      https://git.kernel.org/vfs/vfs/c/001397f5ef49
[2/2] xfs: support sub-block aligned vectors in always COW mode
      https://git.kernel.org/vfs/vfs/c/8caec6c9fef7


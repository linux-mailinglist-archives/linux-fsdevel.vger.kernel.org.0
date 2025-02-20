Return-Path: <linux-fsdevel+bounces-42171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E85A3DD49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC23A9758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA31D5ADE;
	Thu, 20 Feb 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q46io9xH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294D19D06E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062926; cv=none; b=XdssmYfq/HwBBGsZwBtCPiC21xZZ3XSm+J8kyIdkIzXiSWfEaFpDr14Zc18eQ0sN3lxyaLT9Tc+G+Eh6ZSSbCtmLQ8cy7TN1nSDRo5bT74e6kpmD/XJFJYd7v5C/K24ebyTviASo0kD6CPb0SoIsRE9B3HpExs2IguU77Y83j0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062926; c=relaxed/simple;
	bh=gFLGh3sA2mLudrpV3yYeXbKs1c/klVkG5ILcdlc2C6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq8ZlZYJTEQPy/AsgdT1HuxEYxcI0bsIAxdP2b6TW1cxxg2NeCxPi5CrQaWc5Ejg1lLkpuwpnbz43bicGAb//yyBhL8YBbVeE8+61krQA94xH8t5psdo1Nj0HF80bb9t4IWXCn0aH4Pk1LSqHI0XmwmMRx7A26IY3qf7dfFPXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q46io9xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE67C4CED1;
	Thu, 20 Feb 2025 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740062925;
	bh=gFLGh3sA2mLudrpV3yYeXbKs1c/klVkG5ILcdlc2C6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q46io9xH2rcEVSn+wrCw6uj29axotSBuG95y8iKtYLJNqSKw3v0PIaoFpgpp0EU7m
	 kwvbSaFNEKEbbVMl+lbNByUnf7OLDpbv5OtyK00VQldhpl2rRRplV+297NIywn5TiI
	 /O0pOd/d8wdF6ZB9IctXor5N9GPBXph2HICNYkyc7IavbQ/gskG9Ce9fVz9XCi0red
	 lphP1wcOhWQVTv3syKGfmyBkRybhV+/tkXAnOzpS5y31s5JjKIon5DcganWgieJujJ
	 6WBpl++BdgcT/Tzbulf3wkjuR2eM0wrjBv219HRiiVZAvBu/qGNcCHA/FcnQ/k9/T5
	 fhLSx/9XDgslw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Laura Promberger <laura.promberger@cern.ch>,
	Sam Lewis <samclewis@google.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
Date: Thu, 20 Feb 2025 15:48:36 +0100
Message-ID: <20250220-dromedar-blocken-d9140a10ed2e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220100258.793363-1-mszeredi@redhat.com>
References: <20250220100258.793363-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314; i=brauner@kernel.org; h=from:subject:message-id; bh=gFLGh3sA2mLudrpV3yYeXbKs1c/klVkG5ILcdlc2C6g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvdzj+yGv21IV1FzX8tmqYrF0ud3ffnnid/HvXNUrXH l/O83RdXUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBExMsZGRZeuv7V6kj6scfv GkwZH1/3/mp74+jbIH9J9YxzrlnMel8ZGS5mBZQzzi4pnf6Gb+nVPQ4dRz+xR11Mzeb6eehNz6b XdSwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 11:02:58 +0100, Miklos Szeredi wrote:
> Fuse allows the value of a symlink to change and this property is exploited
> by some filesystems (e.g. CVMFS).
> 
> It has been observed, that sometimes after changing the symlink contents,
> the value is truncated to the old size.
> 
> This is caused by fuse_getattr() racing with fuse_reverse_inval_inode().
> fuse_reverse_inval_inode() updates the fuse_inode's attr_version, which
> results in fuse_change_attributes() exiting before updating the cached
> attributes
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

[1/1] fuse: don't truncate cached, mutated symlink
      https://git.kernel.org/vfs/vfs/c/b4c173dfbb6c


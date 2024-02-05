Return-Path: <linux-fsdevel+bounces-10267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E8884994C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E52852B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445E199A1;
	Mon,  5 Feb 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+tl2WcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDB18EB2;
	Mon,  5 Feb 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134221; cv=none; b=TYwa3vVEMaTRYzbkqYpAg9WBX7Fm27iXV4Zestuu8dMOKYrrEDBETreUvVh4mvxeagMGyEszW2w66jgyFBm2NW7ig1vew3nwu5y5XAo17CUIykyBUZtl9n8f0VnAJnkSDh9XAX4OpFnPLx7ojUPxg6TuDtm6XImkzdgK4byNv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134221; c=relaxed/simple;
	bh=Jht2YlgG8xywLPrGTeO637I3BX/HXjoajzB4+QdcUao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVG+NvCmeyMKxbWcFEpltvEQ1II3mZiLVIRmdPgMERBa6bmB4RnUNEDiHpYQJCXAi4R4CI+8WaKhMsarP0deXNw5yHDOZTGn//mJkZp6OJOsThwD6k21eabyedY8APKoIudsZOuRvOeRJBmUpva5RCdAaUDamUQgRgbsSOlqy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+tl2WcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D996C433F1;
	Mon,  5 Feb 2024 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134220;
	bh=Jht2YlgG8xywLPrGTeO637I3BX/HXjoajzB4+QdcUao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+tl2WcAgWCzXNSjyv0s5bVf9n00Fmv0awJVRxqmH7FPw3caY36xuZwHCPI6rUFyv
	 HvYiE2tLeChGwkVMcjBKPhD3RDZgoHEUzfbXFNnfoT2efwxBAyRfAAi6g1DXgJBHhB
	 S69Cef6D0aErLuyadSLW8MX85bqwutdVjkiFqkOBPnHOJAxGcoaRvK2KHIrCTBkFHq
	 YGn9FyO6ryPhAnoZavLOQjYCJPMMXPjZ640zhF0D29ga+rURKEZLSi5fNksYc/CMrk
	 DaA0yhk2SngrWvo8EXwi42VhlrvhxMonfXw6j2XHjSOX4tOFuw/vL4fkLfx8xpIbQX
	 fv5EpLdm+IGXQ==
From: Christian Brauner <brauner@kernel.org>
To: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com,
	JonasZhou@zhaoxin.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Date: Mon,  5 Feb 2024 12:56:46 +0100
Message-ID: <20240205-harmlos-positionieren-ea42ccc90890@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202083304.10995-1-JonasZhou-oc@zhaoxin.com>
References: <20240202083304.10995-1-JonasZhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=brauner@kernel.org; h=from:subject:message-id; bh=Jht2YlgG8xywLPrGTeO637I3BX/HXjoajzB4+QdcUao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeOMtqetC1ymTGOX6hoyIdV9nZLzXIHBOO6vSO/zB98 mvdgKAnHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN558PIsKygOl7zqee+Bbwf FgQ690mUyOcx8EyLyEx4fbvXXfzUT4bf7D/fSfOfmXxeuM3+2M0jeafkldSdXW4mTjeLWGP8fXk MIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 16:33:04 +0800, JonasZhou-oc wrote:
> In the struct address_space, there is a 32-byte gap between i_mmap
> and i_mmap_rwsem. Due to the alignment of struct address_space
> variables to 8 bytes, in certain situations, i_mmap and i_mmap_rwsem
> may end up in the same CACHE line.
> 
> While running Unixbench/execl, we observe high false sharing issues
> when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> after i_private_list, ensuring a 64-byte gap between i_mmap and
> i_mmap_rwsem.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
      https://git.kernel.org/vfs/vfs/c/2a42e144dd0b


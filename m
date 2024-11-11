Return-Path: <linux-fsdevel+bounces-34204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9619C3AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B2E1F21CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425F171E7C;
	Mon, 11 Nov 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xne7V0kG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5FF1714C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317188; cv=none; b=VY5wsKrQzM8GkbdgrwM3NKXsZDn3U6QAO47v2ds0kCHMBZ/pYkwCgWni0czzbmjQyFQ+ZErBsNC59mt9y9PdKCY84bzKx4TbGYsHB2qp4qG+WOHLHHD/K+wpfXLeerxAG54Mu2yHn12fvz7SvovDa+6Z75C66L6YZv7indgzVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317188; c=relaxed/simple;
	bh=ZzOGhyap/OM/amCmCfANlgzTrLwhFPvminSOpzs5lX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcCh6PRe0TOHSQ9ZfAHsfHS1UHASrLyJWnisiD0jiwmPT03zmG8BfhOU227GrNPDhoHBzc3IT5R3nNuPD+7Zax1JVbwKYLFbE7mYG1lvZ5N+bGt1Nj3ZMRpKL6nIQ3hEMPwH9LKZ7+mkVzu/7wEWoUSztnHZDi7DhJzSqTTcwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xne7V0kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1122AC4CED0;
	Mon, 11 Nov 2024 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731317186;
	bh=ZzOGhyap/OM/amCmCfANlgzTrLwhFPvminSOpzs5lX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xne7V0kGKS9q4lPOQ71DPUyqOzgw787c+wiFKhRaguinlatS8kAlPca4HLB+B/Rcr
	 0KWExzsn8BcEKoReFCRI0DWSVb2aFuvHiolBO3xl+3YIn5BEyjsMslRqtKNAL0XexK
	 M8IFWgrhBb8zETqA2A+XCpcb2AVb44SO6ojHJgJYO63kl85mbXuFUt4PTwbymkCgHg
	 mkMHD8SwnXH/kvKzjiHiUmD7ZI89gFlPzcxtdswjUP4I9N9IQqg4YVctgdiIWTa1Oj
	 HgRTccKn2HuylWPxfI/uW2v0qa0uZVr4Mf9w5vY/FAxtJmyFb28/YTbZdkpjaYvH1V
	 AD5952rEw7JSg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] hfsplus: don't query the device logical block size multiple times
Date: Mon, 11 Nov 2024 10:26:18 +0100
Message-ID: <20241111-petersilie-tropenhelm-71e3e80179d9@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114109.839253-1-cascardo@igalia.com>
References: <20241107114109.839253-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=brauner@kernel.org; h=from:subject:message-id; bh=ZzOGhyap/OM/amCmCfANlgzTrLwhFPvminSOpzs5lX8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbnt1TIXxNvPWTcbQHu9OO3dyzZL9ffLVCoac789l73 4YrC0J/d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkehojw1Y7qasqERpPbKYZ ZPo6Lj22VVzIRvK95Aor5VDuDO/QTIb/zjPrkr8Udl5i5dm8yaFS9Pusc1YRttnv3VjlJhTODj/ OBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 08:41:09 -0300, Thadeu Lima de Souza Cascardo wrote:
> Devices block sizes may change. One of these cases is a loop device by
> using ioctl LOOP_SET_BLOCK_SIZE.
> 
> While this may cause other issues like IO being rejected, in the case of
> hfsplus, it will allocate a block by using that size and potentially write
> out-of-bounds when hfsplus_read_wrapper calls hfsplus_submit_bio and the
> latter function reads a different io_size.
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

[1/1] hfsplus: don't query the device logical block size multiple times
      https://git.kernel.org/vfs/vfs/c/b05565a8e3b8


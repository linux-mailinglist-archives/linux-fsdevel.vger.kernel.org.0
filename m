Return-Path: <linux-fsdevel+bounces-42837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48BA496D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D559E3ACAE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD925D216;
	Fri, 28 Feb 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9s8i4hz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307A25F977
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737720; cv=none; b=jXTd4wVZSxrqju+AlBe3v5LjsNtp4s/qrXGpoDCVK+HXlorHBBaAIeHZ+PKR5KYI/6eiDGVJLYdbbtampSZJR/mLGdUDsskqqKDR4rOZt1xIOG3OCT4FEKgKaSJa6baygi5U+5faTFd6H6kNUlSsGOEkK7tEt2/yaoavBifhBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737720; c=relaxed/simple;
	bh=bRd0yX/+Lpqhn1Yd4wfzNI5gcDQ5bk5OZl9PgCV6Vmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhB+VKKavMJ8Hb0E+Bk1uK81H5l/Dzkx6YD1zZvYVDLmOO6bzkc9x9c3d/JaEVGlSAx5uK9uhzmsULcXg8dQvJZna62xVftxo/HIMVg4asrTxIVDvqQpLGoN0lWGykFj5TIo3vawfdb41ArlGfvzEGT42GVcRlRicTNCa842oJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9s8i4hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28414C4CEE4;
	Fri, 28 Feb 2025 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737720;
	bh=bRd0yX/+Lpqhn1Yd4wfzNI5gcDQ5bk5OZl9PgCV6Vmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9s8i4hzYtWx+I130q468X8iZ1BniKDhTDSDGPm/26vGFKl69e/JiQRfi38yc2GXo
	 MHOCEULcleiW11crwmNcQ/7F/pzxD+5p4KZIUlwmRQAuyF7dcN7nAF4w41rrBPZhah
	 DXR+6g9KEAoDzj5ygkZiCSdipU/y/uaJ8kWGL7GkHYRUL76TRD+dumsCperuGm0NrS
	 SPKjWfzr7PTzwTRtcntSvpVK7QC2Z7NeLSooA4CRIEetAyd6S4dS7wC9ohaLHVxlRH
	 H/QIGSUCtVUySsQHCpXlCdS/KwxqG53kXcLy/hos8iRJdO42WfYf9YO4M22XOqHo+L
	 tMBTSN0MKQrUw==
From: Christian Brauner <brauner@kernel.org>
To: Pan Deng <pan.deng@intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	lipeng.zhu@intel.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: place f_ref to 3rd cache line in struct file to resolve false sharing
Date: Fri, 28 Feb 2025 11:15:03 +0100
Message-ID: <20250228-bestzeit-sondieren-0fc0d185fa4d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228020059.3023375-1-pan.deng@intel.com>
References: <20250228020059.3023375-1-pan.deng@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=brauner@kernel.org; h=from:subject:message-id; bh=bRd0yX/+Lpqhn1Yd4wfzNI5gcDQ5bk5OZl9PgCV6Vmo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf7Nmw9rKvr/I2hh3Zuxtzr0sVtG5K5PHxS315uejmn V0xy36yd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE7AIjw/R9E4OT6mqZ7F7l RMZMzgmdwB1R5OT9oTXkpVNlzflV0owMTxfY/RGQsJnG9e5dRqpj6gT9opYVP7oyaie8eP/3xb+ TnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 10:00:59 +0800, Pan Deng wrote:
> When running syscall pread in a high core count system, f_ref contends
> with the reading of f_mode, f_op, f_mapping, f_inode, f_flags in the
> same cache line.
> 
> This change places f_ref to the 3rd cache line where fields are not
> updated as frequently as the 1st cache line, and the contention is
> grealy reduced according to tests. In addition, the size of file
> object is kept in 3 cache lines.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: place f_ref to 3rd cache line in struct file to resolve false sharing
      https://git.kernel.org/vfs/vfs/c/6a9ebf00c3be


Return-Path: <linux-fsdevel+bounces-40717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422CA27006
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFE1881D35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206D220C014;
	Tue,  4 Feb 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXnh/JaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A6208974
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667586; cv=none; b=PRx9VLv4b3jaHZi2U1fanQY893turEKkKBe2D4WV6tYxPPwLz4L5HvnTMJ6j1uKRfGCKh9RWpLgIHzviaEOB5pBRYsA7j2OUkkJAIStVWhuyF/KxYTMvUuJNkjWlF2swWxYVurK9T96yBnCncuDgxTwb8IIrQN3uKuX7Fm+0rqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667586; c=relaxed/simple;
	bh=we22qv5yQrgz+2FEncH6slyWvSovs6AnQsogl+E5EI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f778Wt6cP0aSmSFQkZV41Wyu+wJT8Cgulhh0n0MnmNfJsHDvnegBM13/LfiGRk36Zpji+fqMr/hQjSkh/MR/4xXlXBGW4wFD0WVOQ8qOuUpO/S3Xy1wV8NOPQ7g62TFpkVOzkRsSwDGLT6RQm4z9Uw7l30kRivdeTyiUrlzM1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXnh/JaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE26C4CEDF;
	Tue,  4 Feb 2025 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667586;
	bh=we22qv5yQrgz+2FEncH6slyWvSovs6AnQsogl+E5EI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXnh/JaVfzSP5hBJce8x0UY3KQ/K2Aa9fKt9ohdWHSnNjU1EwiYuSXCzGQBhpiV1H
	 WIyGsznht3OPAUynnIjCy3yFpHi9XG2ZwB+0w0rnfu0OAoVDwem8yPgyK7zsfnPGI5
	 HfPlV0JkjNmbTXu4gGqwga+rmIgKDPxpS+POWZZOSbRF+m2JF+h/560yMvzjAk2JMC
	 rg4PHMaQAvyH5o7ULn/o82kvMRhaoCPX6RbjNMbsEZL2NV5ZbdXn+YE4tfyUGBDwNX
	 ohrTyPuVaKDelLF+m16l16Pm88MPmlEVOJUG6pL3bcVIYTcU4yrahhhTxPb36lqDZ+
	 0dRsKIjUYUE8g==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring requests
Date: Tue,  4 Feb 2025 12:12:52 +0100
Message-ID: <20250204-glashaus-begraben-5ea4e8fc3941@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203185040.2365113-1-joannelkoong@gmail.com>
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=brauner@kernel.org; h=from:subject:message-id; bh=we22qv5yQrgz+2FEncH6slyWvSovs6AnQsogl+E5EI8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/GZjvtx4EU/ufn3tZ1s6E/umGO48FMoxOX0p29t4m 7yiatE7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5s5uR4czMpbfn+rVGzDz4 UHPHBWY3l6zw+VMPJbqxyLDu88qfqMHI8Jd1QvayU/wbf3TPZo8PXHLel2vy1Sn3b/OZP17+sjf nNCcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Feb 2025 10:50:40 -0800, Joanne Koong wrote:
> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
> bit is cleared from the request flags when assigning a request to a
> uring entry, the fiq->lock does not need to be held.
> 
> 

Applied to the vfs-6.15.fuse branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.fuse branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.fuse

[1/1] fuse: clear FR_PENDING without holding fiq lock for uring requests
      https://git.kernel.org/vfs/vfs/c/c612e9f8d20b


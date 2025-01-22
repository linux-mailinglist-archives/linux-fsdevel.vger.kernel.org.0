Return-Path: <linux-fsdevel+bounces-39830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54FA191D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC31610CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94358212F92;
	Wed, 22 Jan 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9pNRcR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7D211A18;
	Wed, 22 Jan 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550473; cv=none; b=sdqSx4DB9u6H/9Xp96F23S2PcD/4ZGRMSQWHImw2CCIwaDEpP+g8CG/HzGE95WfFY3ac6aNXn51jS0g8lCQPpRfKf97FAlvsCt7NS25liEGP4ns+3JUn+vt+wtbDPEjk6kui8AF4dIVHLJDetEwbgD+FTzxTYnFQfbqKzCMHLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550473; c=relaxed/simple;
	bh=CQvzMWEiwgn5xEuligBIa/wG5VPqf5WcQmMtMY+1PCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+UZDjrowujq6pGDNjmGFv0xFjT93PywM85TS1ngBY0fm//u0z6eZR1FeRcCYk/NyS0zd22IsSDvJpBnd4eDLvqhh14tVCY4KdIHXV8gTlVsFltESk4oJYBx1q6K+whroNGh7lhpeLjJHgCLwNg5NCxAKVSnNPDakHcJ0HQ+O9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9pNRcR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB40FC4CED6;
	Wed, 22 Jan 2025 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737550472;
	bh=CQvzMWEiwgn5xEuligBIa/wG5VPqf5WcQmMtMY+1PCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9pNRcR4WRbnoLont8uPYL5jdIzpYpdHM3VGBHIw5bO36b0u2t86hyqE/zDA8ExIq
	 opzv0cafs+d8O7zJ3mz1at3KuUv7WWumU3svrOKrZrr1xaIQAHBKOwnZayAlpqVUen
	 rFeavcYoTTJapM9WW/xQ61M6/LtIc4MKZnrhn1HKE+RrNLtQ5Nc+89X25clHT49Kuh
	 Or1xCJSPKDU1eCGNeQne0eAYjsUQpF1lVtNcUwBJsgSaVa8MASJICS9eZUDqAWjFCg
	 VRsqmK/ERBIY8K8ZvqiVINALT0DFF+V1j5dKMNFATxkJYHSW1AmoyjkV/s1aWS1Iob
	 lgia+HFjH6i3Q==
From: Christian Brauner <brauner@kernel.org>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/1] vboxsf: fix building with GCC 15
Date: Wed, 22 Jan 2025 13:54:17 +0100
Message-ID: <20250122-heimlaufen-fachverband-17319b49fc6d@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121162648.1408743-1-brahmajit.xyz@gmail.com>
References: <20250121162648.1408743-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=brauner@kernel.org; h=from:subject:message-id; bh=CQvzMWEiwgn5xEuligBIa/wG5VPqf5WcQmMtMY+1PCw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRPeNU0uShdMe6K6kqO0osOZ3n3sHybZSSuWPu8f/+Cv DDx/yvvdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkjQ/DL2bnDOm1zqpHJXd5 HF4ukGY974WG+ktnw4tLdh0q2pPikMDwz/jqh6L8qs+Tv5YcePHpqMT6JeskJUq0gjfO5990qPq GPj8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 Jan 2025 21:56:48 +0530, Brahmajit Das wrote:
> Building with GCC 15 results in build error
> fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
>    24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
>       |                                                      ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Due to GCC having enabled -Werror=unterminated-string-initialization[0]
> by default. Separately initializing each array element of
> VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
> and fixing the build error.
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

[1/1] vboxsf: fix building with GCC 15
      https://git.kernel.org/vfs/vfs/c/48a26e63b8af


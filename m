Return-Path: <linux-fsdevel+bounces-37286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB09F0CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D031610F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2823C9;
	Fri, 13 Dec 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM2xnrMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9781C3C0F;
	Fri, 13 Dec 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094138; cv=none; b=GJBOA9iFZHl+IU+LzuFc7HvXp8x/YyCvxwTAU+txU4Lj9LfDEjrhwyl96VZX2/I/uqBN1ML9JPtnCOkXsCrzXvam8+qtCBzB3/VYegJoQ0Mz+s2NUtojuYBwpqsXuZo0AbuhZr6JI1GmPHgaDraMXEOiolt9HB6W2wfyh7u4EMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094138; c=relaxed/simple;
	bh=fDypQjr5cmXNfkql+DYJwukKGeEAkHzfw1jXtUjFtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwILE4fizd7EzoHH4uvu+q90XsJBHw2hRuxU5kxDS7CsxauvsH+2aJv4p38wLE4hHYLrr1QGjBctLZm8dqhVev9y9XtZWY7AwvoUhQDVAHqpYwRSO+gT2TWqKwSEWWYfv/nhydANE7m/rzBZsaQjUnr7lRZ56TTg/TDMHOzJwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM2xnrMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34154C4CED2;
	Fri, 13 Dec 2024 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094137;
	bh=fDypQjr5cmXNfkql+DYJwukKGeEAkHzfw1jXtUjFtNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XM2xnrMFPm+dsQNOoQ9++hKt2nNQJRVMQZZRZFAQXimzRL5Vn4zMtT/i3zb4VrSmt
	 rLzC1C7lWmNnsKmPq9i80hCDfpTs+55clAzkXtxruG4I+HXmeSVJk/HbagDXQS2pkF
	 HCHERDYsF6QTCKv79BBgDPnm1d7BwThSdXGXSLYwLvRu0bzjGg+WbsKpYOrA3qQOO/
	 J1RK51LOl34j/E7xXLFp4+PliOs9a6cpzarHMg3wzjjinmRL0ysUf7MAV7YuFLpClW
	 AfUqiIRhuJJJeoSEsIaQqMenWR3ssGSUM43kvKQy90yfTyZm/KNBUwQj6IxS3ErTke
	 mMP1Nx7/aYR5w==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix is_mnt_ns_file()
Date: Fri, 13 Dec 2024 13:48:50 +0100
Message-ID: <20241213-parolen-kursleiter-663d1f459cfa@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211121118.85268-1-mszeredi@redhat.com>
References: <20241211121118.85268-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=brauner@kernel.org; h=from:subject:message-id; bh=fDypQjr5cmXNfkql+DYJwukKGeEAkHzfw1jXtUjFtNg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTH6Bq3T9wY9V0wzUj8pJE9/+EjKmvOz7U9tuuuepVgV UbDp2frOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiwcfwvyrymFzyJyYZm8rz z2S4epUNan4vOzvbLzJ2jufyFW7LdzAyzBTgS9mcWSayd9LWjb+iJXVK92Qt3BG/o19HQoDjyAR BDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 11 Dec 2024 13:11:17 +0100, Miklos Szeredi wrote:
> Commit 1fa08aece425 ("nsfs: convert to path_from_stashed() helper") reused
> nsfs dentry's d_fsdata, which no longer contains a pointer to
> proc_ns_operations.
> 
> Fix the remaining use in is_mnt_ns_file().
> 
> 
> [...]

Thanks for fixing that!

---

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

[1/1] fs: fix is_mnt_ns_file()
      https://git.kernel.org/vfs/vfs/c/aa21f333c86c


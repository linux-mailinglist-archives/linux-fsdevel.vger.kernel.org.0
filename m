Return-Path: <linux-fsdevel+bounces-52197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D9AE024D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57AD16452B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD0221DAB;
	Thu, 19 Jun 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMeAjzlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A43085D8;
	Thu, 19 Jun 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327463; cv=none; b=QReRnKgHhmS3cQqo/sqYWmn0CqjcT6iPdy358puZAbYqDGUh8q94ZQ/rqvSug43s+gNN4RDCCqP7w6fFZl+vm77/YLqgtE5T5tOXIuz8iLXuLznsXMPig9Is2vl3ptaEfAEIhoz44rMeSUlDe+RHgPyUIiRxUfGCCRVrrgV4zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327463; c=relaxed/simple;
	bh=WJyt11+voGfV0AKmH3A/j8zQiPmx7FXgy1uzaMHZSXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaKO6ckafifIyqNrm7y1JU3yeDygF+pgraj91oPnrRXWZhPgLiT7ZWKHRuWGfNhNZeJbcDULx7zTEYVi/+AF5vLpqZ/OAdnCv7C/BW/CHhFBm6CuXvQuy37x4OWQ96pf+i/BuVL4QZ4qcDrVplRQ4ITDWJr5IH9j11BzYQXiKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMeAjzlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16465C4CEEA;
	Thu, 19 Jun 2025 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327463;
	bh=WJyt11+voGfV0AKmH3A/j8zQiPmx7FXgy1uzaMHZSXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMeAjzlYd/SdbZMB7ndQA72JINwyOL3RA4VRFQwZPQ8FhCmTaoWO4LWTg9hTi2iwy
	 WPJ93WGycINwiFYnVvZa6YDzGez2TJRePXJWC43EX27YSxFpZpC9BzpcpVlkZkVehG
	 8yINIQoXwE6rTrRrbrYjNlxyVg/igHnWxoMUV6cDeHhQNQKG4BPrY7x9OPRIAAA5X8
	 NrCzaAH7r3mpkuMVikaejatE0+ALCOlCig8y5EbPjaKwMgbYn8oCdjtXwrizC30WQH
	 x+1BSNSESs2xbkpRbc19kqz6CYxkPzZv/SwP+ERFT2LRwTxgEuFoffrgWiCcV0mlK1
	 sl6AnSuCUmZTQ==
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Christian Brauner <brauner@kernel.org>,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the abort file in fusectl
Date: Thu, 19 Jun 2025 12:04:15 +0200
Message-ID: <20250619-nennen-eisvogel-6311408892e0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=brauner@kernel.org; h=from:subject:message-id; bh=WJyt11+voGfV0AKmH3A/j8zQiPmx7FXgy1uzaMHZSXQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEP1h0pzHorMqvVjMVK0GzQrUVude9pKYe2bx9063UH WrWq222dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+mVGhrMFTDKTX+1VYStP MQ1n+H2QfdU6RrFXVaof5gZwnLPaqcnwmz3otGvoKdsPd0M6p9ltS7milOBlufTYomUTSn/tfe5 5gAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Jun 2025 17:40:29 +0800, Chen Linxuan wrote:
> This patch add a simple functional test for the "abort" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
> 
> A simple fuse daemon is added for testing.
> 
> Related discussion can be found in the link below.
> 
> [...]

Applied to the vfs-6.17.selftests branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.selftests branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.selftests

[1/1] selftests: filesystems: Add functional test for the abort file in fusectl
      https://git.kernel.org/vfs/vfs/c/0f505cf71c63


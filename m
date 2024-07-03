Return-Path: <linux-fsdevel+bounces-23007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903289255D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C214F1C257D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0613B2A8;
	Wed,  3 Jul 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcwSn1aC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C4136986
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996564; cv=none; b=UfDmHeYbA3Mt+E/v7dXn5/wJwU8Sfvu4ns/acWMVn1U0MsEK7fiHzESKn5oJsSPxy5Ja1U/dbaR3Y5h5mzmMFBEscEDeEpbvcmCHlpB6CJTSyWljfNVfR/1It6Zpbn4TTOkbSuwYOI9+ar6RnFdYDO5tOsOnOcy7XOJ0UYQqQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996564; c=relaxed/simple;
	bh=KINQoNuWD8wAcdRxftxeERAO1Ap8DiVIryPYNCjLppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7fO7qbsAkQ2QiUQGLNOj900rLA9cC3FsLV0pDXJJg7fLGTlK1ldWH4Z+rNEOEZGXpjoSl7plJnAsQ/OXLNvCvmb58Gq/AEz7zo8vIByAUynJ3zxOjOeZtGPpeiR5U+t2XU3rSc98OmHoBmCnxfkFrYVXXQWgYPRgeJLF9/JK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcwSn1aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B31BC32781;
	Wed,  3 Jul 2024 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719996563;
	bh=KINQoNuWD8wAcdRxftxeERAO1Ap8DiVIryPYNCjLppQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcwSn1aCgJXnYYJlRwLm2GEntDqQ034BJi25/0T6K3H3pDSNJEc/3nTisvNrmv9DA
	 5jiQiegi0gOc/68XP+xiaD5P3m6cv1eUyxXrNJ1gu5ujgAN8w5oG9Qil1ilM+3jZWq
	 SDHFQp7MsBxujZulkwGFT+3iZTEpfT2HRVbmbxiCMwlc2z9AQnKMVibpmVPT/SIW4D
	 R+FU3DZaB9JVRc3vzLHr+dzf50oFaLOllgn8d2WpwL+plJA/AWTcPlvgp7JHAQDAff
	 1GRSSq5bBbkteseeyOTjvEOqv9LzVVYfc0MOwiJsSIfRu4xEVtCGIRzibXwmbPwnCu
	 q/7SSdMBnAgfg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH V2 0/3] fat: convert to the new mount API
Date: Wed,  3 Jul 2024 10:49:13 +0200
Message-ID: <20240703-strotzen-verkohlen-f64947a57d8a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=brauner@kernel.org; h=from:subject:message-id; bh=KINQoNuWD8wAcdRxftxeERAO1Ap8DiVIryPYNCjLppQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1CvTOVs2yYGfVDrzJ8kmr9QJPz2xh58T3WXcOzYtQO 1r3lel4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQCIhj+x5Rxe1V8nPdoMe+y ml737pRWBd9bnwoXulnGbnn2xY9xDcP/CM8Xr5kNNN6o866z4fEV1OHYu3Rr7rukyyYh/PNdpwp xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 17:39:25 -0500, Eric Sandeen wrote:
> This short series converts the fat/vfat/msdos filesystem to use the
> new mount API.
> 
> V2 addresses the issues raised with the 2nd patch in the first series,
> details are in patch this time.
> 
> I've tested it with a hacky shell script found at
> 
> [...]

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/3] fat: move debug into fat_mount_options
      https://git.kernel.org/vfs/vfs/c/206d3d8e006c
[2/3] fat: Convert to new mount api
      https://git.kernel.org/vfs/vfs/c/634440b69c7f
[3/3] fat: Convert to new uid/gid option parsing helpers
      https://git.kernel.org/vfs/vfs/c/d02f0bb332d5


Return-Path: <linux-fsdevel+bounces-16656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF578A0B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC833287A56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E2B1422AF;
	Thu, 11 Apr 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmohWyFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C213FD9B;
	Thu, 11 Apr 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823724; cv=none; b=fGXJbs2DL7eNmHQTio6ScLsgvosCrZetSQOcQJykJfvvcAbMecavATC6PFvw4RpfFXkLew6W92CpJjNWpfIQZVTJ4kHaHsfKp5uzQ0lpcI47O7T+gB+Z7anIHVvnrInlX3f+vJUF6E7HWYOc5mMk5/gPR/3lT+Ppptr1eBB71yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823724; c=relaxed/simple;
	bh=oNEmCk3yEkGjg2fPr9n0Fw4bPVs/3syG5A/ow4aPcao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbfS1EhY9FBve4ELuS48kFE2IgM/fTf5aNEwavnAVE3mIZWpN4E3FS6rowLPG7Kz+1F8Bh8LCGXB1zSHu/uC/WWgC9B9tAZ4Z1dtsgBKlqhTI8sq3RbNXaUWq631nLveR9qEoDcjVv0IPvDsT2ZU3Abpoyb6sEhBmMRgSWsX2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmohWyFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE361C433F1;
	Thu, 11 Apr 2024 08:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712823724;
	bh=oNEmCk3yEkGjg2fPr9n0Fw4bPVs/3syG5A/ow4aPcao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmohWyFiMYt6tYR/aq+4GN4WPU/Yo4g0Wlcyu46TRJJjpTVHxh6aR/P+GzSEx0vI/
	 XEqj1RaYwbHZRO60gdN4N7tuDaq74woTDPBJeuVdjHD5lrU+mp1REds/H4L+fdmRmU
	 IHh8avv0war3Au/ql8e7DzTAsxdNcTLLDRwtj3puTeKpK67K6HzcvCsYO/IMM1tPZ1
	 EbzMVXHNV9bbBRHXWyZUw2T6G8UyducqlgsIKmgwQLHyU6wuyJrM4Yhg/gt7fy8L+l
	 OlHpQ1A+CPgBTldyL4R2QeAWqDFLMv8rNPo5DdFLElPGXfiRseSJd1oarI4kDLQnRb
	 +fL8itWxnMSZw==
From: Christian Brauner <brauner@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][next] fs/direct-io: remove redundant assignment to variable retval
Date: Thu, 11 Apr 2024 10:21:40 +0200
Message-ID: <20240411-anheuern-statik-18a9cb9ba524@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410162221.292485-1-colin.i.king@gmail.com>
References: <20240410162221.292485-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=brauner@kernel.org; h=from:subject:message-id; bh=oNEmCk3yEkGjg2fPr9n0Fw4bPVs/3syG5A/ow4aPcao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSJz52jXtr0f8raipPvD4hqTs7jjxS8wbDPdcfv5d/2N TW/EfcI6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAbjJnxkZmnQe/D990+X1ivCN rdXa5zkNnu09FPvwu+GEMxuuNE2cncTIMLM5JX59ydqqLSfS1Ts/pJrIHvK9494YlL7IrbeW6Xs BJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Apr 2024 17:22:21 +0100, Colin Ian King wrote:
> The variable retval is being assigned a value that is not being read,
> it is being re-assigned later on in the function. The assignment
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/direct-io.c:1220:2: warning: Value stored to 'retval' is never
> read [deadcode.DeadStores]
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

[1/1] fs/direct-io: remove redundant assignment to variable retval
      https://git.kernel.org/vfs/vfs/c/fd0a133ef6ed


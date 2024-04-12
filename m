Return-Path: <linux-fsdevel+bounces-16789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77E8A2A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0828289032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB004C602;
	Fri, 12 Apr 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFL2n0xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAC205E3C;
	Fri, 12 Apr 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912919; cv=none; b=CJ2pF5SWV1HMLq/KM37iYKhP7b827jVmdaym2hDgH7WzWKKMkWl/odswdAKwsC6O+DVRAc0ICUidj0I+Iy0lTRnrwOUWGuKRjivf/1Jk1qKxNnRC2hedXMvDpEU9MpIp4gAxzpU9rl+0Xi6bbhU6xNYDhhZH4pipkVMAVtr2PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912919; c=relaxed/simple;
	bh=ii/Uc392uqc7ct/GqIg5jcnCdezu834MOoemDCDL4jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovJcc5q2sSB5Aa7goa7CE/y2gP9Q4FRK7p8FW/ajTnaIbYTK+O7POz24r0Nf6T9ImGP6iegvgqyvp8bQojC72kJ8bi2IcoXcHf3+/sdRctmyPRiwirKxMNLm7ht5ZeWZv8+v+lEtfCvStsV9+dQ6R0ezvpRS6AFnnNP9b/NId2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFL2n0xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C9C113CC;
	Fri, 12 Apr 2024 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712912919;
	bh=ii/Uc392uqc7ct/GqIg5jcnCdezu834MOoemDCDL4jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFL2n0xdOY8vILWBr2XPdtHuPRvh9nxfe5aVeijcCB9ejqQkO4anyUZJ+G7pAjKaX
	 92+ZSLFPWMbSV1rtBV5KBEZMNEvPY81SCESoV4p3Cgci4Ufvnc5/AeMHRYsR88PLw1
	 sA+EHA3+A/gCOVBEGnMrVXtuXis4mYIOktq0KaqmzU9xVZhzf80ccnfMqhnA/h4RqW
	 7VSccRO9yYbJdjfMzCVzzJrTfo2aDYgM5hK3xkwCoacNOZONF+0xcisQskx1XquL2o
	 GYhjo2E6SpsqpinK3snW4f8x+LWisFwH7qp7specjcbb1maIkP8OCqeAQgkQ5rx0qA
	 WJyi2Rf7ABRPA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lutomirski <luto@kernel.org>,
	Peter Anvin <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
Date: Fri, 12 Apr 2024 11:07:36 +0200
Message-ID: <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411001012.12513-1-torvalds@linux-foundation.org>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=brauner@kernel.org; h=from:subject:message-id; bh=ii/Uc392uqc7ct/GqIg5jcnCdezu834MOoemDCDL4jM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRJ/LwZ0Jm5L/jxOlXntDyXCvO/Sp9nbd2tO1ns2t6fX 2WnTjs6taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi7zYzMhzg/P30wu+TgU3p TnambTsbzPvTE3wtmlUUF+/U5Kjtm8nI8CLp6DyDyz9/xl1iNJLYffjO2hmmC3/xPxbN7Ts8NT3 GhBsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Apr 2024 17:10:12 -0700, Linus Torvalds wrote:
>    "The definition of insanity is doing the same thing over and over
>     again and expecting different results”
> 
> We've tried to do this before, most recently with commit bb2314b47996
> ("fs: Allow unprivileged linkat(..., AT_EMPTY_PATH) aka flink") about a
> decade ago.
> 
> [...]

So it seems that this might be worth trying. I've picked up the patch
with two modifications:

(1) added the relaxed capability check.
(2) renamed the flag to LOOKUP_LINKAT_EMPTY
(3) slight adjustment to commit message

Should show up in -next if I don't hear objections or you want to apply
this directly. Fingers crossed we don't see regressions.

---

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

[1/1] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
      https://git.kernel.org/vfs/vfs/c/fa75d6e377fd


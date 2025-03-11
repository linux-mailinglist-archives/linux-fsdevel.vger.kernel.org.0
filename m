Return-Path: <linux-fsdevel+bounces-43707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B098A5C093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8649163FF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CD25B679;
	Tue, 11 Mar 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2hm2Lw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D725A648;
	Tue, 11 Mar 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694853; cv=none; b=Cm59c3MXBjC4s9V91gOGLbEdtzSc4qO1zLBo/9R4I1dJ/xK37DtG5m2g3bBGHNpGtKwGFkKSMs4WG/GXmy3sIf0Ycmn9620u1s7ep/QTPU5EjMbcrWwUMBUv2ycf9+CfhmMMvMyV0vLB3SWpeJYLJlxT8PjUrKPHeX1ojk35dCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694853; c=relaxed/simple;
	bh=jmQ7nPvDWPX4ysCzL3zjUSbc5owtj/SgCViNOxWXCg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To9lI9WlT2AxwWymwSVhGdOLo0FbYCq7herkc5ulIYUIooeChpeZnE1kPZ4/Fd0fnA14rxiG7KkVGq2uYTR0f7ZmLzxFEwiaU1v7aoHGSqwIVQJDJWQOhTYTFAC6jBqGJapJwJLMf8ozAUOVBrhZN40yufzLhDJQwyuaRfjQ4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2hm2Lw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE4FC4CEE9;
	Tue, 11 Mar 2025 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741694853;
	bh=jmQ7nPvDWPX4ysCzL3zjUSbc5owtj/SgCViNOxWXCg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2hm2Lw/aCNAksho3mLJw/PIJCA0dLQer0MnGVMEdTNxgEtMGJ3IdknFxcV4XMaD2
	 ns4jN6ivLRPEWzleRqOcMP30B/FXkPFTiKerD/iPuNh4lfHXplJzPduuFbvw5ZMIi4
	 9hB6Gue9Fmty1TVxVLbJgtErHwpgkpunZ3KjTzLUJ4SOe5+8x7MTO1ymQfwYkS6m6c
	 LD5ku7xybWG3N6BdPrO0X+QqtIhn3BxmxJ1xQ5R4WX2fk9OEGMcVl2L9D9lySL1i+T
	 gTO8jV8EB7b8xDE0ALvY2U7Ca0LUgLux7/58j+KZPA33tyucPEKSyCyeoX0DMT5HSz
	 8XxDBwPJWjhKw==
From: Christian Brauner <brauner@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Add __nonstring annotations for unterminated strings
Date: Tue, 11 Mar 2025 13:07:26 +0100
Message-ID: <20250311-daran-einige-e64c81600277@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310222530.work.374-kees@kernel.org>
References: <20250310222530.work.374-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=brauner@kernel.org; h=from:subject:message-id; bh=jmQ7nPvDWPX4ysCzL3zjUSbc5owtj/SgCViNOxWXCg0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRfUK9PKr4euCnMqv+//Y68A+IS9fzr0475cpSl6E9eJ L3sp/+5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImoHWD4pxoYsbF1i3njql6W RheT9pnX2qy+3v+2NsXRNvlJve5SPUaGs59qDv19k+zD1egmWZqUcSLi9938tjdWmq/exs/0v6n HDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 15:25:31 -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> This effectively reverts the change in 4e7487245abc ("vboxsf: fix building
> with GCC 15"), to add the annotation that has other uses (i.e. warning
> if the string is ever used with C string APIs).
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

[1/1] vboxsf: Add __nonstring annotations for unterminated strings
      https://git.kernel.org/vfs/vfs/c/986a6f5eacb9


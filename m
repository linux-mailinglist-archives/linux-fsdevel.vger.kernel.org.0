Return-Path: <linux-fsdevel+bounces-23031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E89262C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828A2816C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25017A59A;
	Wed,  3 Jul 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq+VQK1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0C139D16
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015401; cv=none; b=M0cs9kYNMUnyvQYtOD7Ziwvho4nH5b0TEKTKqZA/pKLX+cgLUreJbtx/tvB7SSU3XmuSLhKW/pLKKsI/3rJBnjaBaUpsBuG6b1owJuIRExkI24wnDZyGaoRAuPpReh0mx4qWWhElltEkvASaQ9MDqRGOFAYkhNamL41/uso6hOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015401; c=relaxed/simple;
	bh=ViIGM9OXxaWeYdMk1dqpd4Jf5OeRn2aN+L6BTCOq4uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2WdbRSmsAqA8Bss3Qm5XuUqtNEIh4IAGFJ0Y9UgRAalKQ34uj9kohLh4xIRf+vb0mdPp/W7mRqltPN1mXsCrnZ9t+HCx975aGY7fue5KXqbJ8MfeW3T8STBWPKc7FQH+j8/G2B8ttqBY1E5oVx2cOijMYsnakXPg7YlbxmavEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq+VQK1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328ABC2BD10;
	Wed,  3 Jul 2024 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015401;
	bh=ViIGM9OXxaWeYdMk1dqpd4Jf5OeRn2aN+L6BTCOq4uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mq+VQK1cXO76PTE1FsFUqg+iaIF22EOPS8XFYQZMZ/GR/RnOVou81DgeqjhzH25np
	 260RUY+7+VUo3h53RdzrOmrIwCBj+QvimKtFPFcQOVXiHVN3bZeKz0NyzvylXmXgCJ
	 25F3vadnzLB2pI73BoeKRWofsYtsoHRSYk7FGWFXPkeIE0QzZlttnZTbJOPcx0Gc7S
	 kooVrCtQ+lr1lwBCp1WeW1fsDwhVfzHpT9hG3GFz49fnY6/Z69+KS3AAxV6x2wjeC3
	 61S4QGxG/sxl34maQgzyCdLUM1P7Lgi1e2zn6/sM0q6Tm0vTJ7zX0mLJOkh9z/W6it
	 vwb9u7KEqo8kg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Ian Kent <ikent@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] vfs: don't mod negative dentry count when on shrinker list
Date: Wed,  3 Jul 2024 16:03:13 +0200
Message-ID: <20240703-tauziehen-minze-ca52c2866c25@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703121301.247680-1-bfoster@redhat.com>
References: <20240703121301.247680-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=brauner@kernel.org; h=from:subject:message-id; bh=ViIGM9OXxaWeYdMk1dqpd4Jf5OeRn2aN+L6BTCOq4uY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1RinJ7et7s1+6SSBopmCN49yJoas51cr7/+jYbpq2v G1p7IM/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM53Mnwz7Jnpd6GbfeFjtnU TSnl4OL/mT1FT0+iwl5Xks310OQ3VYwM89pD7dY0cBmsf3KjfcKU7w+uzuUvu6ntdZtlreAKk8W 3+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Jul 2024 08:13:01 -0400, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
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

[1/1] vfs: don't mod negative dentry count when on shrinker list
      https://git.kernel.org/vfs/vfs/c/dd445e65afe4


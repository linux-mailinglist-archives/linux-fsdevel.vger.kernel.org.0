Return-Path: <linux-fsdevel+bounces-72059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75115CDC4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059153040677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F632695C;
	Wed, 24 Dec 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOtDh1B3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E84165F1A;
	Wed, 24 Dec 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580973; cv=none; b=K8UNTFsWMvQm+6jkh9GzWF0r8DzPkIeK2Q0fHtQ119CZ3GLSqIh4jK3Yz83LVCiUeYfqbkCOpUDH0OWwd4HYzEDgHYe203o5sCaVv46tVQryqlutPWP4au2Ss1XU+KzS+ATvk/fJaNyC8BdN7qodHcXMnWFarOhIjN8lfExyP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580973; c=relaxed/simple;
	bh=kxJUIRPLIzipYBVszpW1F5Nu/ZlaxVOoEHcSQ6/IMBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uX6IqS6Tq9RidPmGNo2AV2xlT776pR6Gm0cUx+CGuzjHi9yLXXwtKKwjdcl+OZF5led62nhABoH7+PPwObn3WzHL2ex4zvUCfpT413fhDRFWnNG4oFAu+uTCfVl+uQWFz2eK7i403dzyBSZcwBPpD8NGRNLsf7uU8PoCCiEYEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOtDh1B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00463C4CEFB;
	Wed, 24 Dec 2025 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580972;
	bh=kxJUIRPLIzipYBVszpW1F5Nu/ZlaxVOoEHcSQ6/IMBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOtDh1B3ZMEonCocBnI4sNHfnkaxC8CZ+uH7TtiZP3CD5aFEctmhASg+enWfobjUH
	 CsBDbE9S1AK8tKBWg+glDwgQrKAKB9raeqgVeNYZTGJraCqYpevDifJRx3ovQTWKef
	 YRZ+NCEBhJDCXv5yLJ04RAJB9U6b+GTagf96MQmSBB6hSK7KUh+AHHSddLOk2h9e60
	 Ir1QL7NABNO9qlVByePvxQl0KwN3OSlGkRKDu1UIaCbUqKKLyxCSozpvUURSvLKq0e
	 A1Ysf5qm5Y3fy6T5I+ToKZLiRLtwr0JUGP3cUCAZAfGA2cnTKyKfVds4Ttu5cu05ZG
	 ylAbapvhrXt2w==
From: Christian Brauner <brauner@kernel.org>
To: chen zhang <chenzhang@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] chardev: Switch to guard(mutex) and __free(kfree)
Date: Wed, 24 Dec 2025 13:56:03 +0100
Message-ID: <20251224-gaspedal-zufolge-3f3e728f2c8a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215111500.159243-1-chenzhang@kylinos.cn>
References: <20251215111500.159243-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=brauner@kernel.org; h=from:subject:message-id; bh=kxJUIRPLIzipYBVszpW1F5Nu/ZlaxVOoEHcSQ6/IMBw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6P3rB3sH/eKOZXevWkwFZPS+jU1mP8Ku+zH79V0OE9 8KPSZonOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS4M7wz/pNmr3EhiCZea2u judEZRQmemXqqXa/XmTVFrHx2/S4BEaG+2sOG/QV82bfqTC6V3JLyS/Yja11j2fgcd1kxeRk5v2 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Dec 2025 19:15:00 +0800, chen zhang wrote:
> Instead of using the 'goto label; mutex_unlock()' pattern use
> 'guard(mutex)' which will release the mutex when it goes out of scope.
> Use the __free(kfree) cleanup to replace instances of manually
> calling kfree(). Also make some code path simplifications that this
> allows.
> 
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] chardev: Switch to guard(mutex) and __free(kfree)
      https://git.kernel.org/vfs/vfs/c/3685744afa4a


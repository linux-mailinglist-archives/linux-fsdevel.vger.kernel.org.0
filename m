Return-Path: <linux-fsdevel+bounces-59956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2DFB3F8E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721202013EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB52E9EBE;
	Tue,  2 Sep 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa8Kgybk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF120311;
	Tue,  2 Sep 2025 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802515; cv=none; b=VC5L5vVJur6I6C4ErbZz8YTvagIKeb1YqaKUPygYR2FHpXhpg4ao473HCM1JYO46c4GWV91KZxc9HSAntCfMxh/uDKa+pgXwlvnKACHsDqoS4iWEcqCdhbzE2PTRR6kaIM2izog4Xy6SEPp83uW1TCdd77YMjcmNLmiZVeRpmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802515; c=relaxed/simple;
	bh=nTVFxlclw7LzSbfNNJ2PFsMG6pslgAy3nBhdtLRyuMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NapCZLnq9i/FqouEy0xYieiz7p9F2fS1irah9WqrSTwBC82E9ewh/rZvLFdKYYJFxJl1qFFEnCC5+Z3Tj8piMP4FVQoIuy8dRc+g87JHH+GhweU3RJSq8wHVOJckxDcvEDYjBiPzUiy6AG1TtkFXm8PfYtQc3U7Il/BVlqFi0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa8Kgybk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE58C4CEF5;
	Tue,  2 Sep 2025 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802514;
	bh=nTVFxlclw7LzSbfNNJ2PFsMG6pslgAy3nBhdtLRyuMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa8KgybkloK9zH2folFrqDD83Vf8o+wVxFdBgfExirxGdm/XX9K0HW1y2c//FvtsE
	 bq+69491gGnM7IyA9GiglDg2bTVBesj1mBKTK49I6b+fBqUUq6PH7OUho6wquxqsPE
	 gmihHI7+lznB5ew1m4+r3dgN854dYwGGmim+03aa9S5OjM7Iae2YfYuiTqZyiRwXIU
	 ztms7W7iWkq8XkvEXPwTV7KuzHK2AHvJlJpBZfbwi/9ttSxP1VgCMnb9chtYl6+aAQ
	 E4hceOgwigEBXsx+0nBVlnhBuwNi5u7QZiKz62l3KYUVB7Q5B05DnKKd/R8AgqqcH2
	 iMu8vJxq448Cg==
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	cyphar@cyphar.com,
	Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't *trigger* automounts
Date: Tue,  2 Sep 2025 10:41:42 +0200
Message-ID: <20250902-bankwesen-knirps-184b6ed28587@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825181233.2464822-1-safinaskar@zohomail.com>
References: <20250825181233.2464822-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=brauner@kernel.org; h=from:subject:message-id; bh=nTVFxlclw7LzSbfNNJ2PFsMG6pslgAy3nBhdtLRyuMI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsW3t27pNvM94pTq1lbZDaXpv1xuLSwwXCZz/Msq2Ue tHn/TdqakcJC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEci8zfK/pW+0ZsJFtxfW6 wFrupnciO5JcEx5MNAjld8/z/qe9mZFhxunPl6a+M05KnCX8PbJaplxGcFohd2u+f2faimBV972 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 18:12:29 +0000, Askar Safin wrote:
> openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
> doesn't traverse through automounts, but may still trigger them.
> See this link for full bug report with reproducer:
> https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-safinaskar@zohomail.com/
> 
> This patchset fixes the bug.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/4] namei: move cross-device check to traverse_mounts
      https://git.kernel.org/vfs/vfs/c/11c2b7ec2e18
[2/4] namei: remove LOOKUP_NO_XDEV check from handle_mounts
      https://git.kernel.org/vfs/vfs/c/8b966d00b3ec
[3/4] namei: move cross-device check to __traverse_mounts
      https://git.kernel.org/vfs/vfs/c/8ded1fde0827
[4/4] openat2: don't trigger automounts with RESOLVE_NO_XDEV
      https://git.kernel.org/vfs/vfs/c/042a60680de4


Return-Path: <linux-fsdevel+bounces-59964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A313B3FB61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35E73BCE1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E82EE5FA;
	Tue,  2 Sep 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or0avDdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746EE2EB86F;
	Tue,  2 Sep 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806848; cv=none; b=AlEOhPuJhojJ2CMrp8nBIFC6uFv4I7bfaaE4vPyhQj5HiqrsksHCpyD9AaiW3LFvjUA8rxowhVfJH0i33b43sAv61dgK8p0GvicpiSUxr1Odo9H6UGk2D2q/qu6k/EXzw8wSIUcC8rsTRFi5xZ8qayOQ1cKvqJqXco30vS7ASJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806848; c=relaxed/simple;
	bh=F6MUX5AbAPBqp62Jqft20sY4a8sU1JZ5pPowDyOrZM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ3NeXCO3KisMLY1b5ccsje653XEXA3+uh9lyLPBbPhh8Fq/0lKLtdBttadijqyJd0gArjeFIUhJXnLpllWIcPdmU2RFnHoFchNzibqhBHogaAdWqM/OLnO8AW3p5nb9svelWP+dbcvf9wHgF9tk3s3LKo44NB7rghWDdqkVSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or0avDdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8558C4CEED;
	Tue,  2 Sep 2025 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806848;
	bh=F6MUX5AbAPBqp62Jqft20sY4a8sU1JZ5pPowDyOrZM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Or0avDdBFtpCAgQhlKBPNsV6zqu1OaaFxYAxkmLOdxoD7l67L3nRm7+BYIidWNFGo
	 fxLJooaKj09FVO4GAgueCG0oMU7XGD+FMHjqPtfNjIYMDgsTeZIT8juYEXcRLZ8bki
	 I6X6t2Kk+riw8RyV/nBCqnCncaWwgvhZOQ1vaN9MjQApDYXdSk/+T1aM0f5wFgqBqG
	 e+Z4vjZvcuPljlQXBUO2rhbfT4ZRaWwJNlTpxcqnL/JwX2qRAgbyOMvDs+Feo5e4lA
	 PjlJWAUnwyZHVYHYCneemXM7JpSspCbtu1ZMe8cryvPeSi/yDL3z6I5m2XJD0avPDU
	 usIdwscKB2zLQ==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: (subset) [PATCH v4 0/4] procfs: make reference pidns more user-visible
Date: Tue,  2 Sep 2025 11:54:01 +0200
Message-ID: <20250902-amtsmissbrauch-korpulent-b2ea928b89bc@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=brauner@kernel.org; h=from:subject:message-id; bh=F6MUX5AbAPBqp62Jqft20sY4a8sU1JZ5pPowDyOrZM4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRs27dr3VTZPM/2B6uOP9oXsfFuiEGQccxaNt2Y50WbG dZUt4tP6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI5h9GhqdvfITPGa0RuPfR 3C9rwrc5sxIsFeTerZL25uPxi5sodpOR4f4ptukJd6PZf1V1vdofuUXnZHzaUQHjK3JnZ3/f8LJ jLy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Aug 2025 15:45:07 +1000, Aleksa Sarai wrote:
> Ever since the introduction of pid namespaces, procfs has had very
> implicit behaviour surrounding them (the pidns used by a procfs mount is
> auto-selected based on the mounting process's active pidns, and the
> pidns itself is basically hidden once the mount has been constructed).
> 
> /* pidns mount option for procfs */
> 
> [...]

Applied to the vfs-6.18.procfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.procfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.procfs

[1/4] pidns: move is-ancestor logic to helper
      https://git.kernel.org/vfs/vfs/c/60d22c6ef41b
[2/4] procfs: add "pidns" mount option
      https://git.kernel.org/vfs/vfs/c/77e211dd1392
[4/4] selftests/proc: add tests for new pidns APIs
      https://git.kernel.org/vfs/vfs/c/568d4239002c


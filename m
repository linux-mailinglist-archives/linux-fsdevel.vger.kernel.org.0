Return-Path: <linux-fsdevel+bounces-21248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE2900836
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283451C2369B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971819597A;
	Fri,  7 Jun 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqxpoZzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D413F42E;
	Fri,  7 Jun 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772649; cv=none; b=TlsaDyiJxJDinHw3F7VYchXk4vOpRSt0bOWko8FTO3tQZCYzIYKiglxzD7NkCO1oZYDTrpBnCfV7Qwko4/TMYZfPCe0zBtq6tELtIrFf2qAGaUQkGoBpI0xYRww2NEjKIV8M5ENzzlgyRi474hD9AQw3aR3vB8XiNhhSTUgirGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772649; c=relaxed/simple;
	bh=Lzwh59pGqQPMSmXCnv1V9dwU7w38svkd4peyTHM+OsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEirQn2o1Noekp1qh1nN2AhHISHhKgoqQ5m+wzhusy2KHBtnNUNp9FzDJtWjCc+NvBHP9+k+DJpSmjkzA9KtcExWg8oMqmtv/WO/eWoJUfV5/XZZoH43ZxOT1XMPxuOQ/PB3MABoNmOp3ilecARNNPhKy0mXU4Dn3PJY/Sr9eWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqxpoZzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57512C2BBFC;
	Fri,  7 Jun 2024 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772648;
	bh=Lzwh59pGqQPMSmXCnv1V9dwU7w38svkd4peyTHM+OsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqxpoZzCjceNF6IHk5AADWZtZKEBqafprQcRML5t4xFHoFegD1sbOUTkcMuO8uHeF
	 FNUmQZzkRMzcvAa02447Pz9kzQjduNwDkaSNgwCs8VacZVbM5Zs04ppAbITS2DleIg
	 Trp4YY8MkZoRm1HfvCFfqDPXXu+BDN8e2hygdxtxFQJx9XDwsu7HFIwrMYtT5xyCu6
	 h49FxhVgBON1h/M7nrVfchUjYAW2ThRnH03dXTpu5znmYh1uQsbtP5AL95AHL1CE3a
	 9HnDiv79OchJuU4lebNQykIjqnYSJ3zLeQ1ilYcf3XYFlAuFRG9q0y22FmrMQTSkcE
	 I2tm6465xnRXw==
From: Christian Brauner <brauner@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>,
	ebiggers@google.com,
	krisman@suse.de
Cc: Christian Brauner <brauner@kernel.org>,
	chao@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kernel@collabora.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	adilger.kernel@dilger.ca,
	tytso@mit.edu
Subject: Re: [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
Date: Fri,  7 Jun 2024 17:03:59 +0200
Message-ID: <20240607-erziehen-akustik-2600424fea81@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=brauner@kernel.org; h=from:subject:message-id; bh=Lzwh59pGqQPMSmXCnv1V9dwU7w38svkd4peyTHM+OsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQlKyZsql/6SWGLrCefUcj3eZJTpWUOp/A/n/P62dxHu 19KTOLI7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIz1WGf/osalvuLyrme8bg tIZzhW8eP4fDq/b0rmXv8n2E9WKUnzAyNPstaJNK+JcpysxrLZYz8//FPXH+N20dVx0uPlq8q3M 9AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Jun 2024 10:33:46 +0300, Eugen Hristev wrote:
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v18.
> 
> Changes in v18:
> - in patch 2/7 removed the check for folded_name->len
> - in patch 4/7 simplified the use of generic_ci_match
> 
> [...]

Applied to the vfs.casefold branch of the vfs/vfs.git tree.
Patches in the vfs.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.casefold

[1/7] ext4: Simplify the handling of cached casefolded names
      https://git.kernel.org/vfs/vfs/c/f776f02a2c96
[2/7] f2fs: Simplify the handling of cached casefolded names
      https://git.kernel.org/vfs/vfs/c/632f4054b229
[3/7] libfs: Introduce case-insensitive string comparison helper
      https://git.kernel.org/vfs/vfs/c/6a79a4e187bd
[4/7] ext4: Reuse generic_ci_match for ci comparisons
      https://git.kernel.org/vfs/vfs/c/d76b92f61f3b
[5/7] f2fs: Reuse generic_ci_match for ci comparisons
      https://git.kernel.org/vfs/vfs/c/d66858eb0c72
[6/7] ext4: Move CONFIG_UNICODE defguards into the code flow
      https://git.kernel.org/vfs/vfs/c/d98c822232f8
[7/7] f2fs: Move CONFIG_UNICODE defguards into the code flow
      https://git.kernel.org/vfs/vfs/c/28add38d545f


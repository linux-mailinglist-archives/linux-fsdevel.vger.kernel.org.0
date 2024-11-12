Return-Path: <linux-fsdevel+bounces-34454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC69C5BF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944E1B611C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432AE167D83;
	Tue, 12 Nov 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAgJux5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C493143736;
	Tue, 12 Nov 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418772; cv=none; b=BeH8xUl24OW2GFIbuUF0l1teR9BLTMmpOYymU1JD0ZkFABxqmIIMt8q+4JSaHoZFEvH/QCpLvWNCGrxAZ4gqGaWCyI7iBVl9q6wuBmAv8lytHSwcyocUzPzBqolbiYL/aiF90NMGPV6pryNhPHhtAHiHvkKGKXTvazaX7+ON8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418772; c=relaxed/simple;
	bh=bG++P6YTndM6Oq13+GniO3tcZGi4NAOAiRA9v3JLvPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDhYWscyJnBDvyGZZzJpGnd7ylYzkY78Ix4zGZF5TjAy3TTJQn3F58vUxstBRRX6dtvW36+bNikRgLPVGA0xascDSBCXxkjbUDYTDvZZZSFqLh4Zfq3YPUA/WEYYnGwDuH8mLoreSmKx7QtSbyptq/oNFAMbKMX6av0ebezm5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAgJux5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3260C4CECD;
	Tue, 12 Nov 2024 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418772;
	bh=bG++P6YTndM6Oq13+GniO3tcZGi4NAOAiRA9v3JLvPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAgJux5MBbkuO3UAHsragB93KtVH4746+HzjwSTXlyzYfWwnO7r48PSHSopalXI2h
	 WLMbB3YPqY9UQagcXPAPLiogA0RTBHZHAIk+6lzemJTv6yHjMPGMpAe0aMUb5sA78K
	 FbQQg4BuZYPN+K20g2qxEaNCoxgA+PZ+bV29YdnFwVazJTPSkBdmWnciNW48u7YSji
	 JmDiPhggvMNGYcM1dSJJETHneEK4z8HXXqNHH0t6xHRxtgObLhMYyLyyVte+1fTJ8s
	 JuhAAauh2xCCRBlaTKU/STMz3tNcYtJWx+BNpiLVpr3Ne8Z1gIwBzBV0wpBHColvMd
	 3M7IAwrITvB3g==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ian Kent <raven@themaw.net>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
Date: Tue, 12 Nov 2024 14:39:21 +0100
Message-ID: <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=brauner@kernel.org; h=from:subject:message-id; bh=bG++P6YTndM6Oq13+GniO3tcZGi4NAOAiRA9v3JLvPM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbR/X4xQj8q3Su3p/5a1olf1zb4sj7EkZCfs1Wq9QSD 3f/z7zUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBF/H0aG7p1pr0sX5rhc3xW0 a0pnmcgk5/jl87P2dnfsbDzL9vdZKiPDc8kD/+a1v97eqcO//Of921+myMev3FFg96Ww68aDVxW yrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 10:09:54 -0500, Jeff Layton wrote:
> Meta has some internal logging that scrapes /proc/self/mountinfo today.
> I'd like to convert it to use listmount()/statmount(), so we can do a
> better job of monitoring with containers. We're missing some fields
> though. This patchset adds them.
> 
> 

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

[1/3] fs: don't let statmount return empty strings
      https://git.kernel.org/vfs/vfs/c/75ead69a7173
[2/3] fs: add the ability for statmount() to report the fs_subtype
      https://git.kernel.org/vfs/vfs/c/ed9d95f691c2
[3/3] fs: add the ability for statmount() to report the sb_source
      https://git.kernel.org/vfs/vfs/c/d31cea0ab403


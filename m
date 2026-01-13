Return-Path: <linux-fsdevel+bounces-73392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916AD176A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B16B3008154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2D37FF5D;
	Tue, 13 Jan 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EilG7YmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C21F3B87;
	Tue, 13 Jan 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294590; cv=none; b=hg4bQ3qw0LE8byE16q8gSwLebBcS6RwVTRdAvtf2VIqz4BF2BX5fQ6jMOtPWAjlqzmDDNuHn4VfWL8CGhC37WPEjl8Mm1+OJgmvCEYZT7NwFqWpigAip3HOl7VcntWrVztg0ELpYoWdTAcVK4R1PnbSftITUUnAJmL4qEGzjQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294590; c=relaxed/simple;
	bh=B64P/qB/7IkbfSBNLxWQc7ldjiDE6wn5TC1lDSe0uNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl1qSWtBvrTTgZzqDlChyOUBohjpIEipcA9npTOj2/0Ys6rIUMz/xfwSiilSMRn4dmjhwtNkYMQMathnwUfCaaTlyk+qtW+MKrAvtj6bDY35hctSKKGGPVdNiL2gqksW3EgMpJ5fnQ1TcIJ3Cz3H+E0rotKia5maA23ulw0eueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EilG7YmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0E5C116C6;
	Tue, 13 Jan 2026 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294589;
	bh=B64P/qB/7IkbfSBNLxWQc7ldjiDE6wn5TC1lDSe0uNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EilG7YmIIiXyrzlfKrXo6BdVo+ORsqpFKPdKF3aIaHMlcYl4AaugnYE92AczJ1nnE
	 KyBLwjAQxQd1ivNy85fXXlrgR8gx6lazGdH50GC8xJ9y6VBwPHgC1Tf/EulZPp4jwf
	 qQkm1TBflUKnLr6dsZ9CeqZjfJqD4G4nLNJVykTCshKfdPhftjAixv9jlVd/nAOpXg
	 7JfL6sykme/TNTBI5axCUvzIlSmcaCsqLdyxc8ufyT15WYNedWeOu72RP3cmm9KD38
	 imi3WNSqOCT/vW9XqUpqCrsuhXAO+QSuIBB3oPzAj83B2bHjUYdN872K3/w4u6bCnK
	 oSUPB0OewLoVA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: add setlease file operation
Date: Tue, 13 Jan 2026 09:56:23 +0100
Message-ID: <20260113-sprudeln-stornieren-5498b93e01d8@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112130121.25965-1-jlayton@kernel.org>
References: <20260112130121.25965-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=brauner@kernel.org; h=from:subject:message-id; bh=B64P/qB/7IkbfSBNLxWQc7ldjiDE6wn5TC1lDSe0uNU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmcezoVArMPL+jdWFov6G1x4wSTVmf23ZOhYtEWnJSv 865IGvbUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGmP4wMt3IXrF6n+Pe31CHm 2ewxP4RfavkuOtwplat27sb93PY30Qz/dDa+4hczChTbMH395ZTtVZts5As/a8/nbFnCc7zm1od MZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 08:01:21 -0500, Jeff Layton wrote:
> Add the setlease file_operation to fuse_file_operations, pointing to
> generic_setlease.  A future patch will change the default behavior to
> reject lease attempts with -EINVAL when there is no setlease file
> operation defined. Add generic_setlease to retain the ability to set
> leases on this filesystem.
> 
> 
> [...]

Applied to the vfs-7.0.leases branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.leases branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.leases

[1/1] fuse: add setlease file operation
      https://git.kernel.org/vfs/vfs/c/056a96e65f3e


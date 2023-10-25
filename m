Return-Path: <linux-fsdevel+bounces-1162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDD7D6D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B5281C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377C28699;
	Wed, 25 Oct 2023 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN/d/5Xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655F2D61E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406DEC433C7;
	Wed, 25 Oct 2023 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698240731;
	bh=pB1CVc+a7KCJItdLWoIFwMW3uBM8nk4RJurUO/3u5Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN/d/5XwhcqVsoQFJ91i+2gstiCEF4WvLxgxbwTyTWd3CloGBAbG5v5rafINczjtW
	 hgZA6195oGvjn9eVztniZgrgcjJjPU/5sURSPilzNx2OjtNuweoKs9hsvD1zg3x4UA
	 Hv5XVGtNmPjdSnlztlYIn1p+jAFGQ7gjcWdcnaJYkitmZudU9BaVxXlkGD6sFyN5+5
	 fN7diBBK+lLUyaCbNStNx1EzqaER0bn0Fdd7a/aukhUAQ080RkhuPl5f0MjsyPsD1C
	 c2/Y5vGMblmh87fzAMHOHHzm4UKdg8N453f8XhXiVgu7oyfGPiJTMw/1fKHgj0VGA0
	 AX8T1/tQ8y86Q==
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	viro@zeniv.linux.org.uk,
	tytso@mit.edu,
	ebiggers@kernel.org,
	jaegeuk@kernel.org
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Date: Wed, 25 Oct 2023 15:32:02 +0200
Message-Id: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
References: <20230816050803.15660-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=brauner@kernel.org; h=from:subject:message-id; bh=pB1CVc+a7KCJItdLWoIFwMW3uBM8nk4RJurUO/3u5Fs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRaSpxNPW+UduvZZPPEvCMuKy+sN0u/Ortx6934rEXZLX9O ax4S7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIaxgjw9Er1SsOZn765x2vrVyZ9r n9Yk9q3T/f50e2l9os1n7L+oKRYfaZysq6TtEDlVduM3M+tZusema35uKis39tEpiXudw9zwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Aug 2023 01:07:54 -0400, Gabriel Krisman Bertazi wrote:
> This is v6 of the negative dentry on case-insensitive directories.
> Thanks Eric for the review of the last iteration.  This version
> drops the patch to expose the helper to check casefolding directories,
> since it is not necessary in ecryptfs and it might be going away.  It
> also addresses some documentation details, fix a build bot error and
> simplifies the commit messages.  See the changelog in each patch for
> more details.
> 
> [...]

Ok, let's put it into -next so it sees some testing.
So it's too late for v6.7. Seems we forgot about this series.
Sorry about that.

---

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

[1/9] ecryptfs: Reject casefold directory inodes
      https://git.kernel.org/vfs/vfs/c/8512e7c7e665
[2/9] 9p: Split ->weak_revalidate from ->revalidate
      https://git.kernel.org/vfs/vfs/c/17f4423cb24a
[3/9] fs: Expose name under lookup to d_revalidate hooks
      https://git.kernel.org/vfs/vfs/c/24084e50e579
[4/9] fs: Add DCACHE_CASEFOLDED_NAME flag
      https://git.kernel.org/vfs/vfs/c/2daa2df800f8
[5/9] libfs: Validate negative dentries in case-insensitive directories
      https://git.kernel.org/vfs/vfs/c/8d879ccaf0f7
[6/9] libfs: Chain encryption checks after case-insensitive revalidation
      https://git.kernel.org/vfs/vfs/c/314e925d5a2c
[7/9] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
      https://git.kernel.org/vfs/vfs/c/07f820b77c58
[8/9] ext4: Enable negative dentries on case-insensitive lookup
      https://git.kernel.org/vfs/vfs/c/2562ec77f11e
[9/9] f2fs: Enable negative dentries on case-insensitive lookup
      https://git.kernel.org/vfs/vfs/c/39d2dd36a065


Return-Path: <linux-fsdevel+bounces-68356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3112C5A28D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213164EECA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E983233EA;
	Thu, 13 Nov 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHt3JowK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12A2F5A05;
	Thu, 13 Nov 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069530; cv=none; b=klEYvo/wmhZOTVMBnzDPSrIWB11cLsorfLMGmWnnD/sVBOyTFUFeOboFXZtSmco8q7IUvT2qKDJk2HiKRHyLZd54PldkZBUqPtLe4oFNQ40xhvxMDwQ8Y1lFj8X5m8SUNulMXp/lpCpI0jsAZkJxZ0WRBHHuUSWlByFHkAW18yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069530; c=relaxed/simple;
	bh=t3dUhtw0x8C1Y6gxyv0dOMF/AK0TwWQn03AY1ZyQPIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mw4KJGOkYnIfLRRogNKLbAaaCYLufg0Axh51lyUN18kNHMRU39UhnW73/9Tw1CO5BYSWx98St9O6TgatG3Wpb5E2QB9jPqkuyabWywENz76T0yHLe/DSpIBKsuRsQROwJk15J3HFGNGmkpEYdfQ8KYxTz4ENFycoDl4Uhx74rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHt3JowK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EF2C4AF09;
	Thu, 13 Nov 2025 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069530;
	bh=t3dUhtw0x8C1Y6gxyv0dOMF/AK0TwWQn03AY1ZyQPIA=;
	h=From:Subject:Date:To:Cc:From;
	b=rHt3JowKryjp++1tW0PI1f2OoplVh18D74cVxox0S3EjpKDaf0LY/Ps6GKP2WPIMN
	 RnNXht/ghPEMjBQ/lSe9sOeDoJhJnTlG7C1tWP72uKbXaBT+KqffX25gaOc76uxz6/
	 leGfHwFE+fWc6Y6s6nH1ubxslULezNkHqEFFZAOD6AABUlryfg93Ly9Pqt8KmJq+u+
	 JRLaUc/FYEihCCkx6BAWSLW9oTUso5RvM6Y2H1E0WQiYY06BSjhEFl30LeZWhvDSWo
	 LfdpkBW6KKOcCvuHAWhCyNMEo/tBoBYh/sjhuk0gUANbnUnw7R8oCxzXvf6hhS24Mr
	 c6fUldodpgdQQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/42] ovl: convert to cred guard
Date: Thu, 13 Nov 2025 22:31:43 +0100
Message-Id: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9OFmkC/43OTQ7CIBCG4asY1g4B6k/rynsYFxSGlrQpZlDUm
 N5daOLCxIXLdzHPNy8WkTxGdli9GGHy0YcpR7VeMdPrqUPwNjdTQm2llArugQYIaQRDaKG7abK
 ghNW6Na2rnWb58kLo/GNRT+fcrY4ILenJ9MUqyYvDs8OLwxennPY+XgM9l3+SLMBnuvo5nSQIc
 Lqp672Te7GTxwFpwpEH6ljZTuoPRGXEiLrZCNFssRFfyDzPb9AoV+QnAQAA
X-Change-ID: 20251112-work-ovl-cred-guard-20daabcbf8fa
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t3dUhtw0x8C1Y6gxyv0dOMF/AK0TwWQn03AY1ZyQPIA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YV+1bTjfXC5TnSpyusN4tMdTy5jvXNY0MD1/rwLC
 3gWloVUd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEyJbhD6eC4KVuMzbJhf1x
 RTPNxD9OvqeYknfldUyIsdf1B98eiDP8D/SftMirpCfo/7r92U2XC/8895to1tBfYGf/5efp6f+
 MeAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds an overlayfs specific extension of the cred guard
infrastructure I introduced. This allows all of overlayfs to be ported
to cred guards. I refactored a few functions to reduce the scope of the
cred guard. I think this is beneficial as it's visually very easy to
grasp the scope in one go. Lightly tested.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Drop assert.
- Fix ovl_rename() refactoring and split into two.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://patch.msgid.link/20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org

Changes in v2:
- Fixed ovl_lookup() refactoring.
- Various other fixes.
- Added vfs debug assert to detect double credential overrides.
- Link to v1: https://patch.msgid.link/20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org

---
Amir Goldstein (1):
      ovl: refactor ovl_iterate() and port to cred guard

Christian Brauner (41):
      ovl: add override_creds cleanup guard extension for overlayfs
      ovl: port ovl_copy_up_flags() to cred guards
      ovl: port ovl_create_or_link() to cred guard
      ovl: port ovl_set_link_redirect() to cred guard
      ovl: port ovl_do_remove() to cred guard
      ovl: port ovl_create_tmpfile() to cred guard
      ovl: port ovl_open_realfile() to cred guard
      ovl: port ovl_llseek() to cred guard
      ovl: port ovl_fsync() to cred guard
      ovl: port ovl_fallocate() to cred guard
      ovl: port ovl_fadvise() to cred guard
      ovl: port ovl_flush() to cred guard
      ovl: port ovl_setattr() to cred guard
      ovl: port ovl_getattr() to cred guard
      ovl: port ovl_permission() to cred guard
      ovl: port ovl_get_link() to cred guard
      ovl: port do_ovl_get_acl() to cred guard
      ovl: port ovl_set_or_remove_acl() to cred guard
      ovl: port ovl_fiemap() to cred guard
      ovl: port ovl_fileattr_set() to cred guard
      ovl: port ovl_fileattr_get() to cred guard
      ovl: port ovl_maybe_validate_verity() to cred guard
      ovl: port ovl_maybe_lookup_lowerdata() to cred guard
      ovl: don't override credentials for ovl_check_whiteouts()
      ovl: port ovl_dir_llseek() to cred guard
      ovl: port ovl_check_empty_dir() to cred guard
      ovl: port ovl_nlink_start() to cred guard
      ovl: port ovl_nlink_end() to cred guard
      ovl: port ovl_xattr_set() to cred guard
      ovl: port ovl_xattr_get() to cred guard
      ovl: port ovl_listxattr() to cred guard
      ovl: introduce struct ovl_renamedata
      ovl: extract do_ovl_rename() helper function
      ovl: port ovl_rename() to cred guard
      ovl: port ovl_copyfile() to cred guard
      ovl: refactor ovl_lookup()
      ovl: port ovl_lookup() to cred guard
      ovl: port ovl_lower_positive() to cred guard
      ovl: refactor ovl_fill_super()
      ovl: port ovl_fill_super() to cred guard
      ovl: remove ovl_revert_creds()

 fs/overlayfs/copy_up.c   |   6 +-
 fs/overlayfs/dir.c       | 439 +++++++++++++++++++++++------------------------
 fs/overlayfs/file.c      | 101 +++++------
 fs/overlayfs/inode.c     | 120 ++++++-------
 fs/overlayfs/namei.c     | 402 +++++++++++++++++++++----------------------
 fs/overlayfs/overlayfs.h |   6 +-
 fs/overlayfs/readdir.c   |  86 ++++------
 fs/overlayfs/super.c     |  89 +++++-----
 fs/overlayfs/util.c      |  18 +-
 fs/overlayfs/xattrs.c    |  35 ++--
 10 files changed, 615 insertions(+), 687 deletions(-)
---
base-commit: 2902367e352af16cbed9c67ca9022b52a0b738e7
change-id: 20251112-work-ovl-cred-guard-20daabcbf8fa



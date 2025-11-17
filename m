Return-Path: <linux-fsdevel+bounces-68643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6689AC63382
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7093C4F165C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D2326D75;
	Mon, 17 Nov 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECUhSM5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDA260580;
	Mon, 17 Nov 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372025; cv=none; b=tspLUgiZVXR1aTynpbP+ahhF28AnysIJdvpSbahP0I5T5S+0xcFsBQFwp+2UMwZAqg+pFnF9CzuWCLAztnkI99rXN314slRaD41vZVg5NyK925C0Pyjo3L3WB/jPJOvwZQkzBiV1oQo1PigNVPlzrEQktLwbPxK/Eb3yeeiPt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372025; c=relaxed/simple;
	bh=v/MCX6SACCXaGPNp85cuL7jwk2NjXwfiTy4Zb20TLRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PuAULKOz56lKBGvu2bE3U8u0IEs2KcBbbKIYbrF0rpJMC/j4rUl15qq3bN/AyuVXCwRYhvoIzGiIsAXcqwp7i+8dflaAXoegymAKVSBSv2gSLweqADnaeEvkh8BP8018RGRV2HxIMEPNay9U0fOY6/wLxZm9bUzWOLQt9WkJuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECUhSM5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8F9C19425;
	Mon, 17 Nov 2025 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372024;
	bh=v/MCX6SACCXaGPNp85cuL7jwk2NjXwfiTy4Zb20TLRo=;
	h=From:Subject:Date:To:Cc:From;
	b=ECUhSM5GYbfE9Ry09cqlAxzqb4EbUQxtpd3kScpNaqqsor5n+Jc/bzf+EQdIfwTws
	 NiI+BrWazAUlMSUIvztSZptjKrLtpC0e0tnuPiOJvhlFVKuKNfSzf30JHs3cCMbC8M
	 hdfR7jcrjFfUsJjJPZU231w3hGdt+yuKK6AJ6vb8uW697PBlk7NUSB6hNA8JFzSeWR
	 fGxOJ5m8Rp9QvKpv6ho5mTgM1vLkRQDkAZKAadMODdV83Oc4g1IdGyPu3gCVw/UM72
	 bCdkWTFXOj0Z9kc/aqtH6ypUgTKvCdzEJJp36fHm1QBOvOqVqj2MmU9cqNItKL3SgV
	 aNh0cvUZNtp2A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 00/42] ovl: convert to cred guard
Date: Mon, 17 Nov 2025 10:33:31 +0100
Message-Id: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvrGmkC/43OvW4DIRAE4FexqLOIH18MrvweUQrgljtk67CWh
 CSy7t0DJ7mwksLlFPPN3FhBSljYcXdjhDWVlJcW9i87Fma3TAhpbJkpoQYppYKvTGfI9QKBcIT
 p09EISozO+eCjiY615pUwpu9NfXtv2buC4MktYe5Wj7w7vDm8O3xzenVO5SPTz/anyg7cp/W/0
 1WCgOisMYcoD+JVns5IC154pon17aqeQFRDgjB2L4Qd0Io/iH4C0Q3xesBgjcYYHp+s6/oLW1n
 WV2wBAAA=
X-Change-ID: 20251112-work-ovl-cred-guard-20daabcbf8fa
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v/MCX6SACCXaGPNp85cuL7jwk2NjXwfiTy4Zb20TLRo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6iPLk/Rsrg49fPobO6m7fOma3VzteW235i9+erh
 vaPxRZd7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIbAojQx/n3M4Dz1teX9zn
 LipVa2Ayp2F7RXPR0qkTGL72fNlcWsfI0KEfdtkgy+3BFy/evk9Pni94umhNTknTi+sXLHhTG9v
 8mAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds an overlayfs specific extension of the cred guard
infrastructure I introduced. This allows all of overlayfs to be ported
to cred guards. I refactored a few functions to reduce the scope of the
cred guard. I think this is beneficial as it's visually very easy to
grasp the scope in one go. Lightly tested.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v4:
- Bring in Amir's rename refactor updates
- Reflow ovl_iterate() according to review.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://patch.msgid.link/20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org

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
Christian Brauner (42):
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
      ovl: refactor ovl_iterate() and port to cred guard
      ovl: port ovl_dir_llseek() to cred guard
      ovl: port ovl_check_empty_dir() to cred guard
      ovl: port ovl_nlink_start() to cred guard
      ovl: port ovl_nlink_end() to cred guard
      ovl: port ovl_xattr_set() to cred guard
      ovl: port ovl_xattr_get() to cred guard
      ovl: port ovl_listxattr() to cred guard
      ovl: introduce struct ovl_renamedata
      ovl: refactor ovl_rename()
      ovl: port ovl_rename() to cred guard
      ovl: port ovl_copyfile() to cred guard
      ovl: refactor ovl_lookup()
      ovl: port ovl_lookup() to cred guard
      ovl: port ovl_lower_positive() to cred guard
      ovl: refactor ovl_fill_super()
      ovl: port ovl_fill_super() to cred guard
      ovl: remove ovl_revert_creds()

 fs/overlayfs/copy_up.c   |   6 +-
 fs/overlayfs/dir.c       | 380 ++++++++++++++++++++++----------------------
 fs/overlayfs/file.c      | 101 ++++++------
 fs/overlayfs/inode.c     | 120 ++++++--------
 fs/overlayfs/namei.c     | 402 +++++++++++++++++++++++------------------------
 fs/overlayfs/overlayfs.h |   6 +-
 fs/overlayfs/readdir.c   | 100 ++++++------
 fs/overlayfs/super.c     |  89 ++++++-----
 fs/overlayfs/util.c      |  18 +--
 fs/overlayfs/xattrs.c    |  35 ++---
 10 files changed, 606 insertions(+), 651 deletions(-)
---
base-commit: 2902367e352af16cbed9c67ca9022b52a0b738e7
change-id: 20251112-work-ovl-cred-guard-20daabcbf8fa



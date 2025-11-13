Return-Path: <linux-fsdevel+bounces-68293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC4C591C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639914FBAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED92FB085;
	Thu, 13 Nov 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/BBnnxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301C23F294;
	Thu, 13 Nov 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051850; cv=none; b=BI3IVpOwNbuUCn4unVdfTYPn6u4fAvseWRlRaVbXH2eb1ukhaJNGQZrdVYtpImy/juTKPPrwHXClsLT4/7ezZrBmxyMEdkIgj+xdRVL7j68R1RfdA4bgmi+NmMIP1gvNVo6gj9pjd4t9Y+mxN3dVkrtNXIwmdldKfigb48bHMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051850; c=relaxed/simple;
	bh=7qni5pj9X+Ull8FPXbyQ3VGjwmr3AQDKcR5HyLnsH5c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JbNuhx4qzu3WgLeJTwRw9p34vw/DEORsK8Tt19nyGdNWPisn2FC9fXrKho8NX1P1HifML2+GiaHZdzsxZ2fE1UJiPmvcoEGPlOkvErMVO2WpCYIPIvn7et3aIRW2pbpcvQSDzZnhj+R5U88a8okOFhrpFPnF7Fa4b9Nr/X2WgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/BBnnxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B5C4CEF5;
	Thu, 13 Nov 2025 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051849;
	bh=7qni5pj9X+Ull8FPXbyQ3VGjwmr3AQDKcR5HyLnsH5c=;
	h=From:Subject:Date:To:Cc:From;
	b=K/BBnnxkbxSQ3qmw7L0lU6vMAfBRvNmpTZ9RalhAvGc6v9sZL2ARek+4WYd7JKRQ2
	 3SzUNZ6cg2li9I/HKLldP7/JS7PGxIwN0KXC22uhZufzQNlRcfza1fTToAwL2bIjWP
	 s60B7Wo4aEZiHL1A2xd+fgZawDY0Yrk4M+XEksUPbGdfcvVAdi2XFYdw4NMSFX++xh
	 PNXQ3ykAqfeD4wUUYSccqLen5HsAtq8Abj7hbCVj1ydsw3c6X2paozzqR1P1XnSD0A
	 Let7MbBFPm4vlpTxQdFEEf8PERlnuCm7IA4wumn5+wNJlBG9VjdFm7qvK60/Dsreym
	 WrzUY8hiabdIQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/42] ovl: convert to cred guard
Date: Thu, 13 Nov 2025 17:37:05 +0100
Message-Id: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADEJFmkC/23OTQ7CIBCG4asY1g4BjLa68h6mC36GlrQpZlDUN
 L270MSdy3cxzzcLS0gBE7vsFkaYQwpxLqH2O2YHPfcIwZVmSqijlFLBK9IIMU9gCR30T00OlHB
 aG2t86zUrl3dCH96beutKG50QDOnZDtWqyavDi8Orwzenng4hPSJ9tn+yrMBv+vB3OksQ4PW5b
 RsvG3GS1xFpxolH6lm3rusXyRCKWuIAAAA=
X-Change-ID: 20251112-work-ovl-cred-guard-20daabcbf8fa
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7qni5pj9X+Ull8FPXbyQ3VGjwmr3AQDKcR5HyLnsH5c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbp2uU5tvBu8dZ+D5uMpU2b9+XNHcs7355UJv1tVq
 xnMHbSdOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyl5XhN0utpJ7gs8XBvH+i
 pm99WfbkvZzQY6E9QmsEZicrR/8yPsnwz+D0tqaj4TmhfrqB1xRrE9eyGt249FH9uHD11Eexf0q
 tOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds an overlayfs specific extension of the cred guard
infrastructure I introduced. This allows all of overlayfs to be ported
to cred guards. I refactored a few functions to reduce the scope of the
cred guard. I think this is beneficial as it's visually very easy to
grasp the scope in one go. Lightly tested.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
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
      ovl: refactor ovl_rename()
      ovl: port ovl_rename() to cred guard
      ovl: port ovl_copyfile() to cred guard
      ovl: refactor ovl_lookup()
      ovl: port ovl_lookup() to cred guard
      ovl: port ovl_lower_positive() to cred guard
      ovl: refactor ovl_fill_super()
      ovl: port ovl_fill_super() to cred guard
      ovl: remove ovl_revert_creds()
      ovl: detect double credential overrides

 fs/overlayfs/copy_up.c   |   6 +-
 fs/overlayfs/dir.c       | 427 +++++++++++++++++++++++------------------------
 fs/overlayfs/file.c      | 101 +++++------
 fs/overlayfs/inode.c     | 120 ++++++-------
 fs/overlayfs/namei.c     | 402 ++++++++++++++++++++++----------------------
 fs/overlayfs/overlayfs.h |   6 +-
 fs/overlayfs/readdir.c   |  86 ++++------
 fs/overlayfs/super.c     |  89 +++++-----
 fs/overlayfs/util.c      |  20 +--
 fs/overlayfs/xattrs.c    |  35 ++--
 10 files changed, 611 insertions(+), 681 deletions(-)
---
base-commit: 2902367e352af16cbed9c67ca9022b52a0b738e7
change-id: 20251112-work-ovl-cred-guard-20daabcbf8fa



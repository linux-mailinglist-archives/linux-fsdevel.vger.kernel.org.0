Return-Path: <linux-fsdevel+bounces-68217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 862ADC57875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04CBB354EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BA35294B;
	Thu, 13 Nov 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1i+3NjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F5350A17;
	Thu, 13 Nov 2025 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038951; cv=none; b=EdZCv9TYAJgzwpoQNejIjAP2fP5rruO7DbRo/SomDLmBR3o9sfmVLPtLt/MQSc0xKzwoK3DZOdsd/9VgqWeCAlclxSy9gtlFOdI4TppErFsXqiOC3NO9wKqJYxsEbkqRXq8bv+PofVe2G793HNQBXaBZIPeJxZHSarlTQtE35Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038951; c=relaxed/simple;
	bh=1bIPLOu9SpcrvKh7u3lpJVIX0GwR2g3xykgdCzirms8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZXSj3HdRe/bQ6QDq2YrahLWzGxUFQg7wYk2AL8NSlbC84ORbsBlkNCyILy/Q/f8CAhZExoRD6XI0lsSzMM5cv8fh7wYufvdFQizMTpIJovdriCJ/V4jzmDAm44+NMP0Jjdu25uiFXgUf2kzMr+z4G7v6bUALs1JsWrUK3xIpBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1i+3NjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD10C116D0;
	Thu, 13 Nov 2025 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038950;
	bh=1bIPLOu9SpcrvKh7u3lpJVIX0GwR2g3xykgdCzirms8=;
	h=From:Subject:Date:To:Cc:From;
	b=K1i+3NjCjPG3ez7MeD9opBXqAx0WMYm0jpBj0+7E+f3+X+1DeJ/nLDCc70sja2r0J
	 Aj3vA2BfZnxxQfjAw4VNQ87/rTFV7drVQx9lYKGEioWBgAH/0+d2MLTEs+5LDyl8Zx
	 w8rcLEEnoGnnkyBQiS1bq59pa7viYEbNumwy5vNvNyqqK2S//udD/k55WghKYviiuF
	 1jr+iGTQ4nBC6lKrRWcN9XuekdnnZSEnGELyLmiKVaCgjH71yQOoVP/eAMwLvRVXnj
	 Yc/PaAbld2wuUsB+Wqyi8CghVlpp39Rc2zX07sCBWPq9csH7hqGY/jg8iNhOlszyaZ
	 3gLEhKc0KYIsg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/42] ovl: convert to cred guard
Date: Thu, 13 Nov 2025 14:01:20 +0100
Message-Id: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHWFWkC/x3MQQrCMBCF4auUWTuhCQjiVvAAbsXFJJm0QUlkg
 lUovbuTLv8H71uhsWRucB5WEF5yy7Vo2MMAYaYyMeaoDW50R2utw2+VJ9blhUE44vQhiejGSOS
 DT6dEoM+3cMq/Xb3D7XqBh46eGqMXKmHuYE/TMaOY6ZjZMdi2PyuTVy2VAAAA
X-Change-ID: 20251112-work-ovl-cred-guard-20daabcbf8fa
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1bIPLOu9SpcrvKh7u3lpJVIX0GwR2g3xykgdCzirms8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuU76yU+q7e6pql7tOX11+L8O3hW50rnPCMg+vT6
 6xDvQE8HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZfJyRYbtUu3mJxfUgxSd8
 K+U9pvR6rvPgFGc9Mic8mUtl6tspHxgZPvS/+Swva/3zF8uZHNOzPw/d6985SS1d8ZTHZ2/zy5O
 SGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds a overlayfs extension of the cred guard infrastructure I
introduced. This allows all of overlayfs to be ported to cred guards.
I refactored a few functions to reduce the scope of the credguard. I
think this is pretty beneficial as it's visually very easy to grasp the
scope in one go. Lightly tested.

Signed-off-by: Christian Brauner <brauner@kernel.org>
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
      ovl: return directly
      ovl: port ovl_permission() to cred guard
      ovl: port ovl_get_link() to cred guard
      ovl: port do_ovl_get_acl() to cred guard
      ovl: port ovl_set_or_remove_acl() to cred guard
      ovl: port ovl_fiemap() to cred guard
      ovl: port ovl_fileattr_set() to cred guard
      ovl: port ovl_fileattr_get() to cred guard
      ovl: port ovl_maybe_validate_verity() to cred guard
      ovl: port ovl_maybe_lookup_lowerdata() to cred guard
      ovl: port ovl_check_whiteout() to cred guard
      ovl: port ovl_iterate() to cred guard
      ovl: port ovl_dir_llseek() to cred guard
      ovl: port ovl_check_empty_dir() to cred guard
      ovl: port ovl_nlink_start() to cred guard
      ovl: port ovl_nlink_end() to cred guard
      ovl: port ovl_xattr_set() to cred guard
      ovl: port ovl_xattr_set() to cred guard
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

 fs/overlayfs/copy_up.c   |   6 +-
 fs/overlayfs/dir.c       | 426 +++++++++++++++++++++++------------------------
 fs/overlayfs/file.c      | 101 +++++------
 fs/overlayfs/inode.c     | 120 ++++++-------
 fs/overlayfs/namei.c     | 403 ++++++++++++++++++++++----------------------
 fs/overlayfs/overlayfs.h |   6 +-
 fs/overlayfs/readdir.c   | 131 +++++++--------
 fs/overlayfs/super.c     | 115 ++++++-------
 fs/overlayfs/util.c      |  18 +-
 fs/overlayfs/xattrs.c    |  35 ++--
 10 files changed, 643 insertions(+), 718 deletions(-)
---
base-commit: 2902367e352af16cbed9c67ca9022b52a0b738e7
change-id: 20251112-work-ovl-cred-guard-20daabcbf8fa



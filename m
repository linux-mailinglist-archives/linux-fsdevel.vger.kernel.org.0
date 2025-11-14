Return-Path: <linux-fsdevel+bounces-68548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22006C5F864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0452D4E224A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE722DC34E;
	Fri, 14 Nov 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsAWWxkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1969224D6;
	Fri, 14 Nov 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160330; cv=none; b=miOTjgnAOYL/ze+9eOO26XVLPnyxpnCuQcpBRtUr84eJJQWApJkzsR79DGxsW4XsQ55EIiStwBOl2c7uUW3y5f2JKE+RPSGwVYFOCi8Mv0O+l0VneosvTvHEzAUrtmG1PeML+n8Y8M4SV9IFsl9UU19uuzayS9whjQblplCuYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160330; c=relaxed/simple;
	bh=B5lYKr9+wiCQx3OHEreiZNRmynpqI86x2A1RYVAnPKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jqSxziPd5FV75dFPpiFKcxydy648jFfXnLD4+nQWqaVs4TDpfqkt/rq2JkP+RKCme7eK393qFuZwKsp3MRbZ90Rta/1MHfbBhbxCHzWSZoiyvVrpPVEErPk9bBvqlRxHkZkAD6Zxb+/7gNbKZUbweQXx8jgelu1P0B3c3AxZdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsAWWxkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07834C116D0;
	Fri, 14 Nov 2025 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160330;
	bh=B5lYKr9+wiCQx3OHEreiZNRmynpqI86x2A1RYVAnPKE=;
	h=From:Subject:Date:To:Cc:From;
	b=RsAWWxkpZS+klqdmXVrqqpIkfD9ci3G2sgT4bWsL4z/uEgg9BqD2SzqQFLquNbZSJ
	 qL4NzKHytNz7mPPCNKDyA8Vf6TCnjfcDN5tfPCqTvji7yOwRy6uKgxjv7yePr/KgEH
	 NVc4yReFdENVHdtMX1AKd+GXDBaz0rfOSwkK0DmvcrzyUYNOXqJr0yBMlZU7wSfnSy
	 skZsfrosbaJCRn8gh+Ynnq6BG7WV05Wwr5X6pBGYnR7EP75CHf4Txj1dDJKOD58BJb
	 hEXEIa1UoHjrUsAsFAz7KLNOUyvO2n9OCrs3Mg6QRN2UssXCrmxbI/I7ZrZg2O6vaI
	 VtbKBAjqDG3Dg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] ovl: convert copyup credential override to cred guard
Date: Fri, 14 Nov 2025 23:45:21 +0100
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGxF2kC/yXMSw6CMBAA0KuQWTsN5WOMVzEuSjtAo2mbaUAN4
 e5Mcfk2b4NM7CnDvdqAafXZxyDQlwrsbMJE6J0YmrrptdYdfiK/MK5vtEwOp8WwQxvTb0lIuqX
 WXanubyNIkJhG/z3zx1M8mEw4sAl2LmWhKp2STpVOnZ36d7DvB11BXHieAAAA
X-Change-ID: 20251114-work-ovl-cred-guard-copyup-e13e3d6e058f
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B5lYKr9+wiCQx3OHEreiZNRmynpqI86x2A1RYVAnPKE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkXsQigadN24cDLqT0l5lAaty/RmX+DyYgqJUbQkk8X6mODX
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkXsQgACgkQkcYbwGV43KKGmgEA3MuR
 0rsJUx/UWND1mdyh9X3//mMPNmeyZHA+E9JxFTMA/3lO641WDcnMSNaIh2TPn0dRBLyWoD8RWbo
 QcPos4EYG
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is on top of the other overlayfs cleanup guard work I already sent
out. This simplifies the copyup specific credential override.

The current code is centered around a helper struct ovl_cu_creds and is
a bit convoluted. We can simplify this by using a cred guard. This will
also allow us to remove the helper struct and associated functions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (5):
      ovl: add copy up credential guard
      ovl: port ovl_copy_up_workdir() to cred guard
      ovl: mark *_cu_creds() as unused temporarily
      ovl: port ovl_copy_up_tmpfile() to cred guard
      ovl: remove struct ovl_cu_creds and associated functions

 fs/overlayfs/copy_up.c | 64 ++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)
---
base-commit: bc452b620b01ca11d050b4219ee8a894e55a633b
change-id: 20251114-work-ovl-cred-guard-copyup-e13e3d6e058f



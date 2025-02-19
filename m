Return-Path: <linux-fsdevel+bounces-42048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33881A3BB0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A20F188C39F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD91D5ACD;
	Wed, 19 Feb 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ4gAJzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5531BEF75;
	Wed, 19 Feb 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959337; cv=none; b=TZFMqHY9ZsOa82DBKSzRECRaIWLsn7rios9HUZKj0cVxCotAZlfR2+ZX4KCl3GKfKVUMO7IlWOsXQZsii/8XbcYxV6hfmQP1Y3i8xgEDOhUiALGgvcDcWW6kYjkMb0Uii+3M0o0fRpooaoz6iNcugDf8r+kYO//AFW/kaQzh+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959337; c=relaxed/simple;
	bh=l8WjW69U7BhePUL3SbnqsroGKmyglhcniS7YuSnpAA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c8NJp8kTRCSuPvVglw110jo0o3qA/mAtlvFPScNP2TWA8FzsNxnpMS8GshKlm8Fp/QZMve32CRWmPtH4vAkCd0cAhjMhiHHqU4NR5lcpX0GKJMKMi5bW0aylxcsBEA80BiJkyxgS9z63/pluJznPd/+919hpmF5HgHP6Nev2dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ4gAJzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C1FC4CED1;
	Wed, 19 Feb 2025 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739959336;
	bh=l8WjW69U7BhePUL3SbnqsroGKmyglhcniS7YuSnpAA0=;
	h=From:Subject:Date:To:Cc:From;
	b=rQ4gAJzrX7i+h/p9alxlyRa6+35cub7g9CY+jbZn1r3F/4QOdptTe2IoxI54JPSsS
	 M9V60NyFtLRWtJZjKEBQHrg2kJWnIk1A5Wh4vaKzeknqdGcdXBUGJdhDZGENGgpQ1q
	 vpOvjR6ZtIzEVOyshwAdBY+G0mbxIW3700mbEbkOMFdoJqpDpMZI+ufRQx1tWdoXca
	 IAALWlROXJNP3qUDzZO/8Fq/lGg8lSZLfR7EkAH5GGAGB2YQzj9ZZRotlrqXN7OEzu
	 MI27+yOr24jvbv4mZ1sLOKwN0jFBr55H44Eq7WeIQlSvwnH0UblBec3e65I69n8F9V
	 aNt2OIG4riC+g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/4] ovl: add override_creds mount option
Date: Wed, 19 Feb 2025 11:01:48 +0100
Message-Id: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAystWcC/3XOTQ7CIBQE4KsY1tIU+kN15T2MCwqPlrQW82jQp
 undha40xuUsvplZiQe04Mn5sBKEYL11UwzF8UBUL6cOqNUxE57zKuespE+HA3UBcJSL8VQbZVS
 ptIBWk4geCMa+9sLrLeZWeqAtykn1qeYu/QyYhTqLVahYIr31s8NlvxBYgn/XAqM5LetKs6YWu
 tDlZQCcYMwcdiTNBf7pxY/nyTNtQAjWnOriy2/b9gYg/QAEEAEAAA==
X-Change-ID: 20250214-work-overlayfs-dfcfc4cd7ebd
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l8WjW69U7BhePUL3SbnqsroGKmyglhcniS7YuSnpAA0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRvXaN6K+OixvclvGv+u0zlXDtbqK5dKKT5JsuihXanl
 8+dmpC2t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiT1oY/grvvaY2O3KlXpqm
 WdOt2NIFzInGjUd65Z/UBXSfUIy8vYThn6ntFjXGb/8b3h23PC25U/D1hqxJzDMPPCldlz7V13K
 mAQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs uses the mounter's credentials for it's
override_creds() calls. That provides a consistent permission model.

This patches allows a caller to instruct overlayfs to use its
credentials instead. The caller must be located in the same user
namespace hierarchy as the user namespace the overlayfs instance will be
mounted in. This provides a consistent and simple security model.

With this it is possible to e.g., mount an overlayfs instance where the
mounter must have CAP_SYS_ADMIN but the credentials used for
override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
custom fs{g,u}id different from the callers and other tweaks.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Extended selftests.
- Allowed all user descendant namespaces.
- Link to v2: https://lore.kernel.org/r/20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org

Changes in v2:
- Added new section to overlayfs Documentation.
- Link to v1: https://lore.kernel.org/r/20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org

---
Christian Brauner (4):
      ovl: allow to specify override credentials
      selftests/ovl: add first selftest for "override_creds"
      selftests/ovl: add second selftest for "override_creds"
      selftests/ovl: add third selftest for "override_creds"

 Documentation/filesystems/overlayfs.rst            |  24 +-
 fs/overlayfs/params.c                              |  25 +
 fs/overlayfs/super.c                               |  16 +-
 .../selftests/filesystems/overlayfs/Makefile       |  11 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 312 ++++++++++++-
 tools/testing/selftests/filesystems/utils.c        | 501 +++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.h        |  45 ++
 7 files changed, 924 insertions(+), 10 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250214-work-overlayfs-dfcfc4cd7ebd



Return-Path: <linux-fsdevel+bounces-41392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55522A2ECA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98C0163954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9F4222577;
	Mon, 10 Feb 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CijJy3qF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1D1BE23E;
	Mon, 10 Feb 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191151; cv=none; b=Guf22+57SySPK+DJKH51TV7FmcDL6gpP/ER/o58fWK6FamgIxZouxSeLfRrdo5OTBvRQOvsYvK2RbPgzcWE2BUMhaShX1Y2Dus0zLByxnowcExAWdj3WGwNDWJ5EKkOYUMCaYOduaKKoIrbe9LHMadAGGxcpuTthAFlzjrNyKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191151; c=relaxed/simple;
	bh=XCL+HvyLM4d7o9BC3lETgD3TuRng7yro8rHN4ZTChAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AnrxK0Oxa5SFKnRGgYWB31wq9CbkUdJqXEyTNQAK/JkzPLf0adk6+WQCTytRZfNdm9KUSWvIIJW7Ii0LkgYmoOf9oWTjERhUMssW1+566gDZOWSMJ2ZuJn744VkfamecvDX+bUMJW4Ma5auCUkQS/YlyrllVu/gfDJyfG/5kAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CijJy3qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808DAC4CED1;
	Mon, 10 Feb 2025 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739191150;
	bh=XCL+HvyLM4d7o9BC3lETgD3TuRng7yro8rHN4ZTChAk=;
	h=From:Subject:Date:To:Cc:From;
	b=CijJy3qFMykan8vg9i0f6bdgsYaq0H+v1hyU6bVLUM3Y3Jv2d690WKmpFy8yVqZim
	 QR2PnKDhoQqoy5UskonQAbIMbhfO5OAakk1nZvM0GVxaVnJTUloo829q95IjiNyGi+
	 MC1Z07ytclvV5350aNm8jm/FYCGD/ZmB/O+PsSuE1FeiCbFYphtvzL3yXKGJs+55v0
	 xWOIMZFjTJkvHmvocExrZDcKjkWP4o4f11J9VICo+nD6MaMpt3AGj7dInnScNmzn/l
	 Utm3iiRP0bgw2/n4KFTMuLYhmoqfqj97i/+RRXubGjY5r/hZDyTsT2Cku4kSI75LU2
	 pBR560sb5qACg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] ovl: allow O_PATH file descriptor when specifying
 layers
Date: Mon, 10 Feb 2025 13:38:58 +0100
Message-Id: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLzqWcC/3WOyw6DIBQFf8WwLoaHQttV/6NxgXhVooXmYmiN8
 d+L7rucxcw5G4mADiK5FxtBSC664DOIS0HsaPwA1HWZiWCiZoJp+gk40ZAAZ7P2kcpr3954rbr
 KViRLb4Tefc/gs8ncmgi0RePteGReJi6AZVIlryhafiiji0vA9byQ+CH+XUucMqo4v2kFWkotH
 xOgh7kMOJBm3/cf0OPSdNAAAAA=
X-Change-ID: 20250207-work-overlayfs-38fb9156d4c4
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XCL+HvyLM4d7o9BC3lETgD3TuRng7yro8rHN4ZTChAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv/Jxz++mKSbO/XzixfLnhpKSVBk0Xpyyw13FtDN9+M
 0Xjjad9dEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjN8z/NPcFPHD5/abuct/
 nPhayxPEN+tqXPpX41ixOV+lyuY4tBxnZNj8u63WvHW9y2s5tbeCQd/0L34wEL4knPPIbdsu+Sq
 ltzwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow overlayfs to use O_PATH file descriptors when specifying layers.
Userspace must currently use non-O_PATH file desriptors which is often
pointless especially if the file descriptors have been created via
open_tree(OPEN_TREE_CLONE). This has been a frequent request and came up
again in [1].

Link: https://lore.kernel.org/r/fd8f6574-f737-4743-b220-79c815ee1554@mbaynton.com [1]

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Unconditionally enable O_PATH file descriptors.
- Link to v1: https://lore.kernel.org/r/20250207-work-overlayfs-v1-0-611976e73373@kernel.org

---
Christian Brauner (2):
      fs: support O_PATH fds with FSCONFIG_SET_FD
      selftests/overlayfs: test specifying layers as O_PATH file descriptors

 fs/autofs/autofs_i.h                               |  2 +
 fs/fsopen.c                                        |  2 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 65 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-work-overlayfs-38fb9156d4c4



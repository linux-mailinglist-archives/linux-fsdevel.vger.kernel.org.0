Return-Path: <linux-fsdevel+bounces-40764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D487DA273E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851FB188B209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA42139CB;
	Tue,  4 Feb 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJjw5MUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D3212D95;
	Tue,  4 Feb 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677090; cv=none; b=Rg0hCFc1atNeGEdK/Ve26jx/HfdrNKsbfL+8jKvVa0q/qCQKZ0rb8Pu6t3goESXe+gwI7ypcg67n3Fn68cQCw8RfcmGodWWsvAFj/HRKQ5I6qUOxJ5pG5zYsL9u/INIHG8gzphpIhyJL5RX6mwGLTIgSWPEdYc1N7wkeAT3G1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677090; c=relaxed/simple;
	bh=9P5kRjjp0wC19JDx1SirQIsNArHoZ48MbzvMnzlAk34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhfsZytGQjv93dX8K6sQLLE0bSl1w7R4Y0Yi0ghmYf0VgoT/YLIVmsSQfi+dcE3D5ZyC2D224xZPVr83n5Hs7KiaqaSSWv4BH4BdMF8kVHJmF06UIQ9NYlAyj1XOZzGoV/Pvk6J2w+3G5qfDRWPnlMLVWw4ABOzIPC9nTkZ+fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJjw5MUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D87C4CEDF;
	Tue,  4 Feb 2025 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738677090;
	bh=9P5kRjjp0wC19JDx1SirQIsNArHoZ48MbzvMnzlAk34=;
	h=From:Date:Subject:To:Cc:From;
	b=KJjw5MUlXH/vejQM2FOZZbQ5DImUPybQJQziK8JLH8rtAs0JKeviaTBRQdCZPC5Kw
	 tBb//wwbR40DKqWJtSdNvqxNWi+ZEG/WwlJs0WjGT3j4csQK5EUYrprBzBCRMFtjfA
	 ekCPPmHvsR0B0litGqVLBJIWdlMmScJFf1kdTOt48jduyKtpyq3mLXjrOrRrcucMW3
	 ioNk3cnV95XVkN2HJEobHeYI5OP1PQF4S66KRLJLi0qt1CrX+xb03Py40104bmDa6m
	 NjN77wccHmTlX4v1AyWt6Cy/2++rqbf5CMCgFmuj9+3aoTUDgam3p874CjrRhPLrb5
	 LX8HacnuaOfZw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 14:51:20 +0100
Subject: [PATCH] pidfs: improve ioctl handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFcbomcC/yXMQQrCMBCF4auUWTslRhvRq4iLJJ20g5KUGalC6
 d0b6/Lj8f4FlIRJ4dYsIDSzcskVx0MDcfR5IOS+GqyxnbHmjJ8iT5y4T4pc4vuFjtLl6l1HJxe
 g3iahxN89eX9UB6+EQXyO4y80J23/+7pupLmrbH4AAAA=
X-Change-ID: 20250204-work-pidfs-ioctl-6ef79a65e36b
To: Jann Horn <jannh@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9P5kRjjp0wC19JDx1SirQIsNArHoZ48MbzvMnzlAk34=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvkk5Yefffsec+zXuuX178wbVfu6798z5FmwXKyWk7j
 /CsOPP7ckcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBESg4wMrTMOOl2TKl8Z6Pv
 MyaeQ5p3uW39CjMYQ5sVXnmJJ1gXCDIy3PadfdGxWVbh8VxJdh9VY1P/FOXKW0eSJv669jhpOq8
 uJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pidfs supports extensible and non-extensible ioctls. The extensible
ioctls need to check for the ioctl number itself not just the ioctl
command otherwise both backward- and forward compatibility are broken.

The pidfs ioctl handler also needs to look at the type of the ioctl
command to guard against cases where "[...] a daemon receives some
random file descriptor from a (potentially less privileged) client and
expects the FD to be of some specific type, it might call ioctl() on
this FD with some type-specific command and expect the call to fail if
the FD is of the wrong type; but due to the missing type check, the
kernel instead performs some action that userspace didn't expect."
(cf. [1]]

Reported-by: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org # v6.13
Fixes: https://lore.kernel.org/r/CAG48ez2K9A5GwtgqO31u9ZL292we8ZwAA=TJwwEv7wRuJ3j4Lw@mail.gmail.com [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey,

Jann reported that the pidfs extensible ioctl checking has two issues:

(1) We check for the ioctl command, not the number breaking forward and
    backward compatibility.

(2) We don't verify the type encoded in the ioctl to guard against
    ioctl number collisions.

This adresses both.

Greg, when this patch (or a version thereof) lands upstream then it
needs to please be backported to v6.13 together with the already
upstream commit 8ce352818820 ("pidfs: check for valid ioctl commands").

Christian
---
 fs/pidfs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 049352f973de..63f9699ebac3 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -287,7 +287,6 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
 	switch (cmd) {
 	case FS_IOC_GETVERSION:
 	case PIDFD_GET_CGROUP_NAMESPACE:
-	case PIDFD_GET_INFO:
 	case PIDFD_GET_IPC_NAMESPACE:
 	case PIDFD_GET_MNT_NAMESPACE:
 	case PIDFD_GET_NET_NAMESPACE:
@@ -300,6 +299,17 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
 		return true;
 	}
 
+	/* Extensible ioctls require some more careful checks. */
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(PIDFD_GET_INFO):
+		/*
+		 * Try to prevent performing a pidfd ioctl when someone
+		 * erronously mistook the file descriptor for a pidfd.
+		 * This is not perfect but will catch most cases.
+		 */
+		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
+	}
+
 	return false;
 }
 

---
base-commit: 6470d2c6d4233a781c67f842d3c066bf1cfa4fdc
change-id: 20250204-work-pidfs-ioctl-6ef79a65e36b



Return-Path: <linux-fsdevel+bounces-60775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A233B51996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E05564E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA332CF7F;
	Wed, 10 Sep 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUi0NwHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985732A80C;
	Wed, 10 Sep 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515031; cv=none; b=Kx7SCTi/VDOZawHYoJN/COwd4zXdEc8Sug1BNURdlyHiPN6ZDdUkhSNhlQ8QJJ6oDCCUqLl449/e4rlmonicYVwk3oP+7C9znu1w2HIwEymMWSENX8remhQuZHgi6GiSfAgORISERzyTqRGDvX3N0d4zH/mFCqpIe5/1YRKApRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515031; c=relaxed/simple;
	bh=dcXgRxvD4Lbzl66IOipe3Yjd7eUcYeh/PyxSo3B1aCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHPQqhnDd+eUgE0tF0mjbwNvp528LXeLZtB5K3UkXR7nMShUG/Zu7Uylm5H4ItoNJ+57CcovyPimhjIq95O/XAfT5UziQAGDRrW+aNTX69L0ZUkuIwnc9oVWGY+MI4XhW34Qv6u1Fx6sEtcioLTgkHKcEF6S1odZIYROLz1nrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUi0NwHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEEEC4CEF0;
	Wed, 10 Sep 2025 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515031;
	bh=dcXgRxvD4Lbzl66IOipe3Yjd7eUcYeh/PyxSo3B1aCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uUi0NwHXAELciPrrvG/LmCCu646U1f9tXLk2Y8ur4dugGN1rdEsTIcwZ9ZSLPwKjm
	 dQwZc43gnWQzlYZf1NWaRPxapfPv121fFnx43DyF25bXTgk8sKBjyn0lATDbR6WKKc
	 /ZMiD8bmRtaLPak0OeZe131hqzvCHJKPYiX36OCmhC0j0CRDiJFHxdvxe0rcixwZpk
	 XECS7bkrU/X24Uix6mFq1sTw14jMkKCXevKU/L2/aDPixqmKPVtAds/l4N+6ogPLOD
	 rxIDwQgUwms/PXrAjgMfzPZIEp+FrRlCxe392EwyAd5OW4SUnG1luStIb3iP4Z/clA
	 molJK5GAVfycQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:46 +0200
Subject: [PATCH 01/32] pidfs: validate extensible ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dcXgRxvD4Lbzl66IOipe3Yjd7eUcYeh/PyxSo3B1aCE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7GWfm/e37OokHfmHf6Ys5InXvawUHP5ZoMNmY1cqo
 +Oz+8tCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby+Q8jwzW33TePqJpsP6zB
 9u7qhSv2k/K1KwL8fsmnml/Vd1WbPoOR4UDr4ms7U97Ob0qRjn9iZHZItuhrnOpZm0apQwtaDp8
 x4wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Validate extensible ioctls stricter than we do now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c         |  2 +-
 include/linux/fs.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..0a5083b9cce5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
 		 * erronously mistook the file descriptor for a pidfd.
 		 * This is not perfect but will catch most cases.
 		 */
-		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
+		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
 	}
 
 	return false;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..2f2edc53bf3c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
+static inline bool extensible_ioctl_valid(unsigned int cmd_a,
+					  unsigned int cmd_b, size_t min_size)
+{
+	if (_IOC_DIR(cmd_a) != _IOC_DIR(cmd_b))
+		return false;
+	if (_IOC_TYPE(cmd_a) != _IOC_TYPE(cmd_b))
+		return false;
+	if (_IOC_NR(cmd_a) != _IOC_NR(cmd_b))
+		return false;
+	if (_IOC_SIZE(cmd_a) < min_size)
+		return false;
+	return true;
+}
+
 #endif /* _LINUX_FS_H */

-- 
2.47.3



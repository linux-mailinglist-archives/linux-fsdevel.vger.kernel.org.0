Return-Path: <linux-fsdevel+bounces-61046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF782B54BA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E251898111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12B5302CDF;
	Fri, 12 Sep 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgV69ipU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158A2D238A;
	Fri, 12 Sep 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677986; cv=none; b=MbDLg9IME9U5kJGW/xIrhCBSjENFeCrVN4iaX+jrapFakCpzBwx+HoNQVVS0gHbt8VRZIsOKAuhaJQhUZTjvtzLe83FpZErBcAn604DqOl3pkeIdJwp4mztBhPquAHFsnCy93PyZhN5VbEu5Ceq3G4WOtcIZ7a31RmZvT6WzIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677986; c=relaxed/simple;
	bh=o5M10bc2KTaMvy47wLA0T02mOeZELPiisrkVC9gcmAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiNTGYrzt3TCO0ca8EkO7t2l7kVC700G1WnjkuC01UGcoPCaR8YiHRNvMII1/vByUkWYbMoRwnOQ3k4YYIviM9y3JVNt0cKxHoP9Vx0X6+1WHjW+dg6oVZRjIUVf3hmjKENSzh4F8b/GzNWHVmHAeDQrZkHNeVh6TVGG9gnIeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgV69ipU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63687C4CEFA;
	Fri, 12 Sep 2025 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677985;
	bh=o5M10bc2KTaMvy47wLA0T02mOeZELPiisrkVC9gcmAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OgV69ipUU8XTMnx+7emxEuWLrbUpLE481qs0/Ba9zX4VGge+g8I43uXOFmCx6UBS8
	 J6pkpwqtIBNIlhu5m5MMzDwXDVeirvnfqKTTYfJ0isU9LmHw1V2K1J1CVNyB3wk06q
	 l/f3dDf70upvFfsy1hMFNsaO+w3AFhr0bgj3fw8B/1gyCpDyqljUZzFOugAx/ME0qw
	 MnQjrWq0MXd8xdJRxttNQVc46LfrS0GsHdErLqHMOSzWvV1dH8V1rm/Q/5vINtkRte
	 XtwwkM7oJ9oNJhuZBcgfof+FFCxX2otJ7CjHkgdvkPUzKNTGOIDJAf/gye+hkI12I1
	 lpl76USDLGx/A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:24 +0200
Subject: [PATCH v2 01/33] pidfs: validate extensible ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-1-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=brauner@kernel.org;
 h=from:subject:message-id; bh=o5M10bc2KTaMvy47wLA0T02mOeZELPiisrkVC9gcmAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyyeq1o6p7v4bHpT3xFPqixaFtNCDm+PEaVd93xl
 qoKN+2/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh1GP47/DJa2fB9sJ594pW
 1W9t4VD+mPyh12K9kErmnX0uB44WBjIyXM/6Vf7KIJdf+HGlikjxsvQ0w77853x6Z75OsrSsfeD
 JAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Validate extensible ioctls stricter than we do now.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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



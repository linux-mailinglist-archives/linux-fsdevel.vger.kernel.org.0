Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1B3B9973
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhGAXm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 19:42:58 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:36674 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhGAXm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:42:58 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 19:42:58 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5C5391817A0E0;
        Fri,  2 Jul 2021 01:32:49 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hLZ-QIHthhxs; Fri,  2 Jul 2021 01:32:49 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Qx5VUZYvtAF; Fri,  2 Jul 2021 01:32:48 +0200 (CEST)
From:   David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     richard@sigma-star.at,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH] Log if a core dump is aborted due to changed file permissions
Date:   Fri,  2 Jul 2021 01:31:51 +0200
Message-Id: <20210701233151.102720-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For obvious security reasons, a core dump is aborted if the
filesystem cannot preserve ownership or permissions of the
dump file.

This affects filesystems like e.g. vfat, but also something like
a 9pfs share in a Qemu test setup, running as a regular user,
depending on the security model used. In those cases, the result
is an empty core file and a confused user.

To hopefully safe other people a lot of time figuring out the
cause, this patch adds a simple log message for those specific
cases.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 fs/coredump.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c3d8fc14b993..3e53d3e18b0e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -782,10 +777,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * filesystem.
 		 */
 		mnt_userns =3D file_mnt_user_ns(cprm.file);
-		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode), current_fsuid()))
+		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode),
+			    current_fsuid())) {
+			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file o=
wner\n",
+					    cn.corename);
 			goto close_fail;
-		if ((inode->i_mode & 0677) !=3D 0600)
+		}
+		if ((inode->i_mode & 0677) !=3D 0600) {
+			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file p=
ermissions\n",
+					    cn.corename);
 			goto close_fail;
+		}
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
 			goto close_fail;
 		if (do_truncate(mnt_userns, cprm.file->f_path.dentry,
--=20
2.31.1


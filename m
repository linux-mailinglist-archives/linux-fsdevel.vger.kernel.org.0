Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815278CDE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbjH2U7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbjH2U6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:58:54 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EFCC2;
        Tue, 29 Aug 2023 13:58:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF4F46418DB0;
        Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CkVWw-zOtbhk; Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 78DEF623489F;
        Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ug5bhtGMYFuy; Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-89.cable.dynamic.surfer.at [84.115.238.89])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EF4EB6418DB0;
        Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] user_namespaces.7: Document pitfall with negative permissions and user namespaces
Date:   Tue, 29 Aug 2023 22:58:32 +0200
Message-Id: <20230829205833.14873-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230829205833.14873-1-richard@nod.at>
References: <20230829205833.14873-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is little known that user namespaces and some helpers
can be used to bypass negative permissions.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
This patch applies to the Linux man-pages project.
---
 man7/user_namespaces.7 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man7/user_namespaces.7 b/man7/user_namespaces.7
index a65854d737cf..4927e194bcdc 100644
--- a/man7/user_namespaces.7
+++ b/man7/user_namespaces.7
@@ -1067,6 +1067,35 @@ the remaining unsupported filesystems
 Linux 3.12 added support for the last of the unsupported major filesyste=
ms,
 .\" commit d6970d4b726cea6d7a9bc4120814f95c09571fc3
 XFS.
+.SS Negative permissions and Linux user namespaces
+While it is technically feasible to establish negative permissions throu=
gh
+DAC or ACL settings, such an approach is widely regarded as a suboptimal
+practice. Furthermore, the utilization of Linux user namespaces introduc=
es the
+potential to circumvent specific negative permissions.  This issue stems
+from the fact that privileged helpers, such as
+.BR newuidmap (1) ,
+enable unprivileged users to create user namespaces with subordinate use=
r and
+group IDs. As a consequence, users can drop group memberships, resulting
+in a situation where negative permissions based on group membership no l=
onger
+apply.
+
+Example:
+.in +4n
+.EX
+$ \fBid\fP
+uid=3D1000(rw) gid=3D1000(rw) groups=3D1000(rw),1001(nogames)
+$ \fBunshare -S 0 -G 0 --map-users=3D100000,0,65536 --map-groups=3D10000=
0,0,65536 id\fP
+uid=3D0(root) gid=3D0(root) groups=3D0(root)
+.EE
+.in
+
+User rw got rid of it's supplementary groups and can now access files th=
at
+have been protected using negative permissions that match groups such as=
 \fBnogames\fP.
+Please note that the
+.BR unshare (1)
+tool uses internally
+.BR newuidmap (1) .
+
 .\"
 .SH EXAMPLES
 The program below is designed to allow experimenting with
--=20
2.26.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821E78CDEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjH2U7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbjH2U6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:58:54 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3A1BF;
        Tue, 29 Aug 2023 13:58:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5B0386234894;
        Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fuS8b0GbR-6i; Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EFF8E6234895;
        Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wdueR4L3iX8K; Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-89.cable.dynamic.surfer.at [84.115.238.89])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 7D0A06418DB5;
        Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/3] man: Document pitfall with negative permissions and user namespaces
Date:   Tue, 29 Aug 2023 22:58:31 +0200
Message-Id: <20230829205833.14873-2-richard@nod.at>
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
This patch applies to the acl software project.
---
 man/man5/acl.5 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man/man5/acl.5 b/man/man5/acl.5
index 0db86b325617..2ed144742e37 100644
--- a/man/man5/acl.5
+++ b/man/man5/acl.5
@@ -495,5 +495,20 @@ These non-portable extensions are available on Linux=
 systems.
 .Xr acl_from_mode 3 ,
 .Xr acl_get_perm 3 ,
 .Xr acl_to_any_text 3
+.Sh NOTES
+.Ss Negative permissions and Linux user namespaces
+While it is technically feasible to establish negative permissions throu=
gh
+ACLs, such an approach is widely regarded as a suboptimal practice.
+Furthermore, the utilization of Linux user namespaces introduces the
+potential to circumvent specific negative permissions.  This issue stems
+from the fact that privileged helpers, such as
+.Xr newuidmap 1 ,
+enable unprivileged users to create user namespaces with subordinate use=
r and
+group IDs. As a consequence, users can drop group memberships, resulting
+in a situation where negative permissions based on group membership no l=
onger
+apply.
+For more details, please refer to the
+.Xr user_namespaces 7
+documentation.
 .Sh AUTHOR
 Andreas Gruenbacher, <andreas.gruenbacher@gmail.com>
--=20
2.26.2


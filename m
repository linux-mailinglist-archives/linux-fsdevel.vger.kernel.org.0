Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5751DD2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378837AbiEFQO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443530AbiEFQNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:33 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17E6EB16;
        Fri,  6 May 2022 09:09:47 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWG3qdPzMqT9Z;
        Fri,  6 May 2022 18:09:46 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWG1m5zzlhMBy;
        Fri,  6 May 2022 18:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853386;
        bh=rxl0iHTTGfZtLXdEAP4heAgGzDEhlZqrwHQX62+NSSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw5s6q2dk4hi+eWeco/Nle53UauXNuxoh3VdZ5vyW2JZ7fyuBWxhhbAIKMiaT5ED2
         T3Z9XYM0NJymUbP62U0shtInm/VZ8Cjr+k9b67PoHWi4H8C1pZFc+EiUxKR16aN6ir
         6zCVRcWuxv24vPiiiStmhc+AdZT67eNP8BSQYrZU=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 11/12] landlock: Document good practices about filesystem policies
Date:   Fri,  6 May 2022 18:11:01 +0200
Message-Id: <20220506161102.525323-12-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explain how to set access rights per hierarchy in an efficient and safe
way, especially with the LANDLOCK_ACCESS_FS_REFER side effect (i.e.
partial ordering and constraints for access rights per hierarchy).

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-12-mic@digikod.net
---

Changes since v1:
* Add more explanation in the commit message.

Changes since v1:
* Add Reviewed-by: Paul Moore.
---
 Documentation/userspace-api/landlock.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index ae2aea986aa6..7b4fe6218132 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -156,6 +156,27 @@ ruleset.
 
 Full working code can be found in `samples/landlock/sandboxer.c`_.
 
+Good practices
+--------------
+
+It is recommended setting access rights to file hierarchy leaves as much as
+possible.  For instance, it is better to be able to have ``~/doc/`` as a
+read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
+``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
+Following this good practice leads to self-sufficient hierarchies that don't
+depend on their location (i.e. parent directories).  This is particularly
+relevant when we want to allow linking or renaming.  Indeed, having consistent
+access rights per directory enables to change the location of such directory
+without relying on the destination directory access rights (except those that
+are required for this operation, see `LANDLOCK_ACCESS_FS_REFER` documentation).
+Having self-sufficient hierarchies also helps to tighten the required access
+rights to the minimal set of data.  This also helps avoid sinkhole directories,
+i.e.  directories where data can be linked to but not linked from.  However,
+this depends on data organization, which might not be controlled by developers.
+In this case, granting read-write access to ``~/tmp/``, instead of write-only
+access, would potentially allow to move ``~/tmp/`` to a non-readable directory
+and still keep the ability to list the content of ``~/tmp/``.
+
 Layers of file path access rights
 ---------------------------------
 
-- 
2.35.1


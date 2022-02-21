Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD654BEC84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiBUVX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiBUVXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:17 -0500
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A455C26CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znx0KrTzMqHj1;
        Mon, 21 Feb 2022 22:15:17 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znw5mBSzljTgD;
        Mon, 21 Feb 2022 22:15:16 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 10/11] landlock: Document good practices about filesystem policies
Date:   Mon, 21 Feb 2022 22:25:21 +0100
Message-Id: <20220221212522.320243-11-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-11-mic@digikod.net
---
 Documentation/userspace-api/landlock.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 97db09d36a5c..cc3b52f65f99 100644
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


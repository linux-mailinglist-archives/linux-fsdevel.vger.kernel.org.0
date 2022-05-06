Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5B51DD35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443633AbiEFQNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443584AbiEFQNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:34 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF76EC4A
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWH1WXnzMqTZm;
        Fri,  6 May 2022 18:09:47 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWG6XmtzlhMBP;
        Fri,  6 May 2022 18:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853387;
        bh=ZDryU4YCGeAlBj3UmZfjsG1L2XAydajY89QXvphUw5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIOdNUaDfCq7/HTHeI2gajSnrvZXuId9Gu/WQzRpgEfvmihY6jJiwasP5hzdqt86q
         BG56+DUc5KY7kZGWp9Fv6RS6XoWU7NbJEu88RSerW2tc7Y+fyUVR6/DOpJIM6/MfqV
         2EF31mpkU5Ls5W4ALvgfqvHeLVLrOXiaDH73HITc=
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
Subject: [PATCH v3 12/12] landlock: Add design choices documentation for filesystem access rights
Date:   Fri,  6 May 2022 18:11:02 +0200
Message-Id: <20220506161102.525323-13-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Summarize the rationale of filesystem access rights according to the
file type.

Update the document date.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-13-mic@digikod.net
---

Changes since v2:
* Add more explanation in the commit message.
* Update date.

Changes since v1:
* Add Reviewed-by: Paul Moore.
* Update date.
---
 Documentation/security/landlock.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3df68cb1d10f..5c77730b4479 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: March 2021
+:Date: May 2022
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -42,6 +42,21 @@ Guiding principles for safe access controls
 * Computation related to Landlock operations (e.g. enforcing a ruleset) shall
   only impact the processes requesting them.
 
+Design choices
+==============
+
+Filesystem access rights
+------------------------
+
+All access rights are tied to an inode and what can be accessed through it.
+Reading the content of a directory doesn't imply to be allowed to read the
+content of a listed inode.  Indeed, a file name is local to its parent
+directory, and an inode can be referenced by multiple file names thanks to
+(hard) links.  Being able to unlink a file only has a direct impact on the
+directory, not the unlinked inode.  This is the reason why
+`LANDLOCK_ACCESS_FS_REMOVE_FILE` or `LANDLOCK_ACCESS_FS_REFER` are not allowed
+to be tied to files but only to directories.
+
 Tests
 =====
 
-- 
2.35.1


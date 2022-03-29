Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C747F4EADCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiC2Mx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiC2MxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:02 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D81A3B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 05:51:08 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvb4K4XzMpylX;
        Tue, 29 Mar 2022 14:51:07 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvb2X1mzlhSMV;
        Tue, 29 Mar 2022 14:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558267;
        bh=Myv+feEqRMvVi5vshp42PeNetgkHZQ6w/RvawsOsgJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPARrTXoCBwk6sr/GS0DLrE1KC/kkizLhv/i3QRLmTTo0b1uBLDU/Ra1OqXy17jDV
         takscT6ICLibCT6uhpFy0hOxVdA2AQjn1XyaLWBBX+vJg/VaL/XHATt5DJNcHqRCsr
         wMHwzK0Vo3yQI28HNmmTdU5ffh3GZaCRqQamrww4=
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 11/12] landlock: Document good practices about filesystem policies
Date:   Tue, 29 Mar 2022 14:51:16 +0200
Message-Id: <20220329125117.1393824-12-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-1-mic@digikod.net>
References: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220329125117.1393824-12-mic@digikod.net
---

Changes since v1:
* Add Reviewed-by: Paul Moore.
---
 Documentation/userspace-api/landlock.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b066d281f9f2..4b22c8cd76b4 100644
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


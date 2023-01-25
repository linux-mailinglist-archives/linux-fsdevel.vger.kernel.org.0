Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51667B668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjAYP4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjAYP4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:56:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994A10AB4;
        Wed, 25 Jan 2023 07:56:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w11so6944394edv.0;
        Wed, 25 Jan 2023 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzcelv9hExj0f2F+i5zGp2yUjab3yaJdo+KwahsiJf0=;
        b=nE90rl6fqAh0jCIH7Gl0AQ0V9jAsrWH1dAAnE8tualF10WBRgjTq9SGZySM3YXKZcV
         bu1dhTOjsVlLchc6+T38L1tBOAU1k9Jp2fAxreOzHEH9BDYJU6THRdA3b4ksRzFwD22f
         p0JqXDNBePZJFj0OenNUwLrZQDZTVRRuc5OrBIhIY5ec+BqzLZ36hBoBH4f2qHqVESYy
         IWW2JDsVRA0CP8Ur1FYGWYiq8PPQqatWyXUloFVR8IEME8L2Rj238p3adSkruE/VIDRf
         4ptc4p0Ac0iLQ29cRsd39P78TFO+Xtvtp+dHJnb3JrRX3X2ZXbhMo4B3Fmi171xeefx7
         9y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzcelv9hExj0f2F+i5zGp2yUjab3yaJdo+KwahsiJf0=;
        b=TtbrFCAcP6EI5ecm6opJH80EA89rNw3MqUfBO5X8oZKMVhbwWTBPVWWEjWRwC+y15C
         zPjKyo3pS/R0gDZV9+GlePba5wP7+qf5BUP7Ol0ZXC2KMj8h7CLv7US3GCb2frkYJUuI
         kIbWa2HAoaYmO7gKByJGjAq3XC3iaw4jHQubUoAnSWU9oM9Uv7bSPJM6/iljuTamN0qy
         kacIlkyTmwbPqyRDD+BIIxG/9cXi4wPK2b+pA60XsDPjCnnfqeZKBLf7FxN3vfubkCOo
         BHsvVJ7VQ7zH9hGbUXT3syf+uGaOclId9nMdGzY9fKXJEqKcyEdKOjsMEbFN6wWTBwnZ
         pDUA==
X-Gm-Message-State: AFqh2kqNQKTl06zEofzIFUQzB2L946AYZbOAl491grqKdS3HYnL4AuAR
        tXvXcbHYyU2DaRqV0dC3+5o=
X-Google-Smtp-Source: AMrXdXtoYyqZ+njNVap5kgN/FJzaguYKOrdxMh6aymJ13hY+1s0Wex7oODclJQoRFhk0ETLcTM1cNw==
X-Received: by 2002:aa7:cac2:0:b0:497:948b:e8 with SMTP id l2-20020aa7cac2000000b00497948b00e8mr30451221edt.6.1674662165281;
        Wed, 25 Jan 2023 07:56:05 -0800 (PST)
Received: from f.. (cst-prg-88-122.cust.vodafone.cz. [46.135.88.122])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402517800b0049e249c0e56sm2539287ede.56.2023.01.25.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:56:04 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
Date:   Wed, 25 Jan 2023 16:55:57 +0100
Message-Id: <20230125155557.37816-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125155557.37816-1-mjguzik@gmail.com>
References: <20230125155557.37816-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

access(2) remains commonly used, for example on exec:
access("/etc/ld.so.preload", R_OK)

or when running gcc: strace -c gcc empty.c
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  0.00    0.000000           0        42        26 access

It falls down to do_faccessat without the AT_EACCESS flag, which in turn
results in allocation of new creds in order to modify fsuid/fsgid and
caps. This is a very expensive process single-threaded and most notably
multi-threaded, with numerous structures getting refed and unrefed on
imminent new cred destruction.

Turns out for typical consumers the resulting creds would be identical
and this can be checked upfront, avoiding the hard work.

An access benchmark plugged into will-it-scale running on Cascade Lake
shows:
test	proc	before	after
access1	1	1310582	2908735	 (+121%)  # distinct files
access1	24	4716491	63822173 (+1353%) # distinct files
access2	24	2378041	5370335	 (+125%)  # same file

The above benchmarks are not integrated into will-it-scale, but can be
found in a pull request:
https://github.com/antonblanchard/will-it-scale/pull/36/files

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

v3:
- add a comment warning about changing access_override_creds
v2:
- fix current->cred usage warn reported by the kernel test robot
Link: https://lore.kernel.org/all/202301150709.9EC6UKBT-lkp@intel.com/
---
 fs/open.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..2afed058250c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -367,7 +367,37 @@ COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode, compat_arg_u64_dual(offset
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
+ *
+ * Creating new credentials is expensive, so we try to skip doing it,
+ * which we can if the result would match what we already got.
  */
+static bool access_need_override_creds(int flags)
+{
+	const struct cred *cred;
+
+	if (flags & AT_EACCESS)
+		return false;
+
+	cred = current_cred();
+	if (!uid_eq(cred->fsuid, cred->uid) ||
+	    !gid_eq(cred->fsgid, cred->gid))
+		return true;
+
+	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
+		kuid_t root_uid = make_kuid(cred->user_ns, 0);
+		if (!uid_eq(cred->uid, root_uid)) {
+			if (!cap_isclear(cred->cap_effective))
+				return true;
+		} else {
+			if (!cap_isidentical(cred->cap_effective,
+			    cred->cap_permitted))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static const struct cred *access_override_creds(void)
 {
 	const struct cred *old_cred;
@@ -377,6 +407,12 @@ static const struct cred *access_override_creds(void)
 	if (!override_cred)
 		return NULL;
 
+	/*
+	 * XXX access_need_override_creds performs checks in hopes of skipping
+	 * this work. Make sure it stays in sync if making any changes in this
+	 * routine.
+	 */
+
 	override_cred->fsuid = override_cred->uid;
 	override_cred->fsgid = override_cred->gid;
 
@@ -436,7 +472,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 
-	if (!(flags & AT_EACCESS)) {
+	if (access_need_override_creds(flags)) {
 		old_cred = access_override_creds();
 		if (!old_cred)
 			return -ENOMEM;
-- 
2.39.0

